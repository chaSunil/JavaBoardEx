<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wonder .. let's go</title>
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
	#box {
		width: 1500px;
		margin: auto;
		margin-top: 50px;
	}
	#title {
		text-align: center;
		font-weight: bold;
		font-size: 32px;
		color: skyblue;
		text-shadow: 1px 1px 1px gray;
	}
	.go {
		background: skyblue;
		border: white;
		margin-bottom: 35px;
	}
	#empty_msg {
		text-align: center;
		margin-top: 150px;
	}
	td {
		vertical-align : middle !important;
	}

</style>
<script type="text/javascript">
	function del(mem_idx) {
		
		if(confirm("정말 삭제 하시겠습니까?")==false) return;
		
		// 삭제요청
		location.href = "delete.do?mem_idx=" + mem_idx; // MemberDeleteAction 
		
		// 본인계정은 삭제 후에 session을 삭제시켜서 로그아웃 시켜야한다.
		// 관리자계정은 본인삭제가 불가능하게 만들어야 한다.
		
	}
</script>

<script type="text/javascript">

	$(document).ready(function(){
			setTimeout(showMessage, 100);
	});
	
	function showMessage() {
		if("${ param.reason == 'fail_delete'}" == "true") {
			alert("관리자 계정은 삭제할 수가 없습니다.");
		}
	}

</script>

</head>
<body>

	<div id="box">
		<div id="title">
			<h1>방문하신 여러분 환영합니다.</h1>
			<img alt="" src="https://www.wonderking.co.kr/img/WonderKingLogo.png">
		</div>
		<div style="text-align: right; float: right;">
		
			<!-- 로그인이 안된경우 -->
			<c:if test="${ empty sessionScope.user }">
				<input class="btn btn-primary go" type="button" value="로그인" onclick="location.href='login_form.do'">
			</c:if>
			
			<!-- 로그인이 된경우 not or !  -->
			<c:if test="${ not empty sessionScope.user }">
				<b>${ sessionScope.user.mem_name }님 어서오십시오.</b>
				<input class="btn btn-primary go" type="button" value="로그아웃" onclick="location.href='logout.do'">
			</c:if>
			
		</div>
			<div style="margin-top: 50px; text-align: right; float: right;">
			<c:if test="${ empty user }">
				<input class="btn btn-primary go" type="button" value="회원가입" onclick="location.href='insert_form.do'">
			</c:if>
			<c:if test="${ not empty user }">
			</c:if>
				<input class="btn btn-primary go" type="button" value="캐시충전" onclick="location.href='login_form.do'">
			</div>
			
			<table class="table">
				<tr class="info">
					<th>회원번호</th>
					<th>회원명</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>아이피</th>
					<th>가입일자</th>
					<th>회원등급</th>
					<th>편집</th>
				</tr>
			<!-- 데이터가 있는 경우 -->
			<!-- for(Member Vo vo : list) -->
			<c:forEach var="vo" items="${ list }">
				<tr>
					<td>${ vo.mem_idx }</td>
					<td>${ vo.mem_name }</td>
					<td>${ vo.mem_id }</td>
					<td>${ vo.mem_pwd }</td>
					<td>${ vo.mem_zipcode }</td>
					<td>${ vo.mem_addr }</td>
					<td>${ vo.mem_ip }</td>
					<td>${ fn:substring(vo.mem_regdate,0,10) }</td>
					<td>${ vo.mem_grade }</td>
					<td>
						<!-- 관리자나 idx값이 해당되는 유저(for문으로 한 번만 적용됨)면 -->
						<c:if test="${ (user.mem_grade eq '관리자') or (user.mem_idx eq vo.mem_idx) }">
							<input class="btn btn-primary" type="button" value="수정" onclick= "location.href='modify_form.do?mem_idx=${vo.mem_idx}'">
							<input class="btn btn-danger" type="button" value="삭제" onclick="del('${vo.mem_idx}');">
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
			<!-- 데이터가 없는 경우 -->
			<c:if test="${ empty requestScope.list }">
				<div id="empty_msg">등록된 회원 정보가 없습니다.</div>
			</c:if>
			
	</div>

</body>
</html>