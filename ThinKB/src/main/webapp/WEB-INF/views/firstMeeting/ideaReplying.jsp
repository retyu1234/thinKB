<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <p>
            <span><input type="hidden" id="modal-idea-id"></span>
        </p>
        <p>
            <span><input type="hidden" id="modal-idea-title"></span>
        </p>
        <p>
            User ID: <span id="modal-idea-userId"></span>
        </p>
        <p>
            상세설명 : <span id="modal-idea-description"></span>
        </p>
        <p>질문하기</p>
        <div class="idea-container" id="modal-idea-replies">
            <!-- 댓글 내용이 여기에 동적으로 추가됩니다 -->
        </div>
        <div id="input-reply-container">
            <input type="text" id="replyContent" placeholder="댓글을 입력하세요" />
            <button onclick="submitReply()" id="input-button">입력</button>
        </div>
        <div id="reply-button-container">
            <button onclick="submitReplyAnswer()" id="reply-button" style="display: none;">답글달기</button>
        </div>
        <div id="reply-form-container" style="display: none;">
            <!-- 답변 폼이 여기에 동적으로 추가됩니다 -->
        </div>
    </div>
</div>



<script>
    // JavaScript 코드로 모달 창 열기/닫기 기능 추가
    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("close")[0];

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    
    function openModal(ideaId, ideaTitle, ideaDescription, ideaUserId) {
        document.getElementById("myModal").style.display = "block";
        document.getElementById("modal-idea-id").innerText = ideaId;
        document.getElementById("modal-idea-title").innerText = ideaTitle;
        document.getElementById("modal-idea-description").innerText = ideaDescription;
        document.getElementById("modal-idea-userId").innerText = ideaUserId;

        const sessionUserId = document.getElementById("session-user-id").value;

        if (Number(sessionUserId) === Number(ideaUserId)) {
            document.getElementById("reply-button").style.display = "block";
            document.getElementById("replyContent").style.display = "block";
            document.getElementById("input-button").style.display = "none";
        } else {
            document.getElementById("reply-button").style.display = "none";
            document.getElementById("replyContent").style.display = "block";
            document.getElementById("input-button").style.display = "block";
        }

        // AJAX 요청을 통해 댓글 데이터 불러오기
        fetch('${pageContext.request.contextPath}/getIdeaReplies?ideaId=' + ideaId)
            .then(response => response.json())
            .then(data => {
                const repliesContainer = document.getElementById("modal-idea-replies");
                repliesContainer.innerHTML = '';
                data.forEach(reply => {
                    const replyElement = document.createElement('div');
                    replyElement.className = 'idea-box';
                    let replyHtml = reply.replyContent;
                    if (Number(sessionUserId) === Number(ideaUserId)) {
                        replyHtml += `<button onclick="showReplyForm(${reply.ideaReply}, '${reply.replyContent}')">답변달기</button>`;
                    }
                    replyElement.innerHTML = replyHtml;
                    repliesContainer.appendChild(replyElement);
                });
            });
    }
    
    function showReplyForm(ideaReply, replyContent) {
    	   

    }

    function submitReply() {
        const replyContent = document.getElementById("replyContent").value;
        if (replyContent.trim() === "") {
            alert("질문 내용을 입력하세요.");
            return;
        }

        const sessionUserId = document.getElementById("session-user-id").value;
        const ideaUserId = document.getElementById("modal-idea-userId").innerText;

        const data = new URLSearchParams();
        data.append("replyContent", replyContent);
        data.append("ideaId", selectedIdeaId);
        data.append("roomId", document.getElementById("session-room-id").value);

        fetch('/star/submitReply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data.toString()
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text(); // JSON 대신 텍스트 형식으로 응답 처리
        })
        .then(result => {
            console.log("Submit Reply Result: ", result);
            if (result === 'success') {
                alert("댓글이 성공적으로 등록되었습니다.");
                openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, ideaUserId); // 모달 새로고침
            } else {
                alert("댓글 등록에 실패하였습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("댓글 등록 중 오류가 발생하였습니다.");
        });
    }




    function submitReplyAnswer() {
        const replyAnswerContent = document.getElementById("replyAnswerContent").value;
        if (replyAnswerContent.trim() === "") {
            alert("답변 내용을 입력하세요.");
            return;
        }

        const ideaReply = document.getElementById("replyToId").value;

        const data = new URLSearchParams();
        data.append("replyContent", replyAnswerContent);
        data.append("ideaId", selectedIdeaId);
        data.append("roomId", document.getElementById("session-room-id").value);
        data.append("replyStep", ideaReply);

        console.log("Submitting reply answer with data: ", data.toString());

        fetch('/star/submitReplyAnswer', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data.toString()
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text(); // JSON 대신 텍스트 형식으로 응답 처리
        })
        .then(result => {
            console.log("Submit Reply Answer Result: ", result);
            if (result === 'success') {
                alert("답글이 성공적으로 등록되었습니다.");
                openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, ideaUserId); // 모달 새로고침
            } else {
                alert("답글 등록에 실패하였습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("답글 등록 중 오류가 발생하였습니다.");
        });
    }
   

</script>
