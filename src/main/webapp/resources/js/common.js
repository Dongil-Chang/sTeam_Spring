/**
 *  공통스크립트: 입력항목 확인
 */
 
function emptyCheck(){
	var ok = true;
	$('.chk').each(function(){
		if( $(this).val()=='' ){
			alert( $(this).attr('title') + '입력하세요!');
			$(this).focus();
			ok = false;
			return ok;
		}
	});
	return ok;
} 