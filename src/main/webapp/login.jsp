<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.annotation.WebServlet" %>
<%@ page import="jakarta.servlet.http.HttpServlet" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<%
    String referrer = request.getHeader("Referer");
	//System.out.println("referrer: "+ referrer);
	
    if (referrer != null && (!referrer.contains("login.jsp") && !referrer.contains("register.jsp"))) {
        session.setAttribute("redirectURL", referrer);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="./css/member.css">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>Login</h2>
            <form method="post" action="LoginServlet">
                <div class="textbox">
                    <input type="text" placeholder="Username" name="memberID" required>
                </div>
                <div class="textbox">
                    <input type="password" placeholder="Password" name="memberPW" required>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>
            <p>
                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                        if (error.equals("1")) {
                            out.println("Invalid username or password.");
                        } else if (error.equals("2")) {
                            out.println("Error occurred during login.");
                        }
                    }
                %>
            </p>
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>