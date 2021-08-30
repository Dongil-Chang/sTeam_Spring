<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
h3 { margin:60px 0 0 0; font-size: 30px;}

.empty  { font-size: 20px; font-weight: bold; padding: 30px 0 30px 0; }

#list-top { padding: 10px 10%; margin-top: 80px; margin-bottom: 10px; }

.box select { width: 100px; text-align: center;}

.box select option { text-align: center;}

.box ul li:nth-child(3) { margin: 0px 0px 5px 5px; }

.box ul li:nth-child(3) a { margin: 0px 0px 0px 5px;}

.box lu li input { font-size: 20px; padding: 5px 0; }

.empty  { font-size: 20px; font-weight: bold; padding: 30px 0 30px 0; }

.item { border: 1px solid #c0c0c0; }

.btn-empty:hover { background: #8338ec; color: white; font-weight: bold; }

a.btn-fill { margin: 0; padding: 6px 7px;}


a.btn-empty { margin: 10px; }

table.tb_list tr { height: 60px; }

#list-top { width: 81%; }

.box ul:first-child { height: 20px; }

.box ul li:last-child { height: 40px; margin-right: 10px;  }


</style>


</head>
<body>
<h3>${name }님 Style글 목록 화면입니다.</h3>
<div id='list-top'>
<form method="post" action='st_list.cu'>
<input type="hidden" name="curPage" value='1'/>
<input type="hidden" name="id" value="${u_id }" />
<input type="hidden" name="u_id"  />
<input type="hidden" name="name" value="${name }" />

<div class="box">
	<ul>
		<li><select name='search' class='w-px90'>
			<option value='all' ${StPage.search eq 'all' ? 'selected' : ''}>전체</option>
			<option value='title' ${StPage.search eq 'title' ? 'selected' : ''}>제목</option>
			<option value='content' ${StPage.search eq 'content' ? 'selected' : ''}>내용</option>
			<option value='writer' ${StPage.search eq 'writer' ? 'selected' : ''}>작성자</option>
			</select>
		</li>
		<li><input type='text' name='keyword' value='${StPage.keyword}' class='w-px300'/></li>
		<li><a class='btn-se' onclick='$("form").submit()'>검색</a></li>
	</ul>
	<ul>
		<li style="margin-right: 20px;"><a class='btn-se' href="list.cu?curPage=${page.curPage }&search=${page.search}&keyword=${page.keyword}">회원목록으로 돌아가기</a></li>
		<li>
			<select name='pageList' class='w-px90' onchange="$('form').submit()">
			<option value='10' ${StPage.pageList eq 10 ? 'selected' : ''}>10개씩</option>
			<option value='15' ${StPage.pageList eq 15 ? 'selected' : ''}>15개씩</option>
			<option value='20' ${StPage.pageList eq 20 ? 'selected' : ''}>20개씩</option>
			<option value='25' ${StPage.pageList eq 25 ? 'selected' : ''}>25개씩</option>
			<option value='30' ${StPage.pageList eq 30 ? 'selected' : ''}>30개씩</option>
			</select>
		</li>
	</ul>
</div>

</form>
</div>

<div id='data-list'>

<c:if test="${StPage.viewType eq 'grid'}">
<ul class='grid'>
	<c:forEach items="${StPage.list}" var="vo">
	<li><div><a onclick='go_detail(${vo.id}, "${u_id }", "${StPage.curPage }", "${StPage.search }", "${StPage.keyword }", "${name }")'>${vo.title }</a></div>
		<div>${vo.name}</div>
		<div>${vo.writedate} [${vo.readcnt}]<span style="float:right;">${empty vo.filename ? '' : "<img src='imgs/attach.png' class='file-img'/>"}</span></div>
	</li>
	</c:forEach>
</ul>
</c:if>

<c:if test="${StPage.viewType eq 'list'}">
<table class='tb_list'>
<thead>
	<tr><th class='w-px90'>번호</th>
		<th>제목</th>
		<th class='w-px120'>작성자</th>
		<th class='w-px120'>작성일자</th>
		<th class='w-px120'>첨부파일</th>
		<th class='w-px120'>조회수</th>
	</tr>
</thead>
<tbody>
	<c:if test="${empty StPage.list}">
	<tr><td colspan='6' class="empty">등록된 게시글 정보가 없습니다</td></tr>
	</c:if>
	
	<c:forEach items="${StPage.list}" var="vo">
	<tr class="item"><td>${vo.no}</td>
		<td class='left'><a onclick='go_detail(${vo.id}, "${u_id }", "${StPage.curPage }", "${StPage.search }", "${StPage.keyword }", "${name }")'>${vo.title }</a></td>
		<td>${vo.name}</td>
		<td>${vo.writedate}</td>
		<td>${empty vo.filename ? 'X' : '<img src="imgs/attach.png" class="file-img"/>'}</td>
		<td>${vo.readcnt}</td>
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
function go_detail(id, u_id, curPage, search, keyword, name){
	$('[name=id]').val( id );
	$('[name=u_id]').val( u_id );
	$('[name=curPage]').val( curPage );
	$('[name=search]').val( search );
	$('[name=keyword]').val( keyword );
	$('[name=name]').val( name );
	$('form').attr('action', 'a_detail.st');
	$('form').submit();
}


</script>
</body>
</html>