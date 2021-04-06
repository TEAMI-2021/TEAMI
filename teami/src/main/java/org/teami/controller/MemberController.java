package org.teami.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.teami.domain.Criteria;
import org.teami.domain.MemberVO;
import org.teami.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
//@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	private MemberService service;
	
	@PostMapping("/joinIn")
	public String joinIn(MemberVO member, RedirectAttributes rttr) {
		
		int result = service.memberChk(member.getUser_id());
		if(result==0) {

			rttr.addFlashAttribute("result", result);
			service.joinIn(member);
		}
		else if(result==1){

			rttr.addFlashAttribute("result", result);
			return "redirect:/joinIn";
		}
		return "redirect:/login";
	}
	
	@GetMapping("/joinIn")
	public void joinIn() {
		
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied: " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	//login
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: " + error);
		log.info("logout: "+ logout);
		
		if(error!=null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout!=null) {
			model.addAttribute("logout", "Logout!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
	}
	
	@ResponseBody
	@RequestMapping(value="/memberChk", method=RequestMethod.GET)
	public int memberChk(String user_id) {

		System.out.println(user_id);
		
		int result = service.memberChk(user_id);

		System.out.println(result);
		
		return result;

	}
	
	@ResponseBody
	@RequestMapping(value="/pwChk", method=RequestMethod.POST)
	public int pwChk(String user_pw) {

		System.out.println(user_pw);
		
		int result = service.pwChk(user_pw);

		System.out.println(result);
		
		return result;

	}
	
	@GetMapping("/userInfo")
	public void userInfo() {
		
	}
	
	@GetMapping("/deleteUser")
	public String deleteUser(@RequestParam("user_id") String user_id) {
		
		log.info("user_id: " + user_id);

		service.deleteUser(user_id);
		
		return "redirect:/login";
		
	}
	
	@PostMapping("/updatePw")
    public String updatePW(MemberVO member, RedirectAttributes rttr) {	
        log.info("updatePW: " + member.getUser_pw());
        service.updatePW(member);
     		
		return "redirect:/board/list";
	}
}
