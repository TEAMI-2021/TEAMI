<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<link href="resources/css/home.css" rel="stylesheet">
	<title>LogIn</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form class="form" method='post' action='/login'>
		    <h2>T E A M I</h2> <br/>
		    <table>
		    	<tr>
		    		<td>ID  <input type="text" name="username"></input><br/><br/></td>
		    	</tr>
		    	<tr>
		    		<td>PW <input type="password" name="password"></input><br/><br/></td>	
		    	</tr>
		    </table>
		    <br/>
		        <input type="submit" value="login"></input>
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </form>
		    ID가 없으신가요? <button onclick="location='joinIn'">회원가입</button><br/><br/>
		</div>
		</div>   
</body>
</html>
