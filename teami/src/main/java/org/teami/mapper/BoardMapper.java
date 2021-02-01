package org.teami.mapper;

import java.util.List;

import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;

public interface BoardMapper {

//	select * from tbl_board where bno > 0;
//	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	// 검색
	public List<BoardVO> getSearch(Criteria cri);
}