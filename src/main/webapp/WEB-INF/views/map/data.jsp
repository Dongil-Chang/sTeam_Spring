<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div id='shop_list'>
</div>


<!-- 구글 맵 API 등록 -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCsrerDHJrp9Wu09Ij7MUELxCTPiYfxfBI"></script>
<!-- 구글 맵 API 등록 -->


<script type="text/javascript">

var pageList=10, blockPage=10;




$(function(){
	shop_list(1);

});

function shop_list(pageNo){
	$.ajax({
		url: "data",
		data: {pageNo: pageNo, pageList: pageList},
		success: function( response ){
// 			console.log( response );
			$('#shop_list').html(response);
			makePage(pageNo);
			
		},error: function(req, text){
			
			alert(text+":"+req.status);
			
		}
		
		
	});
}
$(document).on('click', '.page_list a', function(){
	shop_list( $(this).data('page') );
	
}).on('click', '.shop', function() {
//	alert( $(this).data('x') + " , " +  $(this).data('y'));
	$("#popup, #popup-background").css("display", "block");
	
	var addr = $(this).data('addr');
	var tel = $(this).data('tel');
	
	// 구글 맵 사용	
	// Number() 로 타입을 주는 이유는 위도 경도 값에 123.345000 <- 345뒤에 000값이 붙으면 스트링 값이 되기 때문에 지도표현이 안되기때문에
	// 123.345 까지의 값만 사용하기 위해서
	var xy = { lat: Number($(this).data('y')), lng: Number($(this).data('x')) };	// 위도 경도
	
	// 지도상의 헤어샵 위치를 가운데로 오게 처리
	map = new google.maps.Map(document.getElementById("popup"), {
	    center: xy,
	    zoom: 17,	// 지도 확대도
	});
	
	
	// 헤어샵위치를 마커에 헤어샵이름과 주소를 같이 보이게 표시할 창 만들기
	var info = new google.maps.InfoWindow();
	info.setOptions({
		content: "<div class='marker'><c:if test='${ ! empty loginInfo}'><a href='new.re?data="+tel+"'></c:if>"+ $(this).text() +"<br> 주소 : "+ addr  +"</a></div>"
	});
	info.open(map, new google.maps.Marker({
		map: map,
		position: xy,
	}));
	
	
}).on("click", '#popup-background', function(){
	$("#popup, #popup-background").css("display", "none");
	
	
	
});





</script>

</body>
</html>