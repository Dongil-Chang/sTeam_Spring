<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<style>
tr td { font-size: 14px; text-align: left; }

table { width: 450px; margin: 0 50px; }

.title { margin-left: 5px; }

.date { margin-right: 10px; }

table tr { border: 1px solid gray; }

</style>

<table>
<tr>
	<th colspan="2">최근 공지사항</th>
</tr>
<c:forEach items="${ad_list }" var="vo">
<tr>
<td><a href="detail.no?id=${vo.id}"><span class="title">${vo.title}</span></a></td>
<td><span class="date">${vo.writedate }</span></td>
</tr>
</c:forEach>
</table>