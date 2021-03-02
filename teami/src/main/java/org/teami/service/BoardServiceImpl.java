package org.teami.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.teami.domain.BoardReadVO;
import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;
import org.teami.mapper.BoardAttachMapper;
import org.teami.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	// spring 4.3 �씠�긽�뿉�꽌 �옄�룞 泥섎━

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		
		log.info("resister.........." + board);
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach ->{
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(BoardReadVO boardRead) {
		
		log.info("get.........." + boardRead.getBno());

		return mapper.read(boardRead);
	}

	@Override
	public boolean modify(BoardVO board) {

		log.info("modify............" + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(BoardReadVO boardRead) {

		log.info("remove................." + boardRead.getBno());
		
		return mapper.delete(boardRead) == 1;
	}

	@Override
	public List<BoardVO> getList(String room_code) {
		log.info("getList...........");
		return mapper.getList(room_code);
	}
	
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		log.info("get List wirh Criteria: " + cri);
		List<BoardVO> boardList = mapper.getListWithPaging(cri);
		//for(int i=0; i<boardList.size(); i++) {
		//	boardList.get(i).setRoom_code(cri.getRoom_code());
		//}
		return boardList;
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
}
