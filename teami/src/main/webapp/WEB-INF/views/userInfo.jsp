
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page session="false" %>

<html>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
   <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<link href="/resources/assets/css/home.css" rel="stylesheet">
	   <script src="/resources/assets/js/jquery.min.js"></script>
	   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<title>userInfo</title>
</head>
<body>
		<div class="centered">
		<div class="centered2">
		    <br/>
				<h2>U S E R  I N F O</h2> <br/>
				<table>
					
				        <tr>
				            <td>NAME</td><td><sec:authentication property = "principal.username"/></td>
				        </tr>
				        <tr>
				            <td>ID</td><td><sec:authentication property = "principal.member.user_name"/></td>
				         
				        </tr>
				    
			        <tr>
			        	<td>PW </td> <td> <input type="password" name="user_pw" id="user_pw" class="form-control"></input>
			        	<button type="button" id="checkpw" name="checkpw" id="checkpw" class="btn btn-default">확인</button> 
			        	</td>             
			        </tr>
			         <tr> 
			        	<td>NEW PW </td>
			        	<form role="form" action="/updatePw" method="post" id="updatePw">  
			        	<td><input type="password" name="user_pw" id="user_pw" class="form-control"></input>
			        	<input type="hidden" name="user_id" value='<sec:authentication property = "principal.member.user_name"/>' />
			        	<input type="hidden" name="user_name" value='<sec:authentication property = "principal.username"/>' />
			        			        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			        			        		        <input type="hidden" name="auth" value="ROLE_MEMBER" />
			        	<button type="submit" value="changePw" id="changePw" name="changePw" class="btn btn-default">변경
			        	</button>
			        	</td></form>
			        	
		
			        </tr>
			        
		        </table><br/>
		        <br/> <br/><br/>
		        <a href="/deleteUser?user_id='<sec:authentication property = "principal.username"/>'" class="button">회원탈퇴</a>
		        <input type="hidden" name="auth" value="ROLE_MEMBER" />
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</div>
		</div>
		
</body>

</html>

<script type="text/javascript">


$(document).ready(function(){
    $('#checkpw').on("click", function(e){
    	var token = $("meta[name='_csrf']").attr("content");
 	   var header = $("meta[name='_csrf_header']").attr("content");   
 	   
 	   var user_pw = $("#user_pw").val();
 	   
 	  $.ajax({
          url : "/pwChk",
          type : "get",
          dataType : "json",
          data : {"user_pw" :user_pw},
          beforeSend : function(xhr)
          {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
              xhr.setRequestHeader(header,token);
          },
 	        success : function(result){
 	        	console.log(result);
 	        	console.log(user_pw);
 	            if(result == 1){
 	               alert("확인.");
 	               $("#user_pw").removeAttr("disabled");
 	            }else if(result == 0){
 	               alert("틀림.");
 	               $("#user_pw").val('');
 	            }
 	         }
 	   })
    });
    var updatePw = $("#updatePw");
    $('#changePw').on("click", function(e){
    	var token = $("meta[name='_csrf']").attr("content");
  	   var header = $("meta[name='_csrf_header']").attr("content");   
    	  updatePw.submit();
		$.ajax({
			url: '/updatePW',
			processData: false,
			contentType: false,
			type: 'POST',
			dataType: 'text',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log(result);
				//showUploadResult(result);	//업로드 결과 처리 함수
			}
		});


    	
    });
});


</script>
