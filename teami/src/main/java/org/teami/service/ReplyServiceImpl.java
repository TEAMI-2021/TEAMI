package org.teami.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.teami.domain.BoardReadVO;
import org.teami.domain.Criteria;
import org.teami.domain.ReplyVO;
import org.teami.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	// spring 4.3 이상에서 자동 처리
	
	@Override
	public int register(ReplyVO vo) {
		
		log.info("resister.........." + vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get.........." + rno);

		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {

		log.info("modify............" + vo);
		
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {

		log.info("remove................." + rno);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, BoardReadVO bv) {
		log.info("get Reply List of a Board: " + bv);
		
		return mapper.getListWithPaging(cri, bv);
	}
}
