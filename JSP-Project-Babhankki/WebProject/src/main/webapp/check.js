/**
 * 
 */
/**
 * 
 */

 function insertcheck() {
	if(document.boardform.restaurant_name.value ==""){
		alert("음식점명을 입력해주세요");
		document.boardform.restaurant_name.focus();
		return;
	}
	if(document.boardform.address.value ==""){
		alert("주소를 입력해주세요");
		document.boardform.address.focus();
		return;
	}
	if(document.boardform.bbsContent.value ==""){
		alert("게시물 내용을 입력해주세요");
		document.boardform.bbsContent.focus();
		return;
	}
	if(document.boardform.photo_file.value ==""){
		alert("이미지 파일을 입력해주세요");
		document.boardform.photo_file.focus();
		return;
	}
	document.boardform.submit();
}
function deletecheck() {	
	ok = confirm("삭제하시겠습니까?");
	if (ok) {
		document.boardform.menu.value="delete";
		document.boardform.submit();
	} else {
		return;
	}			
}
function updatecheck() {

	document.boardform.menu.value="update";
	document.boardform.submit();			
}
