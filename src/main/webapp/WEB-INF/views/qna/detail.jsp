<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>QnA글 안내</h3>

<table>
<tr><th class="w-px120">제목</th>
	<td class="left" colspan="5">${vo.q_title}</td>
</tr>
<tr><th class="w-px120">질문유형</th>
	<td class="left" colspan="5">${vo.q_type}</td>
</tr>
<tr><th>작성자</th>
	<td>${vo.q_name}</td>
	<th class="w-px100">작성일자</th>
	<td class="w-px100">${vo.q_writedate}</td>
	<th class="w-px80">조회수</th>
	<td class="w-px80">${vo.q_readcnt}</td>
</tr>

<tr><th>내용</th>
	<td class="left" colspan="5">${fn:replace(vo.q_content, crlf, '<br>')}</td>
</tr>

<tr><th>첨부파일</th>
	<td class="left" colspan="5">${vo.q_filename}
		<c:if test="${ ! empty vo.q_filename }">
		<a href='download.qa?q_id=${vo.q_id}'><i class="font-img fas fa-download"></i></a>
		</c:if>
		
	</td>
</tr>
</table>

<div class="btnSet">
	
	<c:if test="${empty code }">
	<a class="btn-fill" href="list.qa?curPage=${page.curPage}&search=${page.search}keyword=${page.keyword}">목록으로</a>
	</c:if>
	
	<%-- <c:if test="${loginInfo.admin eq 'Y' }">
	<a class="btn-fill" href="qna_list.cu?curPage=${page.curPage}&search=${page.search}keyword=${page.keyword}&id=${id}&name=${name}">돌아가기</a>
	</c:if> --%>
	
	<c:if test="${code == 1 }">
	<c:if test="${loginInfo.admin eq 'Y' || ( vo.q_writer eq loginInfo.id && loginInfo.admin eq 'Y' )}">
	<a class="btn-fill" href="qna_list.cu?curPage=${page.curPage}&search=${page.search}keyword=${page.keyword}&id=${id}&name=${name}">돌아가기</a>
	</c:if>
	</c:if>
	
	
	<!-- 관리자로 로그인된 경우 
		 로그인한 관리자가 쓴 글인 경우
	-->
	<%-- <c:if test="${vo.q_writer eq loginInfo.id}">
	<a class="btn-fill" href="modify.qa?q_id=${vo.q_id}">수정</a>
	<a class="btn-fill" 
		onclick= "if( confirm('정말 삭제하시겠습니까?') ){ href='delete.qa?q_id=${vo.q_id} '} ">삭제</a>
	</c:if> --%>
	
	
	
	<!-- 글쓴이와 관리자만 수정/삭제 권한을 가짐 -->
	<c:if test="${empty code }">
		<c:if test="${vo.q_writer eq loginInfo.id}">
			<a class="btn-fill" href="modify.qa?q_id=${vo.q_id}">수정</a>
		</c:if>
	</c:if>
	
	
	<c:if test="${code == 1 }">
		<c:if test="${vo.q_writer eq loginInfo.id}">
			<a class="btn-fill" href="a_modify.qa?q_id=${vo.q_id}&code=${code}&curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&id=${id}&name=${name}">수정</a>
		</c:if>
	</c:if>
	
	
	
	<!-- 관리자 페이지가 아닌 일반 게시글 페이지에서도 관리자가 삭제할 수 있게 -->
	<c:if test="${empty code }">
	<c:if test="${loginInfo.id eq vo.q_writer || loginInfo.admin eq 'Y'}">
		<a class="btn-fill" onclick= "if( confirm('정말 삭제하시겠습니까?') ){ href='delete.qa?q_id=${vo.q_id} '} ">삭제</a>
	</c:if>
	</c:if>
	
	
	<c:if test="${code == 1 }">
	<c:choose>
		<%-- <c:when test="${vo.q_writer eq loginInfo.id}">
			<a class="btn-fill" href="modify.qa?q_id=${vo.q_id}">수정</a>
			<a class="btn-fill" onclick= "if( confirm('정말 삭제하시겠습니까?') ){ href='delete.qa?q_id=${vo.q_id} '} ">삭제</a>
		</c:when> --%>
		<c:when test="${loginInfo.admin eq 'Y' || ( loginInfo.admin eq 'Y' && vo.q_writer eq loginInfo.id ) }">
			<a class="btn-fill" onclick= "if( confirm('정말 삭제하시겠습니까?') ) { href='a_delete.qa?q_id=${vo.q_id}&curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&id=${id}&name=${name}'} ">관리자권한 삭제</a>
		</c:when>
	</c:choose>
	</c:if>
	
	
	<!-- 관리자가 아니고 로그인되어 있는 경우 답글쓰기 가능 -->
	<c:if test="${empty code }">
	    <c:if test="${!empty loginInfo}">
			<a class="btn-fill" href="reply.qa?q_id=${vo.q_id}">답글쓰기</a>
		</c:if>
	</c:if>
	
	<c:if test="${code == 1 }">
		<c:if test="${loginInfo.admin eq 'Y'}">
			<a class="btn-fill" href="a_reply.qa?q_id=${vo.q_id}&curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&id=${id}&name=${name}">관리자 답글쓰기</a>
		</c:if>  
	</c:if>


</div>

</body>
</html>