<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
  
  <title>집요정 TV</title>
  <link rel="shortcut icon" href="./favicon.ico" />
  <link rel="icon" href="./favicon.png" />
  <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
  
  <link href="./css/videomain.css" rel="stylesheet">
  <link href="./css/header.css" rel="stylesheet">
  <link href="./css/sidebar.css" rel="stylesheet">
  
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
  <script defer src="./js/MV.js"></script>
</head>

<body>
    <!-- ------HEADER ------ -->
   	<%@ include file="./header.jsp" %>

   <!------MAIN------>
   <div class="YtBody">
    <%@ include file="./sidebar.jsp" %>
    
    <div class="video_selection">
        <div class="recommendboxes">
            
        </div>
        
        <div class="container">

  			<!-- Video Player -->
		<div class="allVideo">
	        <div class="videoAndNext">
			  <div class="player">
			    <video id="videoPlayer" controls>
			      <source id="videoSource" src="" type="video/mp4">
			    </video>
			  </div>
			</div>
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