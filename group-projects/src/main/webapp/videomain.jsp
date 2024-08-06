<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
  <script src="./js/videoPlay.js" defer></script>
  <title>집요정 TV</title>
  <link rel="shortcut icon" href="./favicon.ico" />
  <link rel="icon" href="./favicon.png" />
  <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
  <link href="./css/youtubemain.css" rel="stylesheet">
  <link href="./css/videoplay.css" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
    rel="stylesheet">
  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
  <meta property="fb:app_id" content="87741124305">
  <meta name="description"
    content="YouTube에서 마음에 드는 동영상과 음악을 감상하고, 직접 만든 콘텐츠를 업로드하여 친구, 가족뿐 아니라 전 세계 사람들과 콘텐츠를 공유할 수 있습니다.">
  <meta name="keywords" content="동영상, 공유, 카메라폰, 동영상폰, 무료, 올리기">
  <meta name="theme-color" content="rgba(255, 255, 255, 0.98)">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js"
    integrity="sha512-IQLehpLoVS4fNzl7IfH8Iowfm5+RiMGtHykgZJl9AWMgqx0AmJ6cRWcB+GaGVtIsnC4voMfm8f2vwtY+6oPjpQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js"
    integrity="sha512-nTHzMQK7lwWt8nL4KF6DhwLHluv6dVq/hNnj2PBN0xMl2KaMm1PM02csx57mmToPAodHmPsipoERRNn4pG7f+Q=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"
    integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js"
    integrity="sha512-BABFxitBmYt44N6n1NIJkGOsNaVaCs/GpaJwDktrfkWIBFnMD6p5l9m+Kc/4SLJSJ4mYf+cstX98NYrsG/M9ag=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css"
    integrity="sha512-aMup4I6BUl0dG4IBb0/f32270a5XP7H1xplAJ80uVKP6ejYCgZWcBudljdsointfHxn5o302Jbnq1FXsBaMuoQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
  <script defer src="./js/youtubemain.js"></script>
  <script src="./js/MV.js"></script>
</head>

<body>
  <!-- HEADER -->
  <header class="header">
    <div class="header_logo">
      <button id="toggleButton">
        <i class="fas fa-bars"></i>
      </button>
      <img src="./images/logo1.png" alt="집요정TV">
    </div>

    <div class="search">
      <form action="search.jsp" method="get">
        <div class="search-inner">
          <input type="search" name="query" placeholder="검색">
        </div>
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
    </div>
    <div class="header_icons">
      <button id="videoToggle"> <i class="fas fa-video"></i></button>
      <i class="fas fa-ellipsis-h"></i>
      <i class="fas fa-bell"></i>
      <i class="fas fa-user-circle"></i>
    </div>
  </header>

  <!-- Video Player -->
  <section class="player">
    <video id="videoPlayer" controls>
      <source id="videoSource" src="" type="video/mp4">
    </video>
  </section>

  <!-- Video info & Up next -->
  <div class="infoAndUpNext">
    <!-- Video Info -->
    <section class="info">
      <!-- Metadata -->
      <div class="metadata">
        <ul class="hashtags">
          <li>#CPU</li>
          <li>#GPU</li>
          <li>#PC</li>
        </ul>
        <div class="titleAndButton">
          <span class="title clamp">
            바다 가고싶다... 너무너무너무너무너무너무너무
          </span>
          <button class="moreBtn">
            <i class="fas fa-caret-down"></i>
          </button>
        </div>
        <span class="views">1M views 1 month ago</span>
      </div>
      <!-- Actions buttons -->
      <ul class="actions">
        <li>
          <button>
            <i class="active fas fa-thumbs-up"></i><span>1K</span>
          </button>
        </li>
        <li>
          <button><i class="fas fa-thumbs-down"></i><span>0</span></button>
        </li>
        <li>
          <button><i class="fas fa-share"></i><span>Share</span></button>
        </li>
        <li>
          <button><i class="fas fa-plus"></i><span>Save</span></button>
        </li>
        <li>
          <button>
            <i class="fab fa-font-awesome-flag"></i><span>Report</span>
          </button>
        </li>
      </ul>
      <!-- Channel description -->
      <div class="channel">
        <div class="metadata">
          <img src="./images/black.png" alt="" />
          <div class="info">
            <span class="name">민기</span>
            <span class="subscribers">1M subcribers</span>
          </div>
        </div>
        <button class="subscribe">구독</button>
      </div>
    </section>

    <!-- Up next -->
    <section class="upNext">
      <span class="title">다음 영상</span>
      <ul>
        <li class="item">
          <div class="img"><img src="./YouTube/images/amd.png" alt="" /></div>
          <div class="itemInfo">
            <span class="title">AMD</span>
            <span class="name">민기</span>
            <span class="views">82K views</span>
          </div>
          <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
        </li>
        <li class="item">
          <div class="img"><img src="./YouTube/images/intel.png" alt="" /></div>
          <div class="itemInfo">
            <span class="title">intel</span>
            <span class="name">민기</span>
            <span class="views">82K views</span>
          </div>
          <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
        </li>
        <li class="item">
          <div class="img"><img src="./YouTube/images/nvidia.png" alt="" /></div>
          <div class="itemInfo">
            <span class="title">nvidia</span>
            <span class="name">민기</span>
            <span class="views">82K views</span>
          </div>
          <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
        </li>
      </ul>
    </section>
  </div>

   

	 <script>
		  //페이지 로드 후 동영상 경로를 설정하는 함수
		  document.addEventListener('DOMContentLoaded', function() {
		      // URL에서 'video' 쿼리 파라미터 값을 가져옵니다.
		      const videoUrl = new URLSearchParams(window.location.search).get('video');
		      if (videoUrl) {
		          // videoSource 요소를 찾아서 src 속성을 설정합니다.
		          const videoSource = document.getElementById('videoSource');
		          videoSource.src = videoUrl;
		
		          // videoPlayer를 찾아서 새 소스를 로드하고 재생합니다.
		          const videoPlayer = document.getElementById('videoPlayer');
		          videoPlayer.load(); // 소스를 다시 로드합니다.
		          videoPlayer.play(); // 동영상을 재생합니다.
		      } else {
		          console.error('No video URL provided.');
		      }
		  });
    </script>

</body>

</html>