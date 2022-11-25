package com.lunchwb.vo;

public class ReportVo {
	//////////////////// report table ////////////////////
	private int reportNo;
	// private int reportCateNo; (reportCate table fk)
	private int reviewNo;
	private int userNo; //신고자
	private int reportStat;
	
	//////////////////// reportCate table ////////////////////
	private int reportCateNo;
	private String reportCateName;
	
	// store table //
	private int storeNo;

	public ReportVo() {}

	public ReportVo(int reportNo, int reviewNo, int userNo, int reportStat, int reportCateNo, String reportCateName,
			int storeNo) {
		this.reportNo = reportNo;
		this.reviewNo = reviewNo;
		this.userNo = userNo;
		this.reportStat = reportStat;
		this.reportCateNo = reportCateNo;
		this.reportCateName = reportCateName;
		this.storeNo = storeNo;
	} 
	
	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getReportStat() {
		return reportStat;
	}

	public void setReportStat(int reportStat) {
		this.reportStat = reportStat;
	}

	public int getReportCateNo() {
		return reportCateNo;
	}

	public void setReportCateNo(int reportCateNo) {
		this.reportCateNo = reportCateNo;
	}

	public String getReportCateName() {
		return reportCateName;
	}

	public void setReportCateName(String reportCateName) {
		this.reportCateName = reportCateName;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	@Override
	public String toString() {
		return "ReportVo [reportNo=" + reportNo + ", reviewNo=" + reviewNo + ", userNo=" + userNo + ", reportStat="
				+ reportStat + ", reportCateNo=" + reportCateNo + ", reportCateName=" + reportCateName + ", storeNo="
				+ storeNo + "]";
	}

};
