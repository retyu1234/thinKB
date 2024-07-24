<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>투표 시스템</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center; /* 모든 글자 가운데 정렬 */
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .header {
            text-align: center;
        }
        .header img {
            width: 100%;
            height: auto;
            max-height: 500px;
            border-radius: 10px;
        }
        .form-section {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .form-group {
            width: 48%;
        }
        .form-group label {
            font-size: 18px;
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }
        .form-group input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group .search-results, .form-group .added-people {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            background-color: #f9f9f9;
            margin-bottom: 10px;
        }
        .form-group .search-results div, .form-group .added-people div {
            padding: 5px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .form-group .search-results div button, .form-group .added-people div button {
            background-color: #ffc107;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group .search-results div button:hover, .form-group .added-people div button:hover {
            background-color: #e0a800;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #ffc107;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .form-group button:hover {
            background-color: #e0a800;
        }
        .add-option-btn {
            display: block;
            padding: 5px 10px;
            margin-top: 10px;
            background-color: #ffc107;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: right;
        }
        .add-option-btn:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="./resources/logo1.jpg" alt="Header Image">
        </div>
        <div class="form-section">
            <div class="form-group">
                <label for="search">초대할 사람 선택</label>
                <input type="text" id="search" placeholder="이름 / 부서명으로 검색" onkeyup="searchUsers()">
                <div class="search-results" id="search-results"></div>
                <div class="added-people" id="added-people"></div>
                <button onclick="completeSelection()">완료</button>
            </div>
            <div class="form-group">
                <label for="vote-title">투표 제목</label>
                <input type="text" id="vote-title" placeholder="투표 제목을 입력해주세요">
                <div id="vote-options">
                    <input type="text" placeholder="투표안을 입력해주세요">
                </div>
                <button class="add-option-btn" onclick="addOption()">+ 선택지 추가</button>
                <button onclick="createVote()">투표 생성</button>
            </div>
        </div>
    </div>
    
    
    
    <script>
        function searchUsers() {
            const query = document.getElementById('search').value;
            const xhr = new XMLHttpRequest();
            xhr.open('GET', 'search_users.jsp?query=' + query, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('search-results').innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function addPerson(person) {
            const addedPeople = document.getElementById('added-people');
            
            // 중복 추가 방지
            if (Array.from(addedPeople.getElementsByTagName('span')).some(span => span.textContent === person)) {
                return;
            }

            const personDiv = document.createElement('div');
            personDiv.innerHTML = `<span>${person}</span><button onclick="removePerson(this)">-</button>`;
            addedPeople.appendChild(personDiv);
        }

        function removePerson(button) {
            button.parentElement.remove();
        }

        function addOption() {
            const voteOptions = document.getElementById('vote-options');
            const optionInput = document.createElement('input');
            optionInput.type = 'text';
            optionInput.placeholder = '투표안을 입력해주세요';
            voteOptions.appendChild(optionInput);
        }

        function completeSelection() {
            alert('선택이 완료되었습니다.');
        }

        function createVote() {
            alert('투표가 생성되었습니다.');
        }
    </script>
</body>
</html>
