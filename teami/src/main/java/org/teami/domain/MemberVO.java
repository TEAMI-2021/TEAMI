package org.teami.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private boolean enabled;
	
	private String auth;
	
	private List<AuthVO> authList;
	
}
