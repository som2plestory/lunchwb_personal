package com.lunchwb.vo;

import java.util.List;

public class RandomVo {
	
	// random table
	private int randomNo;
	private String storeInfo;
	private int stopAtValue;
	private String groupName;
	private String resultTime;
	private int userNo;
	
	// user table
	private int userState;
	
	// 가게 정보 담기
	private List<StoreVo> rouletteStoreInfo;
	private int groupNo;
	
	public RandomVo() {
	}

	public RandomVo(int randomNo, String storeInfo, int stopAtValue, String groupName, String resultTime, int userNo,
			int userState, List<StoreVo> rouletteStoreInfo, int groupNo) {
		super();
		this.randomNo = randomNo;
		this.storeInfo = storeInfo;
		this.stopAtValue = stopAtValue;
		this.groupName = groupName;
		this.resultTime = resultTime;
		this.userNo = userNo;
		this.userState = userState;
		this.rouletteStoreInfo = rouletteStoreInfo;
		this.groupNo = groupNo;
	}

	public int getRandomNo() {
		return randomNo;
	}

	public void setRandomNo(int randomNo) {
		this.randomNo = randomNo;
	}

	public String getStoreInfo() {
		return storeInfo;
	}

	public void setStoreInfo(String storeInfo) {
		this.storeInfo = storeInfo;
	}

	public int getStopAtValue() {
		return stopAtValue;
	}

	public void setStopAtValue(int stopAtValue) {
		this.stopAtValue = stopAtValue;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getResultTime() {
		return resultTime;
	}

	public void setResultTime(String resultTime) {
		this.resultTime = resultTime;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getUserState() {
		return userState;
	}

	public void setUserState(int userState) {
		this.userState = userState;
	}

	public List<StoreVo> getRouletteStoreInfo() {
		return rouletteStoreInfo;
	}

	public void setRouletteStoreInfo(List<StoreVo> rouletteStoreInfo) {
		this.rouletteStoreInfo = rouletteStoreInfo;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	@Override
	public String toString() {
		return "RandomVo [randomNo=" + randomNo + ", storeInfo=" + storeInfo + ", stopAtValue=" + stopAtValue
				+ ", groupName=" + groupName + ", resultTime=" + resultTime + ", userNo=" + userNo + ", userState="
				+ userState + ", rouletteStoreInfo=" + rouletteStoreInfo + ", groupNo=" + groupNo + "]";
	}
	
}
