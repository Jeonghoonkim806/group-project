<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.dobby.utils.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%	String seq = request.getParameter("seq");
	String title = request.getParameter("title");
  	String description = request.getParameter("description");
    String category = request.getParameter("category");
    String status = request.getParameter("status");
    String tags = request.getParameter("tags");
    String thumbnail_url = request.getParameter("thumbnail_url");
    String video_id = request.getParameter("video_id");
    String logo_url = request.getParameter("logo_url");
    String uploaderId = request.getParameter("uploader_id");
    boolean updateSuccess = false;

    if (seq != null && !seq.isEmpty()) {
        try (Connection conn = DBManager.getDBConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE video SET title = ?, description = ?, category = ?, status = ?, tags = ?, thumbnail_url = ?, video_id = ?, logo_url = ? WHERE seq = ?")) {

            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, category);
            pstmt.setString(4, status);
            pstmt.setString(5, tags);
            pstmt.setString(6, thumbnail_url);
            pstmt.setString(7, video_id);
            pstmt.setString(8, logo_url);
            pstmt.setString(9, seq);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
            	updateSuccess = true;
            } else {
                out.println("<p>비디오를 수정하는 데 실패했습니다. 다시 시도해 주세요.</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>비디오 수정 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>잘못된 요청입니다. 비디오 ID가 유효하지 않습니다.</p>");
    }
%>

<% if (updateSuccess) { %>
    <script>
        alert("비디오가 성공적으로 수정되었습니다.");
        var uploaderId = "<%= uploaderId %>";
        // id 값이 올바르게 출력되는지 확인하기 위해 콘솔에 로그
        console.log('id:', uploaderId);
        // 리디렉션
        window.location.href = 'my_video.jsp?id=' + uploaderId;
    </script>
<% } %>
