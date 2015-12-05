<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="/static/style.css">
    % meta_refresh = get('meta_refresh', 0)
    {{!'<meta http-equiv="refresh" content="%s">' % meta_refresh if meta_refresh else ''}}
    <meta charset="UTF-8">
    <title>{{title}}</title>
    % graph_script = get('graph_script', '')
    % if graph_script:
    {{!graph_script}}
    % end
</head>
<body>
    <div id="head-container">
        <div id="button-wrapper">
            % username_id = get('username_id', '')
            <a href="/?o={{username_id}}" id="home-button">&#8801;</a>
        </div>
        <div></div>
    </div>
    {{!base}}
</body>
</html>
