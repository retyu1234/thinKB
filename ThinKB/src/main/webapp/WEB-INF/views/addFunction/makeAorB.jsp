<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #ffffff;
        /* display: flex; */
        justify-content: center;
        align-items: center;
        /* height: 100vh; */
        /* margin: 0; */
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
        justify-content: space-around;
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
    }

    .image-box span {
        font-size: 5em;
        color: white;
    }

    .image-box img {
        max-width: 100%;
        max-height: 100%;
        border-radius: 10px;
    }

	/* 파일선택 버튼 */
    .upload-button {
        position: absolute;
        bottom: 10px;
        left: 30%;
        transform: translateX(-50%);
        padding: 5px 10px;
        background-color: #f0f0f0;
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
</style>

</head>
<body>
    <form action="${contextPath}/processAorB" method="post" enctype="multipart/form-data">
	    <div class="header1">
	        <input type="text" name="testName" placeholder="테스트 제목을 작성하세요" onfocus="this.placeholder=''" onblur="this.placeholder='테스트 제목을 작성하세요'" />
	    </div>
	    <div class="image-container">
	        <div class="image-box" id="imageBox1">
	            <span>A</span>
	            <input type="file" name="variantA" class="upload-button" id="upload1" onchange="previewImage(this, 'imageBox1')" />
	        </div>
	       <div class="image-box" id="imageBox2">
	            <span>B</span>
	            <input type="file" name="variantB" class="upload-button" id="upload2" onchange="previewImage(this, 'imageBox2')" />
	        </div>
	    </div> 
	    <button class="register-button" type="submit">등록하기</button> 
	        
	</form>
	
	
	
	
<script>
   function showAlert() {
       alert("정상적으로 등록되었습니다.");
   }

   function previewImage(input, imageBoxId) {
       var file = input.files[0];
       var reader = new FileReader();
       reader.onload = function(e) {
           var imageBox = document.getElementById(imageBoxId);
           imageBox.innerHTML = '<img src="' + e.target.result + '" />';
       }
       reader.readAsDataURL(file);
   }
</script>
</body>
</html>
