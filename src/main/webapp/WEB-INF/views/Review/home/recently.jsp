<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<style>
tr td:first-chilid { font-size: 14px; text-align: left; }
tr td:last-child { font-size: 14px; text-align: right; }

table { width: 500px;}

.title { margin-left: 5px; }

.date { margin-right: 10px; }

table tr { border: 1px solid gray; }

</style>

<table>
<tr>
	<th colspan="2">최근 리뷰</th>
</tr>
<c:forEach items="${ad_list }" var="vo">
<tr>
<td><a href="detail.re?id=${vo.rv_id}"><span class="title">${vo.rv_title}</span></a></td>
<td><span class="date">${vo.rv_writedate }</span></td>
</tr>
</c:forEach>
</table>