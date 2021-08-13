<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class='page_list'>

<c:if test="${page.curBlock gt 1}">
<a class='page_first' onclick='go_page(1)'><i class="fas fa-angle-double-left"></i></a>
<a class='page_prev' onclick='go_page(${page.beginPage-page.blockPage})'><i class="fas fa-angle-left"></i></a>
</c:if>

<c:forEach begin="${page.beginPage}" end="${page.endPage}" var="no">
	<c:if test="${no eq page.curPage}">
		<span class='page_on'>${no}</span>
	</c:if>
	<c:if test="${no ne page.curPage}">
		<a class='page_off' onclick='go_page(${no})'>${no}</a>
	</c:if>
</c:forEach>

<c:if test="${page.curBlock lt page.totalBlock}">
<a class='page_next' title='다음' onclick='go_page(${page.endPage+1})'><i class="fas fa-angle-right"></i></a>
<a class='page_last' title='마지막' onclick='go_page(${page.totalPage})'><i class="fas fa-angle-double-right"></i></a>
</c:if>
</div>

<style>
.page_on, .page_off, .page_perv, .page_next, .page_last, .page_first {
	display:inline-block; line-height:30px; margin:0;  
}
.page_on {	
	border:1px solid #777; background-color:#999; color:#fff; font-weight:bold;
}
.page_on, .page_off { min-width:22px; padding:0 5px 2px;}
.page_perv, .page_next, .page_last, .page_first {
	width:30px; height:32px; color:#666;
}
</style>
<script>
function go_page(no){
	$('[name=curPage]').val( no );
	$('form').submit();
}
</script>











