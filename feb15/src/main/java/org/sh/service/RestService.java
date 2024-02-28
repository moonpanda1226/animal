package org.sh.service;

import org.sh.dao.RestDAO;
import org.sh.dto.MemberDTO;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestService extends AbstractService{
	@Autowired
	private RestDAO restDAO;
	
	public int sendEmail() {
		if(util.getSession().getAttribute("mid") != null) {
			//메일 발송 + key 데이터베이스에 저장
			String email = getEmail((String) util.getSession().getAttribute("mid"));
			String key = util.createkey();
			
			MemberDTO dto = new MemberDTO();
			dto.setMemail(email);
			dto.setMkey(key);
			dto.setMid((String) util.getSession().getAttribute("mid"));
			restDAO.setkey(dto);
			
			//util.sendEmail(email,key);
			//System.out.println("key :" + key);
			
			return 1;
		}else {
			return 0;
		}
	}

	private String getEmail(String email) {
		return restDAO.getEmail(email);
	}
	
}
