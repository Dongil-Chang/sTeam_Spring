<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='js/file_check.js'></script>
<script type="text/javascript" src="js/common.js"></script>
</head>
<body>
<h3><img alt="" src="imgs/answers.png"> </h3>

<!-- 파일첨부하여 submit 하는 경우 
1. method 는 post 로 지정
2. form 에는 반드시 enctype='multipart/form-data' 지정
-->
<form method='post' action='reply_insert.qa' enctype='multipart/form-data'>
<input type='hidden' name='q_root' value='${vo.q_root}'/>
<input type='hidden' name='q_step' value='${vo.q_step}'/>
<input type='hidden' name='q_indent' value='${vo.q_indent}'/>
<input type='hidden' name='q_type' value='${vo.q_type}'/>
<table>
<tr><th class='w-px120'>제목</th>
	<td><input type='text' name='q_title' class='chk w-pct80' title='제목'/></td>
</tr>
<tr><th>내용</th>
	<td><textarea name='q_content' class='chk w-pct80' title='내용' style="resize: none; height: 370px;" style="text-align: justify;"></textarea> </td>
</tr>
<tr><th>첨부파일</th>
	<td class='left'>
		<label>
		<a><img src='imgs/select.png' class='file-img' /></a>
		<input type='file' id='attach-file' name='file' />
		</label>
		<span id='file-name'></span>
		<a id='delete-file'><i class="font-img fas fa-times"></i></a>
	</td>
</tr>
</table>
</form>
<div class='btnSet'>
	
	<c:if test="${empty code }">
		<a class='btn-fill' onclick="if( emptyCheck() ) $('form').submit()">저장</a>
		<a class='btn-empty' href='list.qa'>취소</a>
	</c:if>
	
	<c:if test="${code == 1 }">
		<c:if test="${loginInfo.admin eq 'Y' }">
			<a class='btn-fill' onclick="if( emptyCheck() ) go_submit()">저장</a>
			<a class='btn-empty' href='a_detail.qa?q_id=${q_id }&id=${id }&name=${name}&curPage=${curPage}&keyword=${keyword}&search=${search}'>취소</a>
		</c:if>
	</c:if>
</div>

<!-- <script type="text/javascript" src='js/file_check.js'></script> -->
</body>

<script type="text/javascript">
function go_submit() {
	$('form').attr("action", 'a_reply_insert.qa' );
	$('form').submit();
}


</script>


</html>