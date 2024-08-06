<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Search MP4 Files</title>
</head>

<body>
  <h1>Search MP4 Files</h1>
  
  <!-- 검색 폼 -->
  <form method="get" action="search.jsp">
    <input type="text" name="query" placeholder="Enter filename or part of it" />
    <input type="submit" value="Search" />
  </form>

  <%
    String query = request.getParameter("query");
    if (query != null && !query.trim().isEmpty()) {
      Connection conn = null;
      PreparedStatement stmt = null;
      ResultSet rs = null;
      
      try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@1.220.247.78:1522:orcl", "semi_2405_team1", "1234");
        
        // VIDEO_METADATA와 VIDEO_COMMENTS 테이블에서 통합 검색
        String sql = "SELECT filename FROM VIDEO_METADATA WHERE filename LIKE ? " +
                     "UNION " +
                     "SELECT filename FROM VIDEO_COMMENTS WHERE filename LIKE ?";
        
        stmt = conn.prepareStatement(sql);
        String searchPattern = "%" + query.trim().replaceAll("[^a-zA-Z0-9]", "") + "%";
        stmt.setString(1, searchPattern);
        stmt.setString(2, searchPattern);
        
        rs = stmt.executeQuery();
        
        if (rs.next()) {
          out.println("<h2>Search Results:</h2>");
          out.println("<ul>");
          do {
            String filename = rs.getString("filename");
            String encodedFilename = URLEncoder.encode(filename, "UTF-8"); // URL 인코딩
            out.println("<li><a href='videomain1.jsp?video=" + encodedFilename + "'>" + filename + "</a></li>");
          } while (rs.next());
          out.println("</ul>");
        } else {
          out.println("<p>No results found</p>");
        }
        
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>An error occurred while processing your request. Please try again later.</p>");
      } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
      }
    }
  %>
</body>

</html>