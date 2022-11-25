package com.lunchwb.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.lunchwb.vo.UserVo;

@Repository
public class WebSocketHandler extends TextWebSocketHandler {
			
	@Autowired 
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		logger.info("Socket 연결  -->{}" + currentUserId(session));
		sessions.add(session);
		userSessionsMap.put(currentUserId(session),session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		
		if(msg != null) {
			String[] msgs = msg.split(",");
			if(msgs != null && msgs.length == 2) {
				String receiver = msgs[0];//수신인
				int notiType = Integer.parseInt(msgs[1]); //알림타입
				String receiverId = sqlSession.selectOne("user.alertReceiver", receiver); //수신인아이디
				String comment = "";
				
				System.out.println("알림타입: "+notiType);
				
				if(notiType == 1 || notiType == 10) { //초대를 받았던거야
					comment = "그룹 초대 답변이 도착했습니다.";
				
				}else if(notiType == 0) { //초대를 보냈어
					comment = "그룹 초대가 도착했습니다.";
				
				}else { //그룹이름이 바뀜
					comment = "새로운 알림이 도착했습니다.";
				}
				WebSocketSession receiversession = userSessionsMap.get(receiverId);//수신인이 현재 접속중인가 체크
				if(receiversession !=null) {
					TextMessage txtmsg = new TextMessage(comment);
					receiversession.sendMessage(txtmsg);//보내기
					/*
					 * }else { TextMessage txtmsg = new TextMessage(comment);
					 * session.sendMessage(txtmsg);//보내지는지 체크하기
					 */				}
			}
			
		}
			
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		logger.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(currentUserId(session),session);
	}
	
	
	private String currentUserId(WebSocketSession session) {
		Map<String,Object> map = session.getAttributes();  
		
		UserVo authUser = (UserVo)map.get("authUser");  
		String mid = authUser.getUserEmail();
		
		return mid;
	}
}