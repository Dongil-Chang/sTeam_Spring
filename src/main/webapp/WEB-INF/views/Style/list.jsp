<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><img alt="" src="imgs/style.png"> </h3>
<div id='list-top'>
<form method="post" action='list.st'>
<input type="hidden" name="curPage" value='1'/>
<input type="hidden" name="id" />
<div>
	<ul>
		<li><select name='search' class='w-px90'>
			<option value='all' ${page.search eq 'all' ? 'selected' : ''}>전체</option>
			<option value='title' ${page.search eq 'title' ? 'selected' : ''}>제목</option>
			<option value='content' ${page.search eq 'content' ? 'selected' : ''}>내용</option>
			<option value='writer' ${page.search eq 'writer' ? 'selected' : ''}>작성자</option>
			</select>
		</li>
		<li><input type='text' name='keyword' value='${page.keyword}' class='w-px300'/></li>
		<li><a class="btn-se" onclick='$("form").submit()'>검색</a></li>
	</ul>
	<ul>
		<li><span style="margin-right: 20px; font-weight: bold; color:#cc0073">* 전문가만 글 작성이 가능합니다</span></li>
		<!-- 전문가인 경우만 글쓰기 가능 -->
		<c:if test="${loginInfo.admin eq 'S'}">
		<li><a class='btn-se' href='new.st' style="margin-right: 20px;">글쓰기</a></li>
		</c:if>
		
		<li>
			<select name='pageList' class='w-px90' onchange="$('form').submit()">
			<option value='10' ${page.pageList eq 10 ? 'selected' : ''}>10개씩</option>
			<option value='15' ${page.pageList eq 15 ? 'selected' : ''}>15개씩</option>
			<option value='20' ${page.pageList eq 20 ? 'selected' : ''}>20개씩</option>
			<option value='25' ${page.pageList eq 25 ? 'selected' : ''}>25개씩</option>
			<option value='30' ${page.pageList eq 30 ? 'selected' : ''}>30개씩</option>
			</select>
		</li>
	</ul>
</div>

</form>
</div>

<div id='data-list'>

<c:if test="${page.viewType eq 'grid'}">
<ul class='grid'>
	<c:forEach items="${page.list}" var="vo">
	<li><div><a onclick='go_detail(${vo.id})'>${vo.title}</a></div>
		<div>${vo.name}</div>
		<div>${vo.writedate} [${vo.readcnt}]<span style="float:right;">${empty vo.filename ? '' : "<img src='imgs/attach.png' class='file-img'/>"}</span></div>
	</li>
	</c:forEach>
</ul>
</c:if>

<c:if test="${page.viewType eq 'list'}">
<table class='tb_list'>
<thead>
	<tr><th class='w-px70'>번호</th>
		<th>제목</th>
		<th class='w-px100'>작성자</th>
		<th class='w-px100'>작성일자</th>
		<th class='w-px80'>조회수</th>
		<th class='w-px60'>첨부파일</th>
	</tr>
</thead>
<tbody>
	<c:if test="${empty page.list}">
	<tr><td colspan='6'>등록된 게시글 정보가 없습니다</td></tr>
	</c:if>
	
	<c:forEach items="${page.list}" var="vo">
	<tr><td>${vo.no}</td>
		<td class='left'><a onclick='go_detail(${vo.id})'>${vo.title}</a></td>
		<td>${vo.name}</td>
		<td>${vo.writedate}</td>
		<td>${vo.readcnt}</td>
		<td>${empty vo.filename ? '' : '<img src="imgs/attach.png" class="file-img"/>'}</td>
	</tr>
	</c:forEach>
</tbody>
</table>
</c:if>

</div>

<div class='btnSet'>
	<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>

<script type="text/javascript">
function go_detail(id){
	$('[name=id]').val( id );
	$('form').attr('action', 'detail.st');
	$('form').submit();
}


</script>
</body>
</html>