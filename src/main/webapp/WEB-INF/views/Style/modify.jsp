<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='js/file_check.js'></script>	<!-- 태그보다 위 쪽에 선언된 경우   -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="js/summernote-ko-KR.js"></script>
<script>
$(document).ready(function() {
	  $('#summernote').summernote({
 	    	/* placeholder: 'content', */
	        minHeight: 370,
	        maxHeight: null,
	        fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
 	    	fontNamesIgnoreCheck : [ '맑은고딕' ],
	        focus: true, 
	        lang : 'ko-KR',
	        callbacks : { 
	        	onImageUpload : function(files){
	        		for (var i = files.length - 1; i >= 0; i--) {
	        			sendFile(files[i]);
		           	}
	    			/* sendFile(files[0]); */
	    		}
        	}
	  });
});
function sendFile(file){
	var data = new FormData();	
	data.append("file",file);
	$.ajax({
		url: "uploadSummernoteImageFile", //////여기 본인 주소! 
		type: "POST",
		enctype: 'multipart/form-data',
		data: data,
		cache: false,
		contentType : false,
		processData : false,
		success: function(image){
			console.log( image.url );
			var url = "<c:url value='"+image.url+"' />" 
			$('#summernote').summernote('insertImage',url);
		},
		error: function(e){console.log(e);}  
	});	
}
</script>
<style type="text/css">
tr{style="text-align: center;"}
</style>
</head>
<body>
<h3><img alt="" src="imgs/style.png"></h3>
<form action="update.st" method="post" enctype="multipart/form-data">
<input type='hidden' name='attach' />
<input type='hidden' name='id' value='${vo.id}' />
<table >
<tr><th class='w-px120'>제목</th>
	<td><input type='text' name='title' value='${vo.title}' class='chk w-pct80' title='제목' /></td>
</tr>
<tr><th>내용</th>
	<td><textarea id="summernote" name='content' class='chk w-pct80' title='내용' style=" resize : none; height: 370px;">${vo.content}</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class='left middle'><label>
		<input type='file' name='file' id='attach-file'>
		<a><img src='imgs/attach.png' class='file-img'/></a>
		</label>
		<span id='file-name'>${vo.filename}</span>
		<span id='preview'></span>
		<a id='delete-file'><i class='fas fa-times font-img'></i></a>
	</td>
</tr>
</table>
</form>
<div class='btnSet'>
	<a class='btn-fill' onclick="if( emptyCheck() ) { $('[name=attach]').val( $('#file-name').text() );  $('form').submit() }">저장</a>
	<a class='btn-empty' onclick="history.go(-1)">취소</a>
</div>

<script type="text/javascript" src='js/file_check.js'></script>
<script type="text/javascript">
if( ${ ! empty vo.filename } ){
	//첨부파일이 있는 글인 경우 삭제버튼 보이게
	$('#delete-file').css('display', 'inline');
	//첨부파일이 이미지파일인 경우 미리보기 되게
	if( isImage( '${vo.filename}' ) ) 
		$('#preview').html( "<img src='${vo.filepath}' id='preview-img' />" );
}
</script>
</body>
</html>







