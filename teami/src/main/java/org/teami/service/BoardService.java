package org.teami.service;

import java.util.List;

import org.teami.domain.BoardReadVO;
import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(BoardReadVO boardRead);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(BoardReadVO boardRead);
	
	public List<BoardVO> getList(String room_code);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public List<BoardVO> getNoticeListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public int getNoticeTotal(Criteria cri);

	public List<BoardVO> getSearch(Criteria cri);
}
