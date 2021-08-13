
$(document).ready(function() {
	var imgCnt = $(".slider_panel").children().length;
	var imgIdx = 1;
	var timer = null;
	var refreshInterval = null;
	
	function moveSlider(index) {
		var willMoveLeft = -(1000 * index);
		
		$(".slider_panel").animate({
			left: willMoveLeft //세미콜론 없음
		},"slow");//animate
		
		$(".control_button[data-index =" + index + "]").addClass("active");
		$(".control_button[data-index !=" + index + "]").removeClass("active");
		
		$(".slider_text[data-index =" + index + "]").show("fast")
				.animate({
					left: 0
				},"slow");
		$(".slider_text[data-index !=" + index + "]").hide("fast")
				.animate({
					left: -300
				},"slow");
// 		$(".slider_text[data-index =" + index + "]").show("fast", function() {
// 			$(this).css("left",0);
// 		});
// 		$(".slider_text[data-index !=" + index + "]").hide("fast",function() {
// 			$(this).css("left",-300);
// 		});
	} //moveSlider
	
	timer = function() {
		moveSlider(imgIdx);
		
		if (imgIdx < imgCnt - 1) {
			imgIdx++;
		} else {
			imgIdx = 0;
		}
	};
	
	$(".animation_canvas").on({
		"mouseenter" : function() {
			clearInterval(refreshInterval);
		},
		"mouseleave" : function() {
			refreshInterval = setInterval(timer, 3800);
		}
	});
	
	//control_button의 클릭리스너 지정 및 data-index 할당
	$(".control_button").each(function(index) {
		$(this).attr("data-index",index)
	}).click(function() {
		var index = $(this).attr("data-index");
		imgIdx = index; //내가 임의로 클릭한 컨트롤 버튼
		moveSlider(index); //슬라이더 및 텍스트 움직이게 하는 함수
	});//each,click
	
	
	//초기 텍스트 위치 지정 및 data-index 할당
	$(".slider_text").css("left",-300).each(function(index) {
		$(this).attr("data-index",index);
	});

	//초기 0번째 슬라이더 텍스트 가져오기
	$(".slider_text[data-index=" + 0 +"]").show("slow").animate({
		left: 0 //컴마, 세미콜론 없음
	},"slow");
	
	//초기 0번째 컨트롤 버튼 가져오기
	$(".control_button[data-index=" + 0 + "]").addClass("active");
	
	//3초마다 움직이는 timer 함수 호출
	refreshInterval = setInterval(timer, 3800);
	
	
});
