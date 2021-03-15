<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
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
				<form method="post" action="/board/modify" id="form">
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
						<div class="uploadDiv">
							<!-- <a href="#" class="button icon solid fa-download">첨부파일</a> -->									
							<input type="file" name='uploadFile' class="button icon solid fa-download" multiple>
							<ul class='uploadResult'>
							</ul>								
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
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		
		var bno = '<c:out value="${board.bno}"/>'
		var room_code = '<c:out value="${room.room_code}"/>'
		$.getJSON("/board/getAttachList", {bno: bno, room_code: room_code}, function(arr){
			console.log(arr);				
			var str="";
				
			$(arr).each(function(i, attach){
				var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
						
				str += "<li ";
				str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<span> " + attach.fileName + "</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>";
				str += "</div></li>";
			});
			$(".uploadResult").html(str);
		});
		
		$(".uploadResult").on("click", "button", function(e){
			if(confirm("Remove this file? ")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
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
		var formObj = $("#form");
		$("input[type='submit']").on("click", function(e){
			
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