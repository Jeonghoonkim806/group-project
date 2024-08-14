<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.LinkedHashSet" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Set" %>
<%

    class myVideo {
        String seq;
        String title;
        String description;
        String category;
        String status;
        String videoID;
        String uploadDate;
        String uploaderId;  
    }
	String memberID1 = request.getParameter("id");
    List<myVideo> videos = new ArrayList<>();
    
    String selectSql = "SELECT seq, title, description,category, status, upload_date, video_id, uploader_id FROM video WHERE uploader_id = ?";  
           	
    try (Connection conn = DBManager.getDBConnection();
            PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
           
    	 pstmt.setString(1, memberID1);
           
           try (ResultSet rs = pstmt.executeQuery()) {
               while (rs.next()) {
                   myVideo video = new myVideo();
                   video.seq = rs.getString("seq");
                   video.title = rs.getString("title");
                   video.description = rs.getString("description");
                   video.category = rs.getString("category");
                   video.status = rs.getString("status");
                   video.videoID = rs.getString("video_id");
                   video.uploadDate = rs.getString("upload_date");
                   video.uploaderId = rs.getString("uploader_id");

                   videos.add(video);
               }
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
   %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 1. 탭 타이틀 세팅 -->
    <title>내 동영상</title>
    <!-- 2. favicon(favorite icon) 세팅 -->
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="icon" href="favicon.png" />
    <!-- 3. reset.css 세팅(cdn) -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
    <!-- 4. 커스템 css파일 세팅(local) -->
    <link href="./css/my_video.css" rel="stylesheet">
    <link href="./css/sidebar.css" rel="stylesheet">
    <link href="./css/header.css" rel="stylesheet">
    <!-- 5. 폰트 설정 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <!-- 6. 아이콘 설정 --> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 7. 오픈 그래프 설정(더 많은 속성을 보고 싶으면 https://ogp.me) -->
    <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
    <meta property="fb:app_id" content="87741124305">
    <meta name="description" content="YouTube에서 마음에 드는 동영상과 음악을 감상하고, 직접 만든 콘텐츠를 업로드하여 친구, 가족뿐 아니라 전 세계 사람들과 콘텐츠를 공유할 수 있습니다.">
    <meta name="keywords" content="동영상, 공유, 카메라폰, 동영상폰, 무료, 올리기">
    <meta name="theme-color" content="rgba(255, 255, 255, 0.98)">
    
    <!-- gsap js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js" integrity="sha512-IQLehpLoVS4fNzl7IfH8Iowfm5+RiMGtHykgZJl9AWMgqx0AmJ6cRWcB+GaGVtIsnC4voMfm8f2vwtY+6oPjpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js" integrity="sha512-nTHzMQK7lwWt8nL4KF6DhwLHluv6dVq/hNnj2PBN0xMl2KaMm1PM02csx57mmToPAodHmPsipoERRNn4pG7f+Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <!-- swiper 6.8.4 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js" integrity="sha512-BABFxitBmYt44N6n1NIJkGOsNaVaCs/GpaJwDktrfkWIBFnMD6p5l9m+Kc/4SLJSJ4mYf+cstX98NYrsG/M9ag==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" integrity="sha512-aMup4I6BUl0dG4IBb0/f32270a5XP7H1xplAJ80uVKP6ejYCgZWcBudljdsointfHxn5o302Jbnq1FXsBaMuoQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- jQuery 연결 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!--  아이콘 불러오기 -->
    <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
    <script defer src="./js/my_video.js"></script>
</head>
<body>
	 <%@ include file="./header.jsp" %>
    <div class="YtBody">
        <%@ include file="./sidebar.jsp" %>
        <div class="video_selection">
            <div class="container">
                <% if (videos.isEmpty()) { %>
                    <p>업로드한 영상이 존재하지 않습니다.</p>
                <% } else { %>
                    <div class="mylist">
                        <h4>내 동영상 목록</h4>
                        <div class = "mylist-search">
                        	<form "javascript:void(0);">
                        		<div class="search-inner">
                        			<input type="search"  name="searchTitle" placeholder="제목">
	                        		<button type ="button">
	                        			<i class="fas fa-search"></i>
	                        		</button>  
                        		</div>           	
                        	</form>
                       	</div>
                        <div class="mylist-header">
                            <ul>
                                <li>제 목</li>
                                <li>설 명</li>
                                <li>카테고리</li>
                                <li>상 태</li>
                                <li>영상 ID</li>
                                <li>업로드 날짜</li>
                            </ul>
                        </div>
                        <% for (myVideo video : videos) { %>
                        <div class="mylist-item" data-seq="<%= video.seq %>">
                            <ul class="video_list">
                                <li id="title"><%= video.title %></li>
                                <li><%= video.description %></li>
                                <li><%= video.category %></li>
                                <li><%= video.status %></li>
                                <li><%= video.videoID %></li>
                                <li><%= video.uploadDate %></li>
                            </ul>
                            <div class="setting">    
                                <i class="fa-solid fa-pen-to-square update-button" data-seq="<%= video.seq %>"></i>
                                <i class="fa-solid fa-trash-can delete-button" data-seq="<%= video.seq %>"></i>
                                <i class="fa-solid fa-location-arrow play-button" data-seq="<%= video.seq %>" ></i>            
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div id="no-results-message">
                        검색 결과가 없습니다.
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>