<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dob.DBManager" %>
<%
    HttpSession session2 = request.getSession(false);
    if (session2 == null || session2.getAttribute("memberID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Video</title>
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="icon" href="favicon.png" />
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
    <link href="./css/upload.css" rel="stylesheet">
    <link href="./css/header.css" rel="stylesheet">
    <link href="./css/sidebar.css" rel="stylesheet">
    <!-- 폰트 설정 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- 아이콘 설정 --> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@20..700&display=swap" />
    <!-- 오픈 그래프 설정 -->
    <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
    <meta property="fb:app_id" content="87741124305">
    <meta name="description" content="YouTube에서 마음에 드는 동영상과 음악을 감상하고, 직접 만든 콘텐츠를 업로드하여 친구, 가족뿐 아니라 전 세계 사람들과 콘텐츠를 공유할 수 있습니다.">
    <meta name="keywords" content="동영상, 공유, 카메라폰, 동영상폰, 무료, 올리기">
    <meta name="theme-color" content="rgba(255, 255, 255, 0.98)">
    <!-- 자바 스크립트 설정 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- gsap js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" crossorigin="anonymous"></script>
    <!-- swiper 6.8.4 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" crossorigin="anonymous" />
    <!-- 아이콘 불러오기 -->
    <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
    <script defer src="./js/upload.js"></script>
</head>
<body>
    <div class="header">
        <%@ include file="header.jsp" %>
    </div>
    <%@ include file="sidebar.jsp" %>
    <div class="upload-form">
        <div class="upload-header">
            <img src="./images/uploadmain.png">
        </div>
        <form action="./upload.jsp" method="post" id="form1" >
            <div class="upload-body">
	            <div class="textbox">
	            	<h4>제목</h4>
	                <input type="text" placeholder="Title" name="title" />
	            </div>
	            <div class="textbox">
	            	<h4>설명</h4>
	                <textarea placeholder="Description" name="description" /></textarea>
	            </div>
	            <div class="textbox">
	            	<h4>카테고리</h4>
	                 <select name="category">
	                    <option value="Film & Animation">영화 및 애니메이션</option>
	                    <option value="Autos & Vehicles">자동차 및 차량</option>
	                    <option value="Music">음악</option>
	                    <option value="Pets & Animals">애완동물 및 동물</option>
	                    <option value="Sports">스포츠</option>
	                    <option value="Travel & Events">여행 및 이벤트</option>
	                    <option value="Gaming">게임</option>
	                    <option value="People & Blogs">인물 및 블로그</option>
	                    <option value="Comedy">코미디</option>
	                    <option value="Entertainment">엔터테인먼트</option>
	                    <option value="News & Politics">뉴스 및 정치</option>
	                    <option value="Howto & Style">노하우 및 스타일</option>
	                    <option value="Education">교육</option>
	                    <option value="Science & Technology">과학 및 기술</option>
	                    <option value="Nonprofits & Activism">비영리 및 사회운동</option>
	                </select>
	            </div>
	            <div class="textbox">
	            	<h4>태그</h4>
	                <input type="text" placeholder="Tags" name="tags" autocomplete="on" />
	            </div>
	            <div class="textbox">
	            	<h4>상태</h4>
	                <select name="status" required>
	                    <option value="공개">공개</option>
	                    <option value="비공개">비공개</option>
	                </select>
	            </div>
	            <div class="textbox">
	            	<h4>썸네일</h4>
	                <input type="text" placeholder="Thumbnail URL" name="thumbnail_url" />
	            </div>
	            <div class="textbox">
	            	<h4>영상ID</h4>
	                <input type="text" placeholder="Video ID" name="video_id" />
	            </div>
	            <div class="textbox">
	            	<h4>로고이미지주소</h4>
	                <input type="text" placeholder="Logo URL" name="logo_url" />
	            </div>
	            <div class="btn-sc">
	                <a href ="javascript: regSubmit();">등 록</a>
	                <a href ="./main.jsp">취 소</a>
            	</div>
            </div>  
        </form>
    </div>
</body>
</html>
