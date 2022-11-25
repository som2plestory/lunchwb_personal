package com.lunchwb.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.lunchwb.service.InquiryService;
import com.lunchwb.vo.InquiryVo;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController {
	
	@Autowired
	private InquiryService inquiryService;
	
	// ============================================ FAQ 폼 ============================================
	@GetMapping("/faq")
	public String faqForm(Model model) {
		
		Map<String,Object> fMap = inquiryService.divFaqList();
		model.addAttribute("fMap",fMap);
		
		return "customer/FAQ";
	};
	
	@GetMapping("/manageFaq")
	public String manageFaqForm(Model model) {
		
		Map<String,Object> fMap = inquiryService.divFaqList();
		model.addAttribute("fMap",fMap);
		
		return "customer/manageFAQ";
	};
	
	
	// ============================================ 문의작성 폼 ============================================
	@GetMapping("/writeInquiry")
	public String writeInquiryForm() {
		
		return "customer/writeInquiry";
	};
	
	// MultipartFile 형식 데이터 받기용
	@PostMapping("/writeInquiry")
	public String writeInquiry(@ModelAttribute InquiryVo inqVo, @RequestPart(value = "file", required = false) MultipartFile file) {
		
		inquiryService.writeInquiry(inqVo,file);
		
		return "redirect:/customer/reviewReport/"+inqVo.getUserNo();
	};
	
	// ============================================ 문의내역 폼 ============================================
	@GetMapping("/reviewReport/{userNo}")
	public String reviewReportForm(@PathVariable("userNo") int userNo, Model model) {
		
		List<InquiryVo> inqList= inquiryService.userInqList(userNo);
		model.addAttribute("inqList", inqList);
		
		return "customer/reviewReport";
	};
	
	@PostMapping("/reviewReport")
	public String reviewSearch() {
			
		return "customer/reviewReport";
	};
	
	// ============================================ 문의상세보기 폼 ============================================
	@RequestMapping(value = "/readInquiryForm/{inquiryNo}", method= {RequestMethod.GET,RequestMethod.POST})
	public String readInquiryForm(@PathVariable("inquiryNo") int inquiryNo, Model model) {
		
		InquiryVo inqVo = inquiryService.readInquiry(inquiryNo);
		model.addAttribute("inqVo",inqVo);
		
		return "customer/readInquiry";
	};

}
