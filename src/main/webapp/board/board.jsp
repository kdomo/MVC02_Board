<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<style>
.container {
	width: 1000px;
	margin: auto;
	text-align: center;
}

.header {
	margin-top: 60px;
	margin-bottom: 40px;
}

tr {
	border: 1px solid gray;
}

.topButtons {
	text-align: right;
}

.footer {
	text-align: right;
}
</style>
<body>
	<div class="container">
		<div class="row header">
			<h1 class="col-12">게시판</h1>
		</div>
		<div class="topButtons row">
			<div class="col-12">
				<button type="button" class="btn btn-secondary mb-3" id="btn_logout">로그아웃</button>
				<button type="button" class="btn btn-dark mb-3" id="btn_write">글쓰기</button>
			</div>
		</div>
		<table class="table">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>작성일</th>
			</tr>
			<tr>
				<td>1</td>
				<td>비오는 월요일~</td>
				<td>MonMon</td>
				<td>2020-11-10</td>
			</tr>
		</table>
		<div class="footer row">
			<div class="col-12">
				<button type="button" class="btn btn-secondary mb-3" id="btn_home">홈으로</button>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			$('#btn_home').on('click', function() {
				location.href = "${pageContext.request.contextPath}/";
			});
			$('#btn_logout').on('click',function() {
				location.href = "${pageContext.request.contextPath}/logoutProc.mem";
			});
			$('#btn_write').on('click',function(){
				location.href = "${pageContext.request.contextPath}/writeMove.bd";
			});
			
		});
	</script>
</body>
</html>