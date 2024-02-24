package com.feb.join.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.feb.join.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 회원가입 페이지 이동
	 * @return ModelAndView login.jsp
	 */
	@GetMapping("/join-page.do")
	public ModelAndView joinPage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		return mv;
	}
	
	/**
	 * ID 중복 검사
	 * @param memberId 사용자가 입력한 가입하려는 ID
	 * @return ResponseEntity<String> 가입 가능한 ID면 "0"
	 */
	@PostMapping(value = "/confirmId.do", produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> confirmId(String memberId) {
		int cnt = memberService.confirmId(memberId);
		
		return new ResponseEntity<>(cnt+"", HttpStatus.OK);
	}
	
	/**
	 * 회원 가입
	 * @param params 사용자가 입력한 회원 정보
	 * @return int 가입 성공 시 1
	 */
	@PostMapping("/sign-up.do")
	public ModelAndView signUp(@RequestParam HashMap<String, String> params) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		int result = memberService.signUp(params);
		// 가입 성공 시 1, 실패 시 0
		if(result == 1) {
			mv.addObject("resultMsg", "회원 가입 성공");
		} else {
			mv.addObject("resultMsg", "회원 가입 실패");
		}
		return mv;
	}
}
