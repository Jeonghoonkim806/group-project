function searchNotice() {
	const searchTextBoxEl = document.querySelector('#sch_bar');

	window.location.href = '/starbucks-homepage1/notice_list.jsp?search=' + searchTextBoxEl.value;
}