<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
   <meta name="_csrf_header" content="${_csrf.headerName}"/>
   <link href="/resources/assets/css/home.css" rel="stylesheet">
   <title>JoinIn</title>
   <script src="/resources/assets/js/jquery.min.js"></script>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
   
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>

<body>
      <div class="centered">
      <div class="centered2">
          <form role="form" action="/joinIn" method="post" id="joinInForm">
          <br/>
            <h2>T E A M I</h2> <br/>
            <table>
               <tr>
                  <td>NAME </td> 
                  <td> <input name="user_name" class="form-control"></input></td> 
                  
                  
               </tr>
               <tr>
                    <td>ID </td> <td> <input id="user_id" name="user_id" class="form-control"></input></td>
                    <td>  <input id="checkButton" type="button" value="중복체크" onclick="fn_idChk();"/>
                    	<input type="hidden" id="id_duplicate_check"  value="N"/>
                    </td>
                    <!-- onclick="fn_idChk();" -->
                 </tr>
                 <tr>
                    <td>PW </td> <td> <input type="password" name="user_pw" class="form-control"></input></td>
                 </tr>
              </table><br/>
              <input type="submit" id="submitButton" value="JoinIn" class="btn btn-default"></input><br/> <br/><br/>
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

<script type="text/javascript">

	console.log("회원가입ㄱㄱㄱㄱ");
   function fn_idChk(){
	   
	   var token = $("meta[name='_csrf']").attr("content");
	   var header = $("meta[name='_csrf_header']").attr("content");   
	   
	   var user_id = $("#user_id").val();
	  
	   console.log(user_id);
      $.ajax({
         url : "/memberChk",
         type : "get",
         dataType : "json",
         data : {"user_id" : $("#user_id").val()},
         beforeSend : function(xhr)
         {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
             xhr.setRequestHeader(header,token);
         },
         success : function(result){
        	 console.log(user_id);
        	console.log(result);
            if(result == 1){
               alert("중복된 아이디입니다.");
            }else if(result == 0){
               $("#id_duplicate_check").attr("value", "Y");
               alert("사용가능한 아이디입니다.");
            }
         }
      })
   }
   
   $(document).ready(function(){
      $('#id_duplicate_check').on("click", function(e){
    	  var token = $("meta[name='_csrf']").attr("content");
   	   var header = $("meta[name='_csrf_header']").attr("content");   
   	   
   	   var user_id = $("#user_id").val();
   	  
   	   console.log(user_id);
         $.ajax({
            url : "/memberChk",
            type : "get",
            dataType : "json",
            data : {"user_id" : $("#user_id").val()},
            beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader(header,token);
            },
            success : function(result){
           	 console.log(user_id);
           	console.log(result);
               if(result == 1){
            	   $("#id_duplicate_check").attr("value", "N");
                  alert("중복된 아이디입니다.");
               }else if(result == 0){
                  $("#id_duplicate_check").attr("value", "Y");
                  alert("사용가능한 아이디입니다.");
               }
            }
         });
      });
      
      var joinInForm = $("#joinInForm");
		
		$('#submitButton').on("click", function(e){
			if(!joinInForm.find("input[name='user_name']").val()){
				alert("닉네임을 입력하세요");
				return false;
			}
			if(!joinInForm.find("input[name='user_id']").val()){
				alert("아이디를 입력하세요");
				return false;
			}
			if(!joinInForm.find("input[name='user_pw']").val()){
				alert("비밀번호를 입력하세요");
				return false;
			}
			if($("#id_duplicate_check").val()=="N"){
				alert("아이디 중복확인을 해주세요");
				return false;
			}
			e.preventDefault();
			joinInForm.submit();
		});
   });

</script>
 -->
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