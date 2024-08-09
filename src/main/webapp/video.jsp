<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    String searchQuery = request.getParameter("search");
    String videoUrl = null;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@1.220.247.78:1522:orcl", "username", "password");

            String sql = "SELECT filename FROM mp4_metadata WHERE filename LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchQuery + "%");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                videoUrl = rs.getString("filename");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        if (videoUrl != null) {
            response.sendRedirect("videomain.jsp?video=" + videoUrl);
        } else {
            out.println("No video found");
        }
    }
%>