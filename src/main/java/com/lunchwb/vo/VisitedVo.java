package com.lunchwb.vo;

import java.util.List;

public class VisitedVo {
	
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
	private float ratingBujang;
	private int lastVisit;
		
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
	
	//갈사람들
	private List<GroupVo> groupVoList;
	
	// 달력 표시 순서용
	private int seq;
	
	
	
	//생성자
	public VisitedVo() {
	}
	
	public VisitedVo(List<GroupVo> groupVoList) {
		this.groupVoList = groupVoList;
	}

	// 달력정보가져오기 용(입력값)
	public VisitedVo(int userNo,String selectMonth) {
		this.userNo = userNo;
		this.selectMonth = selectMonth;
	}

	public VisitedVo(int userNo, int groupNo, int storeNo) {
		this.userNo = userNo;
		this.groupNo = groupNo;
		this.storeNo = storeNo;
	}
	
	// 달력 출력용
	public VisitedVo(int storeNo,String visitedDate, String menu1stCateName, String groupName, String storeName,
			String menuName, int seq) {
		this.storeNo = storeNo;
		this.visitedDate = visitedDate;
		this.menu1stCateName = menu1stCateName;
		this.groupName = groupName;
		this.storeName = storeName;
		this.menuName = menuName;
		this.seq = seq;
	}

	public VisitedVo(int visitedNo, int userNo, int groupNo, int storeNo, int menuNo, String visitedDate,
			int visitCount, int menuCount, String menu2ndCateName,
			String storeRoadAddress, float ratingBujang, int lastVisit, String menu1stCateName, String groupName,
			String storeName, String menuName, String selectMonth, int groupOrder, List<GroupVo> groupVoList) {
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
		this.lastVisit = lastVisit;
		this.menu1stCateName = menu1stCateName;
		this.groupName = groupName;
		this.storeName = storeName;
		this.menuName = menuName;
		this.selectMonth = selectMonth;
		this.groupOrder = groupOrder;
		this.groupVoList = groupVoList;
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

	public float getRatingBujang() {
		return ratingBujang;
	}

	public void setRatingBujang(float ratingBujang) {
		this.ratingBujang = ratingBujang;
	}

	public int getLastVisit() {
		return lastVisit;
	}

	public void setLastVisit(int lastVisit) {
		this.lastVisit = lastVisit;
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
	
	public List<GroupVo> getGroupVoList() {
		return groupVoList;
	}

	public void setGroupVoList(List<GroupVo> groupVoList) {
		this.groupVoList = groupVoList;
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	@Override
	public String toString() {
		return "VisitedVo [visitedNo=" + visitedNo + ", userNo=" + userNo + ", groupNo=" + groupNo + ", storeNo="
				+ storeNo + ", menuNo=" + menuNo + ", visitedDate=" + visitedDate + ", visitCount=" + visitCount
				+ ", menuCount=" + menuCount + ", menu2ndCateName=" + menu2ndCateName + ", storeRoadAddress="
				+ storeRoadAddress + ", ratingBujang=" + ratingBujang + ", lastVisit=" + lastVisit
				+ ", menu1stCateName=" + menu1stCateName + ", groupName=" + groupName + ", storeName=" + storeName
				+ ", menuName=" + menuName + ", selectMonth=" + selectMonth + ", groupOrder=" + groupOrder
				+ ", groupVoList=" + groupVoList + ", seq=" + seq + "]";
	}

	
	

};
