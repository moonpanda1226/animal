package org.sh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sh.dto.BoardDTO;
import org.sh.dto.CommentDTO;
import org.sh.dto.SearchDTO;
import org.sh.dto.WriteDTO;
import org.sh.service.BoardService;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	// 1. 엔터키 처리 / 글쓰기 / 댓글쓰기
	// 2. 로그인 처리 / 글쓰기 / 댓글쓰기

	@Autowired
	private BoardService boardService;

	@Autowired
	private Util util;

	@GetMapping("index")
	public String index() {
		return "index";
	}

	// 페이징 추가하기 2024-02-20
	@GetMapping({ "/board" })
	public String board(
			@RequestParam(value = "pageNo", required = false) String no,
			@RequestParam(value = "search", required = false) String search,
			HttpServletRequest request,
			Model model) {
		
		System.out.println(search);
		
		// pageNo가 오지 않는다면
		int currentPageNo = 1;
		if (util.str2Int(no) > 0) {// 여기 수정해주세요
			currentPageNo = Integer.parseInt(no);
		}
		// 전체 글 수 totalRecordCount
		int totalRecordCount = boardService.totalRecordCount(search);
		// System.out.println("totalRecordCount : " + totalRecordCount);

		// pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);// 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10);// 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totalRecordCount);// 전체 게시물 건 수
		System.out.println("이뚱 사랑하는 사람 : " + request.getRemoteAddr());
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDTO.setSearch(search);

		List<BoardDTO> list = boardService.boardList(searchDTO);
		model.addAttribute("list", list);
		// 페이징 관련 정보가 있는 paginationInfo 객체를 모델에 반드시 넣어준다.
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNo", currentPageNo);
		model.addAttribute("search", search);
		

		return "board";
	}

	// 2024-02-16 웹표준 기술 psd
	@GetMapping("/detail")
	public String detail(@RequestParam(value = "no", defaultValue = "10") String no, Model model) {
		// public String detail(HttpServletRequest request) {
		// 오는 no잡기
		// String no = request.getParameter("no");
		// System.out.println(util.str2Int(no));
		// System.out.println(no);
		int reNo = util.str2Int(no);
		if (reNo != 0) {
			// 0이 아니야 = 정상 : //DB에 물어보기 //값 가져오기 // 붙이기
			BoardDTO detail = boardService.detail(reNo);
			model.addAttribute("detail", detail);
			// 2024-02-19 psd 댓글도 뽑기
			// System.out.println("댓글 수 : " + detail.getComment());
			if (detail.getComment() > 0) {
				List<CommentDTO> commentsList = boardService.commentsList(reNo);
				model.addAttribute("commentsList", commentsList);

				System.out.println(commentsList.get(0).getMname());
			}
			// 이동하기
			return "detail";

		} else {
			// 0이야 = 비정상 : 에러로 페이지 이동하기
			// return "/error/error"; //에러 폴더 error.jsp
			return "redirect:/error"; // controller에 있는 error매핑을 실행해
		}

	}
	@GetMapping("/write")
	public String write() {
		//return "write";
		return "redirect:/login?error=2048";
	}

	// 글쓰기 2024-02-16
	@PostMapping("/write") // 내용 + 제목 받아요 -> db에 저장 -> 보드로
	public String write(WriteDTO dto) {
		if (util.getSession().getAttribute("mid") != null) {
			int result = boardService.write(dto);
			// 추후 세션관련 작업을 더 해야 합니다.
			if (result == 1) {
				// 내가 쓴 글로 다시 돌아가게 하는 기법
				return "redirect:/detail?no=" + dto.getBoard_no();
			} else {
				return "redirect:/error";
			}
		} else {
			return "redirect:/login?error='로그인 하셔야해요~'";
		}
	}

	// 댓글쓰기 2024-02-19 psd == 글번호 no, 댓글내용 comment, 글쓴이
	@PostMapping("/commentWrite")
	public String commentWrite(CommentDTO comment) {
		// HttpSession session = request.getSession();
		// comment.setMid((String) session.getAttribute("mid"));
		// 로그인 여부 검사
		if (util.getSession().getAttribute("mid") != null) {
			int result = boardService.commentWrite(comment);
			return "redirect:/detail?no=" + comment.getNo();
		} else {
			return "redirect:/login";
		}
		//System.out.println("댓글쓰기 결과" + result);
		// System.out.println(comment.getNo());
		// System.out.println(comment.getComment());
		// System.out.println(comment.getMid());
	}

	@PostMapping("/postDel")
	public String postDel(@RequestParam("no") int no) {
		// 로그인 여부
		if (util.getSession().getAttribute("mid") != null) {
			// System.out.println("no : " + no);
			int result = boardService.postDel(no);
			// System.out.println("result", result);
			return "redirect:/board";
		} else {
			return "redirect:/login";
		}
	}

	// 댓글 삭제 2024-02-21 psd == 댓글 번호 + mid + 글번호
	@GetMapping("/deleteComment")
	public String deleteComment(@RequestParam("no") int no, @RequestParam("cno") int cno) {
		System.out.println("no : " + no);
		System.out.println("cno : " + no);

		int result = boardService.deleteComment(no, cno);

		return "redirect:/detail?no=" + no;
	}
	
	//2024-02-22 요구사항 확인 psd
	@GetMapping("/likeUp")
	public String likeUp(@RequestParam("no") String no, @RequestParam("cno") String cno) { //board_no=no, cno=cno
		System.out.println(no);
		System.out.println(cno);
		if(util.intCheck(no) && util.intCheck(cno)) {
			CommentDTO dto = new CommentDTO();
			dto.setBoard_no(util.str2Int(no));
			dto.setNo(util.str2Int(cno));
			
			 boardService.likeUp(dto);
			return "redirect:/detail?no="+dto.getBoard_no();
		}else {
			return "redirect:/error";
		}
	
	}
}
