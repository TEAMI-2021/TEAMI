package org.teami.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.teami.domain.BoardReadVO;
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
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList("411").forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새 제목");
		board.setContent("새 내용");
		board.setWriter("newbie");
		board.setRoom_code("411");
		for(int i=0; i<300; i++) {
			mapper.insert(board);
		}
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새 제목 select key");
		board.setContent("새 내용 select key");
		board.setWriter("newbie");
		board.setRoom_code("411");
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
//	
	@Test
	public void testRead() {
		BoardReadVO br = new BoardReadVO();
		br.setBno(4L);
		br.setRoom_code("411");
		
		// 존래하는 게시물 번호로 테스트
		BoardVO board = mapper.read(br);
		
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		BoardReadVO br = new BoardReadVO();
		br.setBno(3L);
		br.setRoom_code("411");
		log.info("DELETE COUNT: " + mapper.delete(br));
	}
	
	@Test
	public void testUpdate() {
		
		BoardVO board = new BoardVO();
		// 실행전 존재하는 번호인지 확인할 것
		board.setBno(600L);
		board.setTitle("수정 제목");
		board.setContent("수정 내용");
		board.setWriter("user00");

		int count = mapper.update(board);
		
		log.info("UPDATE COUNT: " + count);
	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		cri.setRoom_code("411");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getBno()));
	}
	
	@Test
	public void testNoticePaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		cri.setRoom_code("346");
		List<BoardVO> list = mapper.getNoticeListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getBno()));
	}
	
	@Test
	public void testNoticeTotal() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		cri.setRoom_code("346");
		
		log.info(mapper.getNoticeTotalCount(cri));
	}
	/*
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("4");
		cri.setType("TC");;
		
		List<BoardVO> list = mapper.getSearch(cri);
		
		list.forEach(board -> log.info(board));
	}
	*/
}
