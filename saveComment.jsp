<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dob.DBManager" %>

<%
    request.setCharacterEncoding("UTF-8");

    String filename = request.getParameter("filename");
    String comment = request.getParameter("comment");
    String videoId = request.getParameter("videoId");

    boolean success = false;
    String errorMessage = null;

    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs1 = null;

    try {
        conn = DBManager.getDBConnection();
        conn.setAutoCommit(false); // 자동 커밋 비활성화

        // 비디오 ID 조회
        pstmt1 = conn.prepareStatement("SELECT VIDEO_ID FROM VIDEO_METADATA WHERE FILENAME = ?");
        pstmt1.setString(1, filename);
        rs1 = pstmt1.executeQuery();

        if (rs1.next()) {
            videoId = rs1.getString("VIDEO_ID");
        }

        if (videoId != null) {
            String title = filename.replace(".mp4", "");

            // 댓글 저장
            pstmt2 = conn.prepareStatement(
                    "INSERT INTO VIDEO_COMMENTS (ID, FILENAME, \"COMMENT\", TITLE, VIDEO_ID) " +
                    "VALUES (VIDEO_COMMENTS_SEQ.NEXTVAL, ?, ?, ?, ?)");
            pstmt2.setString(1, filename);
            pstmt2.setString(2, comment);
            pstmt2.setString(3, title);
            pstmt2.setString(4, videoId);

            int rowsInserted = pstmt2.executeUpdate();
            conn.commit(); // 수동 커밋

            if (rowsInserted > 0) {
                success = true;
            } else {
                errorMessage = "코멘트 저장에 실패했습니다.";
            }
        } else {
            errorMessage = "해당 파일에 대한 비디오 ID를 찾을 수 없습니다.";
        }
    } catch (SQLException e) {
        errorMessage = "코멘트 저장 중 오류가 발생했습니다: " + e.getMessage();
        e.printStackTrace();
        if (conn != null) {
            try {
                conn.rollback(); // 오류 발생 시 롤백
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
    } finally {
        if (rs1 != null) {
            try { rs1.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (pstmt1 != null) {
            try { pstmt1.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (pstmt2 != null) {
            try { pstmt2.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    if (success) {
        response.sendRedirect("videomain1.jsp?video=" + filename);
    } else {
        out.println("<p style='color:red;'>" + errorMessage + "</p>");
    }
%>