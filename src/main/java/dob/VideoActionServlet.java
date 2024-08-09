package dob;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VideoActionServlet")
public class VideoActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memberID") == null) {
            // 로그인하지 않은 사용자에게는 접근을 차단
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You must be logged in to perform this action.");
            return;
        }

        String action = request.getParameter("action");
        String videoFile = request.getParameter("videoFile");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DBManager.getDBConnection()) {
            if ("like".equals(action)) {
                // 좋아요 증가
                String sql = "UPDATE video_metadata SET likes = likes + 1 WHERE filename = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, videoFile);
                    pstmt.executeUpdate();
                }

            } else if ("dislike".equals(action)) {
                // 싫어요 증가
                String sql = "UPDATE video_metadata SET dislikes = dislikes + 1 WHERE filename = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, videoFile);
                    pstmt.executeUpdate();
                }

            } else if ("comment".equals(action)) {
                String comment = request.getParameter("comment");
                // 댓글 추가
                String sql = "INSERT INTO video_comments (filename, comment) VALUES (?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, videoFile);
                    pstmt.setString(2, comment);
                    pstmt.executeUpdate();
                }

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
                return;
            }

            response.getWriter().print("{\"status\":\"success\"}");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        }
    }
}