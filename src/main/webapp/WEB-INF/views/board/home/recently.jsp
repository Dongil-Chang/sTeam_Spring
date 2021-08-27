<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<style>
tr td { font-size: 14px; text-align: left; }

table { width: 420px;}

.title { margin-left: 5px; }

.date { margin-right: 10px; }

table tr { border: 1px solid gray; }

td span img { margin-left:6px; }

</style>

<table>
<tr>
	<th colspan="2">최근 커뮤니티</th>
</tr>

<c:forEach items="${ad_list }" var="vo" begin="0" end="2">
<tr>
<td><a href="detail.fb?id=${vo.id}"><span class="title">${vo.title}<img alt="" src="imgs/main_new.png"></span></a></td>
<td><span class="date">${vo.writedate }</span></td>
</tr>
</c:forEach>

<c:forEach items="${ad_list }" var="vo" begin="3" end="4">
<tr>
<td><a href="detail.fb?id=${vo.id}"><span class="title">${vo.title}</span></a></td>
<td><span class="date">${vo.writedate }</span></td>
</tr>
</c:forEach>

</table>