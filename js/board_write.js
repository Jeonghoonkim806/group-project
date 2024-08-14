/**
 * 공지사항 글 등록 함수
 */
function regSubmit() {
	// form태그 안의 action값으로 이동
	document.getElementById('form1').submit();
}

/**
 * 공지사항 글 수정페이지 이동하는 함수
 */
function moveUpdate(seq) {
	location.href = '/starbucks-homepage1/admin_notice_update_form.jsp?seq=' + seq;
}

/**
 * 공지사항 글 수정 함수
 */
function updateSubmit() {
	// form태그 안의 action값으로 이동
	document.getElementById('form1').submit();
}

/**
 * 공지사항 글 삭제 함수
 */
function deleteNotice(seq) {
	if(!confirm('정말 ' + seq + '번호의 게시글을 삭제하시겠습니까?')) {
		return false;
	}
	location.href = '/starbucks-homepage1/admin_notice_delete.jsp?seq=' + seq;
}