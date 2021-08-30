<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<style>
tr td:first-chilid { font-size: 14px; text-align: left; }
tr td:last-child { font-size: 14px; text-align: right; }

table { width: 450px; height: 315px;}

.title { margin-left: 5px; }

.date { margin-right: 10px; }

table tr { border: 2px solid #8338ec; }

td span img { margin-left:6px; }

td span img { vertical-align: middle; margin-bottom: 2px; }

</style>

<table>
<tr>
   <th colspan="2">Review Update</th>
</tr>

<c:forEach items="${ad_list }" var="vo" begin="0" end="2">
<tr>
<td><a href="detail.re?id=${vo.rv_id}&curPage=${curPage}"><span class="title">${vo.rv_title}<img alt="" src="imgs/main_new.png"></span></a></td>
<td><span class="date">${vo.rv_writedate }</span></td>
</tr>
</c:forEach>

<c:forEach items="${ad_list }" var="vo" begin="3" end="4">
<tr>
<td><a href="detail.re?id=${vo.rv_id}&curPage=${curPage}"><span class="title">${vo.rv_title}</span></a></td>
<td><span class="date">${vo.rv_writedate }</span></td>
</tr>
</c:forEach>

</table>