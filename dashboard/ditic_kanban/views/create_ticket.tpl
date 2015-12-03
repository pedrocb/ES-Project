<!DOCTYPE html>


<html>
<head>
	<title>Create Ticket</title>
	<link rel="stylesheet" type="text/css" href="/static/create_ticket.css">
</head>

<body>
   	<br><br>
   	<br><br>	
   	<br><br>
       <div class= "Title" >
	    <h1 align="center">Create a Ticket </h1>
        </div>
    <form action="/ticket/new?o={{username_id}}&email={{email}}" method="post">
        <form class="form">
            <div class="TT2">
        Subject: &nbsp&nbsp&nbsp&nbsp <textarea name="subject" cols="70" rows="1" align="center">
	</textarea>        

        <p>Description: <textarea name="description" cols="70" rows="10" align="center" >
        </textarea>
        </p>
        </div>
	<br><br>
        
            <button type="submit" id="ticket-button">Create</button>
    </form>

</body>
</html>

