<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dob.DBManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
    String seq = request.getParameter("seq");
    if (seq != null && !seq.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getDBConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // video_like 테이블의 레코드 먼저 삭제
            String deleteLikesSql = "DELETE FROM video_like WHERE seq = ?";
            pstmt = conn.prepareStatement(deleteLikesSql);
            pstmt.setString(1, seq);  // 여기에 video_id 사용
            pstmt.executeUpdate();
            pstmt.close();

            // video 테이블에서 부모 레코드 삭제
            String deleteVideoSql = "DELETE FROM video WHERE seq = ?";
            pstmt = conn.prepareStatement(deleteVideoSql);
            pstmt.setString(1, seq);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                conn.commit(); // 트랜잭션 커밋
                out.print("success");
            } else {
                conn.rollback(); // 실패 시 롤백
                out.print("fail");
            }
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // 오류 발생 시 롤백
            }
            e.printStackTrace();
            out.print("error");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.print("invalid");
    }
%>
