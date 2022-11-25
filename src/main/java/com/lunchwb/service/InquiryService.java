package com.lunchwb.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lunchwb.dao.FaqDao;
import com.lunchwb.dao.InquiryDao;
import com.lunchwb.vo.FaqVo;
import com.lunchwb.vo.InquiryVo;

@Service
public class InquiryService {
	
	@Autowired
	private FaqDao faqDao;
	
	@Autowired
	private InquiryDao inquiryDao;
	
	// ================================ FAQ목록 불러오기 ================================
	public Map<String,Object> divFaqList(){
		
		List<FaqVo> faqList = faqDao.faqList();					// 모든 FAQ목록
		
		List<FaqVo> faqQuestList = new ArrayList<FaqVo>();		// 자주 찾는 질문
		List<FaqVo> faqHelpList = new ArrayList<FaqVo>();		// 문의 유형별 도움말
		
		// faqStatus로 자주찾는질문, 문의유형별도움말 구분
		for (int i = 0; i < faqList.size(); i++) {
			if (faqList.get(i).getFaqStatus().equals("help")) {
				faqHelpList.add(faqList.get(i));
				
			} else if(faqList.get(i).getFaqStatus().equals("quest")){
				faqQuestList.add(faqList.get(i));
			}
		};
		
		
		Map<String, Object> fMap = new HashMap<String,Object>();
		fMap.put("qList", faqQuestList);
		fMap.put("hList", faqHelpList);
		
		return fMap;
	};
	
	
	// ================================ 개인유저 문의내역 ================================
	public List<InquiryVo> userInqList(int userNo){
		List<InquiryVo> inqList = inquiryDao.userInqList(userNo);
		
		return inqList;
	};
	
	// ================================ 개인유저 문의하기(이미지 첨부 구분) ================================
	public int writeInquiry(InquiryVo inqVo,MultipartFile file) {
		
		int count = 0;
		
		String saveDir = "C:\\javaStudy\\upload";							//윈도우용
		//String saveDir = "/Users/choijungphil/javaStudy/upload";			//맥OS용
		String orgName = "";
		String saveName = "";

		if (file.getOriginalFilename().equals("")) {	//파일 없는 경우 방지
			inqVo.setInquiryFilePath(saveName);

			// (1)다오로 보내서 DB 업데이트
			count = inquiryDao.writeInquiry(inqVo);

		} else {	// 파일업로드 할 때 작용
			// 오리지널 파일명
			orgName = file.getOriginalFilename();

			// 확장자명 가져오기
			String exName = orgName.substring(orgName.lastIndexOf("."));

			// 드라이브에 저장할 파일명
			saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;

			// 파일경로(디렉토리+저장파일명)
			String filePath = saveDir + "\\" + saveName;					//윈도우용
			//String filePath = saveDir + "/" + saveName;					//맥OS용
			
			inqVo.setInquiryFilePath(saveName);

			// (1)다오로 보내서 DB 업데이트
			count = inquiryDao.writeInquiry(inqVo);

			// (2)파일저장
			try {
				byte[] fileData = file.getBytes();
				OutputStream os = new FileOutputStream(filePath);
				BufferedOutputStream bos = new BufferedOutputStream(os);

				bos.write(fileData);
				bos.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return count;
	};
	
	// ================================ 문의 클릭시 해당 문의정보 ================================
	public InquiryVo readInquiry(int inquiryNo) {
		InquiryVo inqVo = inquiryDao.getInq(inquiryNo);
		
		return inqVo;
	};
	

}
