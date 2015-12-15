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
                                            <li><form action="/ticket/create?o={{username_id}}&email={{email}}" method="post">
                                                <input type="submit" value="Create Ticket">
                                                </form>
                                            <li>
                                            <li><a href= "" class="button disabled " > DIR </a>
                                            <li>
                                            <li><a href="dir-inbox.html"  class="button disabled " >DIR-INBOX </a>
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

   </body>
</html>