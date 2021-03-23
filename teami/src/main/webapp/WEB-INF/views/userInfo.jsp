
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<link href="/resources/assets/css/home.css" rel="stylesheet">
	<title>userInfo</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form role="form" action="/userInfo" method="post">
		    <br/>
				<h2>U S E R  I N F O</h2> <br/>
				<table>
					
				        <tr>
				            <td>NAME</td><td><c:out value=""/></td>
				        </tr>
				        <tr>
				            <td>ID</td><td><c:out value=""/></td>
				         
				        </tr>
				    
			        <tr>
			        	<td>PW </td> <td> <input type="password" name="user_pw" class="form-control"></input></td>
			        </tr>
			        
		        </table><br/>
		        <input type="submit" value="비밀번호 변경하기" class="btn btn-default"></input><br/> <br/><br/>
		        <button><a href="/deleteUser?user_id='<sec:authentication property = "principal.username"/>'">회원탈퇴</a></button>
		        <input type="button" value="회원탈퇴" name="deleteUser"></input></br>
		        <input type="hidden" name="auth" value="ROLE_MEMBER" />
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </form>
		</div>
		</div>

</body>
</html>
