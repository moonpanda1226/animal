package org.sh.controller;

import java.util.List;

import javax.annotation.Resource;

import org.sh.dto.NoticeDTO;
import org.sh.service.NoticeService;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {

	
	@Resource(name="noticeService")
	private NoticeService noticeService; 
	
	@Autowired
	private Util util;
	
	//2024-02-27 요구사항 확인 psd
	
	@GetMapping("/notice") 
	public String notice(@RequestParam(value = "pageNo",required = false) String no , Model model ) {
		int currentPageNo = 1;
		if(util.str2Int(no) > 0) {
			currentPageNo = Integer.parseInt(no);
		}
		int totalRecordCount = noticeService.totalRecordCount();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalRecordCount);
	
		List<NoticeDTO> list = noticeService.noticeList(paginationInfo.getFirstRecordIndex());
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNo", currentPageNo);
		
		return "notice"; //........./views/notice.jsp
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam(value = "no", defaultValue = "0", required = true) int no, Model model) {
		if(no == 0) {
			return "redirect:/error";
		}else {
			NoticeDTO detail = noticeService.detail(no);
		if(detail.getNno() == 0) {
				return "redirect:/error";
			}else {
				model.addAttribute("detail", detail);
				return "noticeDetail";
			}
		}
		
	}
	//2024-02-27
	//noticeDel
	@GetMapping("/noticeDel")
	public String noticeDel(@PathVariable("no") int no) {
		//System.out.println("@PathVariable : " + no);
		noticeService.noticeDel(no);
		return "redirect:/notice";
	}
	
	
	
	//2024-02-27
	//공지 글쓰기 -> admin 관리자 화면에서 
	@GetMapping("/admin/noticeWrite")
	public String noticeWrite() {
		return "admin/noticeWrite"; //       /views/admin/noticeWrite.jsp
	}
	
	@PostMapping("/admin/noticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		//System.out.println(dto.getNtitle());
		//System.out.println(dto.getNcontent());
		int result = noticeService.noticeWrite(dto);
		return "redirect:/notice";
	}

}
