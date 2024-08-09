<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.annotation.WebServlet" %>
<%@ page import="jakarta.servlet.http.HttpServlet" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="./css/member.css">
</head>
<body>
    <div class="container">
        <div class="register-box">
            <h2>Register</h2>
            <form method="post" action="RegisterServlet">
                <div class="textbox">
                    <input type="text" placeholder="Username" name="memberID" required>
                </div>
                <div class="textbox">
                    <input type="password" placeholder="Password" name="memberPW" required>
                </div>
                <div class="textbox">
                    <input type="text" placeholder="Name" name="name" required>
                </div>
                <div class="textbox gender">
                    <label>Gender:</label>
                    <input type="radio" id="male" name="gender" value="M" required>
                    <label for="male">Male</label>
                    <input type="radio" id="female" name="gender" value="F" required>
                    <label for="female">Female</label>
                </div>
                <div class="textbox">
                    <input type="email" placeholder="Email" name="email" required>
                </div>
                <button type="submit" class="btn">Register</button>
            </form>
            <p>
                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                        if (error.equals("1")) {
                            out.println("Username already exists. Please choose another.");
                        } else if (error.equals("2")) {
                            out.println("Error occurred during registration.");
                        }
                    }
                %>
            </p>
            <p>Already have an account? <a href="./login.jsp">Login here</a></p>
        </div>
    </div>
</body>
</html>