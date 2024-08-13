<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "dob.DBManager" %>    
<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");

	System.out.println("board_update가 실행됨");

	String seq = request.getParameter("seq");
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	System.out.println("title -> " + title);
	System.out.println("writer -> " + writer);
	System.out.println("content -> " + content);
	
	Exception exception = null;
	
	//DB접속 객체 가져오기
	Connection conn = DBManager.getDBConnection();

	//DB조회쿼리 실행하여 DB에 있는 데이터 값 가져오기
	PreparedStatement pstmt = null;
	try {
		String updateSql = "UPDATE board SET TITLE = ?, WRITER = ?, CONTENT = ? WHERE SEQ = ?";
		
		pstmt = conn.prepareStatement(updateSql);
		pstmt.setString(1, title);
		pstmt.setString(2, writer);
		pstmt.setString(3, content);
		pstmt.setInt(4, Integer.parseInt(seq));
		
		pstmt.executeUpdate(); // sql update 실행
	/* } catch (SQLException se) {
		System.out.println("게시판 수정 쿼리 실행 오류: " + se.getMessage()); */
	} catch (Exception e) {
		exception = e;
		System.out.println("게시판 수정 쿼리 실행 오류: " + e.getMessage());
	} finally {
		DBManager.dbClose(conn, pstmt, null);
	}
%>

<%
	if (exception != null) {	// 글 수정시 오류일 때 처리
%>
	게시글 수정이 실패하였습니다. 시스템 관리자에게 문의하세요.<br>
	오류내용: <%= exception.getMessage() %>
<%
	} else {					// 글 수정시 성공일 때 처리
		out.println("<script>alert('게시글이 성공적으로 수정되었습니다.');</script>");
		// board.jsp파일로 이동	
		//response.sendRedirect(request.getContextPath() + "/board.jsp");
%>
	<script>
		// alert('공지사항 글이 성공적으로 수정되었습니다.');
		location.href = '<%= request.getContextPath() %>/board.jsp';
	</script>
<%
	}
%>