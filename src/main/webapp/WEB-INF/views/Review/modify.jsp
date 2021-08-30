<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3><img alt="" src="imgs/Review.png"> </h3>
	<form action="update.re" method="post" enctype="multipart/form-data">
	<input type="hidden" name="attach"/>
	<input type="hidden" name="rv_id" value="${vo.rv_id }"/>
		<table>
			<tr>
				<th class="w-px120">제목</th>
				<td>
					<input type="text" name="rv_title" class="chk w-pct80" title="제목" value="${vo.rv_title }" onkeypress="if( event.keyCode==13 ){ event.preventDefault(); $('[name=rv_content]').focus() }"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="rv_content" class="chk w-pct80" title="내용" style="resize: none;  height:370px;" >${vo.rv_content }</textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td class="left middle">
					<label>
						<input name="file" type="file" id="attach-file"/>
						<a><img src="imgs/attach.png" class="file-img"></a>
					</label>
					<span id="file-name">${vo.rv_filename }</span>
					<span id="preview"></span>	<!-- 파일 첨부하면 이미지가 작게 보여지게 하는거 -->
					<a id="delete-file"><i class="fas fa-times font-img"></i></a>
				</td>
			</tr>
		</table>
	</form>
	
	<div class="btnSet">
		<a class='btn-fill' onclick="if( emptyCheck() ) { $('[name=attach]').val( $('#file-name').text() );  $('form').submit() }">저장</a>
		<a class="btn-empty" onclick="history.go(-1)">취소</a>
	</div>
	
	<script type="text/javascript" src="js/file_check.js"></script>
	
	<!-- 수정화면에서 첨부파일이 있는경우 사진을 나타나게 하는곳 -->
	<script type="text/javascript">
		if( ${ ! empty vo.rv_filename } ){
			//첨부파일이 있는 글인 경우 삭제버튼 보이게
			$('#delete-file').css('display', 'inline');
			//첨부파일이 이미지파일인 경우 미리보기 되게
			if( isImage( '${vo.rv_filename}' ) ) 
				$('#preview').html( "<img src='${vo.rv_filepath}' id='preview-img' />" );
		}
</script>
</body>
</html>