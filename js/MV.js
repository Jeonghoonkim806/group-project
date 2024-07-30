function openVideo(videoUrl) {
    // YouTube URL을 변환하여 video.html로 전달
    window.location.href = `video.html?video=${encodeURIComponent(videoUrl)}`;
}