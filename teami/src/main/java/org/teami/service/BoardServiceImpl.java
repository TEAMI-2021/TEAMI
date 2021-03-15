package org.teami.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.teami.domain.BoardAttachVO;
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
		BoardReadVO br = new BoardReadVO();
		br.setBno(board.getBno());
		br.setRoom_code(board.getRoom_code());
		
		
		attachMapper.deleteAll(br);
		
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getAttachList()!=null&&board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attach.setRoom_code(board.getRoom_code());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Override
	public boolean remove(BoardReadVO boardRead) {

		log.info("remove................." + boardRead.getBno());
		attachMapper.deleteAll(boardRead);
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
		if(cri.getKeyword()==null) {
			return mapper.getTotalCount(cri);
		}else {
			return mapper.getTotalSearchCount(cri);
		}
		
	}

	@Override
	public List<BoardVO> getSearch(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getSearch(cri);
	}

	@Override
	public List<BoardVO> getNoticeListWithPaging(Criteria cri) {
		List<BoardVO> boardList = mapper.getNoticeListWithPaging(cri);
		return boardList;
	}

	@Override
	public int getNoticeTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getNoticeTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(BoardReadVO br) {
		// TODO Auto-generated method stub
		return attachMapper.findByBno(br);
	}
	
}
