<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<h3> </h3>
<form action="insert.fb" method="post" enctype="multipart/form-data">
<table>
	<tr><th class='w-px120'>제목</th>
		<td><input type='text' name='title' class='chk' title='제목'/></td>
	</tr>
	<tr><th>내용</th>
		<td><textarea name='content' class='chk' title='내용' style="margin: 0px; width: 100%; height: 300px;"></textarea>
		</td>
	</tr>
	<tr><th>첨부파일</th>
		<td class='left middle'>
			<label>
				<input type='file' name='file' id='attach-file' />
				<a><img src='imgs/select.png' class='file-img'/></a>
			</label>
			<span id='file-name'></span>
			<span id='preview'></span>
			<a id='delete-file'><i class='font-img fas fa-times'></i></a>
		</td>
	</tr>
</table>
</form>
<div class='btnSet'>
	<a class='btn-fill' onclick="if( emptyCheck() ) $('form').submit()">저장</a>
	<a class='btn-empty' href='list.fb'>취소</a>
</div>
<script type="text/javascript" 
	src='js/file_check.js?v=<%=new java.util.Date().getTime()%>'></script>






</body>
</html>