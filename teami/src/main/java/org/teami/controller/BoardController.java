package org.teami.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.teami.domain.BoardReadVO;
import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;
import org.teami.domain.PageDTO;
import org.teami.domain.RoomVO;
import org.teami.service.BoardService;
import org.teami.service.RoomService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController{

	private BoardService service;
	private RoomService roomService;
//	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		model.addAttribute("list", service.getList());		
//	}
	
	class regDateCompare implements Comparator<BoardVO>{

		@Override
		public int compare(BoardVO o1, BoardVO o2) {
			// TODO Auto-generated method stub
			return o1.getRegdate().compareTo(o2.getRegdate());
		}
	}
	
	@GetMapping("/list")
	public void list(@RequestParam(value="room_code", required=false) String room_code,@RequestParam(value="notice", required=false) String notice, Criteria cri, Principal principal, Model model) {		
		if(room_code == null && notice == null) {
			List<RoomVO> roomList = roomService.getList(principal.getName());
			List<BoardVO> boardList = new ArrayList<BoardVO>();
			List<BoardVO> boardList2 = new ArrayList<BoardVO>();
			int total=0;
			for(int i=0; i<roomList.size(); i++) {
				String room=roomList.get(i).getRoom_code();
				cri.setRoom_code(room);
				boardList.addAll(service.getList(room));
				for(int j = total; j<boardList.size(); j++) {
					boardList.get(j).setRoom_code(room);
				}
				total = total + service.getTotal(cri);
			}
			Collections.sort(boardList, new regDateCompare());
			Collections.reverse(boardList);
			for(int i=cri.getSkip(); i<cri.getSkip()+cri.getAmount(); i++) {
				if(i==total) {
					break;
				}
				boardList2.add(boardList.get(i));
			}
			model.addAttribute("room_code", null);
			model.addAttribute("list", boardList2);
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		}
		else if(notice==null){
			log.info("list: " + cri);
			model.addAttribute("list", service.getListWithPaging(cri));
			model.addAttribute("room_code", room_code);
//			model.addAttribute("pageMaker", new PageDTO(cri, 123));
			int total = service.getTotal(cri);
			
			log.info("total: " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		}
		else{
			model.addAttribute("list", service.getNoticeListWithPaging(cri));
			model.addAttribute("room_code", room_code);
			
			int noticeTotal = service.getNoticeTotal(cri);
			
			model.addAttribute("pageMaker", new PageDTO(cri, noticeTotal));
		}
		model.addAttribute("roomList", roomService.getList(principal.getName()));
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register: " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno,  @RequestParam("room_code") String room_code, @ModelAttribute("cri") Criteria cri, Model model, Principal principal) {
		
		BoardReadVO br = new BoardReadVO();
		br.setBno(bno);
		br.setRoom_code(room_code);
		
		log.info("get or modify");
		model.addAttribute("board", service.get(br));
		model.addAttribute("roomList", roomService.getList(principal.getName()));
		model.addAttribute("room", roomService.get(room_code));
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify: " + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list?room_code="+board.getRoom_code();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @RequestParam("room_code") String room_code, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove: " + bno);
		
		BoardReadVO br = new BoardReadVO();
		br.setBno(bno);
		br.setRoom_code(room_code);
		
		if (service.remove(br)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	public void register(Principal principal, Model model) {
		model.addAttribute("roomList", roomService.getList(principal.getName()));
	}
	
	
}
