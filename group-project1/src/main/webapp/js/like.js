document.addEventListener('DOMContentLoaded', function() {
    const videoUrl = new URLSearchParams(window.location.search).get('video');
    const videoId = decodeURIComponent(videoUrl);
    const filenameInput = document.getElementById('filename');
    const filename = filenameInput ? filenameInput.value : '';

    if (!videoId && !filename) {
        console.error('No video URL or filename provided.');
        return;
    }

    const likeButton = document.getElementById('likeButton');
    const dislikeButton = document.getElementById('dislikeButton');

    if (!likeButton || !dislikeButton) {
        console.error('Like or Dislike button not found.');
        return;
    }

    likeButton.addEventListener('click', () => handleLikeDislike('like'));
    dislikeButton.addEventListener('click', () => handleLikeDislike('dislike'));

    function handleLikeDislike(type) {
        fetch('handleLikeDislike.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                filename: filename,
                type: type
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                updateCounts(data.likeCount, data.dislikeCount);
                showAlert('성공적으로 업데이트되었습니다!');
            } else {
                showAlert(' ' + (data.message || '알 수 없는 오류'));
            }
        })
        .catch(error => showAlert('에러: ' + error.message));
    }

    function updateCounts(likeCount, dislikeCount) {
        document.getElementById('likeCount').innerText = `: ${likeCount}`;
        document.getElementById('dislikeCount').innerText = `: ${dislikeCount}`;
    }

    function showAlert(message) {
        alert(message);
    }

    // 초기 좋아요와 싫어요 카운트 로드
    fetch('getVideoCounts.jsp?' + new URLSearchParams({ filename: filename }))
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                updateCounts(data.likeCount, data.dislikeCount);
            } else {
                console.error('Error loading video counts:', data.message || 'Unknown error');
            }
        })
        .catch(error => console.error('Error:', error));
});