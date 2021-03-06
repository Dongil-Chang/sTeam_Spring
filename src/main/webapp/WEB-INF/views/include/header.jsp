<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   

<header style='padding:15px 0; text-align:center;'>
	<div class='category' style='margin-left:100px;'>
	<div id='logo'>
	<ul>
		<li><a href='<c:url value="/"/>'><img src='imgs/goodhair.png'/></a></li>
	</ul>
	</div>
	<br/>
	<ul>
		<!-- 관리자로 로그인된 경우만 회원관리 페이지에 접근 가능하도록 할 예정 -->
		<c:if test="${loginInfo.admin eq 'Y' }">
		<li><a href='list.cu' class='${category eq "cu" ? "active" : ""}'>Admin</a></li>
		</c:if>
		<!-- 관리자로 로그인된 경우만 회원관리 페이지에 접근 가능하도록 할 예정 -->
		
		<!-- 헤어샵 지도 페이지  -->
		<li><a href='list.ma' class='${category eq "map" ? "active" : ""}'>Shop</a></li>
		<!--  헤어샵 지도 페이지 -->
		
		<li><a href='list.re' class='${category eq "re" ? "active" : ""}'>Review</a></li>
		<li><a href='list.st' class='${category eq "st" ? "active" : ""}'>Style</a></li>
		<li><a href='list.fb' class='${category eq "fb" ? "active" : ""}'>Community</a></li>
		<li><a href='list.qa' class='${category eq "qa" ? "active" : ""}'>QnA</a></li>
		<li><a href='list.no' class='${category eq "no" ? "active" : ""}'>Notice</a></li>
<%-- 		<li><a href='list.mp' class="${category eq 'mp' ? 'active' : ''}">My Page</a></li>
		<li><a href='list.lg' class="${category eq 'lg' ? 'active' : ''}">Login</a></li>
		<li><a href='list.ou' class="${category eq 'ou' ? 'active' : ''}">Logout</a></li> --%>
		<!-- 로그인하지 않은 상태 -->
		<c:if test="${empty loginInfo}">
		<li><a href='list.lg' class="${category eq 'lg' ? 'active' : ''}">Login</a></li>
			
		</c:if>
		<!-- 로그인한 상태 -->
		<c:if test="${!empty loginInfo}">
		<li>
		<a href='list.mp' class="${category eq 'mp' ? 'active' : ''}">My Page</a>
		</li>
		<li>
			<strong>${loginInfo.name}</strong> 님<a href='list.ou' class="${category eq 'ou' ? 'active' : ''}" style="color: red; font-weight: bold;"> Logout</a>
		</li>
		</c:if>
	</ul>
	</div>
	<div class="banner">
		<a href="#">
			<img src="imgs/topimg.png" alt="Top">
		</a>
	</div>
	
</header>    
<style>

.banner { position: fixed; top:790px; right:20px; }
		
#logo{margin: 30px;}

header ul, header ul li { margin:0 auto; padding:0; display:inline; }

header .category { font-size:18px; }

header .category ul li:not(:first-child){ padding-left:30px;}

header .category ul li a{color : black; text-decoration : none;}

header .category ul li a:hover, header .category ul li a.active { font-weight:bold; color : #8338ec; }


</style>









    