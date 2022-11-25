package com.lunchwb.vo;

public class AloneVo {
	
	//////////////////// review table ////////////////////
	private int reviewNo;
	private int userNo;
	private int visitedNo;
	private String reviewContent;
	private int userScore;
	private String reviewFileName;
	private int reviewReported;
	
	// visited table //
	private int visitedDate;
	private int visitedCount;
	
	// store table //
	private int storeNo;
	private String storeName;
	private double storeX;
	private double storeY;
	private String storeRoadAddress;
	private String storeOldAddress;
	
	// food_1st_category table //
	private String menu1stCateName;
	
	// user table //
	private String userName;
	
	// menu table //
	private String menuName;
	
	// groups table //
	private String groupName;
	
	
	// 평균나이가져오기 용
	private String ageGroup;
	
	
	
	// 생성자
	public AloneVo() {
		
	};
	
	public AloneVo(int userNo) {
		this.userNo = userNo;
	}

	public AloneVo(int reviewNo, String reviewContent, int userScore) {
		this.reviewNo = reviewNo;
		this.reviewContent = reviewContent;
		this.userScore = userScore;
	}

	public AloneVo(int reviewNo, String reviewContent, int userScore, String reviewFileName) {
		this.reviewNo = reviewNo;
		this.reviewContent = reviewContent;
		this.userScore = userScore;
		this.reviewFileName = reviewFileName;
	}

	public AloneVo(int reviewNo, int userNo, int visitedNo, String reviewContent, int userScore, String reviewFileName,
			int reviewReported, int visitedDate, int visitedCount, int storeNo, String storeName, double storeX,
			double storeY, String storeRoadAddress, String storeOldAddress, String menu1stCateName, String userName,
			String menuName, String groupName, String ageGroup) {
		this.reviewNo = reviewNo;
		this.userNo = userNo;
		this.visitedNo = visitedNo;
		this.reviewContent = reviewContent;
		this.userScore = userScore;
		this.reviewFileName = reviewFileName;
		this.reviewReported = reviewReported;
		this.visitedDate = visitedDate;
		this.visitedCount = visitedCount;
		this.storeNo = storeNo;
		this.storeName = storeName;
		this.storeX = storeX;
		this.storeY = storeY;
		this.storeRoadAddress = storeRoadAddress;
		this.storeOldAddress = storeOldAddress;
		this.menu1stCateName = menu1stCateName;
		this.userName = userName;
		this.menuName = menuName;
		this.groupName = groupName;
		this.ageGroup = ageGroup;
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

	public int getVisitedDate() {
		return visitedDate;
	}

	public void setVisitedDate(int visitedDate) {
		this.visitedDate = visitedDate;
	}

	public int getVisitedCount() {
		return visitedCount;
	}

	public void setVisitedCount(int visitedCount) {
		this.visitedCount = visitedCount;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public double getStoreX() {
		return storeX;
	}

	public void setStoreX(double storeX) {
		this.storeX = storeX;
	}

	public double getStoreY() {
		return storeY;
	}

	public void setStoreY(double storeY) {
		this.storeY = storeY;
	}

	public String getStoreRoadAddress() {
		return storeRoadAddress;
	}

	public void setStoreRoadAddress(String storeRoadAddress) {
		this.storeRoadAddress = storeRoadAddress;
	}

	public String getStoreOldAddress() {
		return storeOldAddress;
	}

	public void setStoreOldAddress(String storeOldAddress) {
		this.storeOldAddress = storeOldAddress;
	}

	public String getMenu1stCateName() {
		return menu1stCateName;
	}

	public void setMenu1stCateName(String menu1stCateName) {
		this.menu1stCateName = menu1stCateName;
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

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	

	public String getAgeGroup() {
		return ageGroup;
	}

	public void setAgeGroup(String ageGroup) {
		this.ageGroup = ageGroup;
	}
	
	@Override
	public String toString() {
		return "AloneVo [reviewNo=" + reviewNo + ", userNo=" + userNo + ", visitedNo=" + visitedNo + ", reviewContent="
				+ reviewContent + ", userScore=" + userScore + ", reviewFileName=" + reviewFileName
				+ ", reviewReported=" + reviewReported + ", visitedDate=" + visitedDate + ", visitedCount="
				+ visitedCount + ", storeNo=" + storeNo + ", storeName=" + storeName + ", storeX=" + storeX
				+ ", storeY=" + storeY + ", storeRoadAddress=" + storeRoadAddress + ", storeOldAddress="
				+ storeOldAddress + ", menu1stCateName=" + menu1stCateName + ", userName=" + userName + ", menuName="
				+ menuName + ", groupName=" + groupName + ", ageGroup=" + ageGroup + "]";
	}


}
