<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #ffffff;
    justify-content: center;
    align-items: center;
}

.container {
    width: 60%; /* 너비 조정 */
    background-color: white;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    text-align: center;
}

.header1 {
    margin-bottom: 50px;
    text-align: center; /* 가운데 정렬 */
    margin-top: 50px;
}

.header1 input {
    width: 70%; /* 제목 입력란 너비 조정 */
    padding: 20px;
    font-size: 1.4em;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* A/B 이미지 창 */
.image-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px 0;
}

.image-box {
    width: 45%; /* 이미지 박스 너비 조정 */
    height: 500px;
    border: 2px solid #ccc;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    background-color: #f0f0f0;
    margin: 10px;
    text-align: center;
    overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
}

.image-box img {
    width: 100%; /* 이미지 너비 100%로 설정 */
    height: 100%; /* 이미지 높이 100%로 설정 */
    object-fit: cover; /* 이미지를 비율 유지하면서 박스에 맞게 잘라줌 */
    border-radius: 10px;
}

/* 파일선택 버튼 */
.upload-button {
    position: absolute;
    bottom: 10px;
    left: 30%;
    transform: translateX(-50%);
    padding: 10px 20px;
    background-color: #ffc107;
    color: white;
    font-size: 1em;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

/* 등록하기 버튼 */
.register-button {
    background-color: #ffc107;
    color: white;
    font-size: 1.2em;
    width: 17%;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 50px;
    display: block; /* 블록 요소로 변경하여 가운데 정렬 적용 */
    margin-left: auto;
    margin-right: auto;
}

.register-button:hover {
    background-color: #e0a800;
}

.file-name {
    position: absolute;
    bottom: 10px;
    left: 10px;
    right: 10px;
    background-color: rgba(255, 255, 255, 0.7);
    padding: 5px;
    border-radius: 5px;
    text-align: center;
}

.label {
    position: absolute;
    top: 5px;
    left: 5px;
    background-color: #ffcc00;
    padding: 5px 10px;
    border-radius: 5px;
    font-weight: bold;
    color: white;
    z-index: 1;
}
</style>

</head>
<body>
    <form action="./processPinTest" method="post"
        enctype="multipart/form-data">
        <div class="header1">
            <input type="text" name="testName" placeholder="테스트 제목을 작성하세요"
                onfocus="this.placeholder=''"
                onblur="this.placeholder='테스트 제목을 작성하세요'" />
        </div>
        <div class="image-container">
            <div class="image-box" id="imageBox1">
                <span class="label">이미지 첨부</span>
                <input type="file" name="file" class="upload-button" id="upload1" onchange="previewImage(this, 'imageBox1')" />
                <div id="fileName" class="file-name"></div>
                <img id="preview" class="preview-image" src="#" alt="Preview" />
            </div>
        </div>
        <button class="register-button" type="submit">등록하기</button>

    </form>



	<script>
   function showAlert() {
       alert("정상적으로 등록되었습니다.");
   }

   function previewImage(input, imageBoxId) {
       const imageBox = document.getElementById(imageBoxId);
       const fileNameDisplay = imageBox.querySelector('.file-name');
       const label = imageBox.querySelector('.label');
       const preview = imageBox.querySelector('img');
       const file = input.files[0];
       const reader = new FileReader();

       reader.onload = function(e) {
           preview.src = e.target.result;
           fileNameDisplay.textContent = file.name; // 파일 이름 표시
           label.style.display = 'none'; // 레이블 숨기기
       }

       if (file) {
           reader.readAsDataURL(file);
       } else {
           preview.src = "";
           fileNameDisplay.textContent = "";
           label.style.display = 'block'; // 레이블 보이기
       }
   }
</script>
</body>
</html>
