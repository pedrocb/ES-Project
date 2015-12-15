% rebase('skin')
<html>

<head>

	<title>Comment Ticket</title>
	<link rel="stylesheet" href="/static/assets/css/main.css" >
</head>


<body>

    	<section id="main" class="wrapper">
				<div class="container">
					<header class="major special">
						<h2>COMMENT DONE</h2>

                        <form action="/ticket/{{ticket_id}}/comment?o={{username_id}}&email={{email}}" method="post">
						    <div class="container 50%">
							    <div class="row uniform 50%">
								    <div class=" 12u$">
                                        <textarea name="comment" id="message" placeholder="justification:" rows="6"></textarea>
									</div>

                                </div>
                            </div>


                            <div>
                                <div class="12u$">
                                    <ul class="actions">
										<li><input type="submit" class="button" id="ticket-button" value="Done"></li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </header>
                </div>
        </section>
</body>
</html>
