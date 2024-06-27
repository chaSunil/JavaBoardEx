<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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

#title {
	text-align: center;
	font-size: 28px;
	
	margin-bottom: 60px
}

#box {
	width: 600px;
	margin: auto;
	margin-top: 100px;
}

textarea {
	resize: none;
}

th {
	vertical-align: middle !important;
	width: 15%;
}
</style>

<script type="text/javascript">

	function send(f) {
		
		// 입력값 검증
		let p_title = f.p_title.value.trim();
		let p_content = f.p_content.value.trim();
		let photo = f.photo.value;
		
		if(p_title=='') {
			alert("제목을 입력하세요!")
			f.p_title.value = "";
			f.p_title.focus();
			return;
		}
		if(p_content=='') {
			alert("내용을 입력하세요!")
			f.p_content.value = "";
			f.p_content.focus();
			return;
		}
		if(photo=='') {
			alert("사진을 선택하세요!")
			return;
		}
		
		f.action = "insert.do";// 전송대상(PhotoInsertAction)
		f.submit();
	}

</script>

</head>
<body>
	<form method="POST" enctype="multipart/form-data">
		<div id="box">
			<h1 id="title">여러분의 방문을 환영합니다.</h1>
			<!-- Ctrl + Shift + F -->
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>사진올리기</h4></div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<th>제목</th>
							<td><input class="form-control" name="p_title" autofocus></td>
						</tr>
						
						<tr>
							<th>내용</th>
							<td>
								<textarea class="form-control" rows="6" name="p_content"></textarea>
							</td>
						</tr>
						
						<tr>
							<th>사진</th>
							<td><input class="form-control" type="file" name="photo" required="required"></td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<input class="btn btn-success" type="button" value="메인화면"
									onclick="location.href='list.do'">
								<input class="btn btn-primary" type="button" value="사진올리기"
									onclick="send(this.form)">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
</body>
</html>