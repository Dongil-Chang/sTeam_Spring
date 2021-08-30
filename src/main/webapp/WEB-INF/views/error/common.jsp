<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="cneter" style="width: 800px; margin: 0 auto; margin-top: 60px;">
	<div class="left" style="height: 60px; margin-bottom: 250px;">
		<a href='<c:url value="/"/>'><img src='imgs/goodhair.png'/></a>
	</div>
	
	<div style="border-top: 2px solid #ced4da;">
		<h3>내부적인 오류가 발생하였습니다.</h3>
		<p>빠른 시일내에 오류를 해결해 복구시키도록 하겠습니다. <br>
		관련 문의사항은 <span style="font-weight: bold; letter-spacing: 2px; margin: 0 5px;">062-362-7797</span> 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.</p>
		<br>
		${msg }
	</div>
</div>