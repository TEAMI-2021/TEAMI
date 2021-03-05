<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<link href="/resources/assets/css/home.css" rel="stylesheet">
	<title>JoinIn</title>
	<script src="/resources/assets/js/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <form role="form" action="/joinIn" method="post">
		    <br/>
				<h2>T E A M I</h2> <br/>
				<table>
					<tr>
						<td>NAME </td> 
						<td> <input name="user_name" class="form-control"></input></td> 
						<td>  <button  onClick="open_pop();"  id="id_duplicate_check">중복체크</button></td>
						
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
		<!-- 모달창 -->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
           	aria-labelledby="myModalLabel" aria-hidden="true">
             <div class="modal-dialog" role="document"> 
             	<div class="modal-content">
             		<div class="modal-header">
             			<h4 class = "modal-title" id = "myModalLabel2">Id Duplicate Check</h4>
             			
                	</div>
                	<div class="modal-body">중복된 아이디 입니다.</div>
                	<div class="modal-footer">
                		<button type="button" class="btn btn-primary"
                			data-dismiss="modal">Close</button>
                	</div>
                </div>
             </div>	
         </div>  

</body>
</html>
<!-- 
<script type="text/javascript">
$(document).ready(function(){
	$("#myModal2").modal("show");
	function openModel(result){
		$("#myModal2").modal("show");
	}
});



</script>
 -->