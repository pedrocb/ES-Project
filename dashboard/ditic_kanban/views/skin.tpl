<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="/static/assets/css/main.css" >
	<source
    % meta_refresh = get('meta_refresh', 0)
    {{!'<meta http-equiv="refresh" content="%s">' % meta_refresh if meta_refresh else ''}}
    <meta charset="UTF-8">
    <title>{{title}}</title>
    % graph_script = get('graph_script', '')
    % if graph_script:
    {{!graph_script}}
    % end
</head>


<body class="landing">

		<!-- Header -->
			<header id="header" class="alt">
				<a href="#nav">Menu</a>
			</header>

		<!-- Nav -->
			<nav id="nav">
				<ul class="links">
					<li><a href="/detail/dir?o={{username_id}}">HOME</a></li>
					<li><a href="/detail/kanban?o={{username_id}}">KANBAN</a></li>
					<li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    <li><a href="user.html">USER</a></li>
				</ul>
			</nav>

% username_id = get('username_id', '')
{{!base}}

<!-- Scripts -->
			<script src="/static/assets/js/jquery.min.js"></script>
			<script src="/static/assets/js/skel.min.js"></script>
			<script src="/static/assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="/static/assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="/static/assets/js/main.js"></script>


</body>
</html>
