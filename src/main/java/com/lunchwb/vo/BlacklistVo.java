package com.lunchwb.vo;

public class BlacklistVo {
	
	//////////////////// blacklist table ////////////////////
	private int blackNo;
	private int storeNo;
	private int groupNo;
	private String regDate;
	private String storeName;
	private String menu2ndCateName;
	private String storeRoadAddress;
	
	//////////검사용
	private int userNo;
	
	//검색용
	private String keyword;
	
	public BlacklistVo() {
	}

	public BlacklistVo(int blackNo, int storeNo, int groupNo, String regDate, String storeName, String menu2ndCateName,
			String storeRoadAddress, int userNo) {
		this.blackNo = blackNo;
		this.storeNo = storeNo;
		this.groupNo = groupNo;
		this.regDate = regDate;
		this.storeName = storeName;
		this.menu2ndCateName = menu2ndCateName;
		this.storeRoadAddress = storeRoadAddress;
		this.userNo = userNo;
	}

	public int getBlackNo() {
		return blackNo;
	}

	public void setBlackNo(int blackNo) {
		this.blackNo = blackNo;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
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

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "BlacklistVo [blackNo=" + blackNo + ", storeNo=" + storeNo + ", groupNo=" + groupNo + ", regDate="
				+ regDate + ", storeName=" + storeName + ", menu2ndCateName=" + menu2ndCateName + ", storeRoadAddress="
				+ storeRoadAddress + ", userNo=" + userNo + "]";
	}

}
