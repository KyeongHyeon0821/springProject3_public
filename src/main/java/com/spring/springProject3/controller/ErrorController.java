package com.spring.springProject3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	
	@RequestMapping(value = "/error400", method = RequestMethod.GET)
	public String error400Get() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/error405", method = RequestMethod.POST)
	public String error405Post() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/error500", method = RequestMethod.POST)
	public String error500Post() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/errorNullPointerException", method = RequestMethod.GET)
	public String errorNullPointerExceptionGet() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/errorNumberFormatException", method = RequestMethod.GET)
	public String errorNumberFormatExceptionGet() {
		return "errorPage/error";
	}
	
	@RequestMapping(value = "/errorArrayIndexOutOfBoundsException", method = RequestMethod.GET)
	public String errorArrayIndexOutOfBoundsExceptionGet() {
		return "errorPage/error";
	}
	
}
