package com.lunchwb.vo;

import java.util.Date;
import java.util.List;

public class VoteVo {
	
	//////////////////// vote table ///////////////////////////
	
	private int voteNo;
	private int voteMadeUser;
	private int groupNo;
	private Date voteEndTime;
	private String voteItems;
	private String voteResults;
	private int voteState; // userState랑 거의 동일한 내용으로 1: 투표중, 3: 투표 종료, 4: 방문 완료
	private double currX;
	private double currY;
	
	//////////////////// vote_members table ////////////////////
	
	private int voteMemberNo;
	// private int voteNo; (vote table fk)
	private Integer userNo;
	private String userName;
	private int voteVoted; // 투표 안함: 0; 투표함: 투표한 가게 storeNo
	private String voteIp;
	
	
	///////////// 투표에서 사용 //////////////////////////////////////////
	
	private Integer userGrade;
	private List<StoreVo> voteStoreInfo;
	private List<Integer> voteResultList;
	private String groupName;
	
	/////////// 투표 처리 //////////////////////////////////////
	
	private int voteIdx;
	private int totCnt;
	private int votedCnt;
	
	/////////// 투표 수정, 여기갈래요 ////////////////////////////////////////////
	
	private int bossCheck;
	private List<Integer> voteMember;
	private int storeNo;
	private int voteVotedIdx;
	
	////////// 생성자 ////////////////////////////////////////////
	
	public VoteVo() {
		
	}
	
	/////////// getter setter ////////////////////////////////

	public int getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(int voteNo) {
		this.voteNo = voteNo;
	}

	public int getVoteMadeUser() {
		return voteMadeUser;
	}

	public void setVoteMadeUser(int voteMadeUser) {
		this.voteMadeUser = voteMadeUser;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public Date getVoteEndTime() {
		return voteEndTime;
	}

	public void setVoteEndTime(Date voteEndTime) {
		this.voteEndTime = voteEndTime;
	}

	public String getVoteItems() {
		return voteItems;
	}

	public void setVoteItems(String voteItems) {
		this.voteItems = voteItems;
	}

	public String getVoteResults() {
		return voteResults;
	}

	public void setVoteResults(String voteResults) {
		this.voteResults = voteResults;
	}

	public int getVoteMemberNo() {
		return voteMemberNo;
	}

	public void setVoteMemberNo(int voteMemberNo) {
		this.voteMemberNo = voteMemberNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getVoteState() {
		return voteState;
	}

	public void setVoteState(int voteState) {
		this.voteState = voteState;
	}

	public int getVoteVoted() {
		return voteVoted;
	}

	public void setVoteVoted(int voteVoted) {
		this.voteVoted = voteVoted;
	}

	public Integer getUserGrade() {
		return userGrade;
	}

	public void setUserGrade(Integer userGrade) {
		this.userGrade = userGrade;
	}
	
	public List<StoreVo> getVoteStoreInfo() {
		return voteStoreInfo;
	}

	public void setVoteStoreInfo(List<StoreVo> voteStoreInfo) {
		this.voteStoreInfo = voteStoreInfo;
	}
	
	public List<Integer> getVoteResultList() {
		return voteResultList;
	}

	public void setVoteResultList(List<Integer> voteResultList) {
		this.voteResultList = voteResultList;
	}
	
	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}
	
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public int getVoteIdx() {
		return voteIdx;
	}

	public void setVoteIdx(int voteIdx) {
		this.voteIdx = voteIdx;
	}
	
	public Integer getUserNo() {
		return userNo;
	}	
	
	public int getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	public int getVotedCnt() {
		return votedCnt;
	}

	public void setVotedCnt(int votedCnt) {
		this.votedCnt = votedCnt;
	}
	
	public String getVoteIp() {
		return voteIp;
	}

	public void setVoteIp(String voteIp) {
		this.voteIp = voteIp;
	}
	
	public int getBossCheck() {
		return bossCheck;
	}

	public void setBossCheck(int bossCheck) {
		this.bossCheck = bossCheck;
	}
		
	public List<Integer> getVoteMember() {
		return voteMember;
	}

	public void setVoteMember(List<Integer> voteMember) {
		this.voteMember = voteMember;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}
	
	public int getVoteVotedIdx() {
		return voteVotedIdx;
	}

	public void setVoteVotedIdx(int voteVotedIdx) {
		this.voteVotedIdx = voteVotedIdx;
	}
	
	public double getCurrX() {
		return currX;
	}

	public void setCurrX(double currX) {
		this.currX = currX;
	}

	public double getCurrY() {
		return currY;
	}

	public void setCurrY(double currY) {
		this.currY = currY;
	}
	
	///////////// toString //////////////////////////////////////////
	
	@Override
	public String toString() {
		return "VoteVo [voteNo=" + voteNo + ", voteMadeUser=" + voteMadeUser + ", groupNo=" + groupNo + ", voteEndTime="
				+ voteEndTime + ", voteItems=" + voteItems + ", voteResults=" + voteResults + ", voteState=" + voteState
				+ ", voteMemberNo=" + voteMemberNo + ", userNo=" + userNo + ", userName=" + userName + ", voteVoted="
				+ voteVoted + ", userGrade=" + userGrade + ", voteStoreInfo=" + voteStoreInfo + ", voteResultList="
				+ voteResultList + ", groupName=" + groupName + "]";
	}

}
