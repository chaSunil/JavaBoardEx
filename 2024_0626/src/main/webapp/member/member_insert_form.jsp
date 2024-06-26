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
<script type="text/javascript">

	function check_id(){
		
		$("#btn_register").prop("disabled", true);
		
		let mem_id = $("#mem_id").val();
		
		if(mem_id.length==0) {
			$("#id_msg").html("");
			return;
		}
		
		if(mem_id.length<3) {
			$("#id_msg").html("id는 3자리 이상으로 부탁드리겠습니다.").css("color","red");
			return;
		}
		
		$.ajax({
			url		:	"check_id.do",		// MemberCheckIdAction
			data	:	{"mem_id":mem_id},	// parameter -> check_id.do?mem_id=one
			dataType:	"json",
			success	:	function(res_data){
				if(res_data.result) {
					$("#id_msg").html("사용가능한 아이디 입니다.").css("color","blue");
					$("#btn_register").prop("disabled",false);
				} else {
					$("#id_msg").html("이미 사용중인 아이디 입니다.").css("color","red");
				}
			},
			error	:	function(err){
				alert("현재, 요청이 지연되고 있습니다.");
			}
		});
	}// end:check_id()
	
		function check_nickname(){
		
		$("#btn_register").prop("disabled", true);
		
		let mem_nickname = $("#mem_nickname").val();
		
		if(mem_nickname.length==0) {
			$("#nickname_msg").html("");
			return;
		}
		
		if(mem_nickname.length<2) {
			$("#nickname_msg").html("닉네임은 2자리 이상으로 부탁드리겠습니다.").css("color","red");
			return;
		}
		
		$.ajax({
			url		:	"check_nickname.do",
			data	:	{"mem_nickname":mem_nickname},
			dataType:	"json",
			success	:	function(res_data){
				if(res_data.result) {
					$("#nickname_msg").html("사용가능한 닉네임 입니다.").css("color","blue");
					$("#btn_register").prop("disabled",false);
				} else {
					$("#nickname_msg").html("이미 사용중인 닉네임 입니다.").css("color","red");
				}
			},
			error	:	function(err){
				alert("현재, 요청이 지연되고 있습니다.");
			}
		});
	}// end:check_nickname()
	
	function find_addr() {
		
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	// input 태그에 넣는 것이니 value 값을 넣어야 한다.
	        	$("#mem_zipcode").val(data.zonecode);
	        	$("#mem_addr").val(data.address);
	        }
	    }).open();
	}// end:find_addr()
	
	// 엔터만 쳐도 가입하기 버튼이 눌림

	
	function send(f) {
		
		let mem_name = f.mem_name.value.trim();
		let mem_pwd = f.mem_pwd.value.trim();
		let mem_zipcode = f.mem_zipcode.value.trim();
		let mem_addr = f.mem_addr.value.trim();
		
		if(mem_name==""){
			alert("이름을 입력하세요");
			f.mem_name.value="";
			f.mem_name.focus();
			return;
		}
		
		if(mem_pwd==""){
			alert("비밀번호를 입력하세요");
			f.mem_pwd.value="";
			f.mem_pwd.focus();
			return;
		}
		
		if(mem_zipcode==""){
			alert("우편번호를 입력하세요");
			f.mem_zipcode.value="";
			f.mem_zipcode.focus();
			return;
		}
		
		if(mem_addr==""){
			alert("주소를 입력하세요");
			f.mem_addr.value="";
			f.mem_addr.focus();
			return;
		}
		
		f.action="insert.do";
		f.submit();
	}

</script>
</head>
<body>
   	<!-- <div id="title"><h4>보드게임 정보 모두 여기에!!</h4></div> -->
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
   					<th>닉네임</th>
   					<td>
   						<input style="width:50%" class="form-control" name="mem_nickname" id="mem_nickname" onkeyup="check_nickname();">
   						<span id="nickname_msg"></span>
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
   						<input class="btn btn-success" type="button" value="목록보기" onclick="location.href='list.do'">
   						<input id="btn_register" class="btn btn-primary" type="button" value="가입하기" disabled="disabled" onclick="send(this.form);">
   					</td>
   				</tr>
   			</table>
   		</div>
   	</div>
</div>
</form>
</body>
</html>