<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<form id = 'searchForm' method="get" action="/board/list">
					<input type="hidden" name="type" value = "TC">
					<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="Search" />
					<button class='button small'>Search</button>
					<input type="hidden" name="pageNum" value = "${cri.pageNum}">
					<input type="hidden" name="amount" value = "${cri.amount}">
					
				</form>
			</section>
										
			<ul class="icons">
				<form action="/customLogout" method="post">
				<li><span><a href="/room/findRoom"><img src="${pageContext.request.contextPath}/resources/img/enter.png" alt="방입장" width="30px" height="37px"></a></span></li>
				<li><span><a href="/room/newRoom"><img src="${pageContext.request.contextPath}/resources/img/create.png" alt="방생성" width="30px" height="37px"></a></span></li>
				<li><a href="index.html" class="logo"><strong><sec:authentication property = "principal.username"/></strong> 님 반갑습니다! </a>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				<button class="button small">로그아웃</button></li></form>
			</ul>								
		</header>
		<script type = "text/javascript">
			$(document).ready(function(){
				var searchForm = $("#searchForm");
			
				$('#searchForm button').on("click", function(e){
					if(!searchForm.find("input[name='keyword']").val()){
						alert("검색어를 입력하세요");
						return false;
					}
					searchForm.find("input[name='pageNum']").val("1");
					e.preventDefault();
					searchForm.submit();
				});
		});
		</script>
	</body>
</html>