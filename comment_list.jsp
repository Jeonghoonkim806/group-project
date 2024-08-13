<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dob.DBManager" %>
<% 
class Comment {
    String title;
    String commentt;
}

List<Comment> comments = new ArrayList<>();

String selectSql = "SELECT TITLE, \"COMMENT\" FROM VIDEO_COMMENTS";

try (Connection conn = DBManager.getDBConnection();
        PreparedStatement pstmt = conn.prepareStatement(selectSql);
        ResultSet rs = pstmt.executeQuery()) {

    while (rs.next()) {
        Comment comment = new Comment();
        comment.title = rs.getString("TITLE");
        comment.commentt = rs.getString("COMMENT");

        comments.add(comment);
    }
} catch (SQLException e) {
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="./css/comment.css">
    <meta charset="UTF-8">
    <title>코멘트 리스트</title>
    <style>
        #commentList {
            width: 80%;
            margin: 0 auto;
            font-family: Arial, sans-serif;
        }
        .comment-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ccc;
        }
        .comment-item .title {
            font-weight: bold;
            width: 30%;
            min-width: 150px;
            text-align: left;
        }
        .comment-item .commentt {
            width: 65%;
            text-align: left;
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <h1>코멘트 리스트</h1>
    <div id="commentList">
        <%
        for (Comment comment : comments) {
        %>
            <div class="comment-item">
                <span class="title"><%= comment.title %></span>
                <span class="commentt"><%= comment.commentt %></span>
            </div>
        <%
        }
        %>
    </div>
</body>
</html>
