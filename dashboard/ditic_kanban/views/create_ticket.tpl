% rebase('skin')
<!-- Form to create a ticket -->
<form action="/ticket/new?o={{username_id}}&email={{email}}" method="post">
  Subject: <input name="subject" type="text"> <br/>
  Description: <input name="description" style="width: 200px; height:100px;" type="text">
  <input type="submit" value="Create Ticket">
</form>

