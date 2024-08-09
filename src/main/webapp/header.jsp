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
  	<div class="searchmain">
    	<div class="search_mp4">
         	<form method="get" action="./search_mp4.jsp">
            	<div class="search-inner">
                	<input type="search" name="query" placeholder="검색 Mp4">
            	</div>
            	<button type="submit">
                	<i class="fas fa-search"></i>
            	</button>
        	</form>
    	</div>
    
	    <div class="search">
	         <form action="javascript:void(0);">
	            <div class = "search-inner">
	            	<input type="search" placeholder="검색 Url">
	            </div>
	            <button type = "submit">
	                <i class="fas fa-search"></i>
	            </button>
	        </form>
	    </div>
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
            <i class="fas fa-video" id="uploadIcon"></i>
            <i class="fas fa-ellipsis-h"></i>
            <i class="fas fa-bell"></i>
        <%
            }
        %>
    </div>
   </header>
   
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>업로드 방법을 선택하세요</p>
            <button class="modal-button" id="file-upload">파일 업로드</button>
            <button class="modal-button" id="url-upload">URL 업로드</button>
            <button class="modal-button" id="cancle-upload">취소</button>
        </div>
    </div>