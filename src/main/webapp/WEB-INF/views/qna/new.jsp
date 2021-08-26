<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<style type="text/css">
#select { width: 100px; height: 35px; float: left; font-size: 17px; }

</style>
</head>
<body>
<h3>QnA글작성</h3>

<!-- 파일첨부하여 submit 하는 경우 
1. method는 post로 지정
2. form 에는 반드시 enctype='multipart/form-data' 지정

-->

<form method="post" action="insert.qa" enctype='multipart/form-data'>
<table>
<tr class="select"><th class='w-px120'> 질문유형</th>
	<td>
	<select name='q_type' id="select" class="w-px100" >
	
		<option>일반질문</option>
		<option>스타일링</option>
		<option>헤어제품</option>
		<option>헤어케어</option>
	</select>
	</td>
<tr><th class='w-px120'>제목</th>
	<td><input type="text" name="q_title" class="chk w-pct80" title="제목"></td>
</tr>
<tr><th>내용</th>
	<td><textarea name="q_content" class="chk w-pct80" title="내용" style="resize: none; height: 300px;"></textarea></td>
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
	<a class="btn-empty" href="list.qa">취소</a>
</div>

</body>
</html>