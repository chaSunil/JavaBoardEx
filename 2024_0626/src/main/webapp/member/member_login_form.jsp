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
<style type="text/css">
#box {
	width: 400px;
	margin: auto;
	margin-top: 200px;
}

input[type="button"] {
	width: 100px;
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
   	<!-- <div id="title"><h4>보드게임 정보 모두 여기에!!</h4></div> -->
<form>
<div class="background_video">
	<video class="background_video_content" autoplay muted loop>
	
	</video>
</div>

	<div id="box">
	<div class="panel panel-primary">
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