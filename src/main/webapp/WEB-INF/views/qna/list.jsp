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
<h3><a href="javascript:history.back(-1)"><img alt="QnA" src="imgs/QnA.png"></a> </h3>

<form method="post" action="list.qa"> 
<input type="hidden" name="curPage" value="1"/>
<!-- <input type="hidden" name="q_id" value="q_id"/> -->
<div id="list-top" style="width:60%; margin:0 auto;">
	<div>
		<ul>
			<li><select name="search" class="w-px90">
				<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
				<option value="q_title" ${page.search eq 'q_title' ? 'selected' : '' }>제목</option>
				<option value="q_content" ${page.search eq 'q_content' ? 'selected' : '' }>내용</option>
				<option value="q_writer" ${page.search eq 'q_writer' ? 'selected' : '' }>작성자</option>
				</select>
			</li>
			<li><input type="text" name="keyword"  value="${page.keyword }" class="w-px300"/></li>
			<li><a class="btn-se" onclick='$("form").submit()'>검색</a></li>
		</ul>
	
	
	
	
		<ul>
		<!--  로그인된 경우만 글쓰기 가능 -->
		<c:if test="${!empty loginInfo}"> <!-- admin이 Y이면 글쓰기 버튼이 보인다 -->
		<li><a class="btn-se" href="new.qa">글쓰기</a></li>
		</c:if>
		</ul>
	</div>
</div>
</form>
<table class="tb_list">
<thead><tr><th class="w-px80">번호</th>
			<th class="w-px120">질문유형</th><th>제목</th>
			<th class="w-px100">작성자</th>
			<th class="w-px100">작성일자</th>
			<th class="w-px80">첨부파일</th>
		</tr>
</thead>
<tbody>
	<c:if test="${empty page.list }">
		<tr>
			<td colspan="6">검색 결과가 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${page.list}" var="vo"> 
	<tr style="border: 1px solid #b0b0b0; "><td>${vo.no }</td>
	<td>${vo.q_type }</td>
	<td class="left" style="text-align:justify; ">
		<c:forEach begin="1" end="${vo.q_indent}" var="i">
			${i eq vo.q_indent ? "<img src='imgs/re.gif'/>" : "&nbsp;&nbsp;"}
		</c:forEach> 
			<a href='detail.qa?q_id=${vo.q_id}'>${vo.q_title }</a></td>
		<td style="text-align:justify; ">${vo.q_name }</td>
		<td>${vo.q_writedate }</td>
		<td>${empty vo.q_filename ? '' : '<img src="imgs/attach.png" class="file-img" />' }</td>
	</tr>
	</c:forEach>
</tbody>
</table>

<div class="btnSet">
<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
</body>
</html>











    