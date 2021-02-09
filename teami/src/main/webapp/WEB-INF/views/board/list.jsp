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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
		
	
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
									            <td><p style="text-align:right"><c:out value="${board.writer}"/>&nbsp;|&nbsp;<fmt:formatDate pattern="yy-MM-dd HH:mm:ss" value = "${board.regdate}"/>&nbsp;</p></td>
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
									                <c:choose>
									                	<c:when test="${room_code==null}">
									                		 <a href="/board/modify?room_code=<c:out value="${board.room_code}"/>&bno=<c:out value="${board.bno}"/>">수정</a>&nbsp;&nbsp;|
									                	</c:when>
									           			<c:otherwise>
									           				<a href="/board/modify?room_code=<c:out value="${room_code}"/>&bno=<c:out value="${board.bno}"/>">수정</a>&nbsp;&nbsp;|
									           			</c:otherwise>
									                </c:choose>
									                <a href="#">삭제</a>&nbsp;&nbsp;
									              </p>
											      </div>

											    </td>								         
									        
									        </table> </c:forEach>
									      </td>
								
									    </tr>

									  </table>
													</div>
													<ul class="pagination">
														<c:choose>
															<c:when test="${pageMaker.prev }">
																<li><a class="page-link" href="${pageMaker.startPage -1 }" tabindex="-1">Prev</a></li>
															</c:when>
															<c:otherwise>
																<li><span class="button disabled">Prev</span></li>
															</c:otherwise>
														</c:choose>
														<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
															<li><a class="page ${pageMaker.cri.pageNum==num?"active":""}"" href="${num }">${num }</a></li>
														</c:forEach>
														<c:choose>
															<c:when test="${pageMaker.next }">
																<li><a href="${pageMaker.endPage +1 }" class="page-link">Next</a></li>
															</c:when>
															<c:otherwise>
																<li><span class="button disabled">Next</span></li>
															</c:otherwise>
														</c:choose>
														<p style="text-align:right;">
									                <a href="/board/register" class="button" style="text-align:right;">글쓰기</a></p>
													</ul>
 
													<form id="actionForm" action="/board/list" method="get">
														<c:choose>
														<c:when test="${room_code ==null }">
															<input type="hidden" name="pageNum" value = "${pageMaker.cri.pageNum }">
                											<input type="hidden" name="amount" value = "${pageMaker.cri.amount }">
														</c:when>
														<c:otherwise>
															<input type="hidden" name="room_code" value = "${room_code}">
															<input type="hidden" name="pageNum" value = "${pageMaker.cri.pageNum }">
                											<input type="hidden" name="amount" value = "${pageMaker.cri.amount }">
														</c:otherwise>
               											</c:choose>
               										</form>
						</div>
					</div>

				<!-- Sidebar -->
					<jsp:include page="../includes/sidebar.jsp" flush="false"/>
						
					</div>
					
					

		<!-- Scripts -->
			<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>
			<script type = "text/javascript">
			$(document).ready(function(){
				var actionForm = $("#actionForm");
			
				$(".page").on("click", function(e){
				
					e.preventDefault();
				
					var targetPage = $(this).attr("href");
				
					console.log(targetPage);
				
					actionForm.find("input[name='pageNum']").val(targetPage);
					actionForm.submit();
				});
				$(".page-link").on("click", function(e){
					
					e.preventDefault();
				
					var targetPage = $(this).attr("href");
				
					console.log(targetPage);
				
					actionForm.find("input[name='pageNum']").val(targetPage);
					actionForm.submit();
				});

		});
		</script>
	</body>
</html>