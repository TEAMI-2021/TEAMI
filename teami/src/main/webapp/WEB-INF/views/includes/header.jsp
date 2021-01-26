<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<!-- Header -->
		<header id="header">
			<!-- Search -->
			<section id="search" class="alt">
				<form method="post" action="#">
				<input type="text" name="query" id="query" placeholder="Search" />
				</form>
			</section>
										
			<ul class="icons">
				<li><span><img src="${pageContext.request.contextPath}/resources/img/enter.png" alt="방입장" width="30px" height="37px"></span></li>
				<li><span><img src="${pageContext.request.contextPath}/resources/img/create.png" alt="방생성" width="30px" height="37px"></span></li>
				<li><a href="index.html" class="logo"><strong>ID</strong> 님 반갑습니다! </a><a href="#" class="button small">로그아웃</a></li>
			</ul>								
		</header>
	</body>
</html>