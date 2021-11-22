<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드 프로젝트 홈</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<style>
.container {
	width: 500px;
	margin: auto;
	text-align: center;
}

.join {
	text-align: left;
}

.find {
	text-align: right;
}

a {
	text-decoration: none;
	color: black;
}
.alert{
padding:6px;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${!empty loginSession}">
			<div class="container">
				<div class="row header">
					<h1 class="col-12">${loginSession}님환영합니다.</h1>
				</div>
				<div class="row">
					<div class="col-12">
						<button type="button" class="btn btn-secondary col-3"
							id="btn_logout">로그아웃</button>
						<button type="button" class="btn btn-dark col-3" id="btn_myPage">마이페이지</button>
						<button type="button" class="btn btn-dark col-3" id="btn_board">게시판</button>
						<button type="button" class="btn btn-danger col-3" id="btn_withdraw">회원탈퇴</button>
					</div>
				</div>
			</div>
			<script>
				$(function() {
					$('#btn_logout')
							.on(
									'click',
									function() {
										location.href = "${pageContext.request.contextPath}/logoutProc.mem";
									});

					$('#btn_myPage')
							.on(
									'click',
									function() {
										location.href = "${pageContext.request.contextPath}/mypageMove.mem";
									});
					$('#btn_withdraw').on('click',function(){
						let rs = confirm("정말 탈퇴하시겠습니까?");
						if(rs){
							location.href = "${pageContext.request.contextPath}/wirhdrawProc.mem";
						}
					});
				})
			</script>
		</c:when>
		<c:when test="${empty loginSession}">
			<div class="container">
				<form action="${pageContext.request.contextPath}/loginProc.mem"
					method="post" id="loginForm">
					<div class="row">
						<h1 class="col-12"><a href="/">Board</a></h1>
					</div>
					<div class="row">
						<div class="col-12 mb-3">
							<input type="text" class="form-control" id="id" name="id"
								placeholder="아이디">
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<input type="password" class="form-control" id="password"
								name="password" placeholder="비밀번호">
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<button type="button" class="btn btn-dark col-12" id="btn_login">로그인</button>
						</div>
					</div>
					<div class="row">
						<div class="col-6 join">
							<a href="${pageContext.request.contextPath}/signupMove.mem">회원가입</a>
						</div>
						<div class="col-6 find">
							<a href="">아이디</a>/<a href="">비밀번호 찾기</a>
						</div>
					</div>
					<c:if test="${rs eq 'fail'}">
						<div class="alert alert-dark" role="alert">
							아이디 또는 비밀번호가 일치하지 않습니다.
						</div>
					</c:if>
				</form>
			</div>
			<script>
				$(function() {
					$('#btn_login').on(
							'click',
							function() {
								if (($('#id').val() == "")
										|| ($('#password').val() == "")) {
									alert("아이디 혹은 비밀번호를 입력해주세요.");
									return;
								}
								$('#loginForm').submit();
							});
				})
			</script>
		</c:when>
	</c:choose>

</body>
</html>