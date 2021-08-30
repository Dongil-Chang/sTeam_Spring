<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer List</title>

<style type="text/css">
body * { outline: none; }

h3 { margin:60px 0 0 0; font-size: 30px; }

#list-top { float: left; padding: 10px 10%; margin-top: 80px; }
/* 
select { height: 43px; } */

.box ul li:nth-child(3) { margin: 0px 0px 5px 5px; }

.box ul li:nth-child(3) a { margin: 0px 0px 0px 5px; }

.box lu li input { font-size: 20px; padding: 5px 0; }

.empty td { font-size: 20px; font-weight: bold; padding: 30px 0 30px 0; }

.item { border: 1px solid #c0c0c0; }

.btn-empty:hover { background: #8338ec; color: white; font-weight: bold; }

.btn-fill-s:hover { background: white; color: #8338ec; font-weight: bold; }

a.btn-fill-s { 
	font-size:13px; font-weight:bold; 
	padding:10px 10px;
	border:1px solid #9163cb;
	border-radius:3px;
	box-shadow:2px 2px 2px #8338ec;
	background-color:#9163cb;  
	color: #fed102; 
}

a.btn-empty { margin: 10px; }

table.tb_list tr { height: 70px; }

#list-top { width: 81%; }

.box ul:first-child { height: 20px; }

.box ul li:last-child { height: 40px; margin-right: 10px;  }

thead tr th { letter-spacing: 2px; }




</style>

</head>
<body>
<h3><img alt="관리자페이지" src="imgs/Mm.png"> </h3>

<%-- <div id='list-top' style="float: right; padding-bottom: 0;">
	<form method="post" action='list.cu' id="List_form">
	<input type="hidden" name="curPage" value="1">
	<div>
		<ul>
			<li style="margin-right: 10px;"><span>회원등급</span></li>
			<li>
				<select name='admin' class='w-px160' onchange="$('#List_form').submit()">
					<option value='all' ${admin eq 'all' ? 'selected' : '' }>전체</option>
					<c:forEach items="${admins}" var="vo">
					<option ${admin ne 'all' and admin eq vo.admin ? 'selected' : '' } value='${vo.admin}'>${vo.admin eq "N" ? "일반회원" : "전문가"}</option>	
					</c:forEach>
				</select>
			</li>
		</ul>
	</div>
	</form>
</div> --%>


<div id="list-top"> 
<form action="list.cu" method="post">
	<input type="hidden" name="curPage" value="1" />
	<input type="hidden" name="id"/>
	<input type="hidden" name="name" />
	<div class="box">
		<ul>
			<li>
				<select name="search" class="w-px90" >
					<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
					<option value="name" ${page.search eq 'name' ? 'selected' : '' }>고객명</option>
					<option value="tel" ${page.search eq 'tel' ? 'selected' : '' }>전화번호</option>
					<option value="addr" ${page.search eq 'addr' ? 'selected' : '' }>주소</option>
				</select>
			</li>
			<li><input type="text" name="keyword" class="w-px300" value="${page.keyword }" /></li>
			<li><a class="btn-se"  onclick="$('form').submit()" >검색</a></li>
		</ul>
			
			
  		<c:if test="${empty page.keyword }">
		<ul>
			<li><a class="btn-empty"  href="list.cu" style="display: none;" >목록바로가기</a></li>
		</ul>				
		</c:if>
		
		
		<c:if test="${!empty page.keyword }">
		<ul>
			<li><a class="btn-empty"  href="list.cu" >목록바로가기</a></li>
		</ul>				
		</c:if>
		
	</div>
</form>
</div>




<table class="w-pct80 tb_list">
<thead>	
	<tr>
		<th class="w-px50">번호</th>
		<th class="w-px80">회원등급</th>
		<th class="w-px80">고객명</th>
		<th class="w-px60">성별</th>
		<th class="w-px100">생년월일</th>
		<th class="w-px280">주소</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th colspan="5">관리자 기능</th>
	</tr>
</thead>
<tbody>
	<%-- <c:if test="${! empty list }">
		<c:if test="${empty search }">
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
		</c:if>
	</c:if> --%>
	
		
		<c:if test="${empty page.list }">
		<tr class="empty">
			<td colspan="9">조회된 결과가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach items="${page.list }" var="vo">
			<tr class="item">
				<td>${vo.no }</td>
				<c:if test="${vo.admin eq 'N' }">
					<td style="color: purple;">일반회원</td>
				</c:if>
				<c:if test="${vo.admin eq 'S' }">
					<td style="color: blue;">전문가</td>
				</c:if>
				<c:if test="${vo.admin eq 'Y' }">
					<td style="color: green;">#관리자</td>
				</c:if>
				<td>${vo.name }</td>
				<td>${vo.gender }</td>
				<td>${empty vo.birth ? "-" : vo.birth }</td>
				<td>${empty vo.addr ? "-" : vo.addr }</td>
				<td>${empty vo.tel ? "-" : vo.tel }</td>
				<td>${empty vo.email ? "-" : vo.email }</td>
				<%-- onclick="go_writeList( '${vo.id}', '${vo.name }' )" --%>
				<td><a class="btn-fill-s" onclick="go_QnaList( '${vo.id}', '${vo.name }', ${page.curPage } )">Q</a></td>
				<td><a class="btn-fill-s" onclick="go_CommuList( '${vo.id}', '${vo.name }', ${page.curPage } )">C</a></td>
				<td><a class="btn-fill-s" onclick="go_ReviewList( '${vo.id}', '${vo.name }', ${page.curPage } )">R</a></td>
				
				<c:if test="${vo.admin eq 'S' }">
				<td><a class="btn-fill-s" onclick="go_StyleList( '${vo.id}', '${vo.name }', ${page.curPage } )">S</a></td>
				</c:if>
				
				<c:if test="${vo.admin ne 'S' }">
				<td><a class="btn-fill-s" style="display: none;">S</a></td>
				</c:if>
				
				<td><a class="btn-fill-s" onclick="if( confirm('정말 삭제 하시겠습니까??') ) { href='delete.cu?id=${vo.id }&curPage=${page.curPage }' }" style="margin: 10px 0; margin-right: 2px;" >회원삭제</a></td>
			</tr>
		</c:forEach>
</tbody>
</table>

<div class="btnSet">
<jsp:include page="/WEB-INF/views/include/page.jsp" />
</div>


<script type="text/javascript">
function go_QnaList(id, name, curPage) {
	$("[name=id]").val(id);
	$("[name=name]").val(name);
	$("[name=curPage]").val(curPage);
	$("form").attr("action", "qna_list.cu");
	$("form").submit();
} 


function go_CommuList(id, name, curPage) {
	$("[name=id]").val(id);
	$("[name=name]").val(name);
	$("[name=curPage]").val(curPage);
	$("form").attr("action", "co_list.cu");
	$("form").submit();
}


function go_ReviewList(id, name, curPage) {
	$("[name=id]").val(id);
	$("[name=name]").val(name);
	$("[name=curPage]").val(curPage);
	$("form").attr("action", "re_list.cu");
	$("form").submit();
}


function go_StyleList(id, name, curPage) {
	$("[name=id]").val(id);
	$("[name=name]").val(name);
	$("[name=curPage]").val(curPage);
	$("form").attr("action", "st_list.cu");
	$("form").submit();
}





/* $(".btn-empty").click(function(){
//	alert($("[name=keyword]").val());
	$("[name=keyword]").val("");
	
}); */




	





</script>





</body>
</html>




