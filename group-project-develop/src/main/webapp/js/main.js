$(document).ready(function() {
    // 사이드바 토글 기능
    $("#toggleButton").click(function() {
        $("#sidebar").toggleClass("hidden");
        $(".video_selection").toggleClass("moved");
    });

    // 서브메뉴 토글 기능
    const navItem = document.querySelector('.nav-item.na');
    const subMenu = document.querySelector('.sub-menu');

    if (navItem) {
        navItem.addEventListener('click', () => {
            subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
        });
    }

    // 검색 기능
    $('.search button').on('click', function() {
        const searchText = $('.search input').val().toLowerCase();
        $('.video').each(function() {
            const videoTitle = $(this).find('h2').text().toLowerCase();
            if (videoTitle.includes(searchText)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
    
    // 비디오 클릭시 상세화면 이동
    $(".video").click(function() {
        const seq = $(this).data('seq');
        window.location.href = 'videomain2.jsp?seq=' + seq;
    });

    // 음악 버튼 클릭 기능
    $('#music-button').click(function() {
        window.location.href = 'music.jsp';
    });

    // 게시판 버튼 클릭 기능
    $('#board-button').click(function() {
        window.location.href = 'board.jsp';
    });
});