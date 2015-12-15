% result = "['Date', 'Created', 'Resolved', 'Still open'],\n"
% for day in sorted(statistics):
%   if statistics[day]:
%       result += '''["%s", %s, %s, %s],\n''' % (day,
%                                              statistics[day]["created_tickets"],
%                                              statistics[day]['team']['resolved'],
%                                              statistics[day]['team']['open'])
%   else:
%       result += '["%s", 0, 0, 0],\n' % day
%   end
% end

% graph_script = """
    <script type="text/javascript"
          src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>

    <script type="text/javascript">
      google.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([ %s]);

        var options = {
          title: 'Número de tickets',
          curveType: 'function',
          legend: { position: 'bottom' },
        };

        var chart = new google.visualization.LineChart(document.getElementById('performance'));

        chart.draw(data, options);
      }
    </script>
""" % result

% result = "['Date', 'Mean Time to Resolve', 'Time worked'],\n"
% for day in sorted(statistics):
%   if statistics[day]:
%       result += '''["%s", %s, %s],\n''' % (day,
%                                      statistics[day]['team']['mean_time_to_resolve']/60,
%                                      statistics[day]['team']['time_worked']/60)
%   else:
%       result += '["%s", 0, 0],\n' % day
%   end
% end
% graph_script += """
 <script type="text/javascript"
          src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>

    <script type="text/javascript">
      google.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
%s
        ]);

        var options = {
          title: 'Tempo médio de resolução vs Tempo total trabalhado (horas)',
          curveType: 'function',
          legend: { position: 'bottom' },
        };

        var chart = new google.visualization.LineChart(document.getElementById('mean_time_to_resolve'));

        chart.draw(data, options);
      }
    </script>
""" % result

% rebase('skin', meta_refresh=300)


<section id="main" class="wrapper">
				<div class="container">
					<header class="major special">
						<h2> Group’s Kanban </h2>
                    </header>
                </div>
</section>

                        <table id ="tabela">


										<tr>
											<td align="left"> DIR </td>

											<td align="right" id="td">
                                                % # DIR
                                                % sum = 0
                                                % # we need this code because DIR can have tickets all along several status
                                                % for status in summary['dir']:
                                                %   sum += summary['dir'][status]
                                                % end
                                                <td align="center" valign="top">{{sum}}</td>
                                            </td>
										</tr>
										<tr>
										<td align="left"> DIR-INBOX </td>

											<td align="right" id="td">
                                                % # DIR-INBOX
                                                % sum = 0
                                                % # we need this code because DIR can have tickets all along several status
                                                % for status in summary['dir-inbox']:
                                                %   sum += summary['dir-inbox'][status]
                                                % end
                                                 <td align="center" valign="top">{{sum}}</td>
                                            </td>
										</tr>

								</table>
<br> </br>

                                    <table id="tabela">
                                        <thead>
                                            <tr>
                                                <th>USER</th>
                                                <th>IN</th>
                                                <th>ACTIVE</th>
                                                <th>STALLED</th>
                                                <th>DONE</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            % totals = { status: 0 for status in ['new', 'open', 'stalled', 'resolved']}
                                            % for email in sorted(summary):
                                            %   if email.startswith('dir'):
                                            %       continue
                                            %   end
                                            %   user = email
                                            %   if  email != 'unknown':
                                            %       user = alias[email]
                                            %   end
                                            <tr>
                                                <td><a href="/detail/{{email}}?o={{username_id}}">{{user}}</a></td>
                                                %   for status in ['new', 'open', 'stalled', 'resolved']:
                                                <td>{{summary[email][status]}}</td>
                                                %       totals[status] += summary[email][status]
                                                % end
                                            </tr>
                                            % end
                                            <tr>
                                                <td><strong>Totais</strong></td>
                                                %   for status in ['new', 'open', 'stalled', 'resolved']:
                                                <td><strong>{{totals[status]}}</strong></td>
                                                % end

                                            </tr>
                                        </tbody>
                                    </table>

<table border="0">
    <td>
        <div id="performance" style="width: 400px; height: 400px"></div>
    </td>
    <td>
        <div id="mean_time_to_resolve" style="width: 400px; height: 400px"></div>
    </td>
</table>
