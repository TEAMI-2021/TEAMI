package org.teami.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;

public interface RoomMapper {

	public List<RoomVO> getList(String user_id);
	
	public RoomVO read(String room_code);
	
	public void insert(RoomVO room);
	
	public void createRoomBoard(@Param("room_code") String room_code);
	
	public void insertRoomMember(RoomVO room);
	
	public void insertRoomMember(RoomMemberVO roomMember);
	
	public int roomChk(String room_code);
	
	public void deleteRoom(String user_id, String room_code);
}
