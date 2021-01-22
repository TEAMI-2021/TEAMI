<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head> 
	<link href="resources/css/room.css" rel="stylesheet">
	<title>FindRoom</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form class="form" action="/room/findRoom" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>방 코드 </td> <td> <input name="roomcodeFind"></input></td>
					</tr>

			    </table>
			    <br/>
			    <input type="submit" value="방 입장하기" id="submitFindRoom"></input><br/> <br/><br/>
				
		    </form>

		</div>
		</div>   
</body>
</html>
