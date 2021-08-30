<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
tr, th, td {
	border: 2px solid #e7d9f5;
}
</style>
</head>
<body>
<h3><a href="javascript:history.back(-1)"><img alt="" src="imgs/Notice.png"></a> </h3>

<table>
<tr><th class="w-px120">제목</th>
	<td class="left" colspan="5">${vo.title}</td>
</tr>
<tr><th>작성자</th>
	<td>${vo.name}</td>
	<th class="w-px100">작성일자</th>
	<td class="w-px100">${vo.writedate}</td>
	<th class="w-px80">조회수</th>
	<td class="w-px80">${vo.readcnt}</td>
</tr>
<tr><th>내용</th>
	<td class="left" colspan="5" style="text-align: justify; padding-left: 28px; padding-right: 28px;" >${fn:replace(vo.content, crlf, '<br>')}</td>
</tr>
<tr><th>첨부파일</th>
	<td class="left" colspan="5">${vo.filename}
		<c:if test="${ ! empty vo.filename }">
		<a href='download.no?id=${vo.id}'><i class="font-img fas fa-download"></i></a>
		</c:if>
		<c:if test="${empty vo.filename }">
			<span style="font-weight: bold; color: gray;">첨부파일이 없습니다.</span>
		</c:if>
	</td>
</tr>
</table>
<div class="btnSet">
	<a class="btn-fill" href="list.no?curPage=${page.curPage}&search=${page.search}keyword=${page.keyword}">목록으로</a>
	<!-- 관리자로 로그인된 경우 
		 로그인한 관리자가 쓴 글인 경우
	-->
	<c:if test="${vo.writer eq loginInfo.id}">
	<a class="btn-fill" href="modify.no?id=${vo.id}">수정</a>
	<a class="btn-fill" 
		onclick= "if( confirm('정말 삭제하시겠습니까?') ){ href='delete.no?id=${vo.id} '} ">삭제</a>
	</c:if>
	<!-- 로그인되어 있는 경우 답글쓰기 가능 -->
	<c:if test="${!empty loginInfo}">
	<a class="btn-fill" href="reply.no?id=${vo.id}">답글쓰기</a>
	</c:if> 
</div>

</body>
</html>