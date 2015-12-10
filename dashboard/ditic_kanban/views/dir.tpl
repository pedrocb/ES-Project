<!DOCTYPE HTML>
<html>
   <head>
      <title>Dir</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <!--[if lte IE 8]><script src="/static/assets/js/ie/html5shiv.js"></script><![endif]-->
      <link rel="stylesheet" href="/static/assets/css/main.css" />
      <!--[if lte IE 8]>
      <link rel="stylesheet" href="/static/assets/css/ie8.css" />
      <![endif]-->
      <!--[if lte IE 9]>
      <link rel="stylesheet" href="/static/assets/css/ie9.css" />
      <![endif]-->
   </head>
   <body>

   % max_len = 40
      <!-- Main -->
      <section id="main" class="wrapper">
         <div class="container">
            <header class="major special">
            <h2>DIR</h2>
               <div class="container 75%">
                  <div class="row uniform 50%">
                     <div class="12u$">
                        <div class="table-wrapper">
                           <div>
                              <ul class="actions">
                                 <li><a href="/ticket/create?o={{username_id}}&email={{email}}" class="button" >NEW TICKET </a>
                                 <li>
                                 <li><a class="button " > DIR </a>
                                 <li>
                                 <li><a href="dir-inbox.html"  class="button disabled " >DIR-INBOX </a>
                                 <li>
                              </ul>
                           </div>
                           <table class="tabela2">
                              <thead>
                                 <tr>
                                    <th>DIR</th>
                                    <th>DESCRIÇÃO</th>
                                    <th>PRIORIDADE</th>
                                    <th>SELECT</th>
                                 </tr>
                              </thead>
                              <tbody>


                              % for priority in sorted(tickets, reverse=True):
                                   % for ticket in sorted(tickets[priority], reverse=True):
                                    <tr>


                                    <td>
                                        <a href="/ticket/{{ticket['id']}}/detail" target="_blank">
                                            {{ticket['id']}}
                                        </a>
                                    </td>

                                    <td>
                                    <a href="/ticket/{{ticket['id']}}/detail" target="_blank">
                                        % subject = ticket['subject']
                                        % if len(ticket['subject']) > max_len:
                                        %   subject = ticket['subject'][:max_len]+'...'
                                        % end
                                        {{subject}}
                                    </a>
                                    </td>
                                    <td>
                                    {{priority}}
                                    </td>

                                    <td>
                                    <div class="6u$ 12u$(small)">
                                    <input type="checkbox" id="copy" name="copy" >
                                    <label for="copy"></label>
                                    </div></td>
                        </tr>

                        %end
                        %end
                  </tbody>
                  </table>
                  <div/>
                  </div>
               </div>
         </div>
         </div>
         <div>
            <ul class="actions">
               <li ><input type="submit" class="button" value="Send to dir- inbox" /></li>
            </ul>
         </div>
      </section>



      <!-- Scripts -->
      <script src="/static/assets/js/jquery.min.js"></script>
      <script src="/static/assets/js/skel.min.js"></script>
      <script src="/static/assets/js/util.js"></script>
      <!--[if lte IE 8]><script src="/static/assets/js/ie/respond.min.js"></script><![endif]-->
      <script src="/static/assets/js/main.js"></script>
   </body>
</html>