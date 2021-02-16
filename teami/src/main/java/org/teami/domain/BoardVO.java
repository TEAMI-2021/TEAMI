package org.teami.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
//	long이던 int이던 상관없음 왜?
	private long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	private String room_code;
	private char notice;
}
