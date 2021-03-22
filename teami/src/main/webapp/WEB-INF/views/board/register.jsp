<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
													<form method="post" action="/board/register" id="form">
														<div class="row gtr-uniform">
															<div class="col-12">
																<input type="text" name="title" value="" placeholder="글제목" />
															</div>
															<!-- Break -->
															<div class="col-12">
																<select name="room_code" id="room_code">
																	<option value="">- 팀선택 -</option>
																	<c:forEach items="${roomList}" var="room">
																		<option value="${room.room_code}"><c:out value="${room.room_name}"/>(방코드: <c:out value="${room.room_code}"/>)</option>
																	</c:forEach>
																</select>
															</div>
															<!-- Break -->
															<div class="col-6 col-12-small">
																<input type="checkbox" id="notice" name="notice" onchange="YnCheck(this)">
																<label for="notice">공지&nbsp;&nbsp;</label></div>
															<div class="uploadDiv">
																<!-- <a href="#" class="button icon solid fa-download">첨부파일</a> -->
																
																<input type="file" name='uploadFile' class="button icon solid fa-download" multiple>
																<ul class='uploadResult'>
																</ul>
																
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
			<script type="text/javascript">
				function YnCheck(obj){
					var checked = obj.checked;
					if(checked){
						obj.value='1';
					}else{
						obj.value='0';
					}
				};
			</script>


<script type="text/javascript">

$(document).ready(function(){

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");	
	console.log("register page");

	
	var formObj = $("#form");
	
	$("input[type='submit']").on("click", function(e){
		//여기가 경고창 띄우는 부분
		if(!formObj.find("input[name='title']").val()){
			alert("제목을 입력하세요");
			return false;
		}
		else if($("#room_code").val() == ''){
			alert("게시할 방을 선택하세요");
			return false;
		}
		else if(!formObj.find("textarea[name='content']").val()){
			alert("글 내용을 작성하세요");
			return false;
		} 
		
		e.preventDefault();
		
		console.log("submit clicked");
		
		var str = "";
		
		$(".uploadResult li").each(function(i, obj){
			
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		});
		formObj.append(str).submit();
		
		$.ajax({
			url: '/board/register',
			processData: false,
			contentType: false,
			type: 'POST',
			dataType: 'text',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log(result);
				//showUploadResult(result);	//업로드 결과 처리 함수
			}
		});
	});
	
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;

	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		
		var uploadUL = $(".uploadResult");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
			
			str += "<li ";
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' ><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>";
			str += "</div></li>";
			
		});
		
		uploadUL.append(str);
	}
	
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/board/deleteFile',
			data: {fileName: targetFile},
			type: 'POST',
			dataType: 'text',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});
	
	$("input[type='file']").change(function(e){
		console.log("dddddd");
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		//console.log(files);
		
		for(var i=0; i<files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}		
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/board/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log(result);
				showUploadResult(result);	//업로드 결과 처리 함수
			}
		});
	});

});
</script>



	</body>
</html>