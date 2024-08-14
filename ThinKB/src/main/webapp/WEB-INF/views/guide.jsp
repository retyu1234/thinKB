<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
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
	width: 85%;
	margin: 0 auto;
}

.guide-title {
	height: auto;
	display: flex;
	align-items: center; /* 이미지와 텍스트를 같은 높이에 배치 */
	margin-top:-10%;
}
/* 초기 상태에서 콘텐츠를 숨기고, 이동 및 투명도 설정 */
.guide-item {
	opacity: 0;
	transform: translateY(50px);
	transition: opacity 0.8s ease, transform 0.8s ease;
	display: flex;
	margin-top: 10%;
	margin-bottom: 10%;
	justify-content: space-between; /* 자식 요소 간의 빈 공간을 없애기 위해 추가 */
	align-items: center; /* 높이 방향에서 중앙 정렬 */
}

.guide-item.visible {
	opacity: 1;
	transform: translateY(0);
}

/* .guide-item:nth-child(even) {
	transform: translateY(50px) rotate(5deg) scale(0.9);
} */
.guide-image-container, .guide-text {
	width: 50%;
	height: auto;
	transition: transform 0.5s ease;
}


.guide-item:hover .guide-image-container {
	transform: scale(1.05);
}

.guide-item:hover .guide-text {
	transform: translateY(-5px);
}


.guide-image-container {
	aspect-ratio: 1 / 1; /* 1:1 비율을 유지합니다. */
	max-width: 300px; /* 최대 크기 */
	width: auto;
	height: auto;
	overflow: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #ffffff;
}
.guide-image-container dotlottie-player {
	aspect-ratio: 1 / 1; /* 정사각형 비율 유지 */
	width: 100%;
	height: auto;
	max-width: 300px; /* 최대 크기를 지정할 수 있습니다. */
	object-fit: contain; /* 내용이 잘리지 않도록 설정 */
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
	margin: 0;
	flex-grow: 1; /* 텍스트 부분이 남은 공간을 차지하게 하기 위한 설정 */
}

.guide-item:nth-child(even) {
	flex-direction: row-reverse;
}

.guide-item:nth-child(even) .guide-text {
	text-align: left;
}

#guide-section h2 {
	font-size: 20pt;
	font-weight: bold;
	margin-bottom: 1vw;
}

#guide-section p {
	font-size: 12pt;
	margin-bottom: 1%;
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
		font-size: 2vw;
	}
}
</style>
</head>
<body>
	<section id="guide-section">
		<div id="guide-container">
			<div class="guide-title" style="display: flex; align-items: center;">
    	<img src="<c:url value='/resources/thinkb_logo.png' />" alt="logo" style="width: 15%; margin-right: 10px;"/>
    	<span style="font-size:25px; font-weight:bold;">사용 가이드</span>
			</div>
			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/2fddae35-0cdc-4b5b-857a-585948fbe4c8/GCE5AsQQMK.json"
						background="transparent" speed="1.5"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text">
				<h2 style="text-align: left;">익명 보장으로 안심! <br>
				자유롭게 아이디어를 등록해요</h2>
				<p>익명으로 편리하게 아이디어를 등록할 수 있어요.</p>
				<p>AI를 사용해 생각을 더욱 쉽게 정리하세요.</p>
				</div>
			</div>

			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/57ac9edb-1df4-4273-943f-bf6c1df8817b/1B3u1zcSOX.json"
						background="transparent" speed="1.5"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text" style="text-align: right;">
					<h2  style="text-align: right;">모두의 의견을 모아 <br>
					2개의 아이디어를 골라요!</h2>
					<p>익명 투표를 진행해 가장 많은 표를 받은 </p>
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
					<h2  style="text-align: left;">다양한 관점에서 <br>
					아이디어를 확장시켜봐요!</h2>
					<p>객관적 관점, 기대효과, 문제점, 실현가능성</p>
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
				<div class="guide-text" style="text-align: right;">
					<h2>관점별 의견들을 모아 <br>
					피드백을 진행해요!</h2>
					<p>관점별로 모인 의견을 바탕으로 </p>
					<p>종합적인 피드백을 담은 의견을 작성해요.</p>
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
					<h2 style="text-align: left;">'❤️좋아요'가 보여주는 <br>
					최고의 의견을 확인해봐요!</h2>
					<p>가장 좋은 의견에 한표!</p>
					<p>팀원들이 생각하는 가장 좋은 의견을 확인할 수 있어요.</p>
				</div>
			</div>
			<div class="guide-item">
				<div class="guide-image-container">
					<dotlottie-player
						src="https://lottie.host/00f3648f-4ffe-4ecd-b54b-bc490b3562bd/Zloqc32xKU.json"
						background="transparent" speed="1"
						style="width: 300px; height: 300px;" loop autoplay></dotlottie-player>
				</div>
				<div class="guide-text" style="text-align: right;">
					<h2>THINKB와 함께라면 <br>
					최종보고서 작성도 어렵지 않아요</h2>
					<p>회의 내용을 담은 요약보고서와 제공되는 양식을 사용해</p>
					<p>최종보고서를 쉽게 작성할 수 있어요.</p>
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
					<h2  style="text-align: left;">다양한 추가기능을<br>
					활용해보세요!</h2>
					<p>A/B테스트, 추가 투표, 핀메모를 이용해</p>
					<p>간단한 의견 정리와 피드백도 쉽게 진행할 수 있어요.</p>
				</div>
			</div>

		</div>
	</section>
</body>
<script>
	
</script>
</html>
