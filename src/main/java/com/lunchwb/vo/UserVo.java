package com.lunchwb.vo;

import java.util.Date;

public class UserVo {
	
	//////////////////// users table ////////////////////
	
	private int userNo;
	private String userEmail;
	private String userPassword;
	private String userName;
	private int userBirthYear;
	private String userSex;
	private String userJoinDate;
	private int userGrade;
	
	
	/* 투표 전(기본) 0 / 투표 중 1 / 나는 투표 했지만 투표 결과가 안나옴 2 / 투표 종료(결과 나옴) 3 / 방문 완료 4 / 투표수정중 99 */ 
	private int userState;
	
	
	/* 자동 로그인 */
	private String sessionId;
	private Date limitDate;
	private boolean autoLogin;
	
	
	/* SNS 로그인 */
	private String snsLogin;

	public UserVo() {
		super();
	}

	public UserVo(int userNo, String userEmail, String userPassword, String userName, int userBirthYear, String userSex,
			String userJoinDate, int userGrade, int userState, String sessionId, Date limitDate, boolean autoLogin,
			String snsLogin) {
		super();
		this.userNo = userNo;
		this.userEmail = userEmail;
		this.userPassword = userPassword;
		this.userName = userName;
		this.userBirthYear = userBirthYear;
		this.userSex = userSex;
		this.userJoinDate = userJoinDate;
		this.userGrade = userGrade;
		this.userState = userState;
		this.sessionId = sessionId;
		this.limitDate = limitDate;
		this.autoLogin = autoLogin;
		this.snsLogin = snsLogin;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserBirthYear() {
		return userBirthYear;
	}

	public void setUserBirthYear(int userBirthYear) {
		this.userBirthYear = userBirthYear;
	}

	public String getUserSex() {
		return userSex;
	}

	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}

	public String getUserJoinDate() {
		return userJoinDate;
	}

	public void setUserJoinDate(String userJoinDate) {
		this.userJoinDate = userJoinDate;
	}

	public int getUserGrade() {
		return userGrade;
	}

	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}

	public int getUserState() {
		return userState;
	}

	public void setUserState(int userState) {
		this.userState = userState;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public Date getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(Date limitDate) {
		this.limitDate = limitDate;
	}

	public boolean isAutoLogin() {
		return autoLogin;
	}

	public void setAutoLogin(boolean autoLogin) {
		this.autoLogin = autoLogin;
	}

	public String getSnsLogin() {
		return snsLogin;
	}

	public void setSnsLogin(String snsLogin) {
		this.snsLogin = snsLogin;
	}

	@Override
	public String toString() {
		return "UserVo [userNo=" + userNo + ", userEmail=" + userEmail + ", userPassword=" + userPassword
				+ ", userName=" + userName + ", userBirthYear=" + userBirthYear + ", userSex=" + userSex
				+ ", userJoinDate=" + userJoinDate + ", userGrade=" + userGrade + ", userState=" + userState
				+ ", sessionId=" + sessionId + ", limitDate=" + limitDate + ", autoLogin=" + autoLogin + ", snsLogin="
				+ snsLogin + "]";
	}

	

	
}