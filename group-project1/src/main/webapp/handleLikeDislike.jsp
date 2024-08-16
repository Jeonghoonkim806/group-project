<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dob.DBManager" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        response.setContentType("application/json");

        
        if (session == null || session.getAttribute("memberID") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"status\": \"error\", \"message\": \"로그인 필요\"}");
            return; // Fix: End execution if not logged in
        }

        conn = DBManager.getDBConnection();
        
        // 파라미터 가져오기
        String filename = request.getParameter("filename");
        String type = request.getParameter("type");

        // 파라미터 검증
        if (filename == null || type == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\": \"error\", \"message\": \"filename 또는 type이 누락되었습니다.\"}");
            return; // Fix: End execution if parameters are missing
        }

        
        
        
        // 쿼리 선택
        String updateSQL;
        if ("like".equals(type)) {
            updateSQL = "UPDATE VIDEO_METADATA SET likes = likes + 1 WHERE FILENAME = ?";
        } else if ("dislike".equals(type)) {
            updateSQL = "UPDATE VIDEO_METADATA SET dislikes = dislikes + 1 WHERE FILENAME = ?";
        } else {
            throw new IllegalArgumentException("유효하지 않은 타입입니다.");
        }

        // 좋아요/싫어요 업데이트
        pstmt = conn.prepareStatement(updateSQL);
        pstmt.setString(1, filename);
        pstmt.executeUpdate();
        
        // 업데이트된 카운트 조회
        pstmt = conn.prepareStatement("SELECT COALESCE(likes, 0) AS likes, COALESCE(dislikes, 0) AS dislikes FROM VIDEO_METADATA WHERE FILENAME = ?");
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
    } catch (IllegalArgumentException e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
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