package org.sh.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.sh.dto.BoardDTO;
import org.sh.dto.SearchDTO;
import org.sh.service.BoardService;
import org.sh.service.RestService;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
public class RestFullController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RestService restService;
	
	@Autowired
	private Util util;

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
	
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		//System.out.println(id);
		int result = restService.idCheck(id);
		//System.out.println("실행결과:" + result);
		//{key : value, key2 : value, key3 : value}
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		//resultMap.put("count", result);
		
		//JsonObject이용시
		JSONObject json = new JSONObject();
		json.put("count", result);
		
		return json.toString();
	}
	
	//게시판을 json으로 출력해주는 api
	@GetMapping("/jsonBoard")
	public String jsonBoard(
			@RequestParam(value = "pageNo", required = false) String no ,
			@RequestParam(value = "search", required = false) String search,
			Model model) {
		// pageNo가 오지 않는다면
		int currentPageNo = 1;
		if (util.str2Int(no) > 0) {// 여기 수정해주세요.
			currentPageNo = Integer.parseInt(no);
		}

		// 전체 글 수 totalRecordCount
		int totalRecordCount = boardService.totalRecordCount(search);
		// System.out.println("totalRecordCount : " + totalRecordCount); // 101
		// pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);// 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); // 한 페이지에 게시되는 게시물 건 수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totalRecordCount);// 전체 게시물 건 수
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDTO.setSearch(search);

		List<BoardDTO> list = boardService.boardList(searchDTO);

		// JSON
		JSONObject jsonList = new JSONObject();
		jsonList.put("list", list);
		jsonList.put("paginationInfo", paginationInfo);
		jsonList.put("pageNo", no);

		return jsonList.toString();
	}

}