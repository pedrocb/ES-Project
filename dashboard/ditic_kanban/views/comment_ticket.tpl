<!DOCTYPE html>

<html>

<head>

	<title>Comment</title>
	<link rel="stylesheet" type="text/css" href="/static/comment_ticket.css" >
</head>

<body>
	<br><br>
	<div class="Title" >
    <h1 align="center">Comment </h1>

    <form action="/ticket/{{ticket_id}}/comment?o={{username_id}}&email={{email}}" method="post">
        <textarea name="comment" cols="70" rows="10" align="center"> </textarea>
        <br>
        <br>
            <button type="submit" id="ticket-button"> Done</button>
    </form>
</div>
</body>
</html>
