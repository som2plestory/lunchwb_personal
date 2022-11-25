package com.lunchwb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/error")
@Controller
public class ErrorController {

	@RequestMapping("/404")
	public String e404() {		
		return "error/404";
	}
	
	@RequestMapping("/403")
	public String e403() {		
		return "error/403";
	}
}
