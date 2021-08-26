<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h3>QnA 글 수정화면</h3>

<form method="post" enctype='multipart/form-data' action='update.qa'>
<input type="hidden" name="q_id" value="${vo.q_id}" />
<input type="hidden" name="curPage"  />
<input type="hidden" name="keyword" />
<input type="hidden" name="search" />
<input type="hidden" name="id"  />
<input type="hidden" name="name" />
<table>
<tr><th class="w-px120">제목</th>
	<td><input type="text" name="q_title" class="chk" title="제목" value="${vo.q_title}" /></td>
</tr>
<tr><th class="w-px120">내용</th>
	<td><textarea name="q_content" class="chk" title="내용" style="margin: 0px; width: 100%; height: 300px;">${vo.q_content}</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<label><a><img src="imgs/select.png" class="file-img"></a>
				<input type="file" name="file" id="attach-file"/>
		</label>
		<span id="file-name">${vo.q_filename}</span>
		<a id="delete-file" 
		style='display:${empty vo.q_filename ? "none" : "inline"}'><i class="font-img fas fa-times"></i></a>
	</td>
</tr>
</table>
<input type="hidden" name="attach" />
</form>
<div class="btnSet">
	<c:if test="${empty code }">
		<a class="btn-fill" onclick="if( emptyCheck() ) { $('[name=attach]').val( $('#file-name').text() ); $('form').submit() }">저장</a>
		<a class="btn-empty" href='detail.qa?q_id=${vo.q_id}'>취소</a>
	</c:if>
	
	<c:if test="${code == 1 }">
		<a class="btn-fill" onclick="if( emptyCheck() ) { $('[name=attach]').val( $('#file-name').text() ); go_detail('${curPage}','${search }','${keyword }', '${id }', '${name }'); }">저장</a>
		<a class="btn-empty" href='a_detail.qa?q_id=${vo.q_id}&curPage=${curPage}&search=${search}&keyword=${keyword}&id=${id}&name=${name}'>취소</a>
	</c:if>
</div>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
function go_detail(curPage, search, keyword, id, name) {
	$('[name=curPage]').val(curPage);
	$('[name=search]').val(search);
	$('[name=keyword]').val(keyword);
	$('[name=id]').val(id);
	$('[name=name]').val(name);
	$('form').attr('action', 'a_update.qa');
	$('form').submit();
}


</script>




</body>
</html>