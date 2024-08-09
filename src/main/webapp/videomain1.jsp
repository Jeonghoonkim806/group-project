<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.concurrent.TimeUnit" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>집요정 TV</title>
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
  <link rel="shortcut icon" href="./favicon.ico" />
  <link rel="icon" href="./favicon.png" />
  <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
  
  <link href="./css/videomain.css" rel="stylesheet">
  <link href="./css/header.css" rel="stylesheet">
  <link href="./css/sidebar.css" rel="stylesheet">
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" />
  
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
            <button class="box">전체</button>
            <button class="box">반려동물</button>
            <button class="box">야구</button>
            <button class="box">뉴스</button>
            <button class="box">요리</button>
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
			     </div>  
			   </section>
			   </div>
            </div>
            
			   <!-- Up next -->
			   <section class="upNext">
                <span class="title">추천 영상</span>
                <ul>
                    <li class="item">
                        <div class="img"><img src="./images/amd.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title">AMD</span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                    <li class="item">
                        <div class="img"><img src="./images/intel.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title">intel</span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                    <li class="item">
                        <div class="img"><img src="./images/nvidia.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title"><strong>nvidia</strong></span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                    <li class="item">
                        <div class="img"><img src="./images/amd.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title">AMD</span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                    <li class="item">
                        <div class="img"><img src="./images/amd.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title">AMD</span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                    <li class="item">
                        <div class="img"><img src="./images/amd.png" alt=""></div>
                        <div class="itemInfo">
                            <span class="title">AMD</span>
                            <span class="name">민기</span>
                            <span class="views">82K views</span>
                        </div>
                        <button class="moreBtn"><i class="fas fa-ellipsis-v"></i></button>
                    </li>
                </ul>
            </section>
			</div>
		</div>
		</div>

  <!-- Comments Section -->
  <section class="comments">
    <form id="commentForm">
      <input type="text" id="commentInput" placeholder="Add a comment" required>
      <button type="submit">Post</button>
    </form>
    <ul id="commentList"></ul>
  </section>

  <!-- 로그인 필요 팝업 -->
  <div id="actionPopup" class="popup-overlay">
    <div class="popup-content">
      <h2>로그인이 필요합니다</h2>
      <button id="popupCloseButton">확인</button>
    </div>
  </div>

  <script>
  document.addEventListener('DOMContentLoaded', function() {
	    const actionPopup = document.getElementById('actionPopup');
	    const popupCloseButton = document.getElementById('popupCloseButton');

	    function checkLoginStatus(callback) {
	        $.ajax({
	            url: 'LoginStatusServlet', // 로그인 상태를 확인하는 서블릿 URL
	            method: 'GET',
	            success: function(data) {
	                try {
	                    const response = JSON.parse(data);
	                    callback(response.loggedIn === 'true');
	                } catch (e) {
	                    console.error('Failed to parse login status:', e);
	                    callback(false);
	                }
	            },
	            error: function(xhr) {
	                console.error('Failed to check login status:', xhr.responseText);
	                callback(false);
	            }
	        });
	    }

	    function showPopup() {
	        actionPopup.style.display = 'flex';
	    }

	    function hidePopup() {
	        actionPopup.style.display = 'none';
	    }
		    
		    

	    const likeButton = document.getElementById('likeButton');
	    const likeCount = document.getElementById('likeCount');
	    const dislikeButton = document.getElementById('dislikeButton');
	    const dislikeCount = document.getElementById('dislikeCount');
	    const commentForm = document.getElementById('commentForm');
	    const commentInput = document.getElementById('commentInput');
	    const commentList = document.getElementById('commentList');
	    const titleElement = document.querySelector('.title');
	    const videoUrl = new URLSearchParams(window.location.search).get('video');

	    if (!videoUrl) {
	        console.error('No video URL provided.');
	        return;
	    }

	    const decodedVideoUrl = decodeURIComponent(videoUrl); // URL 디코딩
	    const videoSource = document.getElementById('videoSource');     
	    videoSource.src = './video1/' + decodedVideoUrl; // 동영상 파일 경로 설정
	    const videoPlayer = document.getElementById('videoPlayer');
	    videoPlayer.load();
	    videoPlayer.play();

	    const videoFile = decodedVideoUrl; // 동영상 파일 이름을 ID로 사용

	    function loadVideoData() {
	        $.ajax({
	            url: 'VideoDataServlet',
	            method: 'GET',
	            data: { videoFile },
	            success: function(data) {
	                try {
	                    const videoData = JSON.parse(data);
	                    titleElement.textContent = videoData.title;
	                    likeCount.textContent = videoData.likes + ' Likes';
	                    dislikeCount.textContent = videoData.dislikes + ' Dislikes';
	                } catch (e) {
	                    console.error('Failed to parse video data:', e);
	                }
	            },
	            error: function(xhr) {
	                console.error('Failed to load video data:', xhr.responseText);
	            }
	        });
	    }

	    function loadLikes() {
	        $.ajax({
	            url: 'VideoDataServlet',
	            method: 'GET',
	            data: { videoFile },
	            success: function(data) {
	                try {
	                    const videoData = JSON.parse(data);
	                    likeCount.textContent = videoData.likes + ' Likes';
	                    dislikeCount.textContent = videoData.dislikes + ' Dislikes';
	                } catch (e) {
	                    console.error('Failed to parse likes:', e);
	                }
	            },
	            error: function(xhr) {
	                console.error('Failed to load likes:', xhr.responseText);
	            }
	        });
	    }

	    function loadComments() {
	        $.ajax({
	            url: 'VideoActionServlet',
	            method: 'GET',
	            data: { action: 'loadComments', videoFile },
	            success: function(data) {
	                commentList.innerHTML = '';
	                try {
	                    const comments = JSON.parse(data);
	                    comments.forEach(comment => {
	                        const li = document.createElement('li');
	                        li.textContent = comment;
	                        commentList.appendChild(li);
	                    });
	                } catch (e) {
	                    console.error('Failed to parse comments:', e);
	                }
	            },
	            error: function(xhr) {
	                console.error('Failed to load comments:', xhr.responseText);
	            }
	        });
	    }

	    likeButton.addEventListener('click', () => {
	        checkLoginStatus((isLoggedIn) => {
	            if (!isLoggedIn) {
	                showPopup();
	                return;
	            }
	            $.ajax({
	                url: 'VideoActionServlet',
	                method: 'POST',
	                data: { action: 'like', videoFile },
	                success: function() {
	                    loadLikes();
	                },
	                error: function(xhr) {
	                    console.error('Failed to like the video:', xhr.responseText);
	                }
	            });
	        });
	    });

	    dislikeButton.addEventListener('click', () => {
	        checkLoginStatus((isLoggedIn) => {
	            if (!isLoggedIn) {
	                showPopup();
	                return;
	            }
	            $.ajax({
	                url: 'VideoActionServlet',
	                method: 'POST',
	                data: { action: 'dislike', videoFile },
	                success: function() {
	                    loadLikes();
	                },
	                error: function(xhr) {
	                    console.error('Failed to dislike the video:', xhr.responseText);
	                }
	            });
	        });
	    });

	    commentForm.addEventListener('submit', (event) => {
	        event.preventDefault();
	        checkLoginStatus((isLoggedIn) => {
	            if (!isLoggedIn) {
	                showPopup();
	                return;
	            }
	            const comment = commentInput.value;
	            if (comment) {
	                $.ajax({
	                    url: 'VideoActionServlet',
	                    method: 'POST',
	                    data: { action: 'comment', videoFile, comment },
	                    success: function() {
	                        loadComments();
	                        commentInput.value = ''; // 입력 필드 비우기
	                    },
	                    error: function(xhr) {
	                        console.error('Failed to post comment:', xhr.responseText);
	                    }
	                });
	            }
	        });
	    });

	    popupCloseButton.addEventListener('click', () => {
	        actionPopup.style.display = 'none';
	    });

	    loadVideoData();
	    loadLikes();
	    loadComments();
	});
  </script>
</body>
</html>