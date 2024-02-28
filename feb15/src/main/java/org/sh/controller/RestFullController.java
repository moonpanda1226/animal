package org.sh.controller;

import org.apache.ibatis.annotations.Param;
import org.sh.dto.BoardDTO;
import org.sh.service.BoardService;
import org.sh.service.RestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestFullController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RestService restService;

	@PostMapping("/restDetail")
	public BoardDTO restDetail(@Param("no") int no) {
		//System.out.println("restDetail : " + no);
		BoardDTO detail = boardService.detail(no);
		
		//System.out.println(detail.getBoard_title());
		//System.out.println(detail.getBoard_content());
		
		return detail;
	}
	
	@PostMapping("/emailAuth")
	public int emailAuth() {
		
		return restService.sendEmail();
	}
}
