document.addEventListener("DOMContentLoaded", function() {
    const itemsPerPage = 10; // 한 페이지에 표시할 항목 수
    const items = document.querySelectorAll("#fullchart .chart-wrap .full-chart-div .each-song"); // 각 항목 선택
    const paginationContainer = document.querySelector(".pagination");

    if (!items.length || !paginationContainer) {
        console.error('페이지네이션에 필요한 요소를 찾을 수 없습니다.');
        return;
    }

    function showPage(pageNumber) {
        // 모든 항목을 숨깁니다.
        items.forEach(item => item.style.display = "none");

        // 현재 페이지의 항목만 표시합니다.
        const start = (pageNumber - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        for (let i = start; i < end; i++) {
            if (items[i]) {
                items[i].style.display = "flex";
            }
        }

        // 활성 페이지 버튼을 업데이트합니다.
        const buttons = paginationContainer.querySelectorAll("button");
        buttons.forEach(button => button.classList.remove("active"));
        buttons[pageNumber - 1]?.classList.add("active");
    }

    function createPaginationButtons() {
        const totalItems = items.length;
        const totalPages = Math.ceil(totalItems / itemsPerPage);

        // 페이지 버튼을 초기화합니다.
        paginationContainer.innerHTML = "";

        // 페이지 버튼을 생성합니다.
        for (let i = 1; i <= totalPages; i++) {
            const button = document.createElement("button");
            button.textContent = i;
            button.className = i === 1 ? "active" : ""; // 첫 페이지 버튼에 기본적으로 활성화 클래스 추가
            button.addEventListener("click", () => showPage(i));
            paginationContainer.appendChild(button);
        }
    }

    // 초기화
    createPaginationButtons();
    showPage(1); // 첫 페이지를 표시합니다.
});