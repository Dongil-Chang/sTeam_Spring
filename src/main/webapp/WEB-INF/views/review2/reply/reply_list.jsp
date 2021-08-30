<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- <hr>  이렇게도ㅗ 되고 staus 해도되고-->
<c:forEach items="${list }" var="vo" varStatus="status">
	${status.index eq 0 ? '<hr>' : '' }
	
	<!-- 로그인한 사용자가 작성한 댓글인 경우 수정/삭제 가능 -->
	<div data-seq='${vo.rp_id }' class="left">
		${vo.name } [${vo.rp_writedate}]
	<c:if test="${vo.rp_writer eq loginInfo.id || loginInfo.admin eq 'Y'}">
	<span style="float:right;">
		<c:if test="${loginInfo.admin ne 'Y' }">
			<a class="btn-fill-s btn-modify-save">수정</a>
		</c:if>
		<a class="btn-fill-s btn-delete-cancel" >삭제</a>
	</span>
	</c:if>
	
		<div class="original">${fn: replace( fn:replace(vo.rp_content, lf, '<br>'), crlf, '<br>') }</div>  <!-- 원글 -->
		<div class="modify" style="margin-top: 6px;"></div>
	</div>
	<hr>
</c:forEach>

<script>
	//$(document).on('click', '.btn-modify-save', function() {
	$('.btn-modify-save').on('click', function (){
		var $div = $(this).closest('div');	
		
		if( $(this).text() == '수정' ){ 
		
			var tag = "<textarea style='width:96%; height:90%;'>"+ $div.children('.original').html().replace(/<br>/g, '\n')+"</textarea>"		
			$div.children('.modify').html(tag);
			
			//수정 상태(false) : 저장/취소버튼, 보기 상태(true): 수정/삭제버튼 
			display_button(false, $div);
		}else{
			$.ajax({
				type: 'post', /* json 방식으로 보내려면 반드시 post로 보내야한다  */
				contentType: 'application/json', /* json 방식으로 보내려면 이것도 지정해야한다. */
				url: 'review/reply/update',
				data: JSON.stringify( { rp_id:$div.data('seq'), rp_content: $div.find('textarea').val() } ), /* json 형태로 한다. */
				success: function( response){
					alert('댓글변경' + response);
					reply_list();
					
				},error: function(req, text){
					alert(text+':'+req.status);
				}
			});
		}
		
	});
	
	$('.btn-delete-cancel').on('click', function(){
		var $div = $(this).closest('div');
		
		if($(this).text() == '취소'){
			display_button(true, $div);
		}else{
			if( confirm('정말 삭제하시겠습니까?')){
				$.ajax({
					url: 'review/reply/delete/' + $div.data('seq'),
					success: function() {
						reply_list();
					},error: function(req, text){
						alert(text+':'+req.status);
					}
				});
				
				
			}//if
		}//if
	
		display_button(true, $div);
	});
	
	function display_button(mode, div){
		div.find('.btn-modify-save').text(mode ? '수정' : '저장');
		div.find('.btn-delete-cancel').text(mode ? '삭제' : '취소');
		
		//수정상태: original 안보이게, modify 보이게		
		//보기상태: modify 안보이게, original 보이게
		div.children('.original').css('display', mode ? 'block' : 'none');
		div.children('.modify').css('display', mode ? 'none' : 'block');
	}
</script>






























