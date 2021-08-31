<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

tr, th, td {
	border: 2px solid #e7d9f5;
}

#popup { border: 2px solid #black; margin-top: 400px; }

#popup-background { 
	position: absolute; left: 0; top: 420px; width: 100%; height: 100%;
	background-color: #000; opacity: 0.3; display: none; 
}

</style>
</head>
<body>
<h3><a href="javascript:history.back(-1)"><img alt="" src="imgs/style.png"></a> </h3>
<table>
<tr>
	<th class="w-px120">유형</th>
	<td colspan="5" class="left" style="font-weight: bold">${vo.type }</td>
</tr>
<tr><th class='w-px120'>제목</th>
	<td colspan='5' class='left'>${vo.title}</td>
</tr>
<tr><th>작성자</th>
	<td>${vo.name}</td>
	<th class='w-px80'>작성일자</th>
	<td class='w-px200'>${vo.writedate}</td>
	<th class='w-px80'>조회수</th>
	<td class='w-px80'>${vo.readcnt}</td>
</tr>
<tr><th>내용</th>
	<td colspan='5' class='left' style='text-align: justify; padding-left: 28px; padding-right: 28px;'>${fn:replace(vo.content, crlf, '<br>')}</td>
</tr>
<tr><th>첨부파일</th>
	<td colspan='5' class='left'>${vo.filename}
		<c:if test="${!empty vo.filename}">
		<a id='preview'></a>
		<a href='download.st?id=${vo.id}'><i class='fas fa-download font-img'></i></a>
		</c:if>
		
		<c:if test="${empty vo.filename }">
			<span style="font-weight: bold; color: gray;">첨부파일이 없습니다.</span>
		</c:if>
	</td>
</tr>

</table>

<div class='btnSet'>


<c:if test="${empty code }">
<a class='btn-fill' href="mslist.mp?id=${loginInfo.id }">목록으로</a>
</c:if>


<c:if test="${code == 1 }">
	<c:if test="${loginInfo.admin eq 'Y' || ( vo.writer eq loginInfo.id && loginInfo.admin eq 'Y' )}">
		<a class='btn-fill' href="st_list.cu?curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&id=${u_id}&name=${name}">돌아가기</a>
	</c:if>
</c:if>


<!-- 글쓴이만 수정/삭제 권한을 가짐 -->
<c:if test="${loginInfo.id eq vo.writer }">
		<a class='btn-fill' onclick="$('form').attr('action', 'modify.st'); $('form').submit()">수정</a>
</c:if>

<!-- 관리자 페이지가 아닌 일반 게시글 페이지에서도 관리자가 삭제할 수 있게 -->
<c:if test="${empty code }">
	<c:if test="${loginInfo.id eq vo.writer || loginInfo.admin eq 'Y'}">
		<a class='btn-fill' onclick="if( confirm('정말 삭제하시겠습니까??') ){ href='mdelete.st?id=${vo.id}' }">삭제</a>
	</c:if>
</c:if>

<!-- 관리자 페이지에서 해당 회원 해당 게시글 목록보기에서 삭제 처리 -->
<c:if test="${code == 1 }">
	<c:if test="${loginInfo.admin eq 'Y' || ( loginInfo.admin eq 'Y' && vo.writer eq loginInfo.id ) }">
		<a class='btn-fill' onclick="if( confirm('정말 삭제 하시겠습니까??') ){ href='a_delete.st?id=${vo.id}&curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&u_id=${u_id}&name=${name} '}">관리자권한 삭제</a>
	</c:if>
</c:if>



</div>

<div id='popup-background'></div>
<div id='popup' class='center'></div>

<form method="post" action='mlist.st'>
	<input type='hidden' name='id' value='${vo.id}'/>
	<input type='hidden' name='search' value='${page.search}'/>
	<input type='hidden' name='keyword' value='${page.keyword}'/>
	<input type='hidden' name='pageList' value='${page.pageList}'/>
	<input type='hidden' name='curPage' value='${page.curPage}'/>
	<input type='hidden' name='viewType' value='${page.viewType}'/>
</form>

<script type="text/javascript" src='js/file_check.js'></script>
<script type="text/javascript">

$(function(){
	//첨부된 파일이 이미지 파일인 경우 미리보기되게
	if( ${ ! empty vo.filename } ){
		if( isImage( '${vo.filename}' ) ){
			$('#preview').html( "<img src='${vo.filepath}' id='preview-img'/>" );
		}
	}
});
$(document).on('click', '#preview-img', function(){
	$('#popup, #popup-background').css('display', 'block');
	$('#popup').html( "<img src='${vo.filepath}' class='popup'/>" );
	
}).on('click', '#popup-background', function(){
	$('#popup, #popup-background').css('display', 'none');
	
})
;
</script>
</body>
</html>






