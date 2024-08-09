$(document).ready(function() {
    $("#toggleButton").click(function() {
        $("#sidebar").toggleClass("hidden"); // .sidebar의 표시 상태를 토글합니다.
        $(".video_selection").toggleClass("moved"); // 콘텐츠 영역 이동
    });

    const navItem = document.querySelector('.nav-item.na');
    const subMenu = document.querySelector('.sub-menu');

    navItem.addEventListener('click', () => {
        subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
    });
});

