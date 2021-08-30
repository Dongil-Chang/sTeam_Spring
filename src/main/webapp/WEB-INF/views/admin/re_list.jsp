<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

h3 { margin:60px 0 0 0; font-size: 30px; }

#list-top { padding: 10px 10%; margin-top: 80px; margin-bottom: 10px; }

.box select {width: 100px; text-align: center;}

.box select option { text-align: center;}

.box ul li:nth-child(3) { margin: 0px 0px 5px 5px; }

.box ul li:nth-child(3) a { margin: 0px 0px 0px 5px; }

.box lu li input { font-size: 20px; padding: 5px 0; }

.empty  { font-size: 20px; font-weight: bold; padding: 30px 0 30px 0; }

.item { border: 1px solid #c0c0c0; }

.btn-empty:hover { background: #8338ec; color: white; font-weight: bold; }

a.btn-fill { margin: 0; padding: 6px 7px;}


a.btn-empty { margin: 10px; }

table.tb_list tr { height: 60px; }

#list-top { width: 70%; }

.box ul:first-child { height: 20px; }

.box ul li:last-child { height: 40px; }



</style>

</head>
<body>
<h3>${name }님 후기작성 목록 화면입니다.</h3>
	
<div id="list-top">
<form action="re_list.cu" method="post">
<input type="hidden" name="curPage" value="1"/>
<input type="hidden" name="id" value="${u_id }" /> <!-- go_detail -->
<input type="hidden" name="u_id"  />
<input type="hidden" name="name" value="${name }" />
	

			<%-- <select name="search" class="w-px150"  id="hair_category" onchange="shoplist()">
					<c:forEach items="${shop_list }" var="vo">
						<option value="${vo.tel }">${vo.name }</option>				
					</c:forEach>
				</select> --%>
	<div class="box">
		<ul style="margin-left: 190px;">				
			<li>				<!-- onchange="$('form').submit()" -->
				<select name="search" class="w-px120"  id="hair_category" >
					<option value="all" ${RePage.search eq 'all' ? 'selected' : '' }>전체</option>
					<option value="rv_type" ${RePage.search eq 'rv_type' ? 'selected' : '' }>유형</option>
					<option value="rv_title" ${RePage.search eq 'rv_title' ? 'selected' : '' }>제목</option>
					<option value="rv_content" ${RePage.search eq 'rv_content' ? 'selected' : '' }>내용</option>						
					<%-- <option value="style" ${RePage.search eq 'style' ? 'selected' : '' }>스타일링</option>		 --%>				
				</select>
			</li>
			<li><input type='text' name='keyword' value='${RePage.keyword}' class='w-px300'/></li>
			<li><a class='btn-se' onclick='$("form").submit()'>검색</a></li>	
		</ul>
		
		<!-- 몇개씩 글목록을 보여지게 할것인지 하는곳 -->
		<ul>
			<li style="margin-right: 20px;"><a class='btn-se' href="list.cu?curPage=${page.curPage }&search=${page.search}&keyword=${page.keyword}">회원목록으로 돌아가기</a></li>
			<li>
				<select name="pageList" class="w-px90" onchange="$('form').submit()">
					<option value="5" ${RePage.pageList eq 5 ? 'selected' : ''}>5개</option>
					<option value="10" ${RePage.pageList eq 10 ? 'selected' : ''}>10개</option>
					<option value="15" ${RePage.pageList eq 15 ? 'selected' : '' }>15개</option>
					<option value="20" ${RePage.pageList eq 20 ? 'selected' : '' }>20개</option>
					<option value="25" ${RePage.pageList eq 25 ? 'selected' : '' }>25개</option>
					<option value="30" ${RePage.pageList eq 30 ? 'selected' : '' }>30개</option>
				</select>
			</li>
			
			<!-- 그리드 형태로 하는곳 -->
			<li>
				<select name="viewType" class="w-px110" onchange="$('form').submit()">
					<option value="list" ${RePage.viewType eq 'list' ? 'selected' : '' }>리스트</option>
					<option value="grid" ${RePage.viewType eq 'grid' ? 'selected' : '' }>그리드</option>
				</select>
			</li>
		</ul>
	</div>	
</form>
</div>
	
<div id='data-list'>
	<c:if test="${RePage.viewType eq 'grid' }">
		<ul class="grid">
			<c:forEach items="${RePage.list }" var="vo">
				<li>
					<div><a onclick='go_detail(${vo.rv_id}, "${u_id }", "${RePage.curPage }", "${RePage.search }", "${RePage.keyword }", "${name }")'>${vo.rv_title }</a></div>
					<c:if test="${!empty vo.shop_name }">
					<div>${vo.name }   /   ${vo.shop_name}</div> 
					</c:if>
					<c:if test="${empty vo.shop_name }">
					<div>${vo.name }   /   일반후기</div> 
					</c:if>
					<div>${vo.rv_writedate }[${vo.rv_readcnt }] <span style="float:right;">${empty vo.rv_filename ? '' : "<img src='imgs/attach.png' class='file-img'/>"} </span></div>
				</li>
			</c:forEach>
		</ul>
	</c:if>


	<c:if test="${RePage.viewType eq 'list' }">
		<table class='tb_list'>
			<thead>
				<tr>
					<th class="w-px70">번호</th>
					<th class="w-px100">유형</th>
					<th class="w-px120" id="shop">매장명</th>
					<th>제목</th>
					<th class="w-px100">작성자</th>
					<th class="w-px120">작성일자</th>
					<th class="w-px80">첨부파일</th>
					<th class="w-px80">조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<c:if test="${empty RePage.list  }">
				<tr>
					<td colspan="6" class="empty">후기 정보가 없습니다</td>
				</tr>
				</c:if>
				
				<c:forEach items="${RePage.list }" var="vo">
					<tr class="item">
						<td>${vo.rv_no }</td>
						<td>${vo.rv_type }</td>
						<!-- 21-08-30 출력 형식 수정하였습니다. -->
	                     <c:if test="${!empty vo.shop_name }">
	                     <td>${vo.shop_name}</td>                     
	                     </c:if>
	                     <c:if test="${empty vo.shop_name }">
	                     <td>일반후기</td>                     
	                     </c:if>
                     	<!-- 21-08-30 출력 형식 수정하였습니다. -->
						<td class='left'><a onclick='go_detail(${vo.rv_id}, "${u_id }", "${RePage.curPage }", "${RePage.search }", "${RePage.keyword }", "${name }")'>${vo.rv_title }</a></td>					
						<td>${vo.name }</td>
						<td>${vo.rv_writedate }</td>
						<td>${ empty vo.rv_filename ? 'X' : "<img src='imgs/attach.png' class='file-img'/>" }</td>
						<td>${vo.rv_readcnt }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>
	
	
<div class="btnSet">
	<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
	
	
	
<script type="text/javascript">
function go_detail(id, u_id, curPage, search, keyword, name){
	$('[name=id]').val( id );
	$('[name=u_id]').val( u_id );
	$('[name=curPage]').val( curPage );
	$('[name=search]').val( search );
	$('[name=keyword]').val( keyword );
	$('[name=name]').val( name );
	$('form').attr('action', 'a_detail.re');
	$('form').submit();
}
		
	
		
</script>
</body>
</html>


