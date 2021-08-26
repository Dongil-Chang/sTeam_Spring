<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table tr td {
	text-align: left;
}

.addr input:not(:last-child) {
	margin-bottom: 2px
}

.ui-datepicker table tr {
	height: inherit;
}

.valid, .invalid {
	font-size: 13px;
	font-weight: bold;
}

.valid {
	color: green;
}

.invalid {
	color: red;
}
</style>
</head>
<body>
	<h3>[ ${vo.name} ] 님 회원정보수정</h3>
	<form action="update.mp" method="post" enctype="multipart/form-data">
		<input type='hidden' name='attach' /> <input type='hidden' name='id'
			value='${vo.id}' />
		<table border="1">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${vo.id}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${vo.name}</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type='password' name='pw' class='chk' /><br>
						<div class='valid'>비밀번호를 입력하세요(영문 대/소문자,숫자를 모두 포함)</div></td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td><input type='password' name='pw_ck' class='chk' /><br>
						<div class='valid'>비밀번호를 다시 입력하세요</div></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>${vo.gender}</td>
				</tr>
				<tr>
					<th> 이메일</th>
					<td><input type='text' name='email' class='chk' /><br>
						<div class='valid'>이메일을 입력하세요</div></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type='text' name='birth' readonly /> <a
						id='delete'><i class="font-img fas fa-times"></i></a></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type='text' name='tel' class='w-px100'
						maxlength="3" /> - <input type='text' name='tel' class='w-px100'
						maxlength="4" /> - <input type='text' name='tel' class='w-px100'
						maxlength="4" /></td>
				</tr>
				<tr>
					<th>주소</th>
					<td class='addr'><a class='btn-fill-s' onclick='daum_post()'>우편번호찾기</a>
						<input type='text' name='post' class='w-px60' readonly /><br>
						<input type='text' name='addr' readonly /> <input type='text'
						name='addr' /></td>
				</tr>
			</tbody>
			<tr class='btnSet'>
				<td colspan="2"><a class='btn-fill'
					onclick='$("form").submit()'>저장</a> <!-- 		<a class='btn-fill' href='javascript:$("form").submit()'>저장</a> -->
					<a class='btn-empty' href='list.mp?id=${vo.id}'>취소</a></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript" src='js/join_check.js'></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		function go_join() {

			if (!item_check($('[name=pw]')))
				return;
			if (!item_check($('[name=pw_ck]')))
				return;
			if (!item_check($('[name=email]')))
				return;

			$('form').submit();
		}

		$(function() {
			var today = new Date();
			var endDay = new Date(today.getFullYear() - 13, today.getMonth(),
					today.getDate() - 1);

			$('[name=birth]').datepicker(
					{
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						changeMonth : true,
						changeYear : true,
						dateFormat : 'yy-mm-dd',
						showMonthAfterYear : true
						//, beforeShowDay: after
						,
						maxDate : endDay
					});
		});

		$('#btn-id').on('click', function() {
			id_check();
		});
		function id_check() {
			var $id = $('[name=id]');
			if ($id.hasClass('checked'))
				return;
			var data = join.tag_status($id);
			if (data.code == 'invalid') {
				alert('아이디 중복확인 불필요\n' + data.desc);
				$id.focus();
				return;
			}

			//DB에 해당 아이디로 가입한 회원이 있는지의 여부를 판단
			$.ajax({
				url : 'id_check',
				data : {
					id : $id.val()
				},
				success : function(response) {
					var data = join.id_usable(response);
					$id.siblings('div').text(data.desc).removeClass().addClass(
							data.code);
					$id.addClass('checked');

				},
				error : function(req, text) {
					alert(text + ':' + req.status);
				}
			});

		}

		$('.chk').on(
				'keyup',
				function(e) {
					if ($(this).attr('name') == 'id') {
						if (e.keyCode == 13)
							id_check();
						else
							$(this).removeClass('checked');
					}
					var data = join.tag_status($(this));
					$(this).siblings('div').text(data.desc).removeClass()
							.addClass(data.code);
				});

		$('[name=birth]').change(function() {
			$('#delete').css('display', 'inline');
		});
		$('#delete').click(function() {
			$('[name=birth]').val('');
			$('#delete').css('display', 'none');
		});

		function after(date) {
			if (date > new Date())
				return [ false ];
			else
				return [ true ];
		}

		function daum_post() {
			new daum.Postcode(
					{
						oncomplete : function(response) {
							$('[name=post]').val(response.zonecode);
							//지번주소: J 도로명주소: R
							var addr = response.userSelectedType == 'J' ? response.jibunAddress
									: response.roadAddress;
							if (response.buildingName != '')
								addr += ' (' + response.buildingName + ')';
							$('[name=addr]').eq(0).val(addr);
						}
					}).open();
		}
	</script>
</body>
</html>