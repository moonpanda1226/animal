package org.sh.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Component
public class Util {
	public int str2Int(String str) {
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			return 0;
		}
	}

	// 2024-02-21 psd 웹표준

	public HttpServletRequest req() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		return request;
	}

	public HttpSession getSession() {
		HttpSession session = req().getSession();
		return session;
	}

	// ip
	public String getIP() {
		// IP얻어오기
		HttpServletRequest request = req();
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	//숫자인지 검사하는 메소드 22일
	public boolean intCheck(String str) {
		try {
			Integer.parseInt(str);
			return true;			
		} catch(Exception e) {
			return false;
		}		
	}
	
	//메일 보내기 22일
    public void sendEmail(String email, String key) throws EmailException {
    	
  		String emailAddr = MailInfo.mailAddr;	 //이메일 주소
  		String name = "이 뚱 동 물 원";				 //이름
  		String passwd =MailInfo.mailPw;				 // 비번
  		String hostName = "smtp-mail.outlook.com";	 // smpt
  		int port = 587;								 //포트 번호
  		
  		SimpleEmail simpleEmail = new SimpleEmail(); // 전송할 메일
  		simpleEmail.setCharset("UTF-8");
  		simpleEmail.setDebug(true);
  		simpleEmail.setHostName(hostName);					//보내는 서버 설정 = 고정
  		simpleEmail.setAuthentication(emailAddr, passwd);	//보내는 사람 인증 = 고정
  		simpleEmail.setSmtpPort(port);						//사용할port = 고정
  		simpleEmail.setStartTLSEnabled(true);				//인증방법 = 고정
  		simpleEmail.setFrom(emailAddr, name);				//보내는 사람 email, 보내는 사람 이름
  		simpleEmail.addTo(email); 							//받는사람
  		simpleEmail.setSubject("이뚱 동물원 인증번호입니다."); 						// 제목
  		simpleEmail.setMsg("인증번호는 [" + key +"] 입니다");// 본문내용 text
  		simpleEmail.send();									// 전송하기
    
    }
    
    public String createkey() {
    	//String key = "";
    	Random r = new Random();
    	r.setSeed(System.currentTimeMillis());
    	String key = r.nextInt(10)+ "" + r.nextInt(10) + "" + r.nextInt(10) + "" + r.nextInt(10);
    	
    	return key;
    }

	public String fileUpload(MultipartFile upFile) {
		//경로저장
		String root = req().getSession().getServletContext().getRealPath("/");
		String upfilePath = root + "resources\\upfile\\";
		//UUID뽑기
		UUID uuid = UUID.randomUUID();
		//UUID를 포함한 파일명
		String newFileName = uuid.toString() + upFile.getOriginalFilename();
		
		//실제업로드
		File file = new File(upfilePath, newFileName);
		if(file.exists() == false) {
			file.mkdir(); //경로가 없다면 다 만들어주기.
		}

		try {
			FileOutputStream thumbnail = new FileOutputStream(new File(upfilePath, "s_"+newFileName));
			Thumbnailator.createThumbnail(upFile.getInputStream(), thumbnail, 100, 100);
			thumbnail.close();
			
			upFile.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return newFileName;
	}
	 
}
