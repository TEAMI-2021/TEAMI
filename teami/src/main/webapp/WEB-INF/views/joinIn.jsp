<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<link href="resources/css/home.css" rel="stylesheet">
	<title>JoinIn</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form class="form">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>NAME </td> <td> <input name="name"></input></td>
					</tr>
					<tr>
			        	<td>ID </td> <td> <input name="id"></input></td>
			        </tr>
			        <tr>
			        	<td>PW </td> <td> <input type="password" name="pw"></input></td>
			        </tr>
		        </table><br/>
		        <input type="submit" value="JoinIn" id="submitB"></input><br/> <br/><br/>
		    </form>
		</div>
		</div>   
</body>
</html>
