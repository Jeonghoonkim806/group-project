$(document).ready(function() {
        $("#toggleButton").click(function() {
            $("#sidebar").toggleClass("hidden");
            $(".video_selection").toggleClass("moved");
        });

        const navItem = document.querySelector('.nav-item.na');
        const subMenu = document.querySelector('.sub-menu');

        navItem.addEventListener('click', () => {
            subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
        });
    });