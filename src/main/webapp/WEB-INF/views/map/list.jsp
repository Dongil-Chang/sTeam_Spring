<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

.tb_list { margin-top: 50px; }

#popup { width: 800px; height: 600px; border: 2px solid #666; display: none; position: absolute; top: 710px; }

.marker:hover{
   font-weight: bold;
   color : #8338ec;
}

#popup-background { position: absolute; left: 0; top: 230px; width: 100%; height: 100%;
               background-color: #000; opacity: 0.3; display: none;
              }

select { border:1px solid #b0b0b0; padding: 0 5px; cursor:pointer; margin-bottom: 5px; }


#list-top { float: left; padding: 10px 1%; margin-top: 30px; }

.box ul li:nth-child(3) { margin: 0px 0px 5px 5px; }

.box ul li:nth-child(3) a { margin: 0px 0px 0px 5px; }

.box lu li input { font-size: 20px; padding: 5px 0; }



</style>


</head>
<body>

<div class="tb_list" >
<h3><a href="javascript:history.back(-1)"><img alt="매장정보" src="imgs/shop.png"  /></a> </h3>   
<div style="float: right;  font-weight: bold; color:#cc0073; padding: 10px 4%; margin-top: 20px; margin-right: 320px;">* 상호명을 클릭 후 지도가 띄워지고 주소를 클릭하면 후기 화면으로 이동합니다.
<br/> <span style="color: red; float:center;">단, 로그인은 필수 입니다.</span>
</div>
<div id="list-top"  style="width :41%;"> 
<form action="data" method="post">
   <div class="box" >
      <ul>
         <li>
            <select name="search" class="w-px90" >
               <option value="all" >전체</option>
               <option value="name" >샵이름</option>
               <option value="tel" >전화번호</option>
               <option value="addr" >주소</option>
            </select>
         </li>
         <li><input type="text" name="keyword" class="w-px300" value="" /></li>
         <li><a class="btn-se"  onclick="$('form').submit()">검색</a></li>
      
      
         <!-- <h3 class="warm">* 상호명을 클릭 후 지도가 띄워지고 주소를 클릭하면 후기 화면으로 이동합니다. <span style="color: red;">단, 로그인은 필수 입니다.</span></h3> -->
      </ul>
      
   </div>
   

</form>
</div> 

<table id='shop_list'>
<thead>
   <tr>
      <th class='w-px200'>헤어샵 이름</th>
      <th >주소</th>
      <th class='w-px160'>전화번호</th>
   </tr>
</thead>
<tbody>
<c:forEach var="idx"  begin="${list.beginList}" end ="${list.endList}">
   <c:set var="vo"  value="${list.item[idx]}"/>
   <tr style="border: 1px solid #b0b0b0; ">
      <td><a class='shop' data-x='${vo.Xpos}' data-y='${vo.Ypos}' data-addr='${vo.addr }' data-tel=${vo.telno }> ${vo.yadmNm} </a></td>
      <td> <!-- style="text-align: justify;" --> ${empty vo.addr ? "-" : vo.addr}</td>
      <td>
         010 -<fmt:formatNumber var="number" value="${vo.telno }" pattern="#,####"/>
         <c:out value="${fn:replace(number, ',' , ' - ') }" />
      </td>
   </tr>   
</c:forEach>

</tbody>   
</table>
</div>

<div id="popup-background"></div>
<div id="popup" class="center"></div>


<div class='btnSet'>
   <div class='page_list'>
   
   </div>
</div>


<script type="text/javascript">

function makePage(curPage){
   var totalPage = Math.ceil(${list.count} / pageList);   // 스크립트에서는 나눗셈을 하면 소수점까지 반환하기 때문에 올림함수 사용
   var totalBlock = Math.ceil(totalPage / blockPage);
   var curBlock = Math.ceil(curPage / blockPage);
   var endPage = curBlock * blockPage;
   var beginPage = endPage - (blockPage-1);
   
   if( endPage > totalPage ) {
      endPage = totalPage;
   }
   
   var tag = '';
   
   if( curBlock > 1 ){
      tag += "<a class='page_first' title='처음'  data-page=1>"
                   + "<i class='fas fa-angle-double-left'></i></a>"
          + "<a class='page_prev' title='이전' data-page="+ (beginPage-blockPage) 
                    + "><i class='fas fa-angle-left'></i></a>";
   }
   
   for(var no=beginPage; no<=endPage; no++){
      if( no==curPage )
         tag += "<span class='page_on'>"+ no +"</span>"; 
      else
         tag += "<a class='page_off' data-page="+ no +">"+ no +"</a>";
   }
   if( curBlock < totalBlock ){
      tag += "<a class='page_next' title='다음' data-page="+ (endPage+1) 
                     + "><i class='fas fa-angle-right'></i></a>"
          + "<a class='page_last' title='마지막' data-page="+ totalPage 
                      + "><i class='fas fa-angle-double-right'></i></a>";
   }
   
   
   $('.page_list').html( tag );
   
}


</script>


</body>
</html>