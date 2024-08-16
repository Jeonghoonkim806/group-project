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

    // 비디오 이동 버튼 클릭 시 상세 페이지로 이동
    $(document).on('click', '.play-button', function() {
        const seq = $(this).data('seq');
        if (seq) {
            window.location.href = 'videomain2.jsp?seq=' + seq;
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
    
     $('.mylist-search button').on('click', function() {
        var searchText = $('.mylist-search input').val().toLowerCase();
        var hasResults = false;

        // 각 동영상 목록 항목을 검사
        $('.mylist-item').each(function() {
            var title = $(this).find('#title').text().toLowerCase();

            // 검색어와 제목이 일치하면 결과가 있는 것으로 간주
            if (title.includes(searchText)) {
                $(this).show();
                hasResults = true;
            } else {
                $(this).hide(); // 검색어와 일치하지 않는 항목 숨기기
            }
        });

        // 검색 결과가 없을 때 메시지 박스 표시
        if (hasResults) {
            $('#no-results-message').hide();
        } else {
            $('#no-results-message').show();
        }
    });

    // Enter 키 입력 시 필터링 수행
    $('.mylist-search input').on('keypress', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();  // Enter 키 입력 시 폼 제출 방지
            $('.mylist-search button').click();  // 버튼 클릭 이벤트 강제 트리거
        }
    });
});