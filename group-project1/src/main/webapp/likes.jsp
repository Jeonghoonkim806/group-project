<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, dob.DBManager" %>
<%
    String seq = request.getParameter("seq");
    String action = request.getParameter("action");
    int newCount = 0;
    
    if (seq == null || action == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
        return;
    }
    
    try (Connection conn = DBManager.getDBConnection()) {
        String checkSql = "SELECT user_action FROM video_like WHERE seq = ?";
        String currentAction = "";
        
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, seq);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    currentAction = rs.getString("user_action");
                }
            }
        }
        
        String updateSql;
        String selectSql;
        
        if ("like".equals(action)) {
            if ("like".equals(currentAction)) {
                updateSql = "UPDATE video_like SET likes = likes - 1, user_action = 'none' WHERE seq = ?";
            } else {
                updateSql = "UPDATE video_like SET likes = likes + 1, user_action = 'like' WHERE seq = ?";
            }
            selectSql = "SELECT likes FROM video_like WHERE seq = ?";
        } else if ("dislike".equals(action)) {
            if ("dislike".equals(currentAction)) {
                updateSql = "UPDATE video_like SET dislike = dislike - 1, user_action = 'none' WHERE seq = ?";
            } else {
                updateSql = "UPDATE video_like SET dislike = dislike + 1, user_action = 'dislike' WHERE seq = ?";
            }
            selectSql = "SELECT dislike FROM video_like WHERE seq = ?";
        } else {
            throw new IllegalArgumentException("Invalid action: " + action);
        }
        
        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
            updateStmt.setString(1, seq);
            updateStmt.executeUpdate();
        }
        
        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            selectStmt.setString(1, seq);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    newCount = rs.getInt(1);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (IllegalArgumentException e) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        return;
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{\"new" + (action.equals("like") ? "Likes" : "Dislikes") + "\": " + newCount + "}");
    out.flush();
%>
