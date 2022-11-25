package com.lunchwb.vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVo {
	
	//////////////////// review table ////////////////////
	private int reviewNo;
	private int userNo;
	private int visitedNo;
	private String reviewContent;
	private int userScore;
	private MultipartFile file;
	private String reviewFileName;
	private int reviewReported;
	
	// store table //
	private int storeNo;
	
	// users table
	private String userName;
	
	// menu table
	private String menuName;
	
	// visited table
	private String visitedDate;
	private int menuNo;
	
	// Informaion of reviews of store
	private String avgAge;
	private int withCount;
	private int visitedCount;
	
	
	public ReviewVo() {
	}

	public ReviewVo(int reviewNo, int userNo, int visitedNo, String reviewContent, int userScore, MultipartFile file,
			String reviewFileName, int reviewReported, int storeNo, String userName, String menuName,
			String visitedDate, int menuNo, String avgAge, int withCount, int visitedCount) {
		super();
		this.reviewNo = reviewNo;
		this.userNo = userNo;
		this.visitedNo = visitedNo;
		this.reviewContent = reviewContent;
		this.userScore = userScore;
		this.file = file;
		this.reviewFileName = reviewFileName;
		this.reviewReported = reviewReported;
		this.storeNo = storeNo;
		this.userName = userName;
		this.menuName = menuName;
		this.visitedDate = visitedDate;
		this.menuNo = menuNo;
		this.avgAge = avgAge;
		this.withCount = withCount;
		this.visitedCount = visitedCount;
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

	public int getVisitedNo() {
		return visitedNo;
	}

	public void setVisitedNo(int visitedNo) {
		this.visitedNo = visitedNo;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getUserScore() {
		return userScore;
	}

	public void setUserScore(int userScore) {
		this.userScore = userScore;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getReviewFileName() {
		return reviewFileName;
	}

	public void setReviewFileName(String reviewFileName) {
		this.reviewFileName = reviewFileName;
	}

	public int getReviewReported() {
		return reviewReported;
	}

	public void setReviewReported(int reviewReported) {
		this.reviewReported = reviewReported;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getVisitedDate() {
		return visitedDate;
	}

	public void setVisitedDate(String visitedDate) {
		this.visitedDate = visitedDate;
	}

	public String getAvgAge() {
		return avgAge;
	}

	public int getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}

	public void setAvgAge(String avgAge) {
		this.avgAge = avgAge;
	}

	public int getWithCount() {
		return withCount;
	}

	public void setWithCount(int withCount) {
		this.withCount = withCount;
	}

	public int getVisitedCount() {
		return visitedCount;
	}

	public void setVisitedCount(int visitedCount) {
		this.visitedCount = visitedCount;
	}

	@Override
	public String toString() {
		return "ReviewVo [reviewNo=" + reviewNo + ", userNo=" + userNo + ", visitedNo=" + visitedNo + ", reviewContent="
				+ reviewContent + ", userScore=" + userScore + ", file=" + file + ", reviewFileName=" + reviewFileName
				+ ", reviewReported=" + reviewReported + ", storeNo=" + storeNo + ", userName=" + userName
				+ ", menuName=" + menuName + ", visitedDate=" + visitedDate + ", menuNo=" + menuNo + ", avgAge="
				+ avgAge + ", withCount=" + withCount + ", visitedCount=" + visitedCount + "]";
	}
}
