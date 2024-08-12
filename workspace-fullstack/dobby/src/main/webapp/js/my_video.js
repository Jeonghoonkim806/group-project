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
        console.log("Search button clicked");
        const searchText = $('.search input').val().toLowerCase();
        console.log("Search text:", searchText);
        window.location.href = './main.jsp?search=' + encodeURIComponent(searchText);
    });
    // 비디오 클릭 시 상세 페이지로 이동
    $(".video").click(function() {
        const seq = $(this).data('seq');
        window.location.href = 'videomain.jsp?seq=' + seq;
    });
    

    // upload 이미지 클릭 시 메시지 박스 띄우기
    $('#uploadIcon').on('click', function(){
        $('#myModal').show();
    });
    $('#cancel-upload').on('click', function() {
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