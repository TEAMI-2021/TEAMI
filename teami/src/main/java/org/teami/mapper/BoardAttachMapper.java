package org.teami.mapper;

import java.util.List;

import org.teami.domain.BoardAttachVO;
import org.teami.domain.BoardReadVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(BoardReadVO br);
	
	public void deleteAll(BoardReadVO br);
}
