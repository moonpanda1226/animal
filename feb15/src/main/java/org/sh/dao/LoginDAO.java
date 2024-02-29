package org.sh.dao;

import org.sh.dto.LoginDTO;
import org.sh.dto.MemberDTO;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO extends AbstractDAO{
	
	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login", dto);
	}

	public void mcountUp(LoginDTO loginDTO) {
		sqlSession.update("login.mcountUp", loginDTO);
	}

	public void mcountReset(LoginDTO loginDTO) {
		sqlSession.update("login.mcountReset", loginDTO);
		
	}

	public String getEmail(String id) {
		return sqlSession.selectOne("login.getEmail", id);
	}

	public int join(MemberDTO join) {
		return sqlSession.insert("login.join", join);
	}
}
