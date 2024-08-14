<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%
    	String memberID2 = (session != null) ? (String) session.getAttribute("memberID") : null;
		%>
<div id = "sidebar" class="sidebar">
        <div class="sidebar_nav">
            <div class="nav-item" id="home">
                <i class="fas fa-home"></i>
                <span >홈</span>
            </div>
            
            <div class="nav-item">
                <i class="fab fa-youtube"></i>
                <span>구독</span>
            </div>
        </div>
        <hr>
        <div class="sidebar_nav">
            <div class="nav-item na">
                <i class="fas fa-list"></i>
                <span>나</span>
            </div>
            <div class = "sub-menu">
                <div class="nav-item items">
                    <i class="fa-solid fa-history"></i>
                    <span>시청기록</span>
                </div>
                 <div class="nav-item items" id="my-video" data-id="<%= memberID2 %>">
                    <i class="fas fa-play"></i>
                    <span>내 동영상</span>
                </div>
                <script>
             // 내 동영상 클릭 기능
                $("#my-video").click(function() {
            	const id = $(this).data('id');	
            	console.log('id:', id);		
            	window.location.href = 'my_video.jsp?id=' + id;
            	});
                </script>
                <div class="nav-item items">
                    <i class="fas fa-clock"></i>
                    <span>나중에 볼 영상</span>
                </div>
                <div class="nav-item items" id="my-video" data-id="<%= memberID2 %>">
                    <i class="fas fa-thumbs-up"></i>
                    <span>좋아요 표시한 영상</span>
                </div>
            </div>
                  
        </div>
        <hr>
        <div class="sidebar_nav">
            <div class="nav-item" id="board-button">
                <i class="fa-solid fa-fire"></i>
                <span>게시판</span>
            </div>
            <div class="nav-item" id="music-button">
                <i class="fa-solid fa-music"></i>
                <span>음악</span>
            </div>         
            <div class="nav-item" id="drama-button">
                <i class="fa-solid fa-clapperboard"></i>
                <span>드라마</span>
            </div>
            <div class="nav-item">
                <i class="fa-solid fa-tower-broadcast"></i>
                <span>실시간</span>
            </div>
            <div class="nav-item">
                <i class="fa-solid fa-gamepad"></i>
                <span>게임</span>
            </div>
            <div class="nav-item">
                <i class="fa-solid fa-trophy"></i>
                <span>스포츠</span>
            </div>
            <div class="nav-item">
                <i class="fa-regular fa-lightbulb"></i>
                <span>학습프로그램</span>
            </div>
            <div class="nav-item">
                <i class="fa-solid fa-podcast"></i>
                <span>팟캐스트</span>
            </div>
        </div>
    </div>
    <script>
       /* document.getElementById('home').addEventListener('click', function() {
            window.location.href = 'main.jsp'; // 음악 파일의 정확한 경로를 입력하세요.
        });
        document.getElementById('board-button').addEventListener('click', function() {
            window.location.href = 'board.jsp'; // 음악 파일의 정확한 경로를 입력하세요.
        });
        document.getElementById('music-button').addEventListener('click', function() {
            window.location.href = 'music.jsp'; // 음악 파일의 정확한 경로를 입력하세요.
        });
        document.getElementById('drama-button').addEventListener('click', function() {
            window.location.href = 'drama.jsp'; // 드라마
        }); */
        $(document).ready(function() {
            $('#home').on('click', function() {
                window.location.href = 'main.jsp'; // 정확한 경로를 입력하세요.
            });

            $('#board-button').on('click', function() {
                window.location.href = 'board.jsp'; // 정확한 경로를 입력하세요.
            });

            $('#music-button').on('click', function() {
                window.location.href = 'music.jsp'; // 정확한 경로를 입력하세요.
            });

            $('#drama-button').on('click', function() {
                window.location.href = 'drama.jsp'; // 드라마
            });
        });

    </script>