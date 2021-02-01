package org.teami.mapper;

import org.apache.ibatis.annotations.Param;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;

public interface RoomMapper {

	public RoomVO read(String room_code);
	
	public void insert(RoomVO room);
	
	public void createRoomBoard(@Param("room_code") String room_code);
	
	public void insertRoomMember(RoomVO room);
	
	public void insertRoomMember(RoomMemberVO roomMember);
	
	public int roomChk(String room_code);
}
