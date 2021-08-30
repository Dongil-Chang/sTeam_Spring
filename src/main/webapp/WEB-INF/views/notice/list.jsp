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
<h3><a href="javascript:history.back(-1)"><img alt="공지" src="imgs/Notice.png"></a> </h3>

<form method="post" action="list.no"> 
<input type="hidden" name="curPage" value="1"/>
<div id="list-top" style="width:60%; margin:0 auto;">
	<div>
		<ul>
			<li><select name="search" class="w-px90">
				<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
				<option value="title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>
				<option value="content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>
				<option value="writer" ${page.search eq 'writer' ? 'selected' : '' }>작성자</option>
				</select>
			</li>
			<li><input type="text" name="keyword"  value="${page.keyword }" class="w-px300"/></li>
			<li><a class="btn-se" onclick='$("form").submit()'>검색</a></li>
		</ul>
	
		<ul>
		<li><span style="margin-right: 30px; font-weight: bold; color:#cc0073">* 관리자만 글 작성이 가능합니다</span></li>
		<!-- 관리자로 로그인된 경우만 글쓰기 가능 -->
		<c:if test="${loginInfo.admin eq 'Y'}"> <!-- admin이 Y이면 글쓰기 버튼이 보인다 -->
		<li><a class="btn-fill" href="new.no">글쓰기</a></li>
		</c:if>
		<!-- 관리자로 로그인된 경우만 글쓰기 가능 -->
		</ul>
	</div>
</div>
</form>
<table class="tb_list">
	<thead><tr><th class="w-px70">번호</th>
			<!-- 	<th class="w-px60"></th> -->
				<th>제목</th>
				<th class="w-px100">작성자</th>
				<th class="w-px100">작성일자</th>
				<th class="w-px80">첨부파일</th>
			</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.list}" var="vo"> 
			<tr style="border: 1px solid #b0b0b0; "><td>${vo.no }</td>
<!-- 			<td></td> -->
			<td class="left" style="text-align:justify; padding-left: 30px;">
				<c:forEach begin="1" end="${vo.indent}" var="i">
					${i eq vo.indent ? "<img src='imgs/re.gif'/>" : "&nbsp;&nbsp;"}
				</c:forEach> 
					<a href='detail.no?id=${vo.id}'>${vo.title }</a></td>
				<td>${vo.name }</td>
				<td>${vo.writedate }</td>
				<td>${empty vo.filename ? '' : '<img src="imgs/attach.png" class="file-img" />' }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="btnSet">
	<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
</body>
</html>



    