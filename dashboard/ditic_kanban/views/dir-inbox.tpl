% rebase('skin')
<html>
   <head>
      <title>Dir-inbox</title>
   </head>
   <body>

   % max_len = 40
      <!-- Main -->
      <section id="main" class="wrapper">
         <div class="container">
            <header class="major special">
            <h2>DIR-INBOX</h2>
               <div class="container 75%">
                  <div class="row uniform 50%">
                     <div class="12u$">
                        <div class="table-wrapper">
                         <ul class="actions">
                           <div>
                                 <li><a href= "" class="button" > DIR </a>
                                 <li>
                                 <li><a href="dir-inbox.html"  class="button disabled " >DIR-INBOX </a>
                                 <li>
                            </div>

                             </ul>
                           <table class="tabela2">
                              <thead>
                                 <tr>
                                    <th>ID</th>
                                    <th>TITLE</th>
                                    <th>PRIORITY</th>
                                    <th>TAKE</th>
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
                                    % if email == 'dir-inbox':
                                        <a href="/ticket/{{ticket['id']}}/action/take?o={{username_id}}&email={{email}}">(take)</a>
                                    %end
                                    </td>
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
   </body>
</html>