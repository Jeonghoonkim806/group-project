package dob;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONObject;
import java.sql.DriverManager;

@WebServlet("/api/add-comment")
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 요청에서 댓글 데이터 추출
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        JSONObject json;
        try {
            json = new JSONObject(sb.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("error", "Invalid JSON format");
            response.getWriter().write(errorResponse.toString());
            return;
        }

        String filename = json.getString("filename");  // 비디오 파일 이름
        String commentText = json.getString("comment");  // 댓글 내용

        // 비디오 메타데이터에서 노래 제목을 가져옴
        String title = getVideoTitle(filename);

        boolean success = saveComment(filename, title, commentText);

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);
        response.getWriter().write(jsonResponse.toString());
    }

    private String getVideoTitle(String filename) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String title = null;

        try {
            conn = DBManager.getDBConnection();
            String sql = "SELECT title FROM video_metadata WHERE filename = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, filename);
            rs = stmt.executeQuery();

            if (rs.next()) {
                title = rs.getString("title");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBManager.dbClose(conn, stmt, rs);
        }

        return title;
    }

    private boolean saveComment(String filename, String title, String commentText) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBManager.getDBConnection();
            String sql = "INSERT INTO video_comments (filename, title, comment) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, filename);  // 비디오 파일 이름 저장
            stmt.setString(2, title);     // 비디오 제목 저장
            stmt.setString(3, commentText);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBManager.dbClose(conn, stmt, null);
        }
    }
}