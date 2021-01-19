package org.teami.domain;


import java.util.List;

import lombok.Data;

@Data
public class RoomVO {
	
	private String room_code;
	private String room_name;
	
	private String user_id;
	
	private List<RoomMemberVO> roomMemberList;
	
}
