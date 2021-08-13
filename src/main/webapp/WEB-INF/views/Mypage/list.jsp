<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css" >
</head>
<body>
<form method="post" action='list.mp'>
	<input type='hidden' name='curPage' value='1'/>
<div id='list-top'>
<a href=""><img src="imgs/MyPage.png"/></a>
</div>
</form>
<div class='btn_set dataOption'>
	<a>회원정보수정</a>
	<a>내가 쓴 글</a>
</div>
<table class='tb_list'>
<thead><tr><th class='w-px70'>번호</th><th>제목</th>
			<th class='w-px100'>작성자</th>
			<th class='w-px100'>작성일자</th>
			<th class='w-px80'>첨부파일</th>
		</tr>
</thead>
<tbody>
	<c:if test="${empty page.list}">
	<tr><td colspan='6'>게시글 정보가 없습니다.</td></tr>
	</c:if>
	<c:forEach items="${page.list}" var="vo">
	<tr>
		<td>${vo.no}</td>
		<td class='left'>
			<c:forEach begin="1" end="${vo.indent}" var="i">
				${i eq vo.indent ? "<img src='imgs/re.gif'/>" : "&nbsp;&nbsp;"}
			</c:forEach>
			<a href='detail.no?id=${vo.id}'>${vo.title}</a></td>
		<td>${vo.name}</td>
		<td>${vo.writedate}</td>
		<td>${empty vo.filename ? '' : '<img src="imgs/attach.png" class="file-img" />'}</td>
	</tr>
	</c:forEach>
</tbody>
</table>

<div class='btnSet'>
<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
<script type="text/javascript">
$('.dataOption a').click(function(){
	$('.dataOption a').removeClass();
	$(this).addClass('btn-fill');
	var idx = $(this).index();
	$('.dataOption a:not(:eq('+ idx +'))').addClass('btn-empty');
	if( idx==0 ) pharmacy_list(1);
	else if( idx==1 ) animal_list();
	
});

$(function(){
	$('.dataOption a:eq(0)').trigger('click'); //클릭이벤트 강제 발생 시키기
	
});
</script>
</body>
</html>