<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script
	src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs"
	type="module"></script>
<title>Guide</title>
<style>
/* Guide 섹션 스타일 */
#guide-section {
	padding: 100px 0;
	background-color: #ffffff;
	overflow-x: hidden; /* 가로 스크롤 방지 */
}

#guide-container {
	width: 70%;
	margin: 0 auto;
}

.guide-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 100px; /* 간격 증가 */
	opacity: 0;
	transform: translateY(50px) rotate(-5deg) scale(0.9);
	transition: opacity 0.8s ease, transform 0.8s
		cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.guide-item:nth-child(even) {
	transform: translateY(50px) rotate(5deg) scale(0.9);
}

.guide-item.visible {
	opacity: 1;
	transform: translateY(0) rotate(0) scale(1);
}

.guide-image-container, .guide-text {
	width: 45%;
	transition: transform 0.5s ease;
}

.guide-item:hover .guide-image-container {
	transform: scale(1.05);
}

.guide-item:hover .guide-text {
	transform: translateY(-5px);
}

.guide-image-container, .guide-text {
	width: 45%;
}

.guide-image-container {
	aspect-ratio: 16/9; /* 16:9 비율 유지 */
	overflow: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #ffffff;
}

.guide-image {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.guide-text {
	display: flex;
	flex-direction: column;
	justify-content: center;
	padding: 0 2%;
	box-sizing: border-box;
}

.guide-item:nth-child(even) {
	flex-direction: row-reverse;
}

.guide-item:nth-child(even) .guide-text {
	text-align: left;
}

#guide-section h2 {
	font-size: 18pt;
	margin-bottom: 1vw;
}

#guide-section p {
	font-size: 15pt;
	margin-bottom: 0.5vw;
}

@media ( max-width : 768px) {
	#guide-container {
		width: 90%;
	}
	.guide-item {
		flex-direction: column;
	}
	.guide-image-container, .guide-text {
		width: 100%;
		margin-bottom: 5%;
	}
	.guide-item:nth-child(even) {
		flex-direction: column;
	}
	#guide-section h2 {
		font-size: 4vw;
	}
	#guide-section p {
		font-size: 3vw;
	}
}

</style>
</head>
<body>
	<section id="guide-section">

		<div id="guide-container">
			<h1 style="font-size: 30pt;">👣Guide</h1>
			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/2fddae35-0cdc-4b5b-857a-585948fbe4c8/GCE5AsQQMK.json"
						background="transparent" speed="1.5"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>자유롭게 아이디어를 나눠요!</h2>
					<p>익명등록으로 편한 분위기로 아이디어를 낼수 있어요.</p>
					<p>AI질문으로 내 생각을 보다 쉽게 정리해요.</p>
				</div>
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
				<dotlottie-player
						src="https://lottie.host/57ac9edb-1df4-4273-943f-bf6c1df8817b/1B3u1zcSOX.json"
						background="transparent" speed="1.5"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>모두의 의견을 모아 2개의 아이디어를 골라요!</h2>
					<p>익명 투표를 진행해 제일 표를 많이 받은</p>
					<p>2개의 아이디어를 뽑아 회의를 진행할 수 있어요.</p>
				</div>
			</div>
			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/e06980d3-898d-4de8-8923-34c387721833/AVAkaMqyRp.json"
						background="transparent" speed="1.5"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>다양한 방향에서 아이디어를 확장시켜봐요!</h2>
					<p>똑똑이, 긍정이, 걱정이, 깐깐이</p>
					<p>4가지 관점에서 아이디어에 대한 의견을 작성해요.</p>
				</div>
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/b96a21bf-1736-4695-862f-187dd034d028/bfzY8RWNgc.json"
						background="transparent" speed="1"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>관점별 의견들을 모아 피드백을 진행해요!</h2>
					<p>관점별로 모인 의견들을</p>
					<p>피드백을 통해 아이디어를 구체화해요.</p>
				</div> 
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/cce0b5d3-0469-48e7-9525-cc37b5ea3034/Ak98tgJK31.json"
						background="transparent" speed="1"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>'❤️좋아요'가 보여주는 최고의 의견을 확인해봐요!</h2>
					<p>가장 좋은 의견에 한표!</p>
					<p>팀원들이 생각하는 가장 좋은 의견을 확인할 수 있어요.</p>
				</div>
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/87c31457-2ad6-4db2-875a-89ba7b91973a/LNSDQjbBnw.json"
						background="transparent" speed="1"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>다양한 추가기능!</h2>
					<p>A/B테스트, 추가 투표, 핀메모를 이용해</p>
					<p>회의뿐 아니라 간단한 의견 종합부터 피드백까지</p>
					<p>추가논의를 진행할 수 있어요.</p> 
				</div>
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
						<dotlottie-player
						src="https://lottie.host/00f3648f-4ffe-4ecd-b54b-bc490b3562bd/Zloqc32xKU.json"
						background="transparent" speed="1"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
					<h2>THINKB와 함께 최종보고서 작성까지!</h2>
					<p>최종보고서 작성도 어렵지 않아요.</p>
					<p>논의가 완료되면 지금까지 알맞에 정리된 의견들과</p>
					<p>함께 제공되는 양식에 맞춰 최종보고서를 작성할 수 있어요.</p>
				</div> 
			</div>
		</div>
	</section>
</body>
</html>
