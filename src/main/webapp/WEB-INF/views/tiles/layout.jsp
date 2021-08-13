<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
	<c:when test="${category eq 're'}"><c:set var='title' value='Review'/></c:when>
	<c:when test="${category eq 'st'}"><c:set var='title' value='Style'/></c:when>
	<c:when test="${category eq 'qa'}"><c:set var='title' value='QnA'/></c:when>
	<c:when test="${category eq 'no'}"><c:set var='title' value='Notice'/></c:when>
	<c:when test="${category eq 'mp'}"><c:set var='title' value='My Page'/></c:when>
	<c:when test="${category eq 'lg'}"><c:set var='title' value='Login'/></c:when>
	<c:when test="${category eq 'ou'}"><c:set var='title' value='Logout'/></c:when>
</c:choose>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project ${title}</title>
<style type="text/css">
#wrap { display:flex; flex-direction:column; height:100%; }
</style>
<link rel="icon" type="image/x-icon" href="imgs/global_logo.png">
<link rel="stylesheet" type="text/css" href="css/style.css?v=<%=new java.util.Date().getTime()%>" >
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script type="text/javascript" 
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
	<script type="text/javascript" src='js/slide.js'></script>
</head>
<body>
<div id='wrap'>
<tiles:insertAttribute name="header"/>
<div id='content'>
<tiles:insertAttribute name="content"/>
</div>
<tiles:insertAttribute name="footer"/>
</div>
</body>
</html>