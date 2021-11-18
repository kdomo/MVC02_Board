<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
 .container {
            width: 500px;
            margin: auto;
            text-align: center;
        }

        .header {
            margin-bottom: 60px;
        }
        .foot{
            margin: auto;
            text-align: center;
        }
</style>
</head>
<body>
	<div class="container">
		<form action=".do" method="post" id="signupForm" name="signupForm">
			<div class="row header">
				<h1 class="col-12">회원가입</h1>
			</div>
			<div class="row">
				<div class="col-8 mb-3">
					<input type="text" class="form-control" id="id" name="id" placeholder="아이디">
				</div>
				<div class="col-4 mb-3">
					<button type="button" class="btn btn-dark col-12" id="btn_check">아이디
						확인</button>
				</div>

			</div>
			<div class="row">
				<div class="mb-3">
					<input type="password" class="form-control" id="pw"
						placeholder="비밀번호">
				</div>
			</div>
			<div class="row">
				<div class="mb-3">
					<input type="password" class="form-control" id="pwCheck"
						placeholder="비밀번호 확인">
				</div>
			</div>
			<div class="row">
				<div class="mb-3">
					<input type="text" class="form-control" id="nickname"
						placeholder="닉네임">
				</div>
			</div>
			<div class="row">
				<div class="col-4 mb-3">
					<select name="phone1" id="phone1" class="form-select">
						<option value="010" selected>010</option>
						<option value="011">011</option>
						<option value="019">019</option>
					</select>
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone2" name="phone2"
						placeholder="">
				</div>
				<div class="col-4 mb-3">
					<input type="text" class="form-control" id="phone3" name="phone3"
						placeholder="">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" id="postcode" placeholder="우편번호"
						class="form-control">
				</div>
				<div class="col-6 mb-3">
					<input type="button" onclick="Postcode()" value="우편번호 찾기"
						class="btn btn-dark col-12">
				</div>
			</div>
			<div class="row">
				<div class="col-12 mb-3">
					<input type="text" class="form-control" id="roadAddress"
						placeholder="도로명주소">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="detailAddress"
						placeholder="상세주소">
				</div>
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="extraAddress"
						placeholder="읍/면/동">
				</div>
			</div>
			  <div class="row foot">
                <div class="col-12 col align-self-start">
                    <button type="button" class="btn btn-secondary col-3">취소</button>
                    <button type="button" class="btn btn-dark col-3">가입</button>
                </div>
            </div>
		</form>
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
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

						}
					}).open();
		}
	</script>
	<script>
		$(function(){
			$('#btn_check').on('click',function(){
				console.log('hi');
				let url="/idCheckPopup.mem";
				let name="아이디 중복검사";
				let option="width=600, height=300 , top=300";
				window.open(url , name , option);
			});
		})
	</script>
	
	
</body>
</html>