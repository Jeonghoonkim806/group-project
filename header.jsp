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
            <span id="my_id" data-id="<%= memberID %>"><%= memberID %></span>
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
    
    <script>
 $(document).ready(function() {
     $('.search button').on('click', function() {
         var searchText = $('.search input').val().toLowerCase();
         window.location.href = 'main.jsp?search=' + encodeURIComponent(searchText);
     });

     // If you want to trigger search on pressing Enter key
     $('.search input').on('keypress', function(event) {
         if (event.key === 'Enter') {
             $('.search button').click();
         }
     });

     // Retain the search term in the input field if it exists in the URL
     var urlParams = new URLSearchParams(window.location.search);
     var search = urlParams.get('search');
     if (search) {
         $('.search input').val(search);
     }
 // upload 이미지 클릭 시 메시지 박스 띄우기
    $('#uploadIcon').on('click', function(){
        $('#myModal').show();
    });
    $('#cancle-upload').on('click', function() {
        $('#myModal').hide();
    });
    
    $(window).on('click', function(event) {
        if ($(event.target).is('#myModal')) {
            $('#myModal').hide();
        }
    });
    $('#file-upload').on('click', function() {
        window.location.href = 'upload_file_form.jsp';
    });

    $('#url-upload').on('click', function() {
        window.location.href = 'upload_form.jsp';
    });
 });
    </script>