function searchNotice() {
	const searchTextBoxEl = document.querySelector('#sch_bar');

	window.location.href = './board.jsp?search=' + searchTextBoxEl.value;
}

document.addEventListener('DOMContentLoaded', () => {
    // memberID가 정의되어 있음을 가정
    if (typeof memberID !== 'undefined' && memberID) {
        console.log('Member ID:', memberID);

        // memberID를 사용하여 다른 작업 수행
    } else {
        console.error('Member ID is not available');
    }
});