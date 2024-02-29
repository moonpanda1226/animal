package org.sh.service;

import org.sh.dao.LoginDAO;
import org.sh.dto.LoginDTO;
import org.sh.dto.MemberDTO;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService extends AbstractService{
	
	@Autowired
	private LoginDAO loginDAO;
	
	public LoginDTO login(LoginDTO dto) {
		return loginDAO.login(dto);
	}

	public void mcountUp(LoginDTO loginDTO) {
		loginDAO.mcountUp(loginDTO);
		
	}

	public void mcountReset(LoginDTO loginDTO) {
		loginDAO.mcountReset(loginDTO);
		
	}

	public String getEmail(String email) {
		return loginDAO.getEmail(email);
	}

	public void myInfo() {
	
		
	}

	public int join(MemberDTO join) {
		return loginDAO.join(join);
	}

}
