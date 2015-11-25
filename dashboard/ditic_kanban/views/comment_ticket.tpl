
<!-- Form to comment a ticket -->
<form action="/ticket/{{ticket_id}}/comment?o={{username_id}}&email={{email}}" method="post">
  Comment: <input name="comment" style="width: 200px; height:100px;" type="text">
  <input type="submit" value="Done">
</form>
