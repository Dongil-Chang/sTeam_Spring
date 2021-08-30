<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3><img alt="" src="imgs/Review.png"> </h3>
	<form action="insert.re" method="post" enctype="multipart/form-data">
	<input type="hidden" name="shop_tel" value="${shopName.shop_tel }"/>
		<table>
			<c:if test="${code != 1 }">			
			<tr>
				<th>shop</th>
				<td>
				<ul style="text-align:justify; padding-left: 20px; ">
				<%-- <select>
						<c:forEach items="${shopName }" var="vo">
							<option value="shop">${vo.shop_name }</option>				
						</c:forEach>
					</select> --%>
						<li> ${shopName.shop_name }</li>
					</ul>	
				</td>
			</tr> 
			</c:if>
			<tr><th class='w-px120'>유형</th>
				<td>
					<ul>
						<li style="text-align:justify; padding-left: 20px; ">
							<select name="rv_type" class="w-px100"  >
								<option value="etc" >일반</option>
								<option value="manhair" >남성헤어</option>
								<option value="womenhair" >여성헤어</option>						
								<option value="style" >스타일링</option>		
							</select>
						</li>
					</ul>
				</td>
			</tr>
			<tr><th class='w-px120'>제목</th>
				<td><input type='text' name='rv_title' class='chk w-pct80' title='제목' onkeypress="if( event.keyCode==13 ){ event.preventDefault(); $('[name=rv_content]').focus() }"/></td>
			</tr>
			
			<tr><th>내용</th>
				<td><textarea name='rv_content' class='chk w-pct80' title='내용' style="resize: none;  height:370px;"></textarea>
				</td>
			</tr>
			
			<tr><th>첨부파일</th>
				<td class='left middle'>
					<label>
						<input type='file' name='file' id='attach-file' />
						<a><img src='imgs/select.png' class='file-img'/></a>
					</label>
					<span id='file-name'></span>
					<span id="preview"></span> <!-- 첨부파일이 이미지이면 옆에 자그마하게 그 이미지가 보이게하는거  -->
					<a id="delete-file"><i class='fas fa-times'></i></a>
				</td>
			</tr>
		</table>
	</form>
	
	<div class="btnSet">
		<a class="btn-fill" onclick="if(emptyCheck()) $('form').submit()">저장</a>
		<a class="btn-empty" href="list.re">취소</a>
	</div>
	
<script type="text/javascript" src='js/file_check.js?v=<%=new java.util.Date().getTime()%>'></script>

</body>
</html>