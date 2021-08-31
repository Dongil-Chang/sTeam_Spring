<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

.box ul li { height: 20px; }

.box ul li:nth-child(2) { margin-left: 20px; }

#list-top div { height: 18px; }

a.btn-fill { margin-right: 0px; }





</style>


</head>
<body>
<h3><a href="javascript:history.back(-1)"><img alt="후기" src="imgs/Review.png"></a> </h3>
   
   <div id="list-top" style="width:60%; margin:0 auto;">
   <form action="mlist.re" method="post">
   <input type="hidden" name="curPage" value="${page.curPage }"/>
   <input type="hidden" name="id"/>   <!-- go_detail -->
   
            <%-- <select name="search" class="w-px150"  id="hair_category" onchange="shoplist()">
                  <c:forEach items="${shop_list }" var="vo">
                     <option value="${vo.tel }">${vo.name }</option>            
                  </c:forEach>
               </select> --%>
      <div class="box">
         <ul>            
            <li>
               <select name="search" class="w-px120"  id="hair_category" onchange="$('form').submit()">
                  <option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
                  <option value="etc" ${page.search eq 'etc' ? 'selected' : '' }>일반</option>
                  <option value="manhair" ${page.search eq 'manhair' ? 'selected' : '' }>남성헤어</option>
                  <option value="womenhair" ${page.search eq 'womenhair' ? 'selected' : '' }>여성헤어</option>                  
                  <option value="style" ${page.search eq 'style' ? 'selected' : '' }>스타일링</option>                  
               </select>
            </li>   
         </ul>
         
         <!-- 몇개씩 글목록을 보여지게 할것인지 하는곳 -->
         <ul>
            <li>
               <select name="pageList" class="w-px90" onchange="$('form').submit()">
                  <option value="5" ${page.pageList eq 5 ? 'selected' : ''}>5개</option>
                  <option value="10" ${page.pageList eq 10 ? 'selected' : ''}>10개</option>
                  <option value="15" ${page.pageList eq 15 ? 'selected' : '' }>15개</option>
                  <option value="20" ${page.pageList eq 20 ? 'selected' : '' }>20개</option>
                  <option value="25" ${page.pageList eq 25 ? 'selected' : '' }>25개</option>
                  <option value="30" ${page.pageList eq 30 ? 'selected' : '' }>30개</option>
               </select>
            </li>
            
            <!-- 그리드 형태로 하는곳 -->
            <li>
               <select name="viewType" class="w-px110" onchange="$('form').submit()">
                  <option value="list" ${page.viewType eq 'list' ? 'selected' : '' }>리스트</option>
                  <option value="grid" ${page.viewType eq 'grid' ? 'selected' : '' }>그리드</option>
               </select>
            </li>
            
          <%--   <!-- 로그인 되어 있는 경우 글쓰기 가능 -->
            <c:if test="${ ! empty loginInfo }">
               <li>
                  <a class="btn-fill" href="new.re?code=${code}" style="margin-top: 0px;">글쓰기</a>
               </li>
            </c:if> --%>
         </ul>
      </div>   
   </form>
   </div>
   
<div id='data-list'>
      <c:if test="${page.viewType eq 'grid' }">
         <ul class="grid">
            <c:forEach items="${page.list }" var="vo">
               <li>
                  <div><a onclick="go_detail(${vo.rv_id})">${vo.rv_title }</a></div>
                  <div>${vo.name }   /   ${vo.shop_name}</div> 
                  <div>${vo.rv_writedate }[${vo.rv_readcnt }] <span style="float:right;">${empty vo.rv_filename ? '' : "<img src='imgs/attach.png' class='file-img'/>"} </span></div>
               </li>
            </c:forEach>
         </ul>
      </c:if>
   
   
      <c:if test="${page.viewType eq 'list' }">
         <table class='tb_list'>
            <thead>
               <tr>
                  <th class="w-px70">번호</th>
                  <th class="w-px100">유형</th>
                  <th class="w-px160" id="shop">매장명</th>
                  <th>제목</th>
                  <th class="w-px100" >작성자</th>
                  <th class="w-px120">작성일자</th>
                  <th class="w-px80">조회수</th>
                  <th class="w-px80">첨부파일</th>
               </tr>
            </thead>
            
            <tbody>
               <c:if test="${empty page.list  }">
               <tr>
                  <td colspan="6">후기 정보가 없습니다</td>
               </tr>
               </c:if>
               
               <c:forEach items="${page.list }" var="vo">
                  <tr style="border: 1px solid #b0b0b0; ">
                     <td>${vo.rv_no }</td>
                     <td>${vo.rv_type }</td>
                     <td>${vo.shop_name}</td>                     
                     <td class="left" style="text-align:justify; "><a onclick="go_detail(${vo.rv_id})">${vo.rv_title }</a></td>
                     <td style="text-align:justify; ">${vo.name }</td>
                     <td>${vo.rv_writedate }</td>
                     <td>${vo.rv_readcnt }</td>
                     <td>${ empty vo.rv_filename ? '' : "<img src='imgs/attach.png' class='file-img'/>" }</td>
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
      function go_detail(id) {
         $('[name=id]').val(id);
         $('form').attr('action', 'mdetail.re');
         $('form').submit();
      }
      
   
      
   </script>
</body>
</html>




























