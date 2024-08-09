// 문서가 준비되면 실행할 함수를 정의
$(document).ready(function() {

	// 사이드바 토글 기능
	$("#toggleButton").click(function() {
    	$("#sidebar").toggleClass("hidden");
    	$(".video_selection").toggleClass("moved");
	});

	// 서브메뉴 토글 기능
	const navItem = document.querySelector('.nav-item.na');
	const subMenu = document.querySelector('.sub-menu');

	navItem.addEventListener('click', () => {
		subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
	});

	// Swiper 초기화
	const swiper = new Swiper('.swiper-container', {
		direction: 'horizontal',
	    loop: false,
		// autoplay: false,
		slidesPerGroup: 4,
		spaceBetween: 10,
		navigation: {
			prevEl: '.top20_box .swiper-prev',
			nextEl: '.top20_box .swiper-next',
		},
		pagination: {
			el: '.top20_box .swiper-pagination',
			type: 'bullets',
			clickable: true,
		},
		breakpoints: {
			300: {
				slidesPerView: 3, // 브라우저가 300보다 클 때
				spaceBetween: 10,
		},
			930: {
				slidesPerView: 4, // 브라우저가 930보다 클 때
		        spaceBetween: 10,
		      },
			1480: {
		        slidesPerView: 5, // 브라우저가 1480보다 클 때
		        spaceBetween: 10,
		      },
			1780: {
		        slidesPerView: 7, // 브라우저가 1780보다 클 때
		        spaceBetween: 10,
			},
		},
		on: {
			init: function() {
				updateNavigationButtons(this); // 초기화 시 버튼 상태 업데이트
			},
			slideChange: function() {
				updateNavigationButtons(this); // 슬라이드 변경 시 버튼 상태 업데이트
			},
		}
	});

	// 네비게이션 버튼 상태 업데이트 함수
	function updateNavigationButtons(swiper) {
		const { isBeginning, isEnd } = swiper;

		const prevButton = document.querySelector('.swiper-prev');
		const nextButton = document.querySelector('.swiper-next');

		if (isBeginning) {
			prevButton.style.display = 'none'; // 첫 번째 페이지에서는 이전 버튼 숨기기
		} else {
			prevButton.style.display = 'block'; // 그렇지 않으면 이전 버튼 보이기
	}

		if (isEnd) {
		      nextButton.style.display = 'none'; // 마지막 페이지에서는 다음 버튼 숨기기
		} else {
		      nextButton.style.display = 'block'; // 그렇지 않으면 다음 버튼 보이기
		}
	}
});


	document.addEventListener('DOMContentLoaded', function() {
	// 모든 버튼 요소를 가져옵니다.
	const buttons = document.querySelectorAll('.title_btn_a, .title_btn_b');

		// 모든 버튼을 순회하여 클릭 이벤트 핸들러를 추가합니다.
		buttons.forEach(button => {
		button.addEventListener('click', function() {
		// 모든 버튼의 활성화 스타일을 초기화합니다.
		buttons.forEach(btn => {
		btn.classList.remove('selected');
		});

		// 클릭된 버튼에만 활성화 스타일을 적용합니다.
			this.classList.add('selected');
				});
			});

		// 페이지 로드 시 첫 번째 버튼을 기본 선택 상태로 설정합니다.
		buttons[0].classList.add('selected');
		});

