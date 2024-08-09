package dob;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VideoDataServlet")
public class VideoDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String videoFile = request.getParameter("videoFile");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DBManager.getDBConnection()) {
            // 비디오 제목, 좋아요 수, 싫어요 수, 댓글 목록 가져오기
            String sql = "SELECT title, likes, dislikes FROM video_metadata WHERE filename = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, videoFile);
            ResultSet rs = pstmt.executeQuery();

            int likes = 0;
            int dislikes = 0;
            String title = null;

            if (rs.next()) {
                title = rs.getString("title");
                likes = rs.getInt("likes");
                dislikes = rs.getInt("dislikes");
            }

            // 댓글 목록 가져오기
            List<String> comments = new ArrayList<>();
            sql = "SELECT comment FROM video_comments WHERE filename = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, videoFile);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                comments.add(rs.getString("comment"));
            }

            // JSON 응답
            VideoData data = new VideoData(title, likes, dislikes, comments);
            Gson gson = new Gson();
            response.getWriter().print(gson.toJson(data));

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        }
    }

    private static class VideoData {
        private String title;
        private int likes;
        private int dislikes;
        private List<String> comments;

        public VideoData(String title, int likes, int dislikes, List<String> comments) {
            this.title = title;
            this.likes = likes;
            this.dislikes = dislikes;
            this.comments = comments;
        }
    }
}