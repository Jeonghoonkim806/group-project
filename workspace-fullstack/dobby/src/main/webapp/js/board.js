/**
 * 게시판 검색
 */
function searchNotice() {
    const searchTextBoxEl = document.querySelector('#sch_bar');
    if (!searchTextBoxEl || !searchTextBoxEl.value) {
        alert("검색어를 입력해주세요.");
        return;
    }
    window.location.href = '/starbucks-homepage1/notice_list.jsp?search=' + encodeURIComponent(searchTextBoxEl.value);
}