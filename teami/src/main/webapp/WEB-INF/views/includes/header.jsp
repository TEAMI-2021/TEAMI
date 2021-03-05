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
				<form id = 'searchForm' method="get" action="/board/list">
					<input type="hidden" name="type" value = "TC">
					<input type="text" name="keyword" placeholder="Search" />
					<button class='button small'>Search</button>
					<input type="hidden" name="pageNum" value = "${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value = "${pageMaker.cri.amount}">
					
				</form>
			</section>
										
			<ul class="icons">
				<li><span><a href="/room/findRoom"><img src="${pageContext.request.contextPath}/resources/img/enter.png" alt="방입장" width="30px" height="37px"></a></span></li>
				<li><span><a href="/room/newRoom"><img src="${pageContext.request.contextPath}/resources/img/create.png" alt="방생성" width="30px" height="37px"></a></span></li>
				<li><a href="index.html" class="logo"><strong>ID</strong> 님 반갑습니다! </a><a href="#" class="button small">로그아웃</a></li>
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