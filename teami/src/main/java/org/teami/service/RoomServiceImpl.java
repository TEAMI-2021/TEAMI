package org.teami.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.teami.domain.BoardVO;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;
import org.teami.mapper.RoomMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RoomServiceImpl implements RoomService{
	
	private RoomMapper mapper;
	
	@Override
	public void register(RoomVO room) {
		log.info("register Room.......");
		mapper.insert(room);
		mapper.insertRoomMember(room);
		mapper.createRoomBoard(room.getRoom_code());
	}

	@Override
	public RoomVO get(String room_code) {
		return mapper.read(room_code);
	}

	@Override
	public void addMember(RoomMemberVO roomMember) {
		mapper.insertRoomMember(roomMember);
	}

	@Override
	public int roomChk(String room_code) {
		return mapper.roomChk(room_code);
	}

	@Override
	public List<RoomVO> getList(String user_id) {
		// TODO Auto-generated method stub
		return mapper.getList(user_id);
	}
	
}
