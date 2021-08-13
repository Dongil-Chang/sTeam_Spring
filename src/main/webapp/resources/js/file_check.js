/**
 *  첨부파일관련 처리 함수
 */
//$(function(){
	
$(document).on( 'change', '#attach-file', function(){	//첨부파일선택시
//$('#attach-file').on('change', function(){
	var attached = this.files[0];
	if( attached ){ //선택한 파일이 있으면
		$('#file-name').text( attached.name );
		$('#delete-file').css('display', 'inline');
		
		//이미지파일인 경우 미리보기에 보여지게 처리
		if( $('#preview').length > 0 ){
			if( isImage(attached.name) ){
				$('#preview').html( '<img src="" id="preview-img" />' );
				var reader = new FileReader();
				reader.onload = function(e){
					$('#preview-img').attr('src', e.target.result);
				}
				reader.readAsDataURL( attached );
			}else	
				$('#preview').html('');
		}
		
	}else{
		$('#file-name').text( '' );
		$('#delete-file').css('display', 'none');
	}
	
}).on( 'click', '#delete-file', function(){ //첨부파일 삭제시
	if( $('#preview').length > 0 ) $('#preview').html('');
	$('#file-name').text( '' );
	$('#delete-file').css('display', 'none');
	$('#attach-file').val(''); //파일태그의 첨부된 파일정보 없애기
	
})
;

function isImage(filename){
	//abc.txt, abc.png, abc.JPG, abc.hwp,,
	var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase();
	var imgs = [ 'png', 'jpg', 'gif', 'jpeg', 'bmp' ];
	if( imgs.indexOf(ext) > -1 ) return true;
	else return false;
}


//}); 








