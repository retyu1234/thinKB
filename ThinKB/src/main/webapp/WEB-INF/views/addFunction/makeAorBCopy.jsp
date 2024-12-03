<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - A/B테스트 만들기</title>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.ab-body {
	font-family: KB금융 본문체 Light;
}

.ab-banner {
	margin-top: 50px;
	margin-left: 15%;
	margin-right: 15%;
	margin-top: 1%;
}

.ab-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.titleAndDetail {
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	margin-bottom: 10px;
}
.titleAndDetail-title {
	margin: 0;
	font-size: 18pt;
	color: black;
	font-weight: bold;
	font-family: KB금융 제목체 Light;
}
.titleAndDetail-detail {
	font-size: 13pt;
}

.new-subject {
	font-size: 15pt;
	color: black;
	border: 3px solid #FFD700;
	border-radius: 20px;
	padding: 20px;
	background-color: white;
}

input.new-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 10px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
	font-family: KB금융 본문체 Light;
}

input.new-subject:focus {
	border-color: #FFD700;
	outline: none;
}

.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
	font-family: KB금융 본문체 Light;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

/* 회색버튼 */
.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
	font-family: KB금융 본문체 Light;
}

.grey-button:hover {
	background-color: #60584C;
}

/* A/B 이미지 창 */
.image-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 20px 0;
}

.image-box {
    width: 48%;
    height: 400px;
    border: 2px solid #ccc;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    position: relative;
    background-color: #f0f0f0;
    overflow: hidden;
}

.image-box-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color: #e0e0e0;
}

.image-box-title {
    font-weight: bold;
    font-size: 15pt;
    margin-left: 20px;
    font-family: KB금융 제목체 Light;
}

.image-preview {
    flex-grow: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

.image-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.image-preview-text {
    color: #888;
    font-size: 14px;
}

</style>

</head>
<body>

<body class="ab-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	
	<!-- 콘텐츠 시작 -->
	<div class="ab-content">
	<div class="titleAndDetail-title" style="margin-bottom:50pt;">새로운 A/B테스트 만들기</div>
	
	<form id="abTestForm" action="./processAorB" method="post" enctype="multipart/form-data">
		<div class="titleAndDetail">
			<div class="titleAndDetail-title">테스트 주제</div>
			<div class="titleAndDetail-detail">A/B테스트 주제를 입력해주세요. </div>
		</div>
		
		<input type="text" class="new-subject" name="testName" style="margin-bottom: 50px;"
			placeholder="여기에 작성해주세요">
	
	
		<div class="image-container">
		    <div class="image-box">
		        <div class="image-box-header">
		            <span class="image-box-title">A 시안</span>
		            <input type="file" id="fileA" name="variantA" style="display: none;" onchange="previewImage(this, 'previewA')">
		            <label for="fileA" class="grey-button">파일 선택</label>
		        </div>
		        <div class="image-preview" id="previewA">
		            <span class="image-preview-text">A시안 미리보기</span>
		        </div>
		    </div>
		    <div class="image-box">
		        <div class="image-box-header">
		            <span class="image-box-title">B 시안</span>
		            <input type="file" id="fileB" name="variantB" style="display: none;" onchange="previewImage(this, 'previewB')">
		            <label for="fileB" class="grey-button">파일 선택</label>
		        </div>
		        <div class="image-preview" id="previewB">
		            <span class="image-preview-text">B시안 미리보기</span>
		        </div>
		    </div>
		</div>
		
		<div style="text-align: center; margin-top: 50px; margin-bottom: 200px;">
        	<button class="yellow-button" type="button" onclick="validateForm()">등록하기</button>
		</div>
    </form>

</div>

	<script>
   function showAlert() {
       alert("정상적으로 등록되었습니다.");
   }

   function previewImage(input, previewId) {
	    const preview = document.getElementById(previewId);
	    const file = input.files[0];
	    const reader = new FileReader();

	    reader.onload = function(e) {
	        preview.innerHTML = '<img src="' + e.target.result + '" alt="Preview">';
	    }

	    if (file) {
	        reader.readAsDataURL(file);
	    } else {
	        preview.innerHTML = '<span class="image-preview-text">' + (previewId === 'previewA' ? 'A' : 'B') + '시안 미리보기</span>';
	    }
	}
   
   function validateForm() {
	    var testName = document.getElementsByName("testName")[0].value;
	    var fileA = document.getElementById("fileA").files.length;
	    var fileB = document.getElementById("fileB").files.length;

	    if (testName.trim() === "" || fileA === 0 || fileB === 0) {
	        alert("A/B테스트를 위해 모든 항목을 입력해주세요");
	    } else {
	        document.getElementById("abTestForm").submit();
	    }
	}
</script>
</body>
</html>
