<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript" src="js/common.js"></script>
</head>
<body>
<h3><img alt="" src="imgs/Notice.png"> </h3>

<!-- 파일첨부하여 submit 하는 경우 
1. method는 post로 지정
2. form 에는 반드시 enctype='multipart/form-data' 지정
-->

<form method="post" action="insert.no" enctype='multipart/form-data'>
<table>
<tr><th class='w-px120'>제목</th>
	<td><input type="text" name="title" class="chk w-pct80" title="제목"></td>
</tr>
<tr><th>내용</th>
	<td><textarea name="content" class="chk w-pct80" title="내용" style="resize:none; height: 370px;"></textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
	<label>
	<a><img src="imgs/select.png" class="file-img" /></a>
	<input type='file' id="attach-file" name="file" />
	</label>
	<span id='file-name'></span>
	<a id="delete-file"><i class="font-img fas fa-times"></i></a>
	</td>
</tr>

</table>
</form>
<div class="btnSet">
	<a class="btn-fill" onclick="if( emptyCheck() )$('form').submit()">저장</a>
	<a class="btn-empty" href="list.no">취소</a>
</div>

</body>
</html>