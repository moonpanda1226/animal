<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>회원가입</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="apple-touch-icon" sizes="57x57"
	href="assets/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="assets/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="assets/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="assets/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="assets/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="assets/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="assets/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="assets/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="assets/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="assets/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="assets/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="assets/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="assets/favicon-16x16.png">
<link rel="manifest" href="assets/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script type="text/javascript">
        const Toast = Swal.mixin({
        	  toast: true,
        	  position: 'center-center',
        	  showConfirmButton: false,
        	  timer: 3000,
        	  timerProgressBar: true,
        	  didOpen: (toast) => {
        	    toast.onmouseenter = Swal.stopTimer;
        	    toast.onmouseleave = Swal.resumeTimer;
        	  }
        	});
        
        $(function(){
        	//Swal.fire('title','content', 'success');
			//2024-02-29 애플리케이션 테스트 수행 psd
        	$('#idCheck').click(function(){
	        	let id = $('#id').val();
        		//Swal.fire('ID체크','검사할 아이디 :' + id, 'success');
        		//3글자 이상, 10글자 이하
        		if(id.length > 10 || id.length < 3){
        			//3글자 이하, 10글자 이상 = 비정상 -> 멈춤
        			Swal.fire('ID검사','아이디는 3~10 글자로 만드셈 :','error');
        		}else{ 
        			//3글자 이상, 10글자 이하 = 정상 -> ajax
        			$.ajax({
        				url :'./idCheck',
        				type : 'post',
        				dataType : 'json',
        				data : {id : id},
        				success : function(data){
        					alert(data.count);
        					if(data.count == 1){
        					Swal.fire('ID검사','있는 아이디임 ㅉ :', 'success');
        					}else{
        					Swal.fire('ID검사',id+ '오키 쓸 수 있음','success');        						
        					}
        				},
        				error : function(error){
        				}
        			});
        		}
        	});
        	
        	//join을 클릭하면 이벤트 발생
        	$('#join').click(function(){
        		//Swal.fire('회원가입','회원가입 버튼을 클릭하셨습니다.', 'success');
        		//id값 가져오기
        		let id = $('#id').val();
        		let pw1 = $('#password1').val();
        		let pw2 = $('#password2').val();
        		let name = $('#name').val();
        		let email = $('#email').val();
        		//Swal.fire('회원가입','아이디 : ' + id + "<br>비밀번호 : " + pw1 + "/" + pw2, 'success');
        		//alert("줄바꿈 \n 줄바꿈");
        		//전송하기
        		let loginForm = $('<form></form>');
        		loginForm.attr('name','login');
        		loginForm.attr('method','post');
        		loginForm.attr('action','./join');
        		
        		loginForm.append(    $('<input>', {'type':'hidden', 'name':'id', 'value':id})   );
        		loginForm.append($('<input>', {type:'hidden', 'name':'pw', 'value':pw1}));
        		loginForm.append($('<input>', {type:'hidden', 'name':'name', 'value':name}));
        		loginForm.append($('<input>', {type:'hidden', 'name':'email', 'value':email}));
        		
        		loginForm.appendTo('body');
        		loginForm.submit();
        	});
        });
        function check(){
        	let pw1 = $('#password1').val();
        	//alert("비번1:" + pw1);
        	let pw2 = $('#password2').val();
        	//alert("비번2 :" + pw2);
        	
        	if(pw1 !== pw2){
        		$('#check').show();
        	}else{
        		$('#check').hide();
        	}
        }
        $(document).ready(function(){
        	$('#check').hide();
        });
   		       
        
        </script>
</head>
<%-- <%@ include file="menu.jsp"%>
<body data-locale="ko">
	<div id="webView" data-canvas="true" data-show-memo="false"
		data-show-link="false"
		title="페이지에 링크가 연결된 객체가 있을 경우 화면을 터치/클릭하면 표시됩니다.">
		<div
			style="position: absolute; top: 1px; left: 215px; width: 769px; height: 613px;"
			data-obj-id="Jop9v" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="background-color: rgb(224, 224, 224);"></div>
		</div>
		<div
			style="position: absolute; top: 449px; left: 370px; width: 460px; height: 35px;"
			data-obj-id="0gqwA" data-obj-type="element" data-text-editable="true"
			class="">
			<input type="text" id="name" data-min-width="60" data-min-height="30"
				data-text-content="true" value="닉네임을 입력해주세요"
				style="color: rgb(190, 190, 190); text-align: center;" class="">
		</div>
		<div
			style="position: absolute; top: 527px; left: 370px; width: 400px; height: 35px;"
			data-obj-id="WC1zE" data-obj-type="element" data-text-editable="true"
			class="">
			<input type="text" id="email" data-min-width="60" data-min-height="30"
				data-text-content="true" value="이메일을 입력해주세요 (인증문자 전용)"
				style="color: rgb(190, 190, 190); text-align: center;" class="">
		</div>
		<div
			style="position: absolute; top: 366px; left: 608px; width: 222px; height: 35px;"
			data-obj-id="KcLqh" data-obj-type="element" data-text-editable="true"
			class="">
			<input type="text" id="password2" data-min-width="60" data-min-height="30"
				data-text-content="true" value="비밀번호 한번 더 입력해주세요"
				style="color: rgb(190, 190, 190); text-align: center;" class="">
		</div>
		<div
			style="position: absolute; top: 366px; left: 370px; width: 222px; height: 35px;"
			data-obj-id="QgfV4" data-obj-type="element" data-text-editable="true"
			class="">
			<input type="text" id="password1" data-min-width="60" data-min-height="30"
				data-text-content="true" value="비밀번호를 입력해주세요"
				style="color: rgb(190, 190, 190); text-align: center;" class="">
		</div>
		<div
			style="position: absolute; top: 289px; left: 372px; width: 400px; height: 35px;"
			data-obj-id="Vdd9n" data-obj-type="element" data-text-editable="true"
			class="">
			<input type="text" id="id" data-min-width="60" data-min-height="30"
				data-text-content="true" value="아이디를 입력해주세요"
				style="color: rgb(190, 190, 190); text-align: center;" class="">
		</div>
		<div
			style="position: absolute; top: 413px; left: 520px; width: 160px; height: 20px;"
			data-obj-id="DU0mG" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 16px; text-align: center;" class="">
				닉네임<br>
			</div>
		</div>
		<div
			style="position: absolute; top: 335px; left: 520px; width: 160px; height: 20px;"
			data-obj-id="RSfSV" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 16px; text-align: center;" class="">비번</div>
		</div>
		<div
			style="position: absolute; top: 256px; left: 520px; width: 160px; height: 20px;"
			data-obj-id="h43BP" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 16px; text-align: center;" class="">아이디</div>
		</div>
		<div
			style="position: absolute; top: 496px; left: 520px; width: 160px; height: 20px;"
			data-obj-id="jO1P2" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 16px; text-align: center;" class="">이메일</div>
		</div>
		<div
			style="position: absolute; top: 574px; left: 620px; width: 60px; height: 26px;"
			data-obj-id="VVmgF" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 12px; color: rgb(255, 255, 255); text-align: center; line-height: 2em; border-top-left-radius: 4px; border-top-right-radius: 4px; border-bottom-right-radius: 4px; border-bottom-left-radius: 4px; background-color: rgb(94, 94, 94);"
				class="">회원가입</div>
		</div>
		<div
			style="position: absolute; top: 574px; left: 520px; width: 60px; height: 26px;"
			data-obj-id="8JgAQ" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 12px; color: rgb(255, 255, 255); text-align: center; line-height: 2em; border-top-left-radius: 4px; border-top-right-radius: 4px; border-bottom-right-radius: 4px; border-bottom-left-radius: 4px; background-color: rgb(94, 94, 94);"
				class="">취소</div>
		</div>
		<div
			style="position: absolute; top: 527px; left: 770px; width: 60px; height: 35px;"
			data-obj-id="trlKA" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 14px; color: rgb(255, 255, 255); text-align: center; line-height: 2.9em; border-radius: 4px; background-color: rgb(94, 94, 94);"
				class="">중복확인</div>
		</div>
		<div
			style="position: absolute; top: 289px; left: 770px; width: 60px; height: 35px;"
			data-obj-id="sZcc8" data-obj-type="element" data-text-editable="true"
			class="">
			<div data-text-content="true"
				style="font-size: 14px; color: rgb(255, 255, 255); text-align: center; line-height: 2.9em; border-radius: 4px; background-color: rgb(94, 94, 94);"
				class="">중복확인</div>
		</div>
		<div
			style="position: absolute; top: 14px; left: 384px; width: 431px; height: 229px;"
			data-obj-id="CTEUV" data-obj-type="image" class="">
			<div data-image-content="true"
				style="background-image: url(/static/imagefarm/101183097/62NSztQRgWWNPd1sqd2XRYYmt2frePto);"></div>
		</div>
	</div>
	<div id="ovenWebview_Gesture" class="ovenWebview_Gesture">
		<div id="gesture_left" data-id=""
			class="gesture_sign gesture_sign_left"></div>
		<div id="gesture_right" data-id=""
			class="gesture_sign gesture_sign_right"></div>
	</div>
	<div style="display: none;" class="ovenQRnURL"></div>
	<div style="" class="ovenWebview_Nav">
		<a href="javascript:;" class="disabled"><span
			class="arrow_triangle-left_alt2"></span></a><a id="toggleMoreMenu"
			href="javascript:;"><span class="icon_menu-circle_alt"></span></a><a
			href="javascript:;" class="disabled"><span
			class="arrow_triangle-right_alt2"></span></a>
		<div style="display: none;" class="ovenWebview_MoreMenu">
			<span class="arrow"></span><a href="javascript:;" class="disabled"><span
				class="icon_menu-square_alt"></span>&nbsp; 페이지 목록</a><a
				href="javascript:;" class="toggle_memo"><span
				class="icon_quotations_alt"></span>&nbsp; 메모 표시</a><a
				href="javascript:;" class="toggle_link"><span
				class="icon_cursor"></span>&nbsp; 링크영역 표시</a><a href="javascript:;"
				class="showQR"><span class="icon_mobile"></span>&nbsp; QR / URL</a>
		</div>
		<link rel="stylesheet" type="text/css"
			href="/static/csslib/elegant-fonts.css">
		<style>
.ovenWebview_Nav {
	position: fixed;
	bottom: 15px;
	left: 15px;
	width: 120px;
	height: 40px;
	color: #fff;
	-webkit-transform: translate3d(0, 0, 0);
	transform: translate3d(0, 0, 0);
}

.ovenWebview_Nav a {
	text-decoration: none;
	color: #fff
}

.ovenWebview_Nav>a {
	margin-right: 5px;
	opacity: 0.7;
	-webkit-transition: all 0.2s;
	transition: all 0.2s;;
	font-size: 36px;
}

.ovenWebview_Nav>a:not(.disabled):hover {
	opacity: 1
}

.ovenWebview_Nav>.disabled {
	opacity: 0.2;
	cursor: default
}

#toggleMoreMenu {
	cursor: move
}

.ovenWebview_MoreMenu {
	position: absolute;
	width: 170px;
	margin-left: -10px;
	box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.15);
	border-radius: 4px;
}

.ovenWebview_MoreMenu .arrow {
	position: absolute;
	bottom: -10px;
	width: 0;
	height: 0;
	border-left: 10px solid transparent;
	border-right: 10px solid transparent;
	border-top: 10px solid #1abc9c;
}

.ovenWebview_MoreMenu .arrow.up {
	bottom: auto;
	top: -10px;
	border-top: none;
	border-bottom: 10px solid #1abc9c;
}

.ovenWebview_Nav .ovenWebview_MoreMenu a {
	display: block;
	height: 40px;
	line-height: 40px;
	padding: 0 14px 0 28px;
	background: #1abc9c;
	color: #fff;
}

.ovenWebview_MoreMenu a:first-of-type {
	border-radius: 4px 4px 0 0
}

.ovenWebview_MoreMenu a:last-of-type {
	border-radius: 0 0 4px 4px
}

.ovenWebview_MoreMenu a:not(.disabled):hover {
	background: #16a085;
}

.ovenWebview_MoreMenu .sub a.current {
	font-weight: bold;
	background: #16a085;
}

.ovenWebview_MoreMenu a.current:after {
	position: absolute;
	left: 7px;
	font-family: "ElegantIcons";
	content: "N"
}

.ovenWebview_MoreMenu a.has_sub.on {
	background: #16a085;
}

.ovenWebview_MoreMenu a.has_sub:after {
	position: absolute;
	right: 10px;
	font-family: "ElegantIcons";
	content: "E"
}

.ovenWebview_MoreMenu .sub {
	display: none;
	overflow: auto;
	position: absolute;
	left: 97%;
	height: 165px;
	margin-top: -70px;
	width: 130px;
	box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.35);
	border-radius: 4px;
	background: #1abc9c
}

.ovenWebview_MoreMenu .sub.alt {
	left: auto;
	right: 97%;
}

.ovenWebview_MoreMenu .sub>a {
	overflow: hidden;
	font-size: 12px;
	height: 30px;
	line-height: 30px;
	padding: 0 10px 0 25px;
	text-overflow: ellipsis;
	white-space: nowrap
}

.ovenWebview_MoreMenu a.disabled {
	color: rgba(255, 255, 255, 0.3);
	cursor: default;
}

.ovenQRnURL {
	position: absolute;
	z-index: 1000;
	top: 50%;
	left: 50%;
	width: 320px;
	margin: -240px 0 0 -170px;
	padding: 10px;
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 20px;
}

.ovenQRnURL>img {
	background-color: #fff;
	margin: 20px;
}

.ovenQRnURL>strong {
	display: block;
	font-size: 24px;
	font-family: Monospace;
	text-align: center;
	color: #fff;
	text-shadow: 0 1px 2px rgba(0, 0, 0, 1);
	word-break: break-all;
}
</style>
		<style>
.ovenWebview_Nav a {
	color: #1abc9c
}
</style>
	</div>
	<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-54845033-1', 'auto');ga('send', 'pageview');
</script>
	<script>var _tiq = 'undefined' !== typeof _tiq ? _tiq : []; _tiq.push(['__setPageName', 'webview']); _tiq.push(['__trackPageview']);(function(d) {var se = d.createElement('script'); se.type = 'text/javascript'; se.async = true;se.src = location.protocol + '//m1.daumcdn.net/tiara/js/td.min.js';var s = d.getElementsByTagName('head')[0]; s.appendChild(se);})(document);</script>
</body> --%>
<body id="page-top">
	<!-- Navigation-->
	<%@ include file="menu.jsp"%>

	<div class="mt-10">회원가입</div>
	
	

	<!-- join -->
	<section class="page-section" id="mail">
		<div class="d-flex justify-content-center ">
			<div class="text-center p-5 w-50 bg-secondary">
				<div class="mb-3 row">
					<label id="idid" for="id" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-7">
						<input type="text" id="id" class="form-control"
							placeholder="아이디를 입력하세요">
					</div>
					<div class="col-sm-3">
						<button type="button" id="idCheck" class="btn btn-info w-100">ID
							검사</button>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-5">
						<input type="password" class="form-control" id="password1"
							placeholder="암호를 입력하세요">
					</div>
					<div class="col-sm-5">
						<input type="password" class="form-control" id="password2"
							placeholder="암호를 입력하세요">
					</div>
					<div id="check" class="invalid-feedback mb-1 m-1">동일하지 않습니다</div>
				</div>
				<div class="mb-3 row">
					<label for="name" class="col-sm-2 col-form-label">이 름</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name"
							placeholder="이름을 입력하세요">
					</div>
				</div>
				<div class="mb-3 row">
					<label for="email" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="email"
							placeholder="이메일을 입력하세요">
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12">
						<button type="button" id="join" class="btn btn-info">회원가입</button>
						<button type="button" onclick="check()" id="pwCheck"
							class="btn btn-info">비번검사</button>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
