<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer List</title>
</head>
<body>
<h3>회원관리 페이지</h3>

<div id='list-top'>
	<form method="post" action='list.cu'>
	<div>
		<ul>
			<li style="margin-right: 10px;"><span>회원등급</span></li>
			<li>
				<select name='admin' class='w-px160' onchange="$('form').submit()" style="outline: none;">
					<option value='all' ${admin eq 'all' ? 'selected' : '' }>전체</option>
					<c:forEach items="${admins}" var="vo">
					<option ${admin ne 'all' and admin eq vo.admin ? 'selected' : '' } value='${vo.admin}'>${vo.admin eq "N" ? "일반회원" : "전문가"}</option>	
					</c:forEach>
				</select>
			</li>
		</ul>
	</div>
	</form>
</div>

<table class="w-pct80 tb_list">
<thead>	
	<tr>
		<th>회원등급</th>
		<th>고객명</th>
		<th>성별</th>
		<th>생년월일</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${list }" var="vo">
	<tr style="border: 1px solid #c0c0c0;">
		
		<td>${vo.admin == 'N' ? "일반회원" : "전문가" }</td>
		<td>${vo.name }</td>
		<td>${vo.gender }</td>
		<td>${empty vo.birth ? "-" : vo.birth }</td>
		<td>${empty vo.addr ? "-" : vo.addr }</td>
		<td>${empty vo.tel ? "-" : vo.tel }</td>
		<td>${empty vo.email ? "-" : vo.email }</td>
		<td><a class="btn-fill" style="margin: 15px;" onclick="if( confirm('정말 삭제하시겠습니까??') ) { href='delete.cu?id=${vo.id }' }">삭제</a></td>
	</tr>
	</c:forEach>
</tbody>
</table>
</body>
</html>




