<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>

<html>
<head> 
	<link href="/resources/css/room.css" rel="stylesheet">
	<title>NewRoom</title>
</head>
<body>
	<!-- 방코드 임의 코드 및 중복방지 처리 자바에서 처리 완료 -->
		<div class="centered">
		<div class="centered2">
		    <form class="form" action="/room/newRoom" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>방 이름 </td> <td> <input name="room_name"></input></td>
					</tr>
					<tr>
			        	<td>방 코드 </td> <td> <input type="text" name="room_code" value="${room_code }" readonly></input></td>
			        </tr>
			    </table>
			    <br/>
			    <input type="submit" value="방 생성하기"></input><br/> <br/><br/>
			    <input type="hidden" name="user_id" value=<sec:authentication property = "principal.username"/> />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </form>

		</div>
		</div>   
</body>
</html>
