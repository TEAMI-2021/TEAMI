<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 글수정 페이지 -->
<title>글수정</title>
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
				<h3>수정하기</h3>
				<form method="post" action="/board/modify">
					<div class="row gtr-uniform">
						<div class="col-12">
							<input type="hidden" name="bno" value="${board.bno} "/>
							<input type="text" name="title" value='<c:out value="${board.title }"/>'/>
						</div>
					<!-- Break -->
						<div class="col-12">
							<input type = "hidden" name="room_code" value='<c:out value="${room.room_code}"/>'/>
							<input type = "text" value='<c:out value="${room.room_name}"/>(방코드: <c:out value="${room.room_code}"/>)' readonly="readonly"/>
							<!-- 
							<select name="demo-category" id="demo-category">
								<option value="">- 팀선택 -</option>
								<option value="1">팀1</option>
								<option value="1">팀2</option>
							</select>
							 -->
						</div>
						<!-- Break -->
						<div class="col-6 col-12-small">
								<c:set var = "notice2" value='${board.notice }'/>
								<c:choose>
									<c:when test="${board.notice == '1'.charAt(0)}">
										<input type="checkbox" id="notice" name="notice" onchange="YnCheck(this)" checked="checked">
										<label for="notice">공지&nbsp;&nbsp;</label>
									</c:when>
									<c:otherwise>
										<input type="checkbox" id="notice" name="notice" onchange="YnCheck(this)">
										<label for="notice">공지&nbsp;&nbsp;</label>
									</c:otherwise>
								</c:choose>
						</div>
						<div>
							<a href="#" class="button icon solid fa-download">첨부파일</a>
						</div>
															
						<!-- Break -->
						<div class="col-12">
							<textarea name="content" rows="6"><c:out value="${board.content}"/></textarea>
						</div>
						<!-- Break -->
						<div class="col-12">
							<ul class="actions">
							<li><input type="submit" value="수정하기" class="primary" /></li>
							</ul>
						</div>
						<input type="hidden" name="writer" value='<sec:authentication property = "principal.username"/>'/>
						<input type="hidden" name="regdate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'/>
						<input type="hidden" name="updatedate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}" />'/>
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
			
	<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $('form');
		//remove 버튼이 눌리면, action 속성 값을 /board/remove로 변경함
		
		//<button>이 클릭되면 함수를 실행해라.
		$('.primary').on("click", function(){

			formObj.submit(); //서버에 <input>에 담긴 데이터를 전달하면서 요청
		});
		
		console.log(${board.notice});
	});
	
	function YnCheck(obj){
		var checked = obj.checked;
		if(checked){
			obj.value='1';
		}else{
			obj.value='0';
		}
	};
	</script>
	
	</body>
</html>