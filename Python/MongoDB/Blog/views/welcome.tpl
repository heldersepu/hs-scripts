<!DOCTYPE html>

<html>
<head>
<title>Welcome</title>
<style type="text/css">
  .label {text-align: right}
  .error {color: red}
  .centerdiv {
	border: 1px solid; 
	width: 350px; 
	min-width: 299px; 
	display: block; 
	margin: auto;
	border-radius: 20px;
	background: white;
	}
  
</style>
</head>

<body style="background: aliceblue">
<div style="padding: 20px;">
<div style="padding: 10px;" class="centerdiv">
<h1>Welcome {{username}}</h1>
<p></p>
<ul>
<li><a href="/">Goto Blog Home</a></li>
<li><a href="/logout">Logout</a></li>
<li><a href="/newpost">Create a New Post</a></li>
</ul>
</div>
</div>
</body>
</html>
