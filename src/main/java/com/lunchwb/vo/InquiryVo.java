package com.lunchwb.vo;

public class InquiryVo {
	//////////////////// inquiry table ////////////////////
	private int inquiryNo;
	private int userNo;
	private String inquiryTitle;
	private String inquiryContent;
	private String inquiryFilePath;
	private String inquiryDate;
	private String inquiryStatus;

	//////////////////// replyInquiry table ////////////////////
	private int replyNo;
	// private int inquiryNo;
	private String replyContent;
	
	//////////////////// users table ////////////////////
	private String userEmail;
	

	// 생성자
	public InquiryVo() {
	};
	
	public InquiryVo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	};
	
	
	
	//회원이 문의등록 시
	// 파일 X
	public InquiryVo(int userNo, String inquiryTitle, String inquiryContent) {
		this.userNo = userNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
	};
	
	// 파일 O
	public InquiryVo(int userNo, String inquiryTitle, String inquiryContent, String inquiryFilePath) {
		this.userNo = userNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.inquiryFilePath = inquiryFilePath;
	};
	


	public InquiryVo(int inquiryNo, int userNo, String inquiryTitle, String inquiryContent, String inquiryFilePath,
			String inquiryDate, String inquiryStatus) {
		this.inquiryNo = inquiryNo;
		this.userNo = userNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.inquiryFilePath = inquiryFilePath;
		this.inquiryDate = inquiryDate;
		this.inquiryStatus = inquiryStatus;
	};

	public InquiryVo(int replyNo, int inquiryNo, String replyContent) {
		this.replyNo = replyNo;
		this.inquiryNo = inquiryNo;
		this.replyContent = replyContent;
	};

	public InquiryVo(int inquiryNo, int userNo, String inquiryTitle, String inquiryContent, String inquiryFilePath,
			String inquiryDate, String inquiryStatus, int replyNo,  String replyContent) {
		this.inquiryNo = inquiryNo;
		this.userNo = userNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.inquiryFilePath = inquiryFilePath;
		this.inquiryDate = inquiryDate;
		this.inquiryStatus = inquiryStatus;
		this.replyNo = replyNo;
		this.replyContent = replyContent;
	};

	// 메소드 - gs
	public int getInquiryNo() {
		return inquiryNo;
	};

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	};

	public int getUserNo() {
		return userNo;
	};

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	};

	public String getInquiryTitle() {
		return inquiryTitle;
	};

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	};

	public String getInquiryContent() {
		return inquiryContent;
	};

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	};

	public String getInquiryFilePath() {
		return inquiryFilePath;
	};

	public void setInquiryFilePath(String inquiryFilePath) {
		this.inquiryFilePath = inquiryFilePath;
	};

	public String getInquiryDate() {
		return inquiryDate;
	};

	public void setInquiryDate(String inquiryDate) {
		this.inquiryDate = inquiryDate;
	};

	public String getInquiryStatus() {
		return inquiryStatus;
	};

	public void setInquiryStatus(String inquiryStatus) {
		this.inquiryStatus = inquiryStatus;
	};

	public int getReplyNo() {
		return replyNo;
	};

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	};


	public String getReplyContent() {
		return replyContent;
	};

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	};
	
	public String getUserEmail() {
		return userEmail;
	}


	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return "InquiryVo [inquiryNo=" + inquiryNo + ", userNo=" + userNo + ", inquiryTitle=" + inquiryTitle
				+ ", inquiryContent=" + inquiryContent + ", inquiryFilePath=" + inquiryFilePath + ", inquiryDate="
				+ inquiryDate + ", inquiryStatus=" + inquiryStatus + ", replyNo=" + replyNo + ", replyContent="
				+ replyContent + ", userEmail=" + userEmail + "]";
	}
	

};
