package org.teami.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	   "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	   "file:src/main/webapp/WEB-INF/spring/security-context.xml"
	})
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
//	
//	@Test
//	public void testExist() {
//		
//		log.info(service);
//		assertNotNull(service);
//	}
//	
	@Test
	public void testRegister() {
		
		BoardVO board = new BoardVO();
		board.setTitle("새 제목");
		board.setContent("새 내용");
		board.setWriter("newbie");
		
		service.register(board);
		
		log.info("생성된 게시물의 번호: " + board.getBno());
	}
	
	@Test
	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
	}
//
//	@Test
//	public void testGet() {
//		
//		log.info(service.get(1L));
//	}
//	
//	@Test
//	public void testUpdate() {
//		
//		BoardVO board = service.get(1L);
//		
//		if (board == null) {
//			return;
//		}
//		board.setTitle("제목 수정합니다");
//		log.info("MODIFY RESULT: " + service.modify(board));
	
//	}	
	
	@Test
	public void testDelete() {
		
		// 게시물 번호의 존대 여부를 확인하고 테스트할 것
		log.info("REMOVE RESULT: " + service.remove(7L));
	}

}
