<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dob.DBManager" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    
    try {
        response.setContentType("application/json");

        conn = DBManager.getDBConnection();
        
        // 파라미터 가져오기
        String filename = request.getParameter("filename");

        // 파라미터 검증
        if (filename == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\": \"error\", \"message\": \"filename이 누락되었습니다.\"}");
            return;
        }

        // 카운트 조회
        pstmt = conn.prepareStatement("SELECT likes, dislikes FROM VIDEO_METADATA WHERE filename = ?");
        pstmt.setString(1, filename);
        rs = pstmt.executeQuery();

        int likeCount = 0;
        int dislikeCount = 0;
        if (rs.next()) {
            likeCount = rs.getInt("likes");
            dislikeCount = rs.getInt("dislikes");
        }

        // JSON 응답 생성
        out.print("{\"status\": \"success\", \"likeCount\": " + likeCount + ", \"dislikeCount\": " + dislikeCount + "}");
    } catch (SQLException e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage().replaceAll("\"", "\\\\\"") + "\"}");
    } catch (Exception e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"status\": \"error\", \"message\": \"Unexpected error: " + e.getMessage().replaceAll("\"", "\\\\\"") + "\"}");
    } finally {
        // 자원 정리
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>