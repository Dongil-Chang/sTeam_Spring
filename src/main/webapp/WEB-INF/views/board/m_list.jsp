<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h3><a href="javascript:history.back(-1)"><img alt="" src="imgs/community.png"></a></h3>
<div id='list-top'  style="width:60%; margin:0 auto;">
<form method="post" action='mlist.fb'>
<input type="hidden" name="curPage" value='${page.curPage }'/>
<input type="hidden" name="id" />
<div>
 <%--   <ul>
      <li><select name='search' class='w-px90'>
         <option value='all' ${page.search eq 'all' ? 'selected' : ''}>전체</option>
         <option value='title' ${page.search eq 'title' ? 'selected' : ''}>제목</option>
         <option value='content' ${page.search eq 'content' ? 'selected' : ''}>내용</option>
         <c:if test="${loginInfo.admin ne 'Y' }">
         <option value='writer' ${page.search eq 'writer' ? 'selected' : ''}>작성자</option>
         </c:if>
         </select>
      </li>
      <li><input type='text' name='keyword' value='${page.keyword}' class='w-px300'/></li>
      <li><a class='btn-se' onclick='$("form").submit()'>검색</a></li>
   </ul> --%>
   <ul>
      <li>
         <select name='pageList' class='w-px90' onchange="$('form').submit()">
         <option value='10' ${page.pageList eq 10 ? 'selected' : ''}>10개씩</option>
         <option value='15' ${page.pageList eq 15 ? 'selected' : ''}>15개씩</option>
         <option value='20' ${page.pageList eq 20 ? 'selected' : ''}>20개씩</option>
         <option value='25' ${page.pageList eq 25 ? 'selected' : ''}>25개씩</option>
         <option value='30' ${page.pageList eq 30 ? 'selected' : ''}>30개씩</option>
         </select>
      </li>
   
      
   <%--    <!-- 로그인되어 있는 경우 글쓰기 가능 -->
      <c:if test="${not empty loginInfo}">
      <li><a class='btn-se' href='new.fb'>글쓰기</a></li>
      </c:if> --%>
   </ul>
</div>

</form>
</div>

<div id='data-list'>

<c:if test="${page.viewType eq 'grid'}">
<ul class='grid'>
   <c:forEach items="${page.list}" var="vo">
   <li><div><a onclick='go_detail(${vo.id})'>${vo.title}</a></div>
      <div>${vo.name}</div>
      <div>${vo.writedate} [${vo.readcnt}]<span style="float:right;">${empty vo.filename ? '' : "<img src='imgs/attach.png' class='file-img'/>"}</span></div>
   </li>
   </c:forEach>
</ul>
</c:if>

<c:if test="${page.viewType eq 'list'}">
<table class='tb_list'>
<thead>
   <tr><th class='w-px70'>번호</th>
   <!--    <th class='w-px70'></th>  -->
      <th>제목</th>
      <th class='w-px100' style="text-align:justify; ">작성자</th>
      <th class='w-px120'>작성일자</th>
      <th class='w-px80'>조회수</th>
      <th class='w-px80'>첨부파일</th>
   </tr>
</thead>
<tbody>
   <c:if test="${empty page.list}">
   <tr><td colspan='6'>등록된 게시글 정보가 없습니다</td></tr>
   </c:if>
   
   <c:forEach items="${page.list}" var="vo">
   <tr style="border: 1px solid #b0b0b0; "><td>${vo.no}</td>
<!--       <td></td> -->
      <td class='left' style="text-align:justify; padding-left: 30px;"><a onclick='go_detail(${vo.id})'>${vo.title}</a></td>
      <td style="text-align:justify; ">${vo.name}</td>
      <td>${vo.writedate}</td>
      <td>${vo.readcnt}</td>
      <td>${empty vo.filename ? '' : '<img src="imgs/attach.png" class="file-img"/>'}</td>
   </tr>
   </c:forEach>
</tbody>
</table>
</c:if>

</div>

<div class='btnSet'>
   <jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>

<script type="text/javascript">
function go_detail(id){
   $('[name=id]').val( id );
   $('form').attr('action', 'mdetail.fb');
   $('form').submit();
}


</script>
</body>
</html>