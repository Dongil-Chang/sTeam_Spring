<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<html>
<head>
<title>Home</title>

<style type="text/css">

#event { border-top:1px solid #ddd; border-bottom:1px solid #ddd;  margin-top: 30px; }

.event-wrap { width:80%; margin:0 auto; overflow: hidden; clear: both; }

.event-text { font-size:14px; font-weight:700; margin: 0 14px 0 0;  display: inline-block; }

.event-contents { font-size:14px; color:#666; display: inline-block;  }

.sns-btn  { float: right;  }

.sns-btn ul li { display: inline-block; margin: 0 5px;  }

.event-text-box { float: left; margin-top: 15px;  }

.middle { margin: 0 70px; }

.youtube { margin: 60px 0; }

.youtube iframe { border: 4px solid #8338ec; }

#main-notice, #main-commu, #main-review { display: inline-block; }

</style>

</head>

<link rel="stylesheet" type="text/css" href="css/style.css" >
<body>
<div id="main">
	<div class="animation_canvas">
		<div class="slider_panel">
			<a target="_blank"><img src="imgs/hair_model.png" class="slider_image" /></a> 
			<a target="_blank"><img src="imgs/hair_model4.png" class="slider_image" /></a> 
			<a target="_blank"><img src="imgs/hair_model5.png" class="slider_image" /></a> 
			<a target="_blank"><img src="imgs/hair_model3.png" class="slider_image" /></a> 
			<a target="_blank"><img src="imgs/hair_model2.png" class="slider_image" /></a> 
		</div>
	</div>
</div>

<div id="main-commu"></div>

<div id="main-notice"></div>

<div id="main-review"></div>

<div class="youtube">
	<h3 style="letter-spacing: 3px;">추천 동영상</h3>
	<iframe width="450" height="315" src="https://www.youtube.com/embed/oJJNpx5f4fs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	<iframe class="middle" width="450" height="315" src="https://www.youtube.com/embed/76fMP6FZF7Q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	<iframe width="450" height="315" src="https://www.youtube.com/embed/rSrtO6PiZK8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<div id="event">
  		<div class="event-wrap">
			<div class="sns-btn">
				<ul>
					<li><a href="#"><img src="imgs/sns1.png" alt=""></a></li>
					<li><a href="#"><img src="imgs/sns2.png" alt=""></a></li>
					<li><a href="#"><img src="imgs/sns3.png" alt=""></a></li>
					<li><a href="#"><img src="imgs/sns4.png" alt=""></a></li>
					<li><a href="#"><img src="imgs/sns5.png" alt=""></a></li>
				</ul>
			</div>
			<div class="event-text-box">
				<div class="event-text">Event</div>
				<div class="event-contents">현재 준비 중 입니다 불편을 드려 죄송합니다.</div>
			</div>
  		</div>
</div>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src='js/slide.js'></script>
<script type="text/javascript">
$(document).ready(function(){
	mainNotice();
	mainCommumity();
	mainReview();
	
	
});

function mainNotice() {
	$.ajax({
		url : "mainNotice.ad",
		type: "post",
		success: function(data) {
         
            $("#main-notice").html(data);
		}, error: function(text,req) {
			alert(text+":"+req.status);
		}
	});
	
	
}


function mainCommumity() {
	$.ajax({
		url : "mainCommu.ad",
		type: "post",
		success: function(data) {
         
            $("#main-commu").html(data);
		}, error: function(text,req) {
			alert(text+":"+req.status);
		}
	});
}



function mainReview() {
	$.ajax({
		url : "mainReview.ad",
		type: "post",
		success: function(data) {
         
            $("#main-review").html(data);
		}, error: function(text,req) {
			alert(text+":"+req.status);
		}
	});
}


</script>
</body>
</html>
