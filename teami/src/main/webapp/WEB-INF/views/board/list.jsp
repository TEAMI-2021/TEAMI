<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
   <%@taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main_page</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" /><link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<meta name="_csrf" content="${_csrf.token}"/>
      <meta name="_csrf_header" content="${_csrf.headerName}"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
		<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
	
		<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<c:forEach items="${list}" var="board">
		<script>
		$(document).ready(function(){
			$("#spreadBtn<c:out value="${board.bno}"/>").click(function(){
				if($("#hiddenList<c:out value="${board.bno}"/>").is(":visible")){
					$("#hiddenList<c:out value="${board.bno}"/>").slideUp(); 
					}
				else{
						$("#hiddenList<c:out value="${board.bno}"/>").slideDown(); 
						} 
				}); 
			}); 
		</script></c:forEach>

	</head>
	<!-- 위 -->
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<jsp:include page="../includes/header.jsp" flush="false"/>

							 <!-- 게시글 ---->

										<!-- 게시글 -->
											
													<div class="table-wrapper">
														<table>
						
									    <tr>
									     
									     
									      <td>
									      
											<c:forEach items="${list}" var="board">
									       <table>
									       
									          <tr>
									          <tr>
									            <td><p style="text-align:right"><c:out value="${board.writer}"/>&nbsp;|&nbsp;<fmt:formatDate pattern="yyyy-MM-dd" value = "${board.regdate}"/>&nbsp;</p></td>
									          </tr>						 
											
											    <td>
											        
											    <div id="spreadBtn<c:out value="${board.bno}"/>" class="btn01">
											    <strong><div><c:out value="${board.bno}"/></div></strong>
											    <div><c:out value="${board.title}"/></div>
											    </div>
											     <div id="hiddenList<c:out value="${board.bno}"/>" class="example01" style="display: none;">
											      <c:out value="${board.content}"/>
											      <p style="text-align:right;">
									                <a href="#">댓글</a>&nbsp;&nbsp;|
									                <a href="#">수정</a>&nbsp;&nbsp;|
									                <a href="#">삭제</a>&nbsp;&nbsp;
									              </p>
									              <div id="comments">
                                         <div class="comment_row">
                                         
                                               <textarea id="reply_text<c:out value="${board.bno}"/>" name="reply_text"></textarea>
                                               <button id="addReplyBtn<c:out value="${board.bno}"/>" class="btn btn-primary btn-xs pull-right" type="submit">댓글 쓰기</button>
                                               
									                  <!-- /.panel -->
												    <div class="panel panel-default">
												<!--       <div class="panel-heading">
												        <i class="fa fa-comments fa-fw"></i> Reply
												      </div> -->
												      
												      <div class="panel-heading">
												        <i class="fa fa-comments fa-fw"></i> Reply
												      </div>      
      
									              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<script src="${pageContext.request.contextPath}/resources/assets/js/reply.js"></script>
											<ul class="chat<c:out value="${board.bno}"/>"></ul>			
											<script>
											 function callRemove(rno,bnoValue){
												 var token =$("meta[name='_csrf']").attr("content");
													var header =$("meta[name='_csrf_header']").attr("content");
												 var replyUL = $(".chat"+bnoValue);
												 
										     
										     	  replyService.remove(header,token,rno, function(result){
										     	      alert(result);
										     	      showList(1,bnoValue,replyUL);
										     	  });
							     	  
								}
											function showList(page,bnoValue,replyUL){
												
												//var bnoValue = '<c:out value="${board.bno}"/>';
												  //var replyUL = $(".chat<c:out value="${board.bno}"/>");
											    replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {
											    	
											    	var str="";
											    	if(list==null||list.length==0){
											    		replyUL.html("");
											    		
											    		return;
											    	}
											    	
											    	 for (var i = 0, len = list.length || 0; i < len; i++) {
											    	       str +=" <table><tr><td><div  data-rno='"+list[i].rno+"'>";
											    	       str +="  <div><div class='header'><strong class='primary-font'>["
											    	    	   +list[i].replyer+"] </strong>"; 
											    	       str +="    <small class='pull-right text-muted'>"
											    	           +list[i].replyDate+"</small></div>";
											    	       str +="    <p>"+list[i].reply+"</p><p style='text-align:right' id='reply_remove<c:out value='${board.bno}'/>' name='reply_text'><a href='javascript:callRemove("+list[i].rno+","+bnoValue+");'>삭제</a>&nbsp;&nbsp;</p></div></div><tr><td></table>";
											    	       console.log(list[i]);
											    	     }
											    	 replyUL.html(str);
											    	});
											    }
											$(document).ready(function () {
												
												var bnoValue = '<c:out value="${board.bno}"/>';
												  var replyUL = $(".chat<c:out value="${board.bno}"/>");
												  
												    showList(1,bnoValue,replyUL);
											});
											$("#addReplyBtn<c:out value="${board.bno}"/>").on("click", function(e){
												// 화면으로부터 입력 받은 변수값의 처리 
												
												var reply = $("#reply_text<c:out value="${board.bno}"/>"); 
												var replyer = "작성자"; 
												var reply_Val = reply.val(); 
												var token =$("meta[name='_csrf']").attr("content");
												var header =$("meta[name='_csrf_header']").attr("content");
												var bnoValue = '<c:out value="${board.bno}"/>';
												  var replyUL = $(".chat<c:out value="${board.bno}"/>");

												
											//var reply = {
														//reply:"댓글",
											           // replyer:"작성자",
											            //bno:bnoValue
											         // };
												replyService.add(header,token,{
													reply:reply_Val,
										            replyer:"작성자",
										            bno:bnoValue
										          }, function(result){
											        
											        alert("result :"+result);
											        reply.val("");

											       
											        //showList(1);
											       showList(1,bnoValue,replyUL);
											        
											      });

											     
											      
											    });
											
											
											</script>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<script type="text/javascript">
											$(document).ready(function() {
											  
											 console.log(replyService);
											    
											  });

											
											</script>
                                               </div>
                                          </div>
                                          </div>
                                          
                                          <!---->
                                         
									              
											      </div>

											    </td>								         
									        
									        </table> </c:forEach>
									      </td>
								
									    </tr>

									  </table>
													</div>
													<ul class="pagination">
														<li><span class="button disabled">Prev</span></li>
														<li><a href="#" class="page active">1</a></li>
														<li><a href="#" class="page">2</a></li>
														<li><a href="#" class="page">3</a></li>
														<li><span>&hellip;</span></li>
														<li><a href="#" class="page">8</a></li>
														<li><a href="#" class="page">9</a></li>
														<li><a href="#" class="page">10</a></li>
														<li><a href="#" class="button">Next</a></li>
														<p style="text-align:right;">
									                <a href="/board/register" class="button" onclick="loaction:/board/register"  style="text-align:right;">글쓰기</a></p>
													</ul>
 
							
						</div>
					</div>

				<!-- Sidebar -->
					<jsp:include page="../includes/sidebar.jsp" flush="false"/>
						
					</div>
					
					

		<!-- Scripts -->
		



 

	</body>
</html>