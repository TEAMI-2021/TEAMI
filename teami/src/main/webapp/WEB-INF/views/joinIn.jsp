<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<link href="/resources/css/home.css" rel="stylesheet">
	<title>JoinIn</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form role="form" action="/joinIn" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>NAME </td> <td> <input name="user_name" class="form-control"></input></td>
					</tr>
					<tr>
			        	<td>ID </td> <td> <input name="user_id" class="form-control"></input></td>
			        </tr>
			        <tr>
			        	<td>PW </td> <td> <input type="password" name="user_pw" class="form-control"></input></td>
			        </tr>
		        </table><br/>
		        <input type="submit" value="JoinIn" class="btn btn-default"></input><br/> <br/><br/>
		        <input type="hidden" name="auth" value="ROLE_MEMBER" />
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </form>
		</div>
		</div>   
</body>
</html>
