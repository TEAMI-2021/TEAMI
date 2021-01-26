<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>

<html>
<head> 
	<link href="/resources/css/room.css" rel="stylesheet">
	<title>FindRoom</title>
</head>
<script type = "text/javascript">
	$(document).ready(function(){
		function fn_roomChk(){
			$.ajax({
				url:"/room/roomChk",
				type : "post"
				dataType : "json",
				data : {"room_code" : $("#room_code").val()},
				success: function(data){
					if(data==1){
						$("#roomChk").attr("value", "Y");
						
					}else if(data == 0){
						alert("유효하지 않는 방코드입니다.")
					}
					
				}
			})
		}
	})
</script>
<body>
		<div class="centered">
		<div class="centered2">
		    <form class="form" action="/room/findRoom" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>방 코드 </td> <td> <input name="room_code"></input></td>
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
             <div class="modal-dialog"> 
             	<div class="modal-content">
             		<div class="modal-header">
             			<h4 class = "modal-title" id = "myModalLabel">Room Code Check</h4>
             			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                		</button>
                	</div>
                	<div class="modal-body">처리가 완료되었습니다.</div>
                	<div class="modal-footer">
                		<button type="button" class="btn btn-default"
                			data-dismiss="modal">Close</button>
                		<button type="button" class="btn btn-primary">Save changes</button>
                	</div>
                </div>
             </div>	
         </div>  
</body>
</html>

<script type="text/javascript">
	
</script>