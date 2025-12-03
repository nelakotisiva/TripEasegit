<html>
<head><title>Add User</title></head>
<body>

<h2>Add New User</h2>

<form action="ManageUsers" method="post">
	Id: <input type="number" name="id" required><br><br>
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    Full Name: <input type="text" name="fullname" required><br><br>
    Phone: <input type="text" name="phone" required><br><br>
    Role:
    <select name="role">
        <option value="developer">Developer</option>
        <option value="HR">HR</option>
        <option value="Hacker">Hacker</option>
    </select><br><br>

    <button type="submit">Save</button>
</form>

<br>
<a href="ManageUsers">Back to List</a>

</body>
</html>
