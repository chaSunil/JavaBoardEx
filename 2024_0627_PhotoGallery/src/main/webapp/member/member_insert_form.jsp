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
@font-face {
    font-family: 'MabinogiClassicR';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2207-01@1.0/MabinogiClassicR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
* {
	font-family: "MabinogiClassicR";
}
/* .all {
	postion: relative;
	width: 100%;
	background: url(https://www.nintendo.co.kr/wallpapers/file/Kirby_Star_Allies/Kirby_Star_Allies-01.jpg) no-repeat 100% 0 fixed;
	background-size: cover;
}
.all::before {
	content: "";
	opactiy: 0.5;
	position: absolute;
	top: 0px;
	left: 0px;
	right: 0px;
	bottom: 0px;
	background-color: #000;
} */
#title {
	text-align: center;
	margin: 50px;
}
#box {
	width: 60vw;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 200px;
}
th {
	vertical-align: middle !important;
	text-align: right;
	font-size: 14px;
}
#id_msg {
	display: inline-block;
	width: 300px;
	height: 20px;
	margin-left: 10px;
}

#footer {
	width: 100%;
	text-align: center;
}
</style>
<!-- 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	function check_id() {
		
		// 회원가입 버튼은 비활성화
		// <input id="btn_register" type="button" ... disabled="disabled">
		$("#btn_register").prop("disabled", true);
		
		// document.getElementById("mem_id").value
		let mem_id = $("#mem_id").val();
		
		if(mem_id.length==0) {
			$("#id_msg").html("");
			return;
		}
		
		if(mem_id.length<3) {
			$("#id_msg").html("id는 3자리 이상이여야 합니다. -글로벌아이티 운영자-").css("color","red");
			return;
		}
		
		// 서버에 현재 입력된 ID를 체크 요청(jQuery Ajax이용)
		$.ajax({
			url		:	"check_id.do",		// MemberCheckIdAction
			data	:	{"mem_id":mem_id},	// parameter => check_id.do?mem_id=one
			dataType:	"json",
			success :	function(res_data){
				// res_data = {"result": true} or {"result": false}
				if(res_data.result) {
					$("#id_msg").html("사용가능한 아이디 입니다.").css("color","blue");
					$("#btn_register").prop("disabled", false);
				} else {
					$("#id_msg").html("이미 사용중인 아이디 입니다.").css("color","red");
				}
			},
			error	:	function(err){
				alert(err.responseText);
			}
		});
		
	}// end:check_id()
	
	function find_addr(){
		
		var themeObj = {
			bgColor: "#C4F7FF" // 바탕배경색
		};
		
	    new daum.Postcode({
	    	theme: themeObj,
	        oncomplete: function(data) {
	        	// input 태그에 넣는 것이니 value 값을 넣어야 한다.
	        	$("#mem_zipcode").val(data.zonecode);
	        	$("#mem_addr").val(data.address);
	        }
	    }).open();
		
	}// end:find_addr()
	
	function send(f){
		
		let mem_name = f.mem_name.value.trim();
		let mem_pwd = f.mem_pwd.value.trim();
		let mem_zipcode = f.mem_zipcode.value.trim();
		let mem_addr = f.mem_addr.value.trim();
		
		if(mem_name=='') {
			alert("이름을 입력하세요");
			f.mem_name.value="";
			f.mem_name.focus();
			return;
		}
		if(mem_pwd=='') {
			alert("비밀번호을 입력하세요");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		if(mem_zipcode=='') {
			alert("우편번호를 입력하세요");
			f.mem_zipcode.value="";
			f.mem_zipcode.focus();
			return;
		}
		if(mem_addr=='') {
			alert("주소를 입력하세요");
			f.mem_addr.value="";
			f.mem_addr.focus();
			return;
		}
		
		f.action="insert.do"; // MemberInsertAction
		f.submit();
	}// end:send()
	
</script>

</head>
<body>
<div id="title"><h4>글로벌 IT 온라인 ver 1.0.05</h4>
	<img alt="" src="https://www.wonderking.co.kr/upload/img/write/notice/wUZw05Sl87KakaoTalk_20240502_110610130.png">
</div>
<div id="title"><h2>회원가입을 환영합니다.</h2></div>
<form class="form-inline">
	<div id="box">
		<div class="panel panel-primary">
      		<div class="panel-heading"><h4>회원가입</h4></div>
      		<div class="panel-body">
      			<table class="table">
      				<tr>
      					<th>이름</th>
      					<td>
      						<input style="width:50%" class="form-control" name="mem_name">
      					</td>
      				</tr>
      				<tr>
      					<th>아이디</th>
      					<td>
      						<input style="width:50%" class="form-control" name="mem_id" id="mem_id" onkeyup="check_id();">
      						<span id="id_msg"></span>
      					</td>
      				</tr>
      				<tr>
      					<th>비밀번호</th>
      					<td>
      						<input style="width:50%" class="form-control" type="password" name="mem_pwd">
      					</td>
      				</tr>
      				<tr>
      					<th>우편번호</th>
      					<td>
      					<!-- 한 줄에 표시해주기 위해서 form-inline으로 잡아준다. -->
      						<input style="width:50%" class="form-control" name="mem_zipcode" id="mem_zipcode">
      						<input class="btn btn-info" type="button" value="주소검색" onclick="find_addr();">
      					</td>
      				</tr>
      					<th>주소</th>
      					<td>
      					<!-- 한 줄에 표시해주기 위해서 form-inline으로 잡아준다. -->
      						<input style="width:100%" class="form-control" name="mem_addr" id="mem_addr">
      					</td>
      				</tr>
      				<tr>
      					<td colspan="2" align="center">	
      						<input class="btn btn-success" type="button" value="메인화면" onclick="location.href='../photo/list.do'">
      						<input id="btn_register" class="btn btn-primary" type="button" value="가입하기" disabled="disabled" onclick="send(this.form);">
      					</td>
      				</tr>
      			</table>
      		</div>
    	</div>
	</div>
</form>
<div id="footer">
	<img alt="" src="../image/footer.JPG">
</div>
</body>
</html>