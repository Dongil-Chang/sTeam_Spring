<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#popup {
	width: 350px;
	height: 350px;
	border: 2px solid #666;
	display: none;
}

.popup {
	width: 100%;
	height: 100%;
}

.reply {
	margin: 0 auto;
	/* padding-top: 20px; */
	width: 500px;
}

#reply-regist {
	width: 100%;
}

#reply_regist span {
	width: 50%;
	float: left;
}

textarea#reply {
	width: 96%;
	height: 60px;
	margin-top: 5px;
	resize: none;
}

tr, th, td {
	border: 2px solid #e7d9f5;
}
</style>
</head>
<body>
	<h3>
		<a href="javascript:history.back(-1)"><img alt=""src="imgs/Review.png"></a>
	</h3>
	<table style="resize: none;">
		<tr>
			<th class="w-px120">유형</th>
			<td colspan="5" class="left" style="font-weight: bold">${vo.rv_type }</td>
		</tr>
		<tr>
			<th class="w-px120">제목</th>
			<td colspan="5" class="left">${vo.rv_title }</td>
		</tr>

		<tr>
			<th>작성자</th>
			<td>${vo.name }</td>

			<th class="w-px80">작성일자</th>
			<td class="w-px200">${vo.rv_writedate }</td>

			<th class="w-px80">조회수</th>
			<td class="w-px80">${vo.rv_readcnt }</td>
		</tr>

		<tr>
			<th>내용</th>
			<td colspan="5" class="left" style="text-align: justify; padding-left: 28px; padding-right: 28px;">${fn:replace(vo.rv_content, crlf, '<br>') }</td>
			<!-- 엔터역할 -->
		</tr>

		<tr>
			<th>첨부파일</th>
			<td colspan="5" class="left middle">${vo.rv_filename}<c:if
					test="${!empty vo.rv_filename  }">
					<a id="preview"></a>
					<a href="download.re?id=${vo.rv_id }"><i
						class="fas fa-download font-img"></i></a>
				</c:if>
				<c:if test="${empty vo.rv_filename }">
					<span style="font-weight: bold; color: gray;">첨부파일이 없습니다.</span>
				</c:if>
			</td>
		</tr>
	</table>

	<div class="btnSet">
		<c:if test="${empty code }">
			<a class="btn-fill" onclick="$('form').submit()">목록으로</a>
		</c:if>

		<c:if test="${code == 1 }">
			<c:if
				test="${loginInfo.admin eq 'Y' || ( vo.rv_writer eq loginInfo.id && loginInfo.admin eq 'Y' )}">
				<a class='btn-fill'
					href="re_list.cu?curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&id=${u_id}&name=${name}&viewType=${page.viewType}&pageList=${page.pageList}">돌아가기</a>
			</c:if>
		</c:if>

		<!-- 글쓴이만 수정/삭제 권한을 가짐 -->
		<c:if test="${loginInfo.id eq vo.rv_writer}">
			<a class="btn-fill"
				onclick="$('form').attr('action', 'modify.re'); $('form').submit()">수정</a>
		</c:if>


		<!-- 관리자 페이지가 아닌 일반 게시글 페이지에서도 관리자가 삭제할 수 있게 -->
		<c:if test="${empty code }">
			<c:if
				test="${loginInfo.id eq vo.rv_writer || loginInfo.admin eq 'Y'}">
				<a class='btn-fill'
					onclick="if( confirm('정말 삭제하시겠습니까?') ){ href='delete.re?id=${vo.rv_id}' }">삭제</a>
			</c:if>
		</c:if>


		<!-- 관리자 페이지에서 해당 회원 해당 게시글 목록보기에서 삭제 처리 -->
		<c:if test="${code == 1 }">
			<c:if
				test="${loginInfo.admin eq 'Y' || ( loginInfo.admin eq 'Y' && vo.rv_writer eq loginInfo.id ) }">
				<a class='btn-fill'
					onclick="if( confirm('정말 삭제 하시겠습니까??') ){ href='a_delete.re?id=${vo.rv_id}&curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}&u_id=${u_id}&name=${name} '}">관리자권한
					삭제</a>
			</c:if>
		</c:if>

	</div>

	<div class='reply'>
		<div id='reply_regist'>
			<span class='left'><strong>댓글작성</strong></span> <span class='right'><a
				class='btn-fill-s' onclick="reply_regist()">댓글등록</a></span>
			<textarea id='reply'></textarea>
		</div>
		<div id="reply_list"></div>
	</div>

	<div id="popup-background"></div>
	<!-- z-index 효과를 위해 이 부분을 먼저 만들고 아래를 만들면된다.  -->
	<div id="popup" class="center"></div>

	<form method="post" action='list.re'>
		<input type='hidden' name='id' value='${vo.rv_id}' /> <input
			type='hidden' name='search' value='${page.search}' /> <input
			type='hidden' name='keyword' value='${page.keyword}' /> <input
			type='hidden' name='pageList' value='${page.pageList}' /> <input
			type='hidden' name='curPage' value='${page.curPage}' /> <input
			type='hidden' name='viewType' value='${page.viewType}' />
	</form>



	<script type="text/javascript" src="js/file_check.js"></script>
	<script type="text/javascript">
		//댓글 등록하기
		function reply_regist() {
			if( ${empty loginInfo} ){
				alert('댓글을 등록하려면 로그인하세요!');
				return;
			}else if($.trim($('#reply').val()) == ''){
				alert('댓글을 등록하려면 입력하세요!');	
				$('#reply').focus();
				$('#reply').val();
				return;
			}//if
			
			$.ajax({
				url: 'review/reply/regist',
				data: { rp_pid:${vo.rv_id}, rp_content:$('#reply').val() ,},
				success: function ( response ) {
					if(response){
						alert('댓글이 저장되었습니다.');
						$('#reply').val('');
						reply_list();
					}else{
						alert('댓글 등록 실패!!');
					}//if
				}, error: function(req, text) {
					alert(text+':'+req.status);
				}
			});
			
			
		}
		
		
		
		
		
		
		function reply_list() {
			$.ajax({
				url: "review/reply/list/${vo.rv_id}",
				success: function (response) {
					
					$('#reply_list').html(response);
					
				}, error: function(req, text) {
					alert(text+':'+req.status);
				}
			});//ajax
		}
	
	
		$(function() {
			//첨부된 파일이 이미지 파일인 경우 미리보기되게 하기
			if(${ ! empty vo.rv_filename}){	//첨부된 파일이 있다면
				if( isImage( '${vo.rv_filename}' )){	//문자데이터? 라서 포테이션으로 엮음
					$('#preview').html("<img src='${vo.rv_filepath}' id='preview-img'/>");
				}//if
			}//if
			reply_list();
		});//function
		
		$(document).on('click', '#preview-img', function(){
			$('#popup, #popup-background').css('display', 'block');
			$('#popup').html("<img src='${vo.rv_filepath}' class='popup'/>");
		}).on('click', '#popup-background', function(){
			$('#popup, #popup-background').css('display', 'none');
		});
	</script>
</body>
</html>
























