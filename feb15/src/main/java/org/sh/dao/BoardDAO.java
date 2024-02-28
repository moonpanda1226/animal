package org.sh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.sh.dto.BoardDTO;
import org.sh.dto.CommentDTO;
import org.sh.dto.WriteDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO extends AbstractDAO{


	public List<BoardDTO> boardList(int pageNo){
		return sqlSession.selectList("board.boardList", pageNo);
	}

	public BoardDTO detail(int no) {
		return sqlSession.selectOne("board.detail", no);
	}

	public int write(WriteDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

	public int commentWrite(CommentDTO comment) {
		return sqlSession.insert("board.commentWrite", comment);
	}

	public List<CommentDTO> commemtsList(int reNo) {
		return sqlSession.selectList("board.commentsList", reNo);
	}

	public int postDel(WriteDTO dto) {
		return sqlSession.update("board.postDel", dto);
	}

	public int totalRecordCount() {
		return sqlSession.selectOne("board.totalRecordCount");
	}

	public int deleteComment(CommentDTO dto) {
		return sqlSession.update("board.deleteComment", dto);
	}

	public int countUP(BoardDTO dto) {
		return sqlSession.insert("board.countUP", dto);
	}

	public int alreadyRead(BoardDTO dto) {//22일
		return sqlSession.selectOne("board.alreadyRead", dto);
	}

	public int likeUp(CommentDTO dto) {
		return sqlSession.update("board.likeUp", dto);
	}

}
