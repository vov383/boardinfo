/**
*
*/

function checkImageType(fileName){
	var pattern =/jpg|gif|png|jpeg/;
	return fileName.match(pattern);
}

function getFileInfo(fullName){
	var fileName, imgsrc, getLink, fileLink;
	if(checkImageType(fullName)) {//이미지 파일인 경우
		imgsrc="/boardinfo/upload/displayFile?fileName="+fullName;
		fileLink=fullName.substr(14); //14인덱스~끝
		var front = fullName.substr(0, 12); //0~11
		var end = fullName.substr(14);
		
		getLink="/boardinfo/upload/displayFile?fileName=" + front + end;
	}else{//이미지가 아닌 경우
		fileLink=fullName.substr(12);
		getLink="/boardinfo/upload/displayFile?fileName=" + fullName;
	}
	
	//uuid를 썼을때 '_' 다음의 fileName을 뽑아내기 위해 끝에 +1 을 붙였다
	fileName = fileLink.substr(fileLink.indexOf("_")+1);

	//json으로 리턴
	return {
		fileName: fileName, imgsrc: imgsrc, 
		getLink: getLink, fullName: fullName
	};
}

