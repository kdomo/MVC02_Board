<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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

.header {
	margin-top:60px;
	margin-bottom: 40px;
}

.foot {
	margin: auto;
	text-align: center;
}

p {
	margin: 0px;
	text-align: left;
}
</style>
</head>
<body>
	<div class="container">
		<form action="${pageContext.request.contextPath}/.mem" method="post" id="signupForm" name="signupForm">
			<div class="row header">
				<h1 class="col-12">회원가입</h1>
			</div>
			<div class="row">
				<div class="mb-3">
					<input type="text" class="form-control" id="id" name="id" placeholder="아이디" readonly>
				</div>
			</div>
<!-- 			<p id="idConfirm">*아이디는 6-12자 이내로 입력하세요.</p> -->
			<div class="row">
				<div class="mb-3">
					<input type="text" class="form-control" id="nickname"
						name="nickname" placeholder="닉네임" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col-4 mb-3">
					<select name="phone1" id="phone1" class="form-select" disabled>
						<option value="none" selected disabled>선택</option>
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
					</select>
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone2" name="phone2"
						placeholder="" readonly>
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone3" name="phone3"
						placeholder="" readonly>
				</div>
				<div class="row d-none">
				<input type="text" class="form-control" id="phone" name="phone">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" id="postcode" placeholder="우편번호" name="postcode"
						class="form-control" readonly>
				</div>
				<div class="col-6 mb-3">
					<input type="button" onclick="Postcode()" value="우편번호 찾기"
						class="btn btn-dark col-12" id="btn_post" disabled>
				</div>
			</div>
			<div class="row">
				<div class="col-12 mb-3">
					<input type="text" class="form-control" id="roadAddress"
						name="roadAddress" placeholder="도로명주소" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="detailAddress"
						name="detailAddress" placeholder="상세주소" readonly>
				</div>
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="extraAddress"
						name="extraAddress" placeholder="읍/면/동" readonly>
				</div>
				<input type="text" class="form-control d-none" id="address" name="address" readonly>
			</div>
			<div class="row foot">
				<div class="col-12 col align-self-start divModify">
					<button type="button" class="btn btn-secondary col-3" id="btn_back">홈으로</button>
					<button type="button" class="btn btn-dark col-3" id="btn_modify">수정</button>
				</div>
				<div class="col-12 col align-self-start divSubmit">
					<button type="button" class="btn btn-secondary col-3" id="btn_cancel">취소</button>
					<button type="button" class="btn btn-dark col-3" id="btn_submit">완료</button>
				</div>
			</div>
		</form>
	</div>

<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		$('.divSubmit').css("display","none"); //취소,완료 버튼은 바로 숨겨준다.
		
		$('#btn_modify').on('click',function(){ //수정 버튼을 누르면
			$('.divModify').css("display","none"); //홈으로 , 수정 버튼이 사라지고
			$('.divSubmit').css("display","block"); // 취소 , 완료 버튼이 나타난다
			$('#nickname').attr("readonly",false);
			$('#phone1').attr("disabled",false);
			$('#phone2').attr("readonly",false);
			$('#phone3').attr("readonly",false);
			$('#postcode').attr("readonly",false);
			$('#btn_post').attr("disabled",false);
			$('#roadAddress').attr("readonly",false);
			$('#detailAddress').attr("readonly",false);
			$('#extraAddress').attr("readonly",false);
		});
		
		$('#btn_cancel').on('click',function(){ //취소 버튼을 누르면
			$('.divSubmit').css("display","none"); // 취소 , 완료 버튼이 사라지고
			//readonly가 다시걸리게끔
			$('.divModify').css("display","block"); //홈으로 , 수정 버튼이 나타난다.
			$('#nickname').attr("readonly",true);
			$('#phone1').attr("disabled",true);
			$('#phone2').attr("readonly",true);
			$('#phone3').attr("readonly",true);
			$('#postcode').attr("readonly",true);
			$('#btn_post').attr("disabled",true);
			$('#roadAddress').attr("readonly",true);
			$('#detailAddress').attr("readonly",true);
			$('#extraAddress').attr("readonly",true);
		});
		
		$('#btn_back').on('click',function(){
			location.href = "/index2Move.mem";
		});
	});
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function Postcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== ''
							&& /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== ''
							&& data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("roadAddress").value = roadAddr;

					// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
					if (roadAddr !== '') {
						document.getElementById("extraAddress").value = extraRoadAddr;
					} else {
						document.getElementById("extraAddress").value = '';
					}
					
					$('#postcode').css("border","2px solid green");
					postcodeNull = true;
					$('#roadAddress').css("border","2px solid green");
					roadAddressNull = true;
					$('#extraAddress').css("border","2px solid green");
					extraAddressNull = true;
				}
			}).open();
}
</script>
</body>
</html>