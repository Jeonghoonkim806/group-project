<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 탭 타이틀 -->
    <title>집요정 TV</title>
    <!-- favicon 설정 -->
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="icon" href="favicon.png" />
    <!-- reset.css 사용 (cdn) -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
    <!-- local css 설정 -->
    <link href="./css/main.css" rel="stylesheet">
    <link href="./css/sidebar.css" rel="stylesheet">
    <link href="./css/header.css" rel="stylesheet">
    <link href="./css/search_mp4.css" rel="stylesheet">
    <!-- 폰트 설정 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <!-- 아이콘 설정 --> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 오픈 그래프 설정 -->
    <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
    <meta property="fb:app_id" content="87741124305">
    <meta name="description" content="YouTube에서 마음에 드는 동영상과 음악을 감상하고, 직접 만든 콘텐츠를 업로드하여 친구, 가족뿐 아니라 전 세계 사람들과 콘텐츠를 공유할 수 있습니다.">
    <meta name="keywords" content="동영상, 공유, 카메라폰, 동영상폰, 무료, 올리기">
    <meta name="theme-color" content="rgba(255, 255, 255, 0.98)">
    <!-- 자바 스크립트 설정 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js" integrity="sha512-IQLehpLoVS4fNzl7IfH8Iowfm5+RiMGtHykgZJl9AWMgqx0AmJ6cRWcB+GaGVtIsnC4voMfm8f2vwtY+6oPjpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js" integrity="sha512-nTHzMQK7lwWt8nL4KF6DhwLHluv6dVq/hNnj2PBN0xMl2KaMm1PM02csx57mmToPAodHmPsipoERRNn4pG7f+Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <!-- swiper 6.8.4 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js" integrity="sha512-BABFxitBmYt44N6n1NIJkGOsNaVaCs/GpaJwDktrfkWIBFnMD6p5l9m+Kc/4SLJSJ4mYf+cstX98NYrsG/M9ag==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" integrity="sha512-aMup4I6BUl0dG4IBb0/f32270a5XP7H1xplAJ80uVKP6ejYCgZWcBudljdsointfHxn5o302Jbnq1FXsBaMuoQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 아이콘 불러오기 -->
    <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
    <script defer src="./js/youtubemain.js"></script>
    <script src="./js/MV.js"></script>
  
</head>

<body>
    <!-- HEADER 포함 -->
    <%@ include file="./header.jsp" %>

    <!-- MAIN -->
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
            
<%
                String query = request.getParameter("query");
                if (query != null && !query.trim().isEmpty()) {
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    Set<String> displayedFiles = new HashSet<>();

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@1.220.247.78:1522:orcl", "semi_2405_team1", "1234");

                        String sql = "SELECT filename, title FROM ( " +
                                     "    SELECT filename, title FROM VIDEO_METADATA WHERE filename LIKE ? " +
                                     "    UNION ALL " +
                                     "    SELECT filename, title FROM VIDEO_COMMENTS WHERE filename LIKE ? " +
                                     ") GROUP BY filename, title";
                        
                        stmt = conn.prepareStatement(sql);

                        String searchPattern = "%" + query.trim().replaceAll("[^a-zA-Z0-9]", "") + "%";
                        stmt.setString(1, searchPattern);
                        stmt.setString(2, searchPattern);

                        rs = stmt.executeQuery();

                        out.println("<ul class='video-container'>"); // 클래스 적용
                        while (rs.next()) {
                            String filename = rs.getString("filename");
                            String title = rs.getString("title");
                            
                            // 중복 검사
                            if (displayedFiles.add(filename)) { // Set에 추가하고 성공 여부 반환
                                String encodedFilename = URLEncoder.encode(filename, "UTF-8"); // 파일명 인코딩
                                String videoUrl = "./video1/" + filename; // 동영상 파일 경로
                                String videoType = "video/mp4"; // 동영상 타입

                                // 동영상 링크 및 플레이어 출력
                                out.println("<li class='video-item'>"); // 클래스 적용
                                out.println("<a href='videomain1.jsp?video=" + encodedFilename + "'>");
                                out.println("<video controls>");
                                out.println("<source src='" + videoUrl + "' type='" + videoType + "'>");
                                
                                out.println("</video>");
                                
                                out.println("</a>");
                                out.println("<p class='video-title'>" + title + "</p>");
                                out.println("</li>");
                            }
                        }
                        out.println("</ul>");
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                        out.println("<p>An error occurred while processing your request. Please try again later.</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
                %>
            </div>
        </div>
    </div>
</body>
</html>