<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.dobby.utils.DBManager" %>
<%
    String seq = request.getParameter("seq");
    String action = request.getParameter("action");

    int newCount = 0;

    try (Connection conn = DBManager.getDBConnection()) {
        String updateSql = "";
        if ("like".equals(action)) {
            updateSql = "UPDATE video SET likes = likes + 1 WHERE seq = ?";
        } else if ("dislike".equals(action)) {
            updateSql = "UPDATE video SET dislike = dislike + 1 WHERE seq = ?";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
            pstmt.setString(1, seq);
            pstmt.executeUpdate();
        }

        String selectSql = "";
        if ("like".equals(action)) {
            selectSql = "SELECT likes FROM video WHERE seq = ?";
        } else if ("dislike".equals(action)) {
            selectSql = "SELECT dislike FROM video WHERE seq = ?";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
            pstmt.setString(1, seq);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    newCount = rs.getInt(1);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{\"new" + (action.equals("like") ? "Likes" : "Dislikes") + "\": " + newCount + "}");
    out.flush();
%>
