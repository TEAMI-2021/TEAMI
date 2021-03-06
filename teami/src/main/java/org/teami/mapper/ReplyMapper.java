package org.teami.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.teami.domain.BoardReadVO;
import org.teami.domain.Criteria;
import org.teami.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int delete(Long targetRno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging (@Param("cri") Criteria cri, @Param("bv") BoardReadVO bv);
}
