<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 글 조회</title>
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
.topButtons{
text-align:right;
}
</style>
<body>
	<div class="container">
		<div class="col-12 topButtons">
			<button type="button" class="btn btn-secondary mb-3" id="btn_logout">로그아웃</button>
		</div>
		<div class="row header">
			<h1 class="col-12">상세 글 조회</h1>
		</div>
		<form action="${pageContext.request.contextPath}/modifyProc.bd"
			method="post" id="detailForm">
			<table class="table">
				<tr>
					<th>제목</th>
					<td colspan="5"><input type="text" value="${dto.getTitle()}"
						id="title" name="title" readonly></td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td><input type="text" value="${dto.getWriter()}" id="writer"
						name="writer" readonly></td>
					<th>날짜</th>
					<td><input type="text" value="${dto.getWritten_date()}"
						id="written_date" name="written_date" readonly></td>
					<th>조회수</th>
					<td><input type="text" value="${dto.getView_count()}"
						id="view_count" name="view_count" readonly></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5"><textarea id="content" name="content" readonly>${dto.getContent()}</textarea></td>
				</tr>
			</table>
			<div class="noneDiv d-none">
				<input type="text" id="seq_board" value="${dto.getSeq_board()}" name="seq_board">
				<input type="text" id="writer_id" value="${dto.getWriter_id()}" name="writer_id">
			</div>
			<c:choose>
				<c:when test="${loginSession.get('id') ne dto.getWriter_id()}">
					<div class="ahter-buttons row " id="before">
						<div class="col-12">
							<button type="button" class="btn btn-secondary mb-3"
								id="btn_back">뒤로가기</button>
						</div>
					</div>
				</c:when>
				<c:when test="${loginSession.get('id') eq dto.getWriter_id()}">
					<div class="buttons row" id="before">
						<div class="col-12">
							<button type="button" class="btn btn-secondary mb-3"
								id="btn_back">뒤로가기</button>
							<button type="button" class="btn btn-dark mb-3" id="btn_modify">수정</button>
							<button type="button" class="btn btn-dark mb-3" id="btn_delete">삭제</button>
						</div>
					</div>
					<script>
					$('#btn_modify').on('click', function() {
						$('#after').css("display", "block");
						$('#before').css("display", "none");
						
						$('#title').removeAttr("readonly");
						$('#content').removeAttr("readonly");
						
						
					});
					$('#btn_delete')
							.on(
									'click',
									function() {
										let rs = confirm("정말 삭제하시겠습니까?");
										if (rs) {
											location.href = "${pageContext.request.contextPath}/deleteProc.bd?seq_board=${dto.getSeq_board()}";
										}
									});
					</script>
				</c:when>
			</c:choose>
			<div class="buttons row" id="after">
				<div class="col-12">
					<button type="button" class="btn btn-dark mb-3" id="btn_cancel">취소</button>
					<button type="button" class="btn btn-dark mb-3" id="btn_submit">완료</button>
				</div>
			</div>
		</form>
	</div>
	<script>
		$(function() {
			$('#after').css("display", "none");

			$('#btn_submit').on('click',function(){
				if($('#title').val() == "" || $('#content').val() == ""){
					alert("타이틀 혹은 내용을 입력하세요.");
					return;
				}
				$('#detailForm').submit();
			});
			
			$('#btn_back')
					.on(
							'click',
							function() {
								location.href = "${pageContext.request.contextPath}/boardMove.bd";
							});
			$('#btn_logout')
					.on(
							'click',
							function() {
								location.href = "${pageContext.request.contextPath}/logoutProc.mem";
							});
			$('#btn_cancel').on('click',function(){
				location.href = "${pageContext.request.contextPath}/detailViewMove.bd?seq_board=${dto.getSeq_board()}";
			});
		})
	</script>
</body>
</html>