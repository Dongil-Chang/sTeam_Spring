<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css">

body * { outline: none; }

h3 { margin:60px 0 0 0; font-size: 30px; }

#list-top { padding: 10px 10%; margin-top: 80px; margin-bottom: 10px; }

.box select {width: 100px; text-align: center;}

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

#list-top { width: 70%; margin-left: 5px; }

.box ul:first-child { height: 20px; }

.box ul li:last-child { height: 40px; margin-right: 10px;  }



</style>

</head>
<body>
<h3><span style="color: purple;">${name }</span>님 QnA 글 목록 화면입니다.</h3>

<form action="qna_list.cu" method="post">
<input type="hidden" name="curPage" value="1"/>
<input type="hidden" name="id" value="${id}"/>
<div id="list-top"> 
	<div class="box">
		<ul style="margin-left: 208px;">
			<li>
				<select name="search" class="w-px90">
					<option value="all" ${QnaPage.search eq 'all' ? 'selected' : '' }>제목 + 내용</option>
					<option value="q_title" ${QnaPage.search eq 'q_title' ? 'selected' : '' }>제목</option>
					<option value="q_content" ${QnaPage.search eq 'q_content' ? 'selected' : '' }>내용</option>
				</select>
			</li>
			<li><input type="text" name="keyword" class="w-px300" value="${QnaPage.keyword }" /></li>
			<li><a class="btn-se" onclick="$('form').submit()" >검색</a></li>
		</ul>
		<ul>
			<li><a class="btn-se" href="list.cu?curPage=${page.curPage }&search=${page.search}&keyword=${page.keyword}">회원목록으로 돌아가기</a>
		</ul>
	</div>
</div>
</form>

<table class="tb_list">
	<thead>
		<tr>
			<th class="w-px90">번호</th>
			<th class="w-px90">질문유형</th>
			<th>제목</th>
			<th class="w-px120">작성자</th>
			<th class="w-px120">작성일자</th>
			<th class="w-px120">첨부파일</th>
			
		</tr>	
	</thead>
	<tbody>
		<c:if test="${empty QnaPage.list}">
			<tr>
				<td colspan="6" class="empty">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${QnaPage.list}" var="vo">
		<tr class="item">
			<td>${vo.no}</td>
			<td>${vo.q_type}</td>
			<td class='left'>
					<c:forEach begin="1" end="${vo.q_indent}" var="i">
						${i eq vo.q_indent ? "<img src='imgs/re.gif'/>" : "&nbsp;&nbsp;"}
					</c:forEach>
					<a href='a_detail.qa?q_id=${vo.q_id}&curPage=${QnaPage.curPage}&search=${QnaPage.search}&keyword=${QnaPage.keyword}&id=${id}&name=${name}'>${vo.q_title }</a>
			</td>	
			<td>${vo.q_name}</td>
			<td>${vo.q_writedate}</td>
			<td>${empty vo.q_filename ? 'X' : '<img src="imgs/attach.png" class="file-img" />'}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

<div class="btnSet">
<jsp:include page="/WEB-INF/views/include/page.jsp" />
</div>

</body>
</html>