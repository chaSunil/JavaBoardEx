<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		
		if(mem_id=="") {
			alert("아이디를 입력해주세요");
			f.mem_id.value="";
			f.mem_id.focus();
			return;
		} else if(mem_pwd=="") {
			alert("비밀번호를 입력해주세요");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		
		f.action = "login.do"; // MemberLoginAction
		f.submit();
		
	}// end:send()

</script>

<script type="text/javascript">
	// 이 안에 있는 html이 전부 호출이 될 때 실행이 된다.
	// javascript 초기화
	// window.onload = function(){};
	
	// jQuery 초기화
	$(document).ready(function(){
		
		// showMessage(); 이렇게 바로 사용하면 하얀 화면에서 메세지가 나와서 이상하다.
		setTimeout(showMessage, 100); // 0.1초후에 메시지 띄워라
		
	});
	
	function showMessage(){
		// login_form.do?reason=fail_id
		// JSP el 사용
		if("${ param.reason == 'fail_id' }" == "true"){
			alert("아이디가 틀립니다.");
		}
		if("${ param.reason == 'fail_pwd' }" == "true"){
			alert("비밀번호가 틀립니다.");
		}
		
		if("${ param.reason == 'session_timeout'}" == "true") {
			alert("시간이 경과되어, 로그아웃 되었습니다.\n로그인 후 다시 등록하세요.");
		}
	}

</script>



</head>
<body>
<form>
	<div id="box">
		<div class="panel panel-primary">
    		<div class="panel-heading"><h5>로그인</h5></div>
    		<div class="panel-body">
    			<table class="table">
    				<tr>
    					<th>아이디</th>
    					<!-- form parameter -->
    					<td><input class="form-control" name="mem_id" value="${ param.mem_id }"></td>
    				</tr>
    				<tr>
    					<th>비밀번호</th>
    					<!-- form parameter -->
    					<td><input class="form-control" type="password" name="mem_pwd"></td>
    				</tr>
    				<tr>
    					<td colspan="2" align="center">
    						<input class="btn btn-success" type="button" value="메인화면" onclick="location.href='../photo/list.do'">
    						<input class="btn btn-primary" type="button" value="로그인" onclick="send(this.form)">
    					</td>
    				</tr>
    			</table>
    		</div>
    	</div>
	</div>
</form>
</body>
</html>