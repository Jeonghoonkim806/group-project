<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String currentPage = request.getRequestURL().toString();

	session.setAttribute("redirectURL", currentPage);

    // 로그아웃 서블릿으로 리디렉션
    response.sendRedirect("LogoutServlet");
%>