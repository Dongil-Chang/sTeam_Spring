<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css" >
</head>
<body>

<form method="post" action='list.mp'>
<div id='list-top'>
<a href=""><img src="imgs/eMyPage.png"/></a>
</div>
</form>
<div class='btn_set dataOption'>
		<a>내가 쓴 글</a>
		<a href="detail.mp">회원정보</a>
		<a onclick="if( confirm('가지마... 내가 잘 할게...')) { href='delete.mp' }">회원탈퇴</a>
</div>

<div>
<ul>
<li><a href="mslist.mp?id=${loginInfo.id }"><img alt="" src="imgs/myStyleList.png"></a></li>
<li><a href="mrlist.mp?id=${loginInfo.id }"><img alt="" src="imgs/myReviewList.png"></a></li>
<li><a href="mclist.mp?id=${loginInfo.id }" ><img alt="" src="imgs/myCommunityList.png"></a></li>
<li><a href="mqlist.mp?id=${loginInfo.id }"><img alt="" src="imgs/myQnaList.png"></a></li>
</ul>
</div>

<script type="text/javascript">
$('.dataOption a').click(function(){
	$('.dataOption a').removeClass();
	$(this).addClass('btn-fill');
	var idx = $(this).index();
	$('.dataOption a:not(:eq('+ idx +'))').addClass('btn-empty');
	
});

$(function(){
	$('.dataOption a:eq(0)').trigger('click'); //클릭이벤트 강제 발생 시키기
	
});

/* function go_info(loginInfo){
	var pw = prompt("회원정보를 확인하려면 비밀번호를 입력하세요.", "");
	
	if(pw == loginInfo.pw){
		location.href="detail.mp";
	}else{
		alert("비밀번호가 일치하지 않습니다!");
	}
	
	} */
</script>
</body>
</html>