<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main_page</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" /><link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
		
	
		<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>

		<script>
		$(document).ready(function(){
			$("#spreadBtn02").click(function(){
				if($("#hiddenList01").is(":visible")){
					$("#hiddenList01").slideUp(); 
					}
				else{
						$("#hiddenList01").slideDown(); 
						} 
				}); 
			}); 
		</script>

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
									        <table>
									          <tr>
									          <tr>
									            <td><p style="text-align:right">작성자&nbsp;|&nbsp;2021.01.08&nbsp;</p></td>
									          </tr>
									            <td>
									              <div id="accordion">
									                <div>테스트 글입니다</div>
									                <div>테스트테스트트ㅔ트트트트.</div>
									                <div>왜 안될까</div>
									                <div>테스트테스트테스테스테</div>										
									              </div>
									            </td>									         
									        
									        </table>

									       <table>
									          <tr>
									          <tr>
									            <td><p style="text-align:right">작성자&nbsp;|&nbsp;2021.01.08&nbsp;</p></td>
									          </tr>						 
											
											    <td>
											        
											    <div id="spreadBtn02" class="btn01">
											    <strong><div>제목 웅앵어쩌구</div></strong>
											    <div>내용 일부분 어쩌구</div>
											    </div>
											     <div id="hiddenList01" class="example01" style="display: none;">
											      전체 내오ㅛㅇ 어쩌구ㅜㅇㅇ
											      ㅇㅇㅇㅇㅇ
											      ㅇㅇㅇㅇ
											      <p style="text-align:right;">
									                <a href="#">댓글</a>&nbsp;&nbsp;|
									                <a href="#">수정</a>&nbsp;&nbsp;|
									                <a href="#">삭제</a>&nbsp;&nbsp;
									              </p>
											      </div>

											    </td>								         
									         
									        </table>
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
									                <a href="#" class="button" onclick="change(1)"  style="text-align:right;">글쓰기</a></p>
													</ul>
 
							
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

	</body>
</html>