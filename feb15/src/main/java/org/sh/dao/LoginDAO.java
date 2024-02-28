package org.sh.dao;

import org.apache.ibatis.session.SqlSession;
import org.sh.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
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
}
