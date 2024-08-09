package dob;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FetchVideoDataServlet")
public class FetchVideoDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filenamePattern = request.getParameter("filenamePattern");

        if (filenamePattern == null || filenamePattern.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Filename pattern is required.");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 쿼리 준비
        String sql = "SELECT v.filename, v.likes, v.dislikes, c.comment " +
                     "FROM VIDEO_METADATA v " +
                     "LEFT JOIN VIDEO_COMMENTS c ON v.filename = c.filename " +
                     "WHERE v.filename LIKE ?";

        try (Connection conn = DBManager.getDBConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 와일드카드 추가
            pstmt.setString(1, "%" + filenamePattern.trim().replaceAll("[^a-zA-Z0-9]", "") + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                StringBuilder jsonResponse = new StringBuilder("[");
                boolean first = true;
                while (rs.next()) {
                    if (!first) {
                        jsonResponse.append(",");
                    }
                    first = false;
                    
                    // JSON 형식으로 응답 구성
                    jsonResponse.append("{")
                        .append("\"filename\":\"").append(escapeJson(rs.getString("filename"))).append("\",")
                        .append("\"likes\":").append(rs.getInt("likes")).append(",")
                        .append("\"dislikes\":").append(rs.getInt("dislikes")).append(",")
                        .append("\"comment\":\"").append(escapeJson(rs.getString("comment"))).append("\"")
                        .append("}");
                }
                jsonResponse.append("]");
                response.getWriter().print(jsonResponse.toString());
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        }
    }

    // JSON 문자열 이스케이프 함수
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}