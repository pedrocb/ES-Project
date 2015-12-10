% rebase('skin')

<!DOCTYPE html>
<html>

<head>

	<title>Create Ticket</title>
	<link rel="stylesheet" href="/static/assets/css/main.css" >
</head>

<body>
    	<section id="main" class="wrapper">
				<div class="container">
					<header class="major special">
						<h2>Create a Ticket</h2>

						   <form action="/ticket/new?o={{username_id}}&email={{email}}" method="post">
						<div class="container 50%">
							<div class="row uniform 50%">
								<div class=" 12u$">
										<textarea name="subject" id="message" placeholder="Subject:" rows="1"></textarea>
									</div>
									<div class="12u$">
										<textarea name="description" id="message" placeholder="Description:" rows="6"></textarea>

									</div>
                            </div>
                               </div>



                            <div>
									<div class="12u$">
										<ul class="actions">

										<li><button type="submit" id="ticket-button" value="Create"></li>

										</ul>
									</div>
								</div>

</section>






</body>
</html>
