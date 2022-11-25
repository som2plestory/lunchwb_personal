package com.lunchwb.vo;

public class NotificationVo {
	//////////////////// notification table ////////////////////
	private int notiNo;
	private int userNo;
	
	private int notiType;
	private int groupNo;
	private int reportNo;
	private int replyNo;
	private String alertCmt;
	private int notiState;
	
	////////////////////notiNo table ////////////////////
	/* join해서 써야합니다.*/
	// private int notiType;
	private String notiName;
	
	//////////////
	//user
	private int sendUser;
	private String sendEmail;
	private String sendName;
	
	//group
	private String groupName;
	
	//group member
	private int groupOrder;
	
	//report cate
	private String reportCateName;
	private String reviewDate;
	
	//inquiry
	private String inquiryTitle;
	private int inquiryNo;
	
	
	
	public NotificationVo() {}

	public NotificationVo(int notiNo, int userNo, int notiType, int groupNo, int reportNo, int replyNo, String alertCmt,
			int notiState, String notiName, int sendUser, String sendEmail, String sendName, String groupName,
			int groupOrder, String reportCateName, String reviewDate, String inquiryTitle, int inquiryNo) {
		this.notiNo = notiNo;
		this.userNo = userNo;
		this.notiType = notiType;
		this.groupNo = groupNo;
		this.reportNo = reportNo;
		this.replyNo = replyNo;
		this.alertCmt = alertCmt;
		this.notiState = notiState;
		this.notiName = notiName;
		this.sendUser = sendUser;
		this.sendEmail = sendEmail;
		this.sendName = sendName;
		this.groupName = groupName;
		this.groupOrder = groupOrder;
		this.reportCateName = reportCateName;
		this.reviewDate = reviewDate;
		this.inquiryTitle = inquiryTitle;
		this.inquiryNo = inquiryNo;
	}



	public int getNotiNo() {
		return notiNo;
	}

	public void setNotiNo(int notiNo) {
		this.notiNo = notiNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getAlertCmt() {
		return alertCmt;
	}

	public void setAlertCmt(String alertCmt) {
		this.alertCmt = alertCmt;
	}

	public int getNotiState() {
		return notiState;
	}

	public void setNotiState(int notiState) {
		this.notiState = notiState;
	}

	public int getNotiType() {
		return notiType;
	}

	public void setNotiType(int notiType) {
		this.notiType = notiType;
	}

	public String getNotiName() {
		return notiName;
	}

	public void setNotiName(String notiName) {
		this.notiName = notiName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public int getGroupOrder() {
		return groupOrder;
	}

	public void setGroupOrder(int groupOrder) {
		this.groupOrder = groupOrder;
	}

	public String getReportCateName() {
		return reportCateName;
	}

	public void setReportCateName(String reportCateName) {
		this.reportCateName = reportCateName;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public int getSendUser() {
		return sendUser;
	}

	public void setSendUser(int sendUser) {
		this.sendUser = sendUser;
	}

	public String getSendEmail() {
		return sendEmail;
	}

	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}

	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}

	public String getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	@Override
	public String toString() {
		return "NotificationVo [notiNo=" + notiNo + ", userNo=" + userNo + ", notiType=" + notiType + ", groupNo="
				+ groupNo + ", reportNo=" + reportNo + ", replyNo=" + replyNo + ", alertCmt=" + alertCmt
				+ ", notiState=" + notiState + ", notiName=" + notiName + ", sendUser=" + sendUser + ", sendEmail="
				+ sendEmail + ", sendName=" + sendName + ", groupName=" + groupName + ", groupOrder=" + groupOrder
				+ ", reportCateName=" + reportCateName + ", reviewDate=" + reviewDate + ", inquiryTitle=" + inquiryTitle
				+ ", inquiryNo=" + inquiryNo + "]";
	}
	
};
