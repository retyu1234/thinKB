package com.kb.star.dto;

import java.sql.Timestamp;

public class PinTestsDto {
    private int pinTestId;
    private String testName;
    private String fileName;
    private int userId;
    private int departmentId;
    private Timestamp createdAt;
    private boolean isDelete;
    private int status;

    // Default constructor
    public PinTestsDto() {
    }

    // Parameterized constructor
    public PinTestsDto(int pinTestId, String testName, String fileName, int userId, int departmentId, Timestamp createdAt, boolean isDelete, int status) {
        this.pinTestId = pinTestId;
        this.testName = testName;
        this.fileName = fileName;
        this.userId = userId;
        this.departmentId = departmentId;
        this.createdAt = createdAt;
        this.isDelete = isDelete;
        this.status = status;
    }

    // Getters and Setters
    public int getPinTestId() {
        return pinTestId;
    }

    public void setPinTestId(int pinTestId) {
        this.pinTestId = pinTestId;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
