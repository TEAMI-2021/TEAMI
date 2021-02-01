<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 글쓰기 페이지 -->
<title>글쓰기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" /><link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
		
	

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

										<!-- Form -->
													<!-- Form -->
													<h3>글쓰기</h3>
													<form method="post" action="/board/register">
														<div class="row gtr-uniform">
															<div class="col-12">
																<input type="text" name="title" value="" placeholder="글제목" />
															</div>
															<!-- Break -->
															<div class="col-12">
																<select name="demo-category" id="demo-category">
																	<option value="">- 팀선택 -</option>
																	<option value="1">팀1</option>
																	<option value="1">팀2</option>
																</select>
															</div>
															<!-- Break -->
															<div class="col-6 col-12-small">
																<input type="checkbox" id="demo-copy" name="demo-copy">
																<label for="demo-copy">공지&nbsp;&nbsp;</label></div>
																<div>
																<a href="#" class="button icon solid fa-download">첨부파일</a>
															</div>
															
															<!-- Break -->
															<div class="col-12">
																<textarea name="content" placeholder="Enter your message" rows="6"></textarea>
															</div>
															<!-- Break -->
															<div class="col-12">
																<ul class="actions">
																	<li><input type="submit" value="글쓰기" class="primary" /></li>
																</ul>
															</div>
															<input type="hidden" name="writer" value=<sec:authentication property = "principal.username"/> />
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														</div>
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

	</body>
</html>