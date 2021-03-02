package org.teami.service;

import java.util.List;

import org.teami.domain.BoardReadVO;
import org.teami.domain.Criteria;
import org.teami.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);

	public List<ReplyVO> getList(Criteria cri, BoardReadVO bv);

}
