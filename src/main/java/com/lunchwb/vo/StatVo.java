package com.lunchwb.vo;

public class StatVo {
	
	//////////////////// visited table //////////////////// 
	private int visitedNo;
	private int userNo;
	private int groupNo;
	private int storeNo;
	private int menuNo;
	private String visitedDate;
	
	///////////집계용//////
	private int visitCount;
	private int menuCount;
	
	///////// 리뷰용 ////////
	private String menu2ndCateName;
	private String storeRoadAddress;
	private int ratingBujang;
	
	//////////////////// 달력용 //////////////////// 
	private String menu1stCateName;
	//private int groupNo;
	private String groupName;
	private String storeName;
	private String menuName;
	//private String visitedDate;
	private String selectMonth;
	
	//////////////////// group_member table //////////////////// 
	// 그룹 순서용
	private int groupOrder;
	
	//////////////////// users table //////////////////// 
	private String ageGroup;
	
	
	//생성자
	public StatVo() {
	}
	

	// 달력 출력용
	public StatVo(String visitedDate, String menu1stCateName, String groupName, String storeName,
			String menuName, int groupOrder) {
		this.visitedDate = visitedDate;
		this.menu1stCateName = menu1stCateName;
		this.groupName = groupName;
		this.storeName = storeName;
		this.menuName = menuName;
		this.groupOrder = groupOrder;
	}
	
	// 전체통계용
	// 지난 6개월간 음식인기조회
	public StatVo(String menu1stCateName){
		this.menu1stCateName = menu1stCateName;
	}
	
	
	public StatVo(String visitedDate, int visitCount) {
		this.visitedDate = visitedDate;
		this.visitCount = visitCount;
	};
	
	public StatVo(int visitCount, String ageGroup) {
		this.visitCount = visitCount;
		this.ageGroup = ageGroup;
		
	}
	

	public StatVo(int visitedNo, int userNo, int groupNo, int storeNo, int menuNo, String visitedDate, int visitCount,
			int menuCount, String menu2ndCateName, String storeRoadAddress, int ratingBujang, String menu1stCateName,
			String groupName, String storeName, String menuName, String selectMonth, int groupOrder,
			String ageGroup) {
		this.visitedNo = visitedNo;
		this.userNo = userNo;
		this.groupNo = groupNo;
		this.storeNo = storeNo;
		this.menuNo = menuNo;
		this.visitedDate = visitedDate;
		this.visitCount = visitCount;
		this.menuCount = menuCount;
		this.menu2ndCateName = menu2ndCateName;
		this.storeRoadAddress = storeRoadAddress;
		this.ratingBujang = ratingBujang;
		this.menu1stCateName = menu1stCateName;
		this.groupName = groupName;
		this.storeName = storeName;
		this.menuName = menuName;
		this.selectMonth = selectMonth;
		this.groupOrder = groupOrder;
		this.ageGroup = ageGroup;
	}

	public int getVisitedNo() {
		return visitedNo;
	}

	public void setVisitedNo(int visitedNo) {
		this.visitedNo = visitedNo;
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

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	public int getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}

	public String getVisitedDate() {
		return visitedDate;
	}

	public void setVisitedDate(String visitedDate) {
		this.visitedDate = visitedDate;
	}

	public String getMenu1stCateName() {
		return menu1stCateName;
	}

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}
	
	public int getMenuCount() {
		return menuCount;
	}

	public void setMenuCount(int menuCount) {
		this.menuCount = menuCount;
	}

	public String getMenu2ndCateName() {
		return menu2ndCateName;
	}

	public void setMenu2ndCateName(String menu2ndCateName) {
		this.menu2ndCateName = menu2ndCateName;
	}

	public String getStoreRoadAddress() {
		return storeRoadAddress;
	}

	public void setStoreRoadAddress(String storeRoadAddress) {
		this.storeRoadAddress = storeRoadAddress;
	}

	public int getRatingBujang() {
		return ratingBujang;
	}

	public void setRatingBujang(int ratingBujang) {
		this.ratingBujang = ratingBujang;
	}

	public void setMenu1stCateName(String menu1stCateName) {
		this.menu1stCateName = menu1stCateName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getSelectMonth() {
		return selectMonth;
	}

	public void setSelectMonth(String selectMonth) {
		this.selectMonth = selectMonth;
	}

	public int getGroupOrder() {
		return groupOrder;
	}

	public void setGroupOrder(int groupOrder) {
		this.groupOrder = groupOrder;
	}

	public String getAgeGroup() {
		return ageGroup;
	}

	public void setAgeGroup(String ageGroup) {
		this.ageGroup = ageGroup;
	}

	@Override
	public String toString() {
		return "StatVo [visitedNo=" + visitedNo + ", userNo=" + userNo + ", groupNo=" + groupNo + ", storeNo=" + storeNo
				+ ", menuNo=" + menuNo + ", visitedDate=" + visitedDate + ", visitCount=" + visitCount + ", menuCount="
				+ menuCount + ", menu2ndCateName=" + menu2ndCateName + ", storeRoadAddress=" + storeRoadAddress
				+ ", ratingBujang=" + ratingBujang + ", menu1stCateName=" + menu1stCateName + ", groupName=" + groupName
				+ ", storeName=" + storeName + ", menuName=" + menuName + ", selectMonth=" + selectMonth
				+ ", groupOrder=" + groupOrder + ", ageGroup=" + ageGroup + "]";
	}

};
