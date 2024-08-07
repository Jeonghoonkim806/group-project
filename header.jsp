<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    HttpSession session1 = request.getSession(false);
    String memberID = (session != null) ? (String) session.getAttribute("memberID") : null;
%>    
<header class="header">
    <div class="header_logo">
        <button id = "toggleButton">
            <i class = "fas fa-bars"></i>
        </button>
        <a href="./main.jsp">
        <img src="./images/logo1.png" alt="집요정TV">
        </a>
    </div>

    <div class="search">
        <form action="javascript:void(0);">
            <div class = "search-inner">
            <input type="search" placeholder="검색">
            </div>
            <button type = "submit">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>
    <div class="header_icons">	
    	 <%
            if (memberID == null) {
        %>
            <a href="login.jsp"><i id="login" class="fas fa-user-circle">로그인</i></a>
        <%
            } else {
        %>
            <span id="my_id"><%= memberID %></span>
            <a href="logout.jsp">
            <button class="logout-btn">Logout</button>
            </a>
            <a href="upload_form.jsp"><i class="fas fa-video"></i></a>
            <i class="fas fa-ellipsis-h"></i>
            <i class="fas fa-bell"></i>
            
            <div id="myModal" class="modal">
				<div class= "modal-content">
					<span class="close">&times;</span>
					<p>업로드 방법을 선택하세요.</p>
					<button class="modal-button" id="file-upload">파일</button>
					<button class="modal-button" id="file-upload">영상-id</button>
				</div>
			</div>
        <%
            }
        %>
    </div>
   </header>