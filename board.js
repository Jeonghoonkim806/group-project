function searchNotice() {
	const searchTextBoxEl = document.querySelector('#sch_bar');

	window.location.href = '/doby/board.jsp?search=' + searchTextBoxEl.value;
}