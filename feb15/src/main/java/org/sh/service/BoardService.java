package org.sh.service;

import java.util.List;

import org.sh.dao.BoardDAO;
import org.sh.dto.BoardDTO;
import org.sh.dto.CommentDTO;
import org.sh.dto.WriteDTO;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService extends AbstractService{

	@Autowired
	private BoardDAO boardDAO;
	
	
	public List<BoardDTO> boardList(int pageNo){
		return boardDAO.boardList(pageNo);
	}

	public BoardDTO detail(int no) {
		//읽음수 올리기 2024-02-22일 psd 요구사항 확인 
		//로그인 했어? -> 읽음 수 올리기 22일
		if(util.getSession().getAttribute("mid") != null) {
			//DTO 객체 만들기 = 번호 + 아이디 22일
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(no);
			dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
			//int result = boardDAO.alreadyRead(dto);
			//if(result == 0) {//이미 읽었는지 검사하기 22일 
				boardDAO.countUP(dto);	
		}
		return boardDAO.detail(no);
	}

	public int write(WriteDTO dto) {
		//HttpServletRequest request = util.req();
		//HttpSession session = util.getSession();
		//엔터키 처리 
		dto.setContent(dto.getContent().replaceAll("\n\r", "<br>"));
		dto.setMid((String) util.getSession().getAttribute("mid"));
		dto.setIp(util.getIP());
		return boardDAO.write(dto);
	}

	public int commentWrite(CommentDTO comment) {
		//comment.setMid("leesu");
		comment.setMid((String) util.getSession().getAttribute("mid"));
		comment.setCip(util.getIP());
		return boardDAO.commentWrite(comment);
	}

	public List<CommentDTO> commentsList(int reNo) {
		return boardDAO.commemtsList(reNo);
	}

	public int postDel(int no) {
		WriteDTO dto = new WriteDTO();
		dto.setBoard_no(no);
		dto.setMid((String) util.getSession().getAttribute("mid"));
		
		return boardDAO.postDel(dto);
	}
	public int totalRecordCount() {
		return boardDAO.totalRecordCount();
	}

	public int deleteComment(int no, int cno) {
		CommentDTO dto = new CommentDTO();
		dto.setNo(cno);
		dto.setBoard_no(no);
		dto.setMid((String) util.getSession().getAttribute("mid"));
		return boardDAO.deleteComment(dto);
	}
	
	public int likeUp(CommentDTO dto ) {
		return boardDAO.likeUp(dto);
	}
	
}