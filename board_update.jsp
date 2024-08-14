<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집요정 TV</title>
</head>
<body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "dob.DBManager" %>    
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<%
    // 한글 처리
    request.setCharacterEncoding("UTF-8");

    System.out.println("board_update가 실행됨");

    String seqString = request.getParameter("seq");
    Integer seq = null;

    // 예외를 저장할 변수 선언
    Exception exception = null;

    // seq가 숫자로 변환 가능한지 확인
    try {
        if (seqString != null && !seqString.isEmpty()) {
            seq = Integer.parseInt(seqString);
        }
    } catch (NumberFormatException e) {
        exception = new Exception("Invalid seq parameter: " + e.getMessage());
    }

    // DB에서 수정할 게시글의 정보를 가져옴
    String writer = null;
    String title = null;
    String content = null;

    // DB 접속 객체 가져오기
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        if (seq != null) {	
            conn = DBManager.getDBConnection();

            // 게시글 정보를 가져오는 쿼리
            String selectSql = "SELECT * FROM board WHERE SEQ = ?";
            pstmt = conn.prepareStatement(selectSql);
            pstmt.setInt(1, seq);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                title = rs.getString("TITLE");
                writer = rs.getString("WRITER");
                content = rs.getString("CONTENT");
            } else {
                exception = new Exception("게시글을 찾을 수 없습니다.");
            }
        } else {
            exception = new Exception("유효하지 않은 seq 값입니다.");
        }
    } catch (SQLException se) {
        exception = se;
        System.out.println("게시판 조회 쿼리 실행 오류: " + se.getMessage());
    } finally {
        // DB 연결 종료
        DBManager.dbClose(conn, pstmt, rs);
    }

    // 게시글 수정 폼 제출 처리
    if (exception == null) {
        try {
            String newTitle = request.getParameter("title");
            String newWriter = request.getParameter("writer");
            String newContent = request.getParameter("content");

            conn = DBManager.getDBConnection();
            String updateSql = "UPDATE board SET TITLE = ?, WRITER = ?, CONTENT = ? WHERE SEQ = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, newTitle);
            pstmt.setString(2, newWriter);
            pstmt.setString(3, newContent);
            pstmt.setInt(4, seq);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>alert('게시글이 성공적으로 수정되었습니다.');</script>");
            } else {
                exception = new Exception("게시글 수정에 실패하였습니다.");
            }
        } catch (SQLException se) {
            exception = se;
            System.out.println("게시글 수정 쿼리 실행 오류: " + se.getMessage());
        } catch (Exception e) {
            exception = e;
            System.out.println("게시글 수정 오류: " + e.getMessage());
        } finally {
            DBManager.dbClose(conn, pstmt, null);
        }
    }
%>

<%
    if (exception != null) {    // 글 수정시 오류일 때 처리
%>
    <p>게시글 수정이 실패하였습니다. 시스템 관리자에게 문의하세요.</p>
    <p>오류내용: <%= exception.getMessage() %></p>
<%
    } else {                    // 글 수정시 성공일 때 처리
%>
    <script>
        location.href = '<%= request.getContextPath() %>/board.jsp';
    </script>
<%
    }
%>


</body>
</html>