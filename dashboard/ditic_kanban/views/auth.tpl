<!DOCTYPE html>

<html>

<head>
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="/static/style.css">
</head>

<body>

	% if message != '':
	Result: <strong>{{message}}</strong>
	% end

	<div class="wrapper">
	<div class="container">
		<h1>LOGIN </h1>
		
		<form action="/auth" method="post">
            <p>
			<input id="project_title" name="username" type="text" onfocus="if (this.value=='Username') this.value='';" value="Username">
        </p>
			<input id="project_title" name="password" type="password" onfocus="if (this.value=='Password') this.value='';" value="Password">
			<button value="Login" type="submit" id="login-button">Submit</button>
		</form>
	</div>

</div>

</body>

</html>
	

