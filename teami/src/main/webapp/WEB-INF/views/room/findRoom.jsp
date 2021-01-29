<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>

<html>
<head> 
	<link href="/resources/assets/css/room.css" rel="stylesheet">
	<title>FindRoom</title>
	<script src="/resources/assets/js/jquery.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form class="form" action="/room/findRoom" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>방 코드 </td> <td> <input name="room_code" id="inputRoomCode"></input></td>
					</tr>

			    </table>
			    <br/>
			    <input type="submit" value="방 입장하기" id="submitFindRoom"></input><br/> <br/><br/>
				<input type="hidden" name="user_id" value=<sec:authentication property = "principal.username"/> />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    </form>

		</div>
		</div>
		
		<!-- 모달창 -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
           	aria-labelledby="myModalLabel" aria-hidden="true">
             <div class="modal-dialog" role="document"> 
             	<div class="modal-content">
             		<div class="modal-header">
             			<h4 class = "modal-title" id = "myModalLabel">Room Code Check</h4>
             			
                	</div>
                	<div class="modal-body">유효하지 않는 방 코드 입니다.</div>
                	<div class="modal-footer">
                		<button type="button" class="btn btn-primary"
                			data-dismiss="modal">Close</button>
                	</div>
                </div>
             </div>	
         </div>  
</body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		//history.replaceState({}, null, null);
		
		function checkModal(result){
			
			if(parseInt(result)===0){
				$("#myModal").modal("show");	
			}
		}
	});
</script>