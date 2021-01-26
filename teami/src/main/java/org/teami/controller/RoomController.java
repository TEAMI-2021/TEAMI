package org.teami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;
import org.teami.service.RoomService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/room/*")
@AllArgsConstructor
public class RoomController {
	
	private RoomService service;
	
	@PostMapping("/newRoom")
	public String register(RoomVO room, RedirectAttributes rttr) {
		
		log.info("방 등록......"+room);
		
		
		service.register(room);;
		
		rttr.addFlashAttribute("result", room.getRoom_code());
		
		return "redirect:/";
	}
	
	@GetMapping("/newRoom")
	public void newRoom(Model model) {
		int max = 1000;
		String room_code;
		while(true) {
			// 임의로 3자리 정수로 방 코드 잡아 놓음, 중복 방지 작업은 아직 안함
			room_code = String.format("%03d",(int)(Math.random() * max)); // 0 ~ max-1 까지의 정수 값을 생성 
			int i = service.roomChk(room_code);
			if(i==0) {
				break;
			}
		}
		
		model.addAttribute("room_code", room_code);
	}
	
	@GetMapping("/findRoom")
	public void findRoom() {
		
	}
	
	@PostMapping("/findRoom")
	public String findRoom(RoomMemberVO roomMember, RedirectAttributes rttr) {
		int result = service.roomChk(roomMember.getRoom_code());
		if(result==0) {
			rttr.addFlashAttribute("result", result);
			return "/room/findRoom";
		}
		else if(result==1){
			rttr.addFlashAttribute("result", result);
			service.addMember(roomMember);	
		}
		return "redirect:/";
	}
	
	
}
