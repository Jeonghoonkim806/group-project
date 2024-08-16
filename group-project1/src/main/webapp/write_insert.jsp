<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "dob.DBManager" %>
<%
//한글 처리
    request.setCharacterEncoding("UTF-8");

    System.out.println("write_insert가 실행됨");

    String title = request.getParameter("title");
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");

    System.out.println("title -> " + title);
    System.out.println("writer -> " + writer);
    System.out.println("content -> " + content);

    Exception exception = null;

    //DB접속 객체 가져오기
    Connection conn = DBManager.getDBConnection();

    // 현재 시간을 Unix 타임스탬프로 변환
    long currentTimeMillis = System.currentTimeMillis();

    //DB조회쿼리 실행하여 DB에 있는 데이터 값 가져오기
    PreparedStatement pstmt = null;
    try {
        String insertSql = "INSERT INTO BOARD(SEQ, TITLE, WRITER, CONTENT)" +
                        " VALUES (seq_board_no.NEXTVAL, ?, ?, ?)";
        
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, title);
        pstmt.setString(2, writer);
        pstmt.setString(3, content);
        //pstmt.setLong(4, currentTimeMillis); // 현재 시간을 밀리초 단위로 설정
        
        pstmt.executeUpdate(); // sql insert 실행
    /* } catch (SQLException se) {
        System.out.println("게시판 삽입 쿼리 실행 오류: " + se.getMessage()); */
    } catch (Exception e) {
        exception = e;
        System.out.println("게시판 삽입 쿼리 실행 오류: " + e.getMessage());
    } finally {
        DBManager.dbClose(conn, pstmt, null);
    }
%>

<%
    if (exception != null) {    // 글 등록시 오류일 때 처리
%>
게시글 등록이 실패하였습니다. 시스템 관리자에게 문의하세요.<br>
오류내용: <%= exception.getMessage() %>
<%
    } else {                    // 글 등록시 성공일 때 처리
        out.println("<script>alert('게시글이 성공적으로 등록되었습니다.');</script>");
%>
<script>
    // alert('공지사항 글이 성공적으로 등록되었습니다.');
    location.href = '<%= request.getContextPath() %>/board.jsp';
</script>
<%
    }
%>