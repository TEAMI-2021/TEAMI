package org.teami.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
		
		//rttr.addFlashAttribute("result", room.getRoom_code());
		
		return "redirect:/";
	}
	
	@GetMapping("/newRoom")
	public void newRoom() {
		
	}
}
