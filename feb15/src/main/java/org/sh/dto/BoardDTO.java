package org.sh.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDTO {
	private int board_no, board_count, comment, mno;
	private String board_title, mname, mid, board_date, board_content, board_ip, board_del;
	//게시판
	//톺아보기
	//글삭제
	//....
}
