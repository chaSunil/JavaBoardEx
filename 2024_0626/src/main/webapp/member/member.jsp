<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">

#box {
	padding-left: 0px;
	width: 100vw;
}

#box img {
	width: 100%;
}

.box {

    /* 바로 상위 태그인 body를 기준으로 맞춰주게끔 */
    /* position의 absolute라는것이, 설정하게 되면
    바로 직계부모 태그의 영향아래 놓이게 된다는 말이다.
    더불어서 네모를 영역으로 봤을때 왼쪽 상단 꼭지점을
    기준으로 움직이게 된다. */
    position: absolute;

    left: 30%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 35vw;
    height: 48vw;
    background: #FFFFFF;
    border: 1px solid #AACDFF;
    box-shadow: 7px 7px 39px rgba(0, 104, 255, 0.25);
    border-radius: 20px;

    /* 이것의 의미는 타겟팅된 영역에 대해 
    지정된 만큼 움직여주는 거라고 한다. */
    /* justify-content: space-evenly;
    align-content: column; */

    margin: 0px;
    padding: 100px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
}

h2 {
    width: 23vw;
    height: 4.7vw;
    left: 725px;
    top: 132px;

    font-family: 'Noto Sans CJK KR';
    font-style: normal;
    font-weight: 700;
    font-size: 32px;
    line-height: 47px;

    color: #0068FF;
    justify-content: space-evenly;


}

.btn {
    width: 200px;
    height: 50px;
    left: 725px;
    top: 875px;
    background-color: #FFFFFF;
    color: royalblue;
    border-radius: 8px;
    border: #0068FF solid 1px;
    
    margin-left: auto;
    margin-right: auto;
    
    text-align: center;
}

label input {
    padding: 0px;
    border: none;
    border-bottom: 1px solid #CFCFCF;
    width: 350px;
    height: 30px;
}

label {
    color: lightgrey;
}

.btn3 {
	display:inline-block;
	margin-top: 50px;
}

#id_msg, #nickname_msg {
	display: inline-block;
	width: 300px;
	height: 20px;
	margin-left: 10px;
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
<form>
	<div id="box">
	<img alt="" src="../image/background_image.jpg" id="background">
	</div>
		<div class="box">
				<h2 id="title">회원가입을 위해<br>정보를 입력해주세요.</h2>
				<label for="mem_name">*이름<br>
					<input name="mem_name"><br><br>
				</label>
				<label for="mem_id">*아이디<br>
					<input name="mem_id" id="mem_id" onkeyup="check_id();"><br><br>
				</label>
				<label for="mem_pwd">*비밀번호<br>
					<input name="mem_pwd" id="mem_pwd" type="password"><br><br>
				</label>
				<label for="mem_nickname">*닉네임<br>
					<input name="mem_nickname" id="mem_nickname" onkeyup="check_nickname();"><br><br>
				</label>
				<label for="mem_zipcode">*우편번호<br>
					<input name="mem_zipcode" id="mem_zipcode"><br><br>
					<input class="btn btn2" type="button" value="주소검색" onclick="find_addr();"><br><br>
				</label>
				<label for="mem_addr">*주소<br>
					<input name="mem_addr" id="mem_addr"><br><br>
				</label>
			<span id="id_msg"></span>
			<span id="nickname_msg"></span>
			<input class="btn btn3" type="button" value="목록보기" onclick="location.href='list.do'">
	   		<input id="btn_register"src="../image/icon.png" class="img-button" type="button" value="가입하기" disabled="disabled" onclick="send(this.form);">
		</div>
</form>
</body>
</html>