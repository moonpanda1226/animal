package org.sh.dto;
//글쓰기할때 사용할 DTO

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WriteDTO {
	private int board_no;
	private String title, content, write, mid, ip;
}
