<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>

<%
    String searchKeyword = request.getParameter("search");
    String pageParam = request.getParameter("page");
    int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
    int recordsPerPage = 10;
    int start = (currentPage - 1) * recordsPerPage;
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>집요정 TV</title>
    <link rel="shortcut icon" href="./favicon.ico" />
    <link rel="icon" href="./favicon.png" />
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet">
    <link href="./css/youtubemain.css" rel="stylesheet">
    <link href="./css/board.css" rel="stylesheet">
    <link href="./css/popup.css" rel="stylesheet">
    <link href="./css/sidebar.css" rel="stylesheet">
    <link href="./css/header.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
    <meta property="fb:app_id" content="87741124305">
    <meta name="description" content="YouTube에서 마음에 드는 동영상과 음악을 감상하고, 직접 만든 콘텐츠를 업로드하여 친구, 가족뿐 아니라 전 세계 사람들과 콘텐츠를 공유할 수 있습니다.">
    <meta name="keywords" content="동영상, 공유, 카메라폰, 동영상폰, 무료, 올리기">
    <meta name="theme-color" content="rgba(255, 255, 255, 0.98)">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js" integrity="sha512-IQLehpLoVS4fNzl7IfH8Iowfm5+RiMGtHykgZJl9AWMgqx0AmJ6cRWcB+GaGVtIsnC4voMfm8f2vwtY+6oPjpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js" integrity="sha512-nTHzMQK7lwWt8nL4KF6DhwLHluv6dVq/hNnj2PBN0xMl2KaMm1PM02csx57mmToPAodHmPsipoERRNn4pG7f+Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js" integrity="sha512-BABFxitBmYt44N6n1NIJkGOsNaVaCs/GpaJwDktrfkWIBFnMD6p5l9m+Kc/4SLJSJ4mYf+cstX98NYrsG/M9ag==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" integrity="sha512-aMup4I6BUl0dG4IBb0/f32270a5XP7H1xplAJ80uVKP6ejYCgZWcBudljdsointfHxn5o302Jbnq1FXsBaMuoQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/12d13cde63.js" crossorigin="anonymous"></script>
    <script defer src="./js/youtubemain.js"></script>
    <script src="./js/MV.js"></script>
    <script src="./js/board.js"></script>
    <script src="./js/popup.js"></script>
</head>
<body>
    <%@ include file="./header.jsp" %>

   <!------MAIN------>
   <div class="YtBody">
    <%@ include file="./sidebar.jsp" %>
    
        <div class="video_selection">
            <div class="recommendboxes">
                <button class="box">전체</button>
                <button class="box">인기글</button>
                <button class="box">영화</button>
                <button class="box">음악</button>
                <button class="box">한줄평</button>
            </div>
     		<div class="board_items">
                <div class="board__write__items">
                    <ul>
                        <li><a href="./write.jsp">글 등록</a></li>
                    </ul>
                </div>
                <div class="sch_items">
                    <input type="text" name="sch_bar" id="sch_bar" placeholder="검색어를 입력해 주세요." />
                    <a href="javascript: searchNotice();" class="new-board-search-btn">검색</a>
                </div>
            </div>
           
            <section style="margin-bottom: 180px;">
                <div class="inner board__list">
                    <div class="board_header">
                        <div class="board_no">NO</div>
                        <div class="board_title">제목</div>
                        <div class="board_title">글쓴이</div>
                        <div class="board_hit">날짜</div>
                    </div>
                    
                    <!-- 공지사항 게시글 제목 리스트 -->
                    <% 
                        Connection conn = DBManager.getDBConnection();
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        int totalRecords = 0;
                        try {
                            String totalSql = "SELECT COUNT(*) FROM board";
                            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                                totalSql += " WHERE TITLE LIKE ?";
                                pstmt = conn.prepareStatement(totalSql);
                                pstmt.setString(1, "%" + searchKeyword + "%");
                            } else {
                                pstmt = conn.prepareStatement(totalSql);
                            }
                            ResultSet totalRs = pstmt.executeQuery();
                            if (totalRs.next()) {
                                totalRecords = totalRs.getInt(1);
                            }

                            String selectSql = "SELECT * FROM ("
                                               + " SELECT board.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rn"
                                               + " FROM board";
                            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                                selectSql += " WHERE TITLE LIKE ?";
                            }
                            selectSql += ") WHERE rn BETWEEN ? AND ?";

                            pstmt = conn.prepareStatement(selectSql);
                            int paramIndex = 1;
                            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                                pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
                            }
                            pstmt.setInt(paramIndex++, start + 1);
                            pstmt.setInt(paramIndex, start + recordsPerPage);

                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                    %>
                    <div class="board__list__items">
                        <ul>
                            <li><%= rs.getString("SEQ") %></li>
                            <li><a href="<%= request.getContextPath() %>/board_detail.jsp?seq=<%= rs.getString("SEQ") %>"><%= rs.getString("TITLE") %></a></li>
                            <li><%= rs.getString("WRITER") %></li>
                            <li><%= rs.getDate("CREATE_DATE") %></li>
                        </ul>
                    </div>
                    <%
                            }
                        } catch (SQLException se) {
                            System.out.println("게시판 조회 쿼리 실행 오류: " + se.getMessage());
                        } finally {
                            DBManager.dbClose(conn, pstmt, rs);
                        }
                        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
                    %>
                    <br><br>
                </div>
                
                <div class="pagination">
                	<% if (currentPage > 1) { %>
                    	<a href="?page=<%= currentPage - 1 %>">&laquo; Previous</a>
               		<% } %>
                	<% for (int i = 1; i <= totalPages; i++) { %>
                    	<a href="?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
                	<% } %>
                	<% if (currentPage < totalPages) { %>
                    	<a href="?page=<%= currentPage + 1 %>">Next &raquo;</a>
                	<% } %>
            	</div>    
            </section> 
        </div>
    </div>
</body>
</html>