function searchNotice() {
	const searchTextBoxEl = document.querySelector('#sch_bar');

	window.location.href = './board.jsp?search=' + searchTextBoxEl.value;
}