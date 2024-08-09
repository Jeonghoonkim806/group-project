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
        window.location.href = 'main.jsp?search=' + encodeURIComponent(searchText);
    });

    // URL 파라미터에서 검색어 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const search = urlParams.get('search');
    if (search) {
        $('.search input').val(search);
        $('.video').each(function() {
            const videoTitle = $(this).find('h2').text().toLowerCase();
            if (videoTitle.includes(search.toLowerCase())) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    // 비디오 클릭 시 상세 페이지로 이동
    $(".video").click(function() {
        const seq = $(this).data('seq');
        window.location.href = 'videomain2.jsp?seq=' + seq;
    });

    // upload 이미지 클릭 시 메시지 박스 띄우기
    $('#uploadIcon').on('click', function(){
        $('#myModal').show();
    });
    $('#cancle-upload').on('click', function() {
        $('#myModal').hide();
    });
    
    $(window).on('click', function(event) {
        if ($(event.target).is('#myModal')) {
            $('#myModal').hide();
        }
    });
    $('#file-upload').on('click', function() {
        window.location.href = 'upload_file_form.jsp';
    });

    $('#url-upload').on('click', function() {
        window.location.href = 'upload_form.jsp';
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
