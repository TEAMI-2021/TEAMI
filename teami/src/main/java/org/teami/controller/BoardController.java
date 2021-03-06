package org.teami.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.teami.domain.AttachFileDTO;
import org.teami.domain.BoardAttachVO;
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
	public <Char> void list(@RequestParam(value="room_code", required=false) String room_code,@RequestParam(value="notice", required=false) String notice,@RequestParam(value="attach", required=false) String attach, Criteria cri, Principal principal, Model model) {		
		if(room_code == null && notice == null && attach==null) {
			List<RoomVO> roomList = roomService.getList(principal.getName());
			List<BoardVO> boardList = new ArrayList<BoardVO>();
			List<BoardVO> boardList2 = new ArrayList<BoardVO>();
			int total=0;
			for(int i=0; i<roomList.size(); i++) {
				String room=roomList.get(i).getRoom_code();
				cri.setRoom_code(room);
				if(cri.getKeyword()==null) {
					boardList.addAll(service.getList(room));
					
				}
				else {
					boardList.addAll(service.getSearch(cri));
				}
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
			model.addAttribute("cri", cri);
		}
		else if(notice==null&&attach==null){
			log.info("list: " + cri);
			model.addAttribute("list", service.getListWithPaging(cri));
			model.addAttribute("room_code", room_code);
//			model.addAttribute("pageMaker", new PageDTO(cri, 123));
			int total = service.getTotal(cri);
			
			log.info("total: " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		}
		else if(notice==null) {
			model.addAttribute("list", service.getAttachListWithPaging(cri));
			model.addAttribute("room_code", room_code);
			
			int attachTotal = service.getAttachTotal(cri);
			
			model.addAttribute("pageMaker", new PageDTO(cri, attachTotal));
		}else{
			model.addAttribute("list", service.getNoticeListWithPaging(cri));
			model.addAttribute("room_code", room_code);
			
			int noticeTotal = service.getNoticeTotal(cri);
			
			model.addAttribute("pageMaker", new PageDTO(cri, noticeTotal));
		}
		

		model.addAttribute("roomList", roomService.getList(principal.getName()));
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("=============================================");
		log.info("register: " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> attach.setRoom_code(board.getRoom_code()));
		}
		
		log.info("=============================================");
		
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
		model.addAttribute(cri);
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
		List<BoardAttachVO> attachList = service.getAttachList(br);
		if (service.remove(br)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	public void register(Principal principal, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("roomList", roomService.getList(principal.getName()));
		model.addAttribute(cri);
	}
	

	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax post.....................");
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		//make folder
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("uploadPath: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
//			log.info("-----------------------------------------------");
//			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
//			log.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				list.add(attachDTO);
			} catch (Exception e) {
//				log.error(e.getMessage());
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName) {
		
		log.info("delete fileName: " + fileName);
		
		File file;
		
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(BoardReadVO br){
		return new ResponseEntity<>(service.getAttachList(br), HttpStatus.OK);
	}
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
		log.info("resource: "+resource);
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName=null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE Browser");
				downloadName=URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			}else if(userAgent.contains("Edge")) {
				log.info("Edge Browser");
				downloadName=URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name: "+downloadName);
			}else {
				log.info("Chrome browser");
				downloadName=new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size()==0) {
			return;
		}
		log.info("delete attach files......................");
		log.info(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				
			}catch(Exception e){
				log.error("delete file eroor"+e.getMessage());
			}
		});
	}
}
