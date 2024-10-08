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
/*    $('.search button').on('click', function() {
        console.log("Search button clicked");
        const searchText = $('.search input').val().toLowerCase();
        console.log("Search text:", searchText);
        window.location.href = './main.jsp?search=' + encodeURIComponent(searchText);
    });*/

    // 좋아요 및 싫어요 버튼 클릭 이벤트 처리
    $('#likeButton').click(function() {
        const seq = $(this).data('seq');
        $.post('likes.jsp', { seq: seq, action: 'like' }, function(response) {
            $('#likeCount').text(response.newLikes);
        });
    });

    $('#dislikeButton').click(function() {
        const seq = $(this).data('seq');
        $.post('likes.jsp', { seq: seq, action: 'dislike' }, function(response) {
            $('#dislikeCount').text(response.newDislikes);
        });
    });
});

var tag = document.createElement('script');

tag.src = "https://www.Youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag,firstScriptTag);

var videoPlayer;
function onYouTubeIframeAPIReady() {
	 var video_id = document.getElementById("videoPlayer").getAttribute("data-video-id");
	new YT.Player('videoPlayer', {
		video_id: video_id, 
		playerVars: {
			autoplay: true,
			controls: true,
			loop: false,
			playlist: video_id
		},
		events: {
			'onReady': onPlayerReady,
			'onStateChange': onPlayerStateChange 
		}	
	});
}

function onPlayerReady(event){
	event.target.playVideo();
}
function onPlayerStateChange(event) {
	if (event.data == YT.PlayerState.PLAYING) console.log("재생중");
	else if(event.data == YT.PlayerState.PAUSED) console.log("일시중지");
}
