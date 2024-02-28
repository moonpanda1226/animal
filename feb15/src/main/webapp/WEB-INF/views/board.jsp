<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>이 뚱 동 물 원</title>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="apple-touch-icon" sizes="57x57" href="assets/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="assets/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="assets/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="assets/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="assets/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="assets/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"href="assets/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="assets/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="assets/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192" href="assets/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="assets/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
<link rel="manifest" href="assets/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link href="css/board.css?ver=0.01" rel="stylesheet" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 서 머 노 트 -->
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/summernote-bs4.min.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet">
<script type="text/javascript">
	function writeCheck(){
		//alert("멤모 버튼을 눌렀습니당");
		let title = document.querySelector("#title");
		let content = document.querySelector("#summernote");
		alert(cont)
		//alert("title : " + title.value + "/ content : " + content.value);
		if(title.value.length < 4){
			alert("제목은 5글자 이상은 쓰셔야죳!!");
			title.focus();
			return false;
			
		}
		if(content.value.length < 10){
			alert("내용이 너무 짧잖아욧!!!!!!")
			content.focus();
			return false;
		}
	}
	
	function detail(no){
		//swal("good job!","상세보기 입니당","success","좋아용");
		/* swal({
			title: "good job!!", 
			text : "번호는" + no,
			icon : "success",
			button: "좋아용"
		});//title, text, icon, button  */
		
		//모달 보이기
		
		let detailModal = new bootstrap.Modal('#detail', {}); //{옵션}
		//$("#modalTitle").text(no);
		//$("#modalContent").text("변경된 내용입니다.");
		//detailModal.show();
		
		$.ajax({
			url		 :"/restDetail",
			type	 :"post",
			dataType :"json",
			data	 :{'no' : no},
			success	 :function(data){
				//alert(data.board_title);
				$("#modalTitle").text(data.board_title);
				$("#modalContent").html(data.board_content);
				detailModal.show();
			},
			error	 : function(error){
				alert(error);
			}
		}); 
	}
	//전자정부 페이징 이동하는 스크립트
	function linkPage(pageNo){
		location.href = "./board?pageNo="+pageNo;
	}
	
</script>
</head>
<body id="page-top">
	<!-- Navigation-->
	<%@ include file="menu.jsp"%>

	<!-- 게시판 -->
	<section class="page-section" id="services">
		<div class="container">
			<div class="text-center">
				<br>
				<h2 class="section-heading text-uppercase">🐼자격증 한번에 합격하게 해주세요
					제발🐨</h2>
				<h4 class="section-heading text-uppercase">🐯우리반 학생분들 자격증 다
					합격하게 해주세요 제발🦁</h4>
				<br>
			</div>
			<div class="row text-center">
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>날짜</th>
							<th>읽음</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="row">
							<tr>
								<td onclick="detail(${row.board_no})">${row.board_no }</td>
								<td class="title"><a href="./detail?no=${row.board_no }">
										${row.board_title } <c:if test="${row.comment gt 0 }">
											<span class="badge">${row.comment }</span>
										</c:if>
								</a></td>
								<td>${row.mname }</td>
								<td>${row.board_date }</td>
								<td>${row.board_count }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 페이징 -->
				<div class="m-2 text-secondary">
					<ui:pagination paginationInfo="${paginationInfo }" type="image"
						jsFunction="linkPage" />
				</div>
				<!-- 글쓰기 버튼 -->
				<c:if test="${sessionScope.mid ne null }">
					<button class="btn btn-success" type="button"
						data-bs-toggle="modal" data-bs-target="#write">멤모</button>
				</c:if>
			</div>
		</div>
	</section>

	<!-- 글쓰기 모달 만들기 -->
	<div class="modal" id="write">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">🥰이뚱사육사에게 한 마 디🤗</h4>
					<br>
					<h7>-두마디 안됌-</h7>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="mt-2">
						<form action="./write" method="post"
							onsubmit="return writeCheck()" name="frm">
							<input type="text" id="title" name="title"
								class="form-control mb-2" required="required"
								placeholder="제목을 입력해 보려무낭">
							<textarea id="summernote" name="content"
								class="form-control mb-2 vh-500" required="required"></textarea>
							<button type="submit" class="btn btn-success">저쟝</button>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					모달 푸터래여?그게무에여?
					<!-- 2024-02-19일 웹표준 기술/  -->
				</div>
			</div>
		</div>
	</div>
	<!-- 글쓰기 모달 -->
	<div class="modal" id="detail">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalTitle">🥰이뚱에게 하고 싶은 말이 있음
						해보렴🤗</h4>
					<h6>-누군지 꼭 밝히도록-</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="mt-2" id="modalContent">
						제목<br> 본문내용
					</div>
				</div>
				<div class="modal-footer">모달 푸터래여? 닫기래여</div>

			</div>
		</div>
	</div>



	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		//여기 아래 부분
		$('#summernote').summernote({
			
			  height: 600,                 // 에디터 높이
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '이쁜말 고운말'	,//placeholder 설정
			  fontNames : ['D2coding', 'Arial Black', 'Comic Sans Ms', 'Courier New'],
			  toolbar : [	    // [groupName, [list of button]]
				    ['style', ['bold', 'italic', 'underline', 'clear']],
				    /* ['font', ['strikethrough', 'superscript', 'subscript']], */
				    ['fontname', ['fontname','fontsize', 'color']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    /* ['height', ['height']] */
				    ['table', ['table','link', 'picture', 'video','fullscreen', 'codeview', 'help']]
				  ]
		});
	});
	</script>
</body>

</html>
