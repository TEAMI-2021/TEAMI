<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div id="sidebar">
			<div class="inner">
				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2>TEAMI</h2>
					</header>
					<ul>
						<li><a href="index.html">Mypage</a></li>
						<c:forEach items="${roomList}" var="room">
							<li>
							<span class="opener active"><c:out value="${room.room_name}"/></span>
							<ul>
								<li><a href="/board/list?room_code=<c:out value="${room.room_code}"/>">전체글</a></li>
								<li><a href="#">공지</a></li>
								<li><a href="#">파일</a></li>						
							</ul>
						</li>
						</c:forEach>
					</ul>
				</nav>
									
				<!-- 사이드 Footer -->
				<footer id="footer">
					<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
				</footer>
			</div>
		</div>
	</body>
</html>