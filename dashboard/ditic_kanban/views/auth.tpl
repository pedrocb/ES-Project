<!DOCTYPE HTML>

<html>
   
    
	<head>
		<title>Login</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="/static/assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="/static/assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="/static/assets/css/ie8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="/static/assets/css/ie9.css" /><![endif]-->

	</head>
	<body class="landing">

		<!-- Header -->
			<header id="header" class="alt">
				<a href="#nav">Menu</a>
			</header>

		<!-- Nav -->
			<nav id="nav">
				<ul class="links">
					<li><a href="index.html">LOGIN</a></li>
					<li><a href="kanban.html">KANBAN</a></li>
					<li><a href="dir.html">DIR</a></li>
                    <li><a href="dir-inbox.html">DIR-INBOX</a></li>
                    <li><a href="user.html">USER</a></li>
				</ul>
			</nav>

			% if message != '':
			Result: <strong>{{message}}</strong>
			% end



		<!-- login-->
			<section id="four" class="wrapper style2 special">
				<div class="inner">
					<header class="major narrow">
						<h2>LOGIN</h2>
						
					</header>
					<form action="/auth" method="post">
						<div class="container 75%">
							<div class="row uniform 50%">
								<div class=" 12u$">
                                
									<input name="username" placeholder="Username" type="text" />
								</div>
								
								<div class="12u$">
									<input name="password" placeholder="Password" type="password"
								</div>
							</div>
            
						</div>
						<ul class="actions">
                            
							<li><input type="submit" class="login-button" value="Login" /></li>
							<li><input type="reset" class="alt" value="Reset" /></li>
						</ul>
					</form>
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