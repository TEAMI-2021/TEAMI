package org.teami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.teami.domain.BoardReadVO;
import org.teami.domain.Criteria;
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
		
		log.info("諛� �벑濡�......"+room);
		
		
		service.register(room);
		
		rttr.addFlashAttribute("result", room.getRoom_code());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/newRoom")
	public void newRoom(Model model) {
		int max = 1000;
		String room_code;
		while(true) {
			// �엫�쓽濡� 3�옄由� �젙�닔濡� 諛� 肄붾뱶 �옟�븘 �넃�쓬, 以묐났 諛⑹� �옉�뾽�� �븘吏� �븞�븿
			room_code = String.format("%03d",(int)(Math.random() * max)); // 0 ~ max-1 源뚯��쓽 �젙�닔 媛믪쓣 �깮�꽦 
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
			return "redirect:/room/findRoom";
		}
		else if(result==1){
			rttr.addFlashAttribute("result", result);
			service.addMember(roomMember);	
		}
		return "redirect:/board/list";
	}
	
	
	@GetMapping("/deleteRoom")
	public String deleteRoom(@RequestParam("user_id") String user_id, @RequestParam("room_code") String room_code, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("deleteRoom: " + room_code + "user_id: " + user_id);

		service.deleteRoom(user_id, room_code);
		
		return "redirect:/board/list";
		
	}
}
