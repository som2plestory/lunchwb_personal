package com.lunchwb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lunchwb.dao.GroupDao;
import com.lunchwb.dao.NotiDao;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.NotificationVo;

@Service
public class NotiService {
	
	@Autowired
	private NotiDao notiDao;
	@Autowired
	private GroupDao groupDao;
	
	
	/* 알림 개수 */
	public int notiCount(int userNo) {
		return notiDao.notiCount(userNo);
	}
	
	
	/* 추가된 알림리스트 */
	public List<NotificationVo> notiList(NotificationVo notiVo){
		return notiDao.notiList(notiVo);
	}
	
	
	/* 그룹 초대 수락 */
	public String inviteOk(NotificationVo notiVo) {
		
		GroupVo groupVo = new GroupVo();
		groupVo.setUserNo(notiVo.getSendUser());
		groupVo.setGroupNo(notiVo.getGroupNo());
		groupVo.setGroupOrder(notiVo.getGroupOrder());
		
		//부장님 수락
		if(notiVo.getNotiType() == 10) {
			groupVo.setBossCheck(1);
		
		}else {
			groupVo.setBossCheck(0);
		}
		
		//그룹원 추가
		groupDao.addMember(groupVo);
		
		//알림 상태 변경
		if(notiDao.notiChangeToCheck(notiVo.getNotiNo()) > 0) {
			//수락 알림 회신 noti : 2
			notiVo.setNotiType(2);
			
			notiDao.addGroupReNoti(notiVo);
			
			return "success";
		}
		
		return "fail";
	}
	
	
	/* 그룹 초대 거절 */
	public String inviteReject(NotificationVo notiVo) {
		//알림 상태 변경
		if(notiDao.notiChangeToCheck(notiVo.getNotiNo()) > 0){
			// 거절 알림 회신 noti : 3
			notiVo.setNotiType(3);
			
			notiDao.addGroupReNoti(notiVo);
			
			return "success";
		}
		
		return "fail";
	}
	
	
	/* 알림 단순 확인 */
	public String alertCheck(int notiNo) {
		//알림 상태 변경
		if(notiDao.notiChangeToCheck(notiNo) > 0) {
			return "success";
		
		}else {
			return "fail";
		}
	}
	
}
