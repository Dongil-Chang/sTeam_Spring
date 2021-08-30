<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="css/style.css" >
<head>
<style>
 a:hover { font-weight:bold; color : #f20089; }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action='login.el'>
<div class="member_form">
				<h3 class="login"><a href='list.lg'>EXPERT LOGIN</a></h3>
				<ul>
					<li><input type="text" id= "userid" placeholder=" 아이디"></li>
					<li><input type="password" id="userpw" placeholder=" 비밀번호" onkeypress="if( event.keyCode==13 ) go_login()"></li>
					<!-- <li><input type="checkbox" id="save_id" checked value="save">
						<label for="save_id">아이디 저장</label></li> -->
					<!-- <li><input type="button" value="로그인" id="loginBtn" onclick="go_login()"></li>
					<li><a href='exmember'><input type="button" value="회원가입" id="joinBtn"></a></li> -->
				</ul>
				<div >
					<a onclick="go_login()"><img alt="" src="imgs/loginbtn.png"/> </a>
					<a href='exmember' > <img alt="" src="imgs/joinbtn.png"/> </a>
				</div>
			</div>
	</form>
	<script type="text/javascript">
		function go_login() {
			if ($('#userid').val() == '') {
				alert('아이디를 입력하세요!');
				$('#userid').focus();
				return;
			} else if ($('#userpw').val() == '') {
				alert('비밀번호를 입력하세요!');
				$('#userpw').focus();
				return;
			}

			$.ajax({
				url : 'webLogin',
				data : {
					id : $('#userid').val(),
					pw : $('#userpw').val()
				},
				success : function(response) {
					if (response) {
						location = '<c:url value="/"/>';
					} else {
						alert('아이디나 비밀번호가 일치하지 않습니다!');
					}

				},
				error : function(req, text) {
					alert(text + ':' + req.status);
				}
			});
		}
	</script>
</body>
</html>