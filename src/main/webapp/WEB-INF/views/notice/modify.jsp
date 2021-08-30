<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><img alt="" src="imgs/Notice.png"> </h3>

<form method="post" enctype='multipart/form-data' action='update.no'>
<input type="hidden" name="id" value="${vo.id}" />
<table>
<tr><th class="w-px120">제목</th>
	<td><input type="text" name="title" class="chk w-pct80" title="제목" value="${vo.title}" /></td>
</tr>
<tr><th class="w-px120">내용</th>
	<td><textarea name="content" class="chk w-pct80" title="내용" style="resize:none; height: 300px;">${vo.content}</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<label><a><img src="imgs/select.png" class="file-img"></a>
				<input type="file" name="file" id="attach-file"/>
		</label>
		<span id="file-name">${vo.filename}</span>
		<a id="delete-file" 
		style='display:${empty vo.filename ? "none" : "inline"}'><i class="font-img fas fa-times"></i></a>
	</td>
</tr>
</table>
<input type="hidden" name="attach" />
</form>
<div class="btnSet">
	<a class="btn-fill" onclick="if( emptyCheck() ) { $('[name=attach]').val( $('#file-name').text() ); $('form').submit() }">저장</a>
	<a class="btn-empty" href='detail.no?id=${vo.id}'>취소</a>
</div>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript" src="js/common.js"></script>
</body>
</html>