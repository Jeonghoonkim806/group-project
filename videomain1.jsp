<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dob.DBManager" %>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>집요정 TV - 비디오 재생</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet" />
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
    <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
    <script defer src="./js/main.js"></script>
    <script defer src="./js/MV.js"></script>
</head>

<body>
    <!-- HEADER 포함 -->
    <%@ include file="./header.jsp" %>

    <!-- MAIN CONTENT -->
    <div class="YtBody">
        <%@ include file="./sidebar.jsp" %>

        <div class="video_selection">
            <div class="container">
                <!-- 비디오 플레이어 -->
                <div class="allVideo">
                    <div class="videoAndNext">
                        <div class="player">
                            <video id="videoPlayer" controls>
                                <source id="videoSource" src="<%= request.getAttribute("videoUrl") %>" type="video/mp4">
                            </video>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="commentSection">
            <h2>댓글 작성</h2>
            <form method="post" id="commentForm" action="saveComment.jsp">
                <input type="hidden" name="filename" id="filename" value="<%= request.getAttribute("videoFileName") %>" />
                
                <textarea id="comment" name="comment" rows="4" cols="50" required></textarea><br><br>
                <input type="submit" value="댓글 등록" />
            </form>
        	</div>
    
			<div class="commentList">
		    <h2>댓글 목록</h2>
		    <%
			    Connection conn = null;
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			
			    // 비디오 ID를 문자열로 안전하게 변환
			    String videoId = (String) request.getAttribute("videoId");
			
			    // 비디오 ID가 null인 경우, 파라미터에서 가져오기
			    if (videoId == null || videoId.isEmpty()) {
			        videoId = request.getParameter("video");
			    }
			
			    // VIDEO_ID 값 확인
			    if (videoId == null || videoId.isEmpty()) {
			        out.println("<p style='color:red;'>비디오 ID가 설정되지 않았습니다.</p>");
			    } else {
			        try {
			            conn = DBManager.getDBConnection();
			            pstmt = conn.prepareStatement("SELECT \"COMMENT\" FROM VIDEO_COMMENTS WHERE FILENAME = ? ORDER BY created_at DESC");
			            pstmt.setString(1, videoId); // 비디오 ID 대신 FILENAME을 사용하는 SQL 쿼리
			            rs = pstmt.executeQuery();
			
			            // 결과가 없는 경우
			            if (!rs.next()) {
			                out.println("<p>댓글이 없습니다.</p>");
			            } else {
			                // 결과가 있는 경우
			                do {
			                    String comment = rs.getString("COMMENT");
			
			                    out.println("<div class='comment'>");
			                    out.println("<p>" + comment + "</p>");
			                    out.println("</div>");
			                } while (rs.next()); // 다음 레코드로 이동
			            }
			        } catch (SQLException e) {
			            e.printStackTrace();
			            out.println("<p style='color:red;'>댓글을 불러오는 데 오류가 발생했습니다: " + e.getMessage() + "</p>");
			        } finally {
			            if (rs != null) {
			                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
			            }
			            if (pstmt != null) {
			                try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			            }
			            if (conn != null) {
			                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
			            }
			        }
			    }
			%>
		</div>
	</div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const videoUrl = new URLSearchParams(window.location.search).get('video');
            
            if (!videoUrl) {
                console.error('No video URL provided.');
                return;
            }
            
            const decodedVideoUrl = decodeURIComponent(videoUrl); // URL 디코딩
            const videoSource = document.getElementById('videoSource');
            videoSource.src = './video1/' + decodedVideoUrl; // 동영상 파일 경로 설정
            
            const videoPlayer = document.getElementById('videoPlayer');
            videoPlayer.load(); // 비디오 로드
            videoPlayer.play(); // 비디오 재생
            
            // 비디오 파일명을 hidden input에 자동 설정
            document.getElementById('filename').value = decodedVideoUrl;
        });
    </script>
    
    
    
</body>
</html>