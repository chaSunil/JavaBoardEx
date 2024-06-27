<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	font-family: 'MabinogiClassicR';
}

#background {
	background: url(../images/maul.png) no-repeat 100% 0 fixed;
	background-size: cover;
}

#box {
	width: 800px;
	margin: auto;
}

#title {
	display: block;
	margin: auto;
	margin-bottom: 50px;
	width: 250px;
}

#photo-box {
	height: 470px;
	background-color: white;
	border: 2px solid black;
	margin-top: 10px;
	/* 상하스크롤 */
	overflow-y: scroll;
	
}

.photo {
	width: 120px;
	height: 160px;
	border: 1px solid gray;
	overflow: hidden;
	margin-left: 60px;
	margin-top: 50px;
	padding: 10px;
	
	float: left;
}

.photo:hover {
	border-color: green;
}

.photo > img {
	width: 100px;
	object-fit : cover;
}

.title {
	border: 1px solid gray;
	padding: 1px;
	margin-top: 5px;
	text-align: center;
}
</style>

<script type="text/javascript">

	function photo_insert() {
		
		// 로그인 체크(로그인이 안된 경우)
		if("${ empty user }"=="true") {
			if (confirm("사진올리기는 로그인 하신 후 이용이 가능합니다.\n로그인 하시겠습니까?")==false) {
				return;
			} else {
				location.href="../member/login_form.do";
				return;
			}
			
		}
		// 로그인이 된 경우 => 사진등록폼으로 이동
		location.href="insert_form.do"; // PhotoInsertFromAction
	}

</script>

</head>
<body>
	<div id="background">
	<div id="box">
		<img id="title" alt="" src="../images/maplelogo.png">
		<div class="row">
		  <div class="col-sm-6">
		  	<input class="btn btn-primary" type="button" value="사진올리기" onclick="photo_insert();">
		  </div>
		  <div class="col-sm-6" style="text-align: right;">
		  	<!-- 로그인이 안된 경우 -->
		  	<c:if test="${empty user}">
		  	<input class="btn btn-info" type="button" value="회원가입" onclick="location.href='../member/insert_form.do'">
		  	<input class="btn btn-primary" type="button" value="로그인" onclick="location.href='../member/login_form.do'">
		  	</c:if>
		  	
		  	<!-- 로그인이 된 경우 -->
		  	<c:if test="${not empty user}">
		  	<b>${user.mem_name}</b>님 환영합니다.
		  	<input class="btn btn-primary" type="button" value="로그아웃" onclick="location.href='../member/logout.do'">
		  	</c:if>
		  </div>
		</div>
	
	<div id="photo-box">
	
	<c:forEach begin="1" end="30">
		<div class="photo">
			<img src="../images/3F.png">
			<div class="title">몬스터명</div>
		</div>
	</c:forEach>
	</div>

	</div>
	</div>
</body>
</html>