<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ThinkKB</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header1 {
            text-align: center;
        }
        .header1 img {
            width: 100%;
            height: auto;
            max-height: 500px;
            /* border-radius: 10px; */
        }
        .user-info p {
            margin: 0;
        }
        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }
        .progress-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px 0;
        }
        .progress {
            background-color: #ffffff;
            padding: 10px;
            border-radius: 25px;
            display: flex;
            justify-content: space-around;
            height: 50px;
            width: 80%;
            border: 1px solid #ccc;
            font-size: 1.3em;
        }
        .progress label {
            display: flex;
            align-items: center;
        }
        .progress input {
            margin-right: 5px;
        }
        /* 진행중인 단계 */
        .progress-header-container {
		    display: flex;
		    justify-content: left;
		    width: 80%;
		    margin: 0 auto;
		}
		.progress-header {
		    margin: 0;
		    padding: 10px 0;
		}
        .ideas {
           margin: 70px 20px;
        }
        .idea {
            padding: 20px 20px;
            background-color: #ffffff;
            border-radius: 10px;
            margin-top: 30px;
            margin-left: auto;
            margin-right: auto;
            height: 100px;
            width: 80%;
            border: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.2em; /* 글자 크기를 키움 */
        }
        .idea h3, .idea p {
            margin: 0;
        }
        .idea-left {
            text-align: left;
        }
        .idea-right {
            text-align: right;
            align-self: flex-end;
		    justify-content: flex-end;
		    display: flex;
		    flex-direction: column;
        }
        .yellow-button {
            background-color: #ffc107;
            color: white;
            font-size: 1.2em; /* 글자 크기를 키움 */
            border: none;
            padding: 20px 20px;
            border-radius: 30px;
            cursor: pointer;
            margin-top: 50px;
            margin-right: 180px;
        }
        .yellow-button:hover {
            background-color: #e0a800;
        }
    </style>
    <script>
    function filterIdeas() {
        var checkboxes = document.querySelectorAll('.progress input');
        var ideas = document.querySelectorAll('.idea');
        var anyChecked = false;

        checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                anyChecked = true;
            }
        });

        if (!anyChecked) {
            ideas.forEach(function(idea) {
                idea.style.display = 'flex'; // 모든 아이디어를 기본적으로 보이도록 설정
            });
        } else {
            ideas.forEach(function(idea) {
                idea.style.display = 'none'; // 기본적으로 숨김 처리
            });

            checkboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    var stage = checkbox.getAttribute('data-stage');
                    var matchingIdeas = document.querySelectorAll('.idea.' + stage);
                    matchingIdeas.forEach(function(idea) {
                        idea.style.display = 'flex'; // 해당하는 아이디어만 보이도록 설정
                    });
                }
            });
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        var checkboxes = document.querySelectorAll('.progress input');
        checkboxes.forEach(function(checkbox) {
            checkbox.addEventListener('change', filterIdeas);
        });
        filterIdeas();
    });
    </script>
</head>
<body>
	<%@ include file="../header.jsp" %>
	  <div class="header1">
            <img src="./resources/header2.jpg" alt="Header Image">
        </div>
        <div class="button-container">
            <button class="yellow-button" onclick="createMeetingRoom()">+ 아이디어 회의방 만들기</button>
        </div>
        <div class="progress-header-container">
		    <h2 class="progress-header">진행중인 단계</h2>
		</div>
        <div class="progress-container">
            <div class="progress">
                <label><input type="checkbox" data-stage="draft" onchange="filterIdeas()"> 초안작성</label>
                <label><input type="checkbox" data-stage="first-review" onchange="filterIdeas()"> 1차의견</label>
                <label><input type="checkbox" data-stage="second-review" onchange="filterIdeas()"> 2차의견</label>
                <label><input type="checkbox" data-stage="final-report" onchange="filterIdeas()"> 최종보고서</label>
                <label><input type="checkbox" data-stage="complete" onchange="filterIdeas()"> 완료</label>
            </div>
        </div>
        <div class="ideas">
            <div class="idea first-review active">
                <div class="idea-left">
                    <h3>회의방 제목 1</h3><br>
                    <p>ESG팀</p>
                </div>
                <div class="idea-right">
                    <p>1차의견</p>
                    <p>2024.01.01 까지</p>
                </div>
            </div>
            <div class="idea draft active">
                <div class="idea-left">
                    <h3>회의방 제목 2</h3><br>
                    <p>ESG팀</p>
                </div>
                <div class="idea-right">
                    <p>초안작성</p>
                    <p>2024.01.01 까지</p>
                </div>
            </div>
            <!-- 더 많은 아이디어를 여기에 추가할 수 있습니다 -->
        </div>
    </div>
    <script>
        function createMeetingRoom() {
            // 회의방 만들기 기능 구현
            alert("회의방 만들기 기능은 구현되지 않았습니다.");
        }
    </script>
</body>
</html>
