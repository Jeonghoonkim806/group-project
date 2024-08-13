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
    $(document).on('click', '.play-button', function() {
        const seq = $(this).data('seq');
        if (seq) {
            window.location.href = 'videomain.jsp?seq=' + seq;
        } else {
            alert("비디오 식별자가 존재하지 않습니다.");
        }
    });
    
     $(document).on('click', '.delete-button', function() {
        const seq = $(this).data('seq');
        if (seq) {
            if(confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    url: 'delete_video.jsp',
                    type: 'POST',
                    data: { seq: seq },
                    success: function(response) {
                        if (response.trim() === 'success') {
                            alert("비디오가 삭제되었습니다.");
                            $(`div[data-seq="${seq}"]`).remove(); // 화면에서 해당 비디오 항목 제거
                        } else {
                            alert("비디오 삭제에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            }
        } else {
            alert("비디오 식별자가 존재하지 않습니다.");
        }
    });
    $(document).on('click', '.update-button', function() {
        const seq = $(this).data('seq');
        if (seq) {
            window.location.href = 'update_video_form.jsp?seq=' + seq;
        } else {
            alert("비디오 식별자가 존재하지 않습니다.");
        }
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