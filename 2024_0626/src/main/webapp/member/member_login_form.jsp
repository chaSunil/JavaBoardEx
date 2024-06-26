<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head >
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 제이쿼리 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- youtube-background 라이브러리 로드 -->
<script src="https://unpkg.com/youtube-background@1.0.14/jquery.youtube-background.min.js"></script>
<style type="text/css">

@font-face {
    font-family: 'PyeongChangPeace-Bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-02@1.0/PyeongChangPeace-Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

#title {
	font-family: 'PyeongChangPeace-Bold';
	text-align: : center;
	z-index: 10;
	left: 50%;
    transform: translate(-50%, 0);
	top: 0;
	position: fixed;
	margin-top: 150px;
	font-size: 80px;
	color: skyblue;
	text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;
}

#box {
	width: 400px;
	margin: auto;
	top: 0;
	left: 50%;
    transform: translate(-50%, 0);
    margin-top: 300px;
    
	z-index: 5;
	position: fixed;
}

input[type="button"] {
	width: 100px;
}

.video_bg {
    overflow: hidden;
    position: relative;
    width: 100%;
    padding-bottom: 56.25%;
    
}
.video_bg iframe {
    position: absolute;
    top: -60px;
    bottom: -60px;
    left: 0;
    width: 100%;
    height: calc(100% + 120px);
    border: none;
    z-index: 3;
}
.video_bg::after {
    content:'';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 4;
}
</style>
<script type="text/javascript">
	
	function send(f) {
		
		let mem_id = f.mem_id.value.trim();
		let mem_pwd = f.mem_pwd.value.trim();
		
		if(mem_id==""){
			alert("아이디를 입력하세요");
			f.mem_id.value="";
			f.mem_id.focus();
			return;
		}
		
		if(mem_pwd==""){
			alert("비밀번호를 입력하세요");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		
		f.action="login.do";
		f.submit();
	}// end:send()

</script>

<script type="text/javascript">
	$(document).ready(function(){
		
		setTimeout(showMessage, 100);
	});
	
	function showMessage() {
		
		if("${param.reason == 'fail_id'}" == "true") {
			alert("아이디가 틀립니다.");
		}
		if("${param.reason == 'fail_pwd'}" == "true") {
			alert("비밀번호가 틀립니다.");
		}
	}// end:showMessage()
</script>

</head>
<body>
<form>
<div class="video_bg">
    <iframe src="https://www.youtube.com/embed/f851NllfHMU?autoplay=1&mute=1&loop=1&playlist=f851NllfHMU"></iframe>
</div>
<div id="title">보드밍 회원가입</div>
<div id="box">
	<div class="panel panel-primary good">
   		<div class="panel-heading"><h4>로그인</h4></div>
   		<div class="panel-body">
   			<table class="table">
   				<tr>
   					<th>아이디</th>
   					<td>
   						<input class="form-control" name="mem_id" value="${param.mem_id}">
   					</td>
   				</tr>
   				<tr>
   					<th>비밀번호</th>
   					<td>
   						<input class="form-control" type="password" name="mem_pwd">
   					</td>
   				</tr>
   				<tr>
   					<td colspan="2" align="center">	
   						<input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">
   						<input class="btn btn-primary" type="button" value="로그인" onclick="send(this.form);">
   					</td>
   				</tr>
   			</table>
   		</div>
   	</div>
</div>
	

</form>
</body>
</html>