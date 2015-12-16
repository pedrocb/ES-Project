# -*- coding: utf-8 -*-
#
# By Pedro Vapi @2015
# This module is responsible for web routing. This is the main web server.
#
from time import time
from datetime import date
import os

from bottle import get
from bottle import post
from bottle import template
from bottle import request
from bottle import run
from bottle import redirect
from bottle import route
from bottle import static_file

from ditic_kanban.rt_summary import get_summary_info
from ditic_kanban.config import DITICConfig
from ditic_kanban.auth import UserAuth
from ditic_kanban.tools import user_tickets_details
from ditic_kanban.tools import ticket_actions
from ditic_kanban.tools import user_closed_tickets
from ditic_kanban.tools import search_tickets
from ditic_kanban.tools import get_urgent_tickets
from ditic_kanban.rt_api import RTApi
from ditic_kanban.statistics import get_date
from ditic_kanban.statistics import get_statistics
from subprocess import call

emailGlobal = ''

# My first global variable...
user_auth = UserAuth()

# Only used by the URGENT tickets search
my_config = DITICConfig()
system = my_config.get_system()
rt_object = RTApi(system['server'], system['username'], system['password'])

# This part is necessary in order to get access to sound files
# Static dir is in the parent directory
STATIC_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), "../static"))

print STATIC_PATH


def create_default_result():
    # Default header configuration
    result = {
        'title': 'Dashboard'
    }

    call(['update_statistics'])
    call(["generate_summary_file"])

    # Summary information
    result.update({'summary': get_summary_info()})


    # Mapping email do uer alias
    config = DITICConfig()
    result.update({'alias': config.get_email_to_user()})

    return result


@get('/')
def get_root():
    start_time = time()

    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    result.update({'username': user_auth.get_email_from_id(request.query.o)})
    result.update({'username_id': request.query.o})
    today = date.today().isoformat()
    result.update({'statistics': get_statistics(get_date(30, today), today)})

    # Is there any URGENT ticket?
    result.update({'urgent': get_urgent_tickets(rt_object)})

    result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})

    result.update({'summary:': get_summary_info()})

    return template('entrance_summary', result)


@post('/auth')
def auth():
    result = create_default_result()
    result.update({'username': request.forms.get('username'), 'password': request.forms.get('password')})
    if request.forms.get('username') and request.forms.get('password'):
        try:
            if user_auth.check_password(request.forms.get('username'), request.forms.get('password')):
                redirect('/?o=%s' % user_auth.get_email_id(request.forms.get('username')))
            else:
                result.update({'message': 'Password incorrect'})
                return template('auth', result)
        except ValueError as e:
            result.update({'message': str(e)})
            return template('auth', result)
    else:
        result.update({'message': 'Mandatory fields'})
        return template('auth', result)



@get('/detail/<email>')
def email_detail(email):
    global emailGlobal
    emailGlobal = email

    start_time = time()

    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    result.update({'username': user_auth.get_email_from_id(request.query.o)})
    result.update({'email': email})
    result.update({'username_id': request.query.o})

    result.update(user_tickets_details(
        user_auth.get_rt_object_from_email(
            user_auth.get_email_from_id(request.query.o)
        ), email))

    # Is there any URGENT ticket?
    result.update({'urgent': get_urgent_tickets(rt_object)})

    result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})

    result.update({'summary:': get_summary_info()})
    if email=='dir':
        print email
        return template('dir', result)
    elif email=='dir-inbox':
        print email
        return template('dir-inbox', result)
    elif email=='unknown' or not email:
        print email
        return template('ticket_list', result)
    else:
        print email
        return template('detail', result)
        #return template('ticket_list', result)

@post('/ticket/create')
def createTemplate():
    email = emailGlobal
    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    result.update({'username':user_auth.get_email_from_id(request.query.o)})
    result.update({'email':email})
    result.update({'username_id': request.query.o})
    return template('create_ticket', result)


@post('/ticket/new')
def create_ticket():
    print "create ticket: ", request.query.o
    print "email: " ,user_auth.get_email_from_id(request.query.o)
    if not request.query.o:
        redirect("/detail/" + emailGlobal + "?o=" + request.query.o)
    else:
        text = "".join([s for s in request.forms.get("description").splitlines(True) if s.strip("\r\n")])
        text = text.replace("\n","\n ")

        create_ticket = {
            'id': 'ticket/new',
            'Owner': 'nobody',
            'Text': text,
            'Priority': request.forms.get("priority"),
            'Subject': request.forms.get('subject'),
            'Queue': 'General',
            'CF-IS - Informatica e Sistemas': 'DIR',
        }

        content = ''
        for key in create_ticket:
            content += '{0}: {1}\n'.format(key, create_ticket[key])

        query = {
            'content': content
        }
        rt_object.get_data_from_rest('ticket/new', query)
        print "sucesso"
        redirect('/?o=%s' % request.query.o)

@get('/ticket/<ticket_id>/commentTemplate')
def comment_template(ticket_id):
    email = emailGlobal
    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    result.update({'email':email})
    result.update({'username_id': request.query.o})
    result.update({'ticket_id':ticket_id})
    return template('comment_ticket', result)



@post('/ticket/<ticket_id>/comment')
def ticket_comment(ticket_id):
        comment = {
            'id': ticket_id,
            'Action': 'comment',
            'Text': request.forms.get('comment'),
        }

        content = ''

        for key in comment:
            content += '{0}: {1}\n'.format(key, comment[key])

        query = {
            'content': content
        }
        rt_object.get_data_from_rest('ticket/' + ticket_id + '/comment', query)
        ticket_action(ticket_id, 'forward')


@get('/ticket/<ticket_id>/detail')
def ticket_detail(ticket_id):

    result = create_default_result()
    response = rt_object.get_data_from_rest('ticket/'+ticket_id+ '/show', {})
    available = ['id', 'queue','owner','subject','creator','status','priority','resolved','timeworked','cf.{is - informatica e sistemas}']
    for line in response:
        divided_line = line.split(":")
        if divided_line[0] in available:
            if divided_line[0]!=available[9]:
                first_argument = divided_line[0].strip()
                second_argument = divided_line[1].strip()
            else:
                first_argument = "cf"
            result.update({first_argument:second_argument})

    description = getTicketDescription(ticket_id)
    result.update({'description':description    })
    return template('ticket_detail', result)

def getTicketDescription(ticket_id):
    response = rt_object.get_data_from_rest('ticket/'+ticket_id+ '/history?format=l', {})

    for i in range(0,len(response)):
        if response[i].startswith("content:"):
            break
    return_value = response[i].split(': ')[1]

    i+=1
    while(response[i]!=''):
        return_value+=("\n" + response[i])
        i+=1

    print return_value
    return return_value


@get('/closed/<email>')
def email_detail(email):
    start_time = time()

    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    result.update({'username': user_auth.get_email_from_id(request.query.o)})
    result.update({'email': email})
    result.update({'username_id': request.query.o})

    result.update(user_closed_tickets(
        user_auth.get_rt_object_from_email(
            user_auth.get_email_from_id(request.query.o)
        ), email))

    # Is there any URGENT ticket?
    result.update({'urgent': get_urgent_tickets(rt_object)})
    result.update({'summary:': get_summary_info()})
    result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})
    return template('ticket_list', result)


@post('/search')
def search():
    start_time = time()

    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    if not request.forms.get('search'):
        redirect('/?o=%s' % request.query.o)
    search = request.forms.get('search')

    result.update({'username': user_auth.get_email_from_id(request.query.o)})
    result.update({'email': search})
    result.update({'username_id': request.query.o})

    result.update(search_tickets(
        user_auth.get_rt_object_from_email(
            user_auth.get_email_from_id(request.query.o)
        ), search))

    # Is there any URGENT ticket?
    result.update({'urgent': get_urgent_tickets(rt_object)})
    result.update({'summary:': get_summary_info()})
    result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})
    return template('search', result)


@route('/ticket/<ticket_id>/action/<action>')
def ticket_action(ticket_id, action):
    ticket_action_aux(ticket_id, action)
    redirect("/detail/" + emailGlobal + "?o=" + request.query.o)



def ticket_action_aux(ticket_id, action):
    start_time = time()
    print(request.query.email)
    result = create_default_result()
    if request.query.o == '' or not user_auth.check_id(request.query.o):
        result.update({'message': ''})
        return template('auth', result)

    # Apply the action to the ticket
    result.update(ticket_actions(
        user_auth.get_rt_object_from_email(
            user_auth.get_email_from_id(request.query.o)
        ),
        ticket_id,
        action,
        request.query.email, user_auth.get_email_from_id(request.query.o)
    ))

    # Update table for this user
    result.update(user_tickets_details(
        user_auth.get_rt_object_from_email(
            user_auth.get_email_from_id(request.query.o)
        ), request.query.email))

    result.update({'username': user_auth.get_email_from_id(request.query.o)})
    result.update({'email': request.query.email})
    result.update({'username_id': request.query.o})

    # Is there any URGENT ticket?
    result.update({'urgent': get_urgent_tickets(rt_object)})

    result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})
    result.update({'summary:': get_summary_info()})

    if request.query.email == 'dir' or request.query.email == 'dir-inbox' or request.query.email == 'unknown':
        return template('ticket_list', result)
    else:
        return template('detail', result)


@route("/static/<filepath:path>")
def static(filepath):
    return static_file(filepath, root=STATIC_PATH)

@get('/static/<filename>')
def fileget(filename):
    return static_file(filename, root='views')

def start_server():
    run(server="paste", host='0.0.0.0', port=8080, debug=False, interval=1, reloader=True, quiet=False)


if __name__ == '__main__':
    start_server()
