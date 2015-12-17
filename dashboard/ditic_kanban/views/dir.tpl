% rebase('skin')
<html>

<head>
      <title>Dir</title>
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
                                        <!-- Button to create ticket -->
                                        <ul class="actions">
                                            <li>
                                            <li>
                                            <li><div class="button disabled " > DIR </div>
                                            <li>
                                            <li><a href="/detail/dir-inbox?o={{username_id}}"  class="button" >DIR-INBOX </a>
                                            <li>
                                            </ul>
                                            </div>
                                               <table class="tabela2">
                                                  <thead>
                                                     <tr>
                                                        <th>DIR</th>
                                                        <th>TITLE</th>
                                                        <th>PRIORITY</th>
                                                        <th>TO INBOX</th>
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
                                                        <a href="/ticket/{{ticket['id']}}/detail?o={{username_id}}&email={{email}}" target="_blank">
                                                            % subject = ticket['subject']
                                                            % if len(ticket['subject']) > max_len:
                                                            %   subject = ticket['subject'][:max_len]+'...'
                                                            % end
                                                            {{subject}}
                                                        </a>
                                                        </td>
                                                        <td>
                                                           <a href="/ticket/{{ticket['id']}}/action/decrease_priority?o={{username_id}}&email={{email}}">-</a>                               {{priority}}
                                       <a href="/ticket/{{ticket['id']}}/action/increase_priority?o={{username_id}}&email={{email}}">+</a>
                                                        </td>

                                                        <td>
                                                        <div class="6u$ 12u$(small)">
                                                        % sum = 0
                                                        % # we need this code because DIR can have tickets all along several status
                                                        % for status in summary['dir-inbox']:
                                                        %   sum += summary['dir-inbox'][status]
                                                        % end
                                                        %if sum < dir_inbox_limit:
                                                          <a href="/ticket/{{ticket['id']}}/action/forward?o={{username_id}}&email={{email}}">Move to Dir-Inbox</a>
                                                        %end
                                                        %if sum >= dir_inbox_limit:
                                                            DIR-INBOX FULL
                                                        %end
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
               <li >
                 <form action="/ticket/create?o={{username_id}}&email={{email}}" method="post">
                   <input type="submit" value="Create Ticket">
                 </form>
               </li>
            </ul>
         </div>
      </section>

   </body>
</html>
