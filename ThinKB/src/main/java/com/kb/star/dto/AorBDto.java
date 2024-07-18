package com.kb.star.dto;

import java.sql.Timestamp;

public class AorBDto {
	private int ABTestID; // A/B 테스트 ID
	private String testName; // 테스트 이름
	private String variantA; // A 버전 사진 경로
	private String variantB; // B 버전 사진 경로
	private int resultANum; // A 버전 결과
	private int resultBNum; // B 버전 결과
	private Timestamp createdAt; // 생성 시간
	private boolean participated;

	// Getters and setters
	public int getABTestID() {
		return ABTestID;
	}

	public void setABTestID(int ABTestID) {
		this.ABTestID = ABTestID;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public String getVariantA() {
		return variantA;
	}

	public void setVariantA(String variantA) {
		this.variantA = variantA;
	}

	public String getVariantB() {
		return variantB;
	}

	public void setVariantB(String variantB) {
		this.variantB = variantB;
	}

	public int getResultANum() {
		return resultANum;
	}

	public void setResultANum(int resultANum) {
		this.resultANum = resultANum;
	}

	public int getResultBNum() {
		return resultBNum;
	}

	public void setResultBNum(int resultBNum) {
		this.resultBNum = resultBNum;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public boolean isParticipated() {
		return participated;
	}

	public void setParticipated(boolean participated) {
		this.participated = participated;
	}
	
}