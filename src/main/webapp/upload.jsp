<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import="dob.DBManager" %>

<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String duration = request.getParameter("duration");
    String uploader_id = (String) request.getSession().getAttribute("memberID");
    String category = request.getParameter("category");
    String tags = request.getParameter("tags");
    String status = request.getParameter("status");
    String thumbnail_url = request.getParameter("thumbnail_url");
    String video_id = request.getParameter("video_id");
    String logo_url = request.getParameter("logo_url");


    // 디버깅 출력
    System.out.println("Title: " + title + "<br>");
    System.out.println("Description: " + description + "<br>");
    System.out.println("Duration: " + duration + "<br>");
    System.out.println("Uploader ID: " + uploader_id + "<br>");
    System.out.println("Category: " + category + "<br>");
    System.out.println("Tags: " + tags + "<br>");
    System.out.println("Status: " + status + "<br>");
    System.out.println("Thumbnail URL: " + thumbnail_url + "<br>");
    System.out.println("Video ID: " + video_id + "<br>");
    System.out.println("Logo URL: " + logo_url + "<br>");
    Exception exception = null;
	
    if (title != null && description != null && duration != null && category != null && tags != null && status != null && thumbnail_url != null && video_id != null && logo_url != null && uploader_id != null) {
    	Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
	    try {
	    	conn = DBManager.getDBConnection();
            conn.setAutoCommit(false);
	        // video 테이블에 레코드 삽입
	        String insertSql = "INSERT INTO video (seq, title, description, duration, uploader_id, category, tags, status, thumbnail_url, video_id, logo_url, views) VALUES (seq_video_no.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
	        pstmt = conn.prepareStatement(insertSql, new String[] {"seq"});
	        pstmt.setString(1, title);
	        pstmt.setString(2, description);
	        pstmt.setString(3, duration);
	        pstmt.setString(4, uploader_id);
	        pstmt.setString(5, category);
	        pstmt.setString(6, tags);
	        pstmt.setString(7, status);
	        pstmt.setString(8, thumbnail_url);
	        pstmt.setString(9, video_id);
	        pstmt.setString(10, logo_url);
	        pstmt.executeUpdate();
	        
	        rs = pstmt.getGeneratedKeys();
	        int videoSeq = 0;
	        if (rs.next()) {
	            videoSeq = rs.getInt(1);
	        }
	        pstmt.close();
	
	
	        // video_like 테이블에 레코드 삽입
	        String insertLikeSql = "INSERT INTO video_like (seq, user_id, video_id, likes, dislike) VALUES (?, ?, ?, 0, 0)";
	        pstmt = conn.prepareStatement(insertLikeSql);
	        pstmt.setInt(1, videoSeq); 
	        pstmt.setString(2, uploader_id);
	        pstmt.setString(3, video_id);
	        pstmt.executeUpdate();
	
	        conn.commit(); // 트랜잭션 커밋
	
	        response.sendRedirect("main.jsp");
	    } catch (Exception e) {
	    	if (conn != null) {
                conn.rollback(); // 오류 발생 시 트랜잭션 롤백
            }
	        exception=e;
	        System.out.println("업로드 쿼리 실행 오류: " + e.getMessage());
	    } finally {
	        DBManager.dbClose(conn, pstmt, rs);
	    }
} else {
    response.getWriter().println("All fields are required.");
}
%>