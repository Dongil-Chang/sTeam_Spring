<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Info</title>
</head>
<body>
<form method="post" action='detail.mp'>
	<input type='hidden' name='id'/>
<div align="center">
<h3><a href="javascript:history.back(-1)"><img alt="" src="imgs/Member info.png"></a></h3>
<table border="1">
	<tbody>
	<tr>
		<th>아이디</th>
		<td>${vo.id}</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td>****</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${vo.name}</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<c:if test="${vo.birth eq null}">
			<td>등록된 생일정보가 없습니다</td>
		</c:if>
		<c:if test="${vo.birth ne null}">
			<td>${vo.birth}</td>
		</c:if>
	</tr>
	<tr>
		<th>성별</th>
		<td>${vo.gender}</td>
	</tr>
	<tr>
		<th>이메일</th>
		<%-- <td>${dto.member_email}</td> --%>
		<c:if test="${vo.email eq null and vo.social_email eq null}">
			<td>등록된 이메일이 없습니다</td>
		</c:if>
		<c:if test="${vo.email ne null}">
			<td>${vo.email}</td>
		</c:if>
		<c:if test="${vo.social_email ne null}">
			<td>${vo.social_email}</td>
		</c:if>
	</tr>
	<tr>
		<th>전화번호</th>
		<c:if test="${vo.tel eq null}">
			<td>등록된 전화번호가 없습니다</td>
		</c:if>
		<c:if test="${vo.tel ne null}">
			<td>${vo.tel}</td>
		</c:if>
	</tr>
	<tr>
		<th>주소</th>
		<c:if test="${vo.addr eq null}">
			<td>등록된 주소정보가 없습니다</td>
		</c:if>
		<c:if test="${vo.addr ne null}">
			<td>${vo.addr}</td>
		</c:if>
	</tr>
	</tbody>
	<tr align="center">
		<td colspan="2">
			<a class='btn-se' onclick="go_update('${vo.id}')">회원정보 수정</a>
			<a class='btn-se' onclick="location.href='list.mp'">목록으로 가기</a>
		</td>
	</tr>
</table>
</div>
</form>
<script type="text/javascript">
function go_update(id) {
	$("[name=id]").val(id);
	$('form').attr('action', 'modify.mp');
	$('form').submit();
}

</script>
</body>
</html>