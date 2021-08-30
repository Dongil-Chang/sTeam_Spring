<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:forEach items="${list}" var="vo" varStatus="status">
${status.index eq 0 ? '<hr>' : ''}
<div data-seq='${vo.id}' class='left'>${vo.name} [${vo.writedate}]
	<!-- 로그인한 사용자가 작성한 댓글인 경우 수정/삭제 가능 -->
	<c:if test="${vo.writer eq loginInfo.id || loginInfo.admin eq 'Y'}">
	<span style="float:right;">
		<c:if test="${loginInfo.admin ne 'Y' }">
		<a class='btn-fill-s btn-modify-save' >수정</a>
		</c:if>
		<a class='btn-fill-s btn-delete-cancel'>삭제</a>
	</span>
	</c:if>
	<div class='original'>${fn: replace( fn:replace(vo.content, lf, '<br>'), crlf, '<br>')}</div>
	<div class='modify' style='margin-top:6px'></div>
</div>
<hr>
</c:forEach>
<script>

// $(document).on('click', '.btn-modify-save', function(){
$('.btn-modify-save').on('click', function(){
	var $div = $(this).closest('div');
	
	if( $(this).text()=='수정' ){
		var tag = "<textarea style='width:96%; height:90%;'>"
				+ $div.children('.original').html().replace(/<br>/g, '\n') + "</textarea>";
		$div.children('.modify').html( tag );
		//수정 상태(false): 저장/취소버튼, 보기상태(true): 수정/삭제버튼
		display_button(false, $div);
		
	}else{
		$.ajax({
			type: 'post',
			contentType: 'application/json',
			url: 'board/comment/update',
			data: JSON.stringify( { id:$div.data('seq')
								   , content: $div.find('textarea').val() } ),
			success: function( response ){
				alert('댓글변경 ' + response );
				comment_list();
				
			},error: function(req, text){
				alert(text+':'+req.status);
			}
		});
	}
});

$('.btn-delete-cancel').on('click', function(){
	var $div = $(this).closest('div');
	
	if( $(this).text()=='취소' )
		display_button(true, $div);
	else{
		if( confirm('정말 삭제하시겠습니까??')  ){
			$.ajax({
				url: 'board/comment/delete/' +  $div.data('seq'),
				success: function(){
					comment_list();
				},error:function(req, test){
					alert(text+':'+req.status);
				}
			});
		}
	}
	
})
;

function display_button(mode, div){
	div.find('.btn-modify-save').text(mode ? '수정' : '저장');
	div.find('.btn-delete-cancel').text(mode ? '삭제' : '취소');
	//수정상태: original 안 보이게, modify 보이게
	//보기상태: original 보이게, modify 안 보이게
	div.children('.original').css('display', mode ? 'block' : 'none');
	div.children('.modify').css('display', mode ? 'none' : 'block');
}

</script>










