package org.sh.dao;

import org.apache.ibatis.session.SqlSession;
import org.sh.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RestDAO extends AbstractDAO{
	
	public String getEmail(String id) {
		return sqlSession.selectOne("rest.getEmail" ,id);
		
	}
	
	public void setkey(MemberDTO dto) {
		sqlSession.update("rest.setKey", dto);
	}
	

}
