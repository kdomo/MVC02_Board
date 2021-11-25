<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
	integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
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

.Buttons {
	text-align: center;
}

input {
	width: 100%;
}

#content {
	resize: none;
	width: 100%;
	height: 360px;
}
</style>
<body>
	<div class="container">
		<div class="row header">
			<h1 class="col-12">글쓰기</h1>
		</div>
		<form action="${pageContext.request.contextPath}/writeProc.bd" method="post" id="boardForm">
			<table class="table">
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title"></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td><input type="file"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea id="content" name="content"
							placeholder="내용을 입력하세요."></textarea></td>
				</tr>
			</table>
			<div class="buttons row">
				<div class="col-12">
					<button type="button" class="btn btn-secondary mb-3" id="btn_back">뒤로가기</button>
					<button type="button" class="btn btn-dark mb-3" id="btn_submit">저장</button>
				</div>
			</div>
		</form>
	</div>

	<script>
		$(function() {
			$('#btn_back').on('click', function() {
				location.href = "/boardMove.bd?currentPage=1";
			});
			
			$('#btn_submit').on('click', function() {
				if(!($('#title').val() == "" || $('#content').val() == "")){
					$('#boardForm').submit();
				}
			});
		});
	</script>
</body>
</html>