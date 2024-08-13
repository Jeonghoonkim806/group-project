<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="dob.DBManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    request.setCharacterEncoding("UTF-8");

    String filename = request.getParameter("filename");
    String comment = request.getParameter("comment");
    String videoId = null;

    List<String> filenames = new ArrayList<>();
    boolean success = false;
    String errorMessage = null;

    try (Connection conn = DBManager.getDBConnection();
         PreparedStatement pstmt1 = conn.prepareStatement("SELECT FILENAME FROM VIDEO_METADATA");
         ResultSet rs1 = pstmt1.executeQuery()) {

        // 비디오 파일명 목록을 불러오기
        while (rs1.next()) {
            filenames.add(rs1.getString("FILENAME"));
        }

        // 코멘트 삽입 로직
        if ("POST".equalsIgnoreCase(request.getMethod()) && filename != null && !filename.isEmpty() && comment != null && !comment.isEmpty()) {
            conn.setAutoCommit(false); // 자동 커밋 비활성화

            // filename에 해당하는 video_id 조회
            try (PreparedStatement pstmt2 = conn.prepareStatement("SELECT VIDEO_ID FROM VIDEO_METADATA WHERE FILENAME = ?")) {
                pstmt2.setString(1, filename);
                try (ResultSet rs2 = pstmt2.executeQuery()) {
                    if (rs2.next()) {
                        videoId = rs2.getString("VIDEO_ID");
                    }
                }
            }

            if (videoId != null) {
                // .mp4 확장자를 제거한 제목 생성
                String title = filename.replace(".mp4", "");

                try (PreparedStatement pstmt3 = conn.prepareStatement(
                        "INSERT INTO VIDEO_COMMENTS (ID, FILENAME, \"COMMENT\", TITLE, VIDEO_ID) " +
                        "VALUES (VIDEO_COMMENTS_SEQ.NEXTVAL, ?, ?, ?, ?)")) {
                    pstmt3.setString(1, filename);
                    pstmt3.setString(2, comment);
                    pstmt3.setString(3, title); // 확장자를 제거한 TITLE 저장
                    pstmt3.setString(4, videoId);

                    int rowsInserted = pstmt3.executeUpdate();
                    conn.commit(); // 트랜잭션 커밋

                    if (rowsInserted > 0) {
                        success = true;
                    } else {
                        errorMessage = "코멘트 저장에 실패했습니다.";
                    }
                }
            } else {
                errorMessage = "해당 파일에 대한 비디오 ID를 찾을 수 없습니다.";
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            errorMessage = "모든 필드를 입력하세요.";
        }
    } catch (SQLException e) {
        errorMessage = "코멘트 저장 중 오류가 발생했습니다: " + e.getMessage();
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="./css/comment.css">
    <meta charset="UTF-8">
    <title>코멘트 입력</title>
</head>
<body>
    <h1>코멘트 입력</h1>

    <% if (errorMessage != null) { %>
        <p style="color:red;"><%= errorMessage %></p>
    <% } else if (success) { %>
        <p style="color:green;">코멘트가 성공적으로 저장되었습니다.</p>
    <% } %>

    <form method="post" id="form1">
        <label for="filename">비디오 파일명:</label>
        <select id="filename" name="filename" required>
            <option value="">파일명을 선택하세요</option>
            <%
                for (String file : filenames) {
            %>
                    <option value="<%= file %>"><%= file %></option>
            <%
                }
            %>
        </select><br><br>

        <label for="comment">코멘트:</label>
        <textarea id="comment" name="comment" rows="4" cols="50" required></textarea><br><br>

        <a href="javascript:regSubmit();">등 록</a>
    </form>

    <script>
        function regSubmit() {
            document.getElementById('form1').submit();
            window.location.href = 'comment_list.jsp';
        }
    </script>
</body>
</html>
