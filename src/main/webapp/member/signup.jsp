<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
	margin-bottom: 60px;
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
		<form action="${pageContext.request.contextPath}/signupProc.mem" method="post" id="signupForm" name="signupForm">
			<div class="row header">
				<h1 class="col-12">회원가입</h1>
			</div>
			<div class="row">
				<div class="col-8">
					<input type="text" class="form-control" id="id" name="id" placeholder="아이디">
				</div>
				<div class="col-4">
					<button type="button" class="btn btn-dark col-12" id="btn_check" disabled>중복
						확인</button>
				</div>

			</div>
			<p id="idConfirm">*아이디는 6-12자 이내로 입력하세요.</p>
			<div class="row">
				<div class="col-12">
					<input type="password" class="form-control" id="password" name="password"
						placeholder="비밀번호">
				</div>
			</div>
			<p id="pwConfirm">
				*비밀번호는 6-20자 이내로 입력하세요.<br> (영어 대소문자,숫자,특수문자 포함)
			</p>
			<div class="row">
				<div class="col-12">
					<input type="password" class="form-control" id="pwCheck" name="pwCheck"
						placeholder="비밀번호 확인">
				</div>
			</div>
			<p id="pwCheckConfirm">*비밀번호를 일치시켜주세요.</p>
			<div class="row">
				<div class="mb-3">
					<input type="text" class="form-control" id="nickname"
						name="nickname" placeholder="닉네임">
				</div>
			</div>
			<div class="row">
				<div class="col-4 mb-3">
					<select name="phone1" id="phone1" class="form-select">
						<option value="none" selected disabled>선택</option>
						<option value="010">010</option>
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
				<div class="row d-none">
				<input type="text" class="form-control" id="phone" name="phone">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" id="postcode" placeholder="우편번호" name="postcode"
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
						name="roadAddress" placeholder="도로명주소">
				</div>
			</div>
			<div class="row">
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="detailAddress"
						name="detailAddress" placeholder="상세주소">
				</div>
				<div class="col-6 mb-3">
					<input type="text" class="form-control" id="extraAddress"
						name="extraAddress" placeholder="읍/면/동">
				</div>
				<input type="text" class="form-control d-none" id="address" name="address">
			</div>
			<div class="row foot">
				<div class="col-12 col align-self-start">
					<button type="button" class="btn btn-secondary col-3" id="btn_back">취소</button>
					<button type="button" class="btn btn-dark col-3" id="btn_submit">가입</button>
				</div>
			</div>
		</form>
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	let idNull = false;
	let idRegex = false;
	
	let passwordNull = false;
	let passwordRegex = false;
	
	let pwCheckNull = false;
	let pwCheckEquals = false;
	
	let nicknameNull = false;
	let nicknameRegex = false;
	
	let phone1Null = false;
	
	let phone2Null = false;
	let phone2Regex = false;
	
	let phone3Null = false;
	let phone3Regex = false;

	let postcodeNull = false;
	let roadAddressNull = false;
	let detailAddressNull = false;
	let extraAddressNull = false;
	
		$(function() {
			$('#btn_check').on('click', function() {
				let url = "/idCheckPopup.mem?id=" + $('#id').val();
				let name = "아이디 중복검사";
				let option = "width=600, height=300 , top=300";
				window.open(url, name, option);
			});

			$('#btn_back').on('click', function() { //취소 버튼을 눌렀을때
				window.history.back();
			});
			
			$('#id').on('keyup', function() {
				let regexId = /^[a-zA-Z][a-zA-Z0-9]{5,11}$/g;
				if (!(regexId.test($('#id').val()))) {
					$('#idConfirm').html("*형식에 맞춰 입력해주세요.");
					$('#idConfirm').css("color", "red");
					$('#id').css("border", "2px solid red");
					$('#btn_check').attr('disabled', true);
					idRegex = false;
				} else {
					$('#idConfirm').html("*올바른 형식의 ID 입니다. 중복확인을 해주세요");
					$('#idConfirm').css("color", "gray");
					$('#id').css("border", "2px solid gray");
					$('#btn_check').attr('disabled', false);
					idRegex = true;
				}
				if ($('#id').val() == "") {
					$('#idConfirm').html("*아이디는 6-12자 이내로 입력하세요.");
					$('#idConfirm').css("color", "gray");
					$('#id').css("border", "");
					$('#btn_check').attr('disabled', true);
					idNull = false;
				} else {
					idNull = true;
				}
			});
			$('#password').on('keyup', function() {
				let regexPw = /^[a-zA-Z0-9~!@#$%^&*+.]{6,20}$/g;
				
				$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
				$('#pwCheckConfirm').css("color", "gray");
				$('#pwCheck').css("border", "");
				$('#pwCheck').val("");
				
				
				if (!(regexPw.test($('#password').val()))) {
					$('#pwConfirm').html("*형식에 맞춰 입력해주세요.");
					$('#pwConfirm').css("color", "red");
					$('#password').css("border", "2px solid red");
					passwordRegex = false;
                } else {
                	$('#pwConfirm').html("*올바른 형식의 PassWord 입니다.");
					$('#pwConfirm').css("color", "green");
					$('#password').css("border", "2px solid green");
					passwordRegex = true;
                    return;
                }

                if ($('#pw').val() == "") {
                	$('#pwConfirm').html("*비밀번호는 6-20자 이내로 입력하세요.<br>(영어 대소문자,숫자,특수문자 포함)");
					$('#pwConfirm').css("color", "gray");
					$('#pw').css("border", "");
					passwordNull = false;
                    return;
                } else {
                	passwordNull = true;
                    return;
                }
			});
			
			$('#pwCheck').on('keyup', function() {
				 	if ($('#password').val() == "") {
					 	$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
						$('#pwCheckConfirm').css("color", "gray");
						$('#password').css("border", "");
						$('#pwCheck').val("");
	                } else {
	                    if ($('#password').val() !== $('#pwCheck').val()) {
	                    	$('#pwCheckConfirm').html("*비밀번호가 일치하지 않습니다.");
							$('#pwCheckConfirm').css("color", "red");
							$('#pwCheck').css("border", "2px solid red");
							pwCheckEquals = false;
	                    } else {
	                    	$('#pwCheckConfirm').html("*비밀번호가 일치합니다.");
							$('#pwCheckConfirm').css("color", "green");
							$('#pwCheck').css("border", "2px solid green");
							pwCheckEquals = true;
	                    }
	                    if ($('#pwCheck').val()=="") {
	                    	$('#pwCheckConfirm').html("*비밀번호를 일치시켜주세요.");
							$('#pwCheckConfirm').css("color", "gray");
							$('#pwCheck').css("border", "2px solid red");
							pwCheckNull = false;
	                    } else {
	                        pwCheckNull = true;
	                        return;
	                    }
	                }
			});
			
			$('#nickname').on('keyup',function(){
				let regexNickname = /^[가-힣a-zA-Z0-9]{2,20}$/g;
				
				if(!(regexNickname.test($('#nickname').val()))){
					$('#nickname').css("border", "2px solid red");
					nicknameRegex = false;
				}else{
					$('#nickname').css("border", "2px solid green");
					nicknameRegex = true;
				}
				if ($('#nickname').val()=="") {
					$('#nickname').css("border", "");
					nicknameNull = false;
                } else {
                	nicknameNull = true;
                    return;
                }
			});
			
			$('#phone1').on('change',function(){
				$('#phone1').css("border","2px solid green");
				phone1Null = true;
			})
			
			$('#phone2').on('keyup',function(){
				 let regexPhone = /^[0-9]{4}$/g;
	                if (!(regexPhone.test($('#phone2').val()))) {
	                	$('#phone2').css("border","2px solid red");
	                	phone2Regex = false;
	                } else {
	                	$('#phone2').css("border","2px solid green");
	                	phone2Regex = true;
	                }
	                if ($('#phone2').val() == "") {
	                	$('#phone2').css("border","");
	                	phone2Null = false;
	                } else {
	                	phone2Null = true;
	                }
			})
			
			$('#phone3').on('keyup',function(){
				 let regexPhone = /^[0-9]{4}$/g;
	                if (!(regexPhone.test($('#phone3').val()))) {
	                	$('#phone3').css("border","2px solid red");
	                	phone3Regex = false;
	                } else {
	                	$('#phone3').css("border","2px solid green");
	                	phone3Regex = true;
	                }
	                if ($('#phone3').val() == "") {
	                	$('#phone3').css("border","");
	                	phone3Null = false;
	                } else {
	                	phone3Null = true;
	                }
			})
			
			$('#detailAddress').on('keyup',function(){
	                
	                if ($('#detailAddress').val() == "") {
	                	$('#detailAddress').css("border","2px solid red");
	                	detailAddressNull = false;
	                } else {
	                	$('#detailAddress').css("border","2px solid green");
	                	detailAddressNull = true;
	                }
			})
			

			$('#btn_submit').on('click',function() { //가입 버튼을 눌렀을때
				if(idNull == true && idRegex == true &&
					passwordNull == true && passwordRegex == true &&
					pwCheckNull == true && pwCheckEquals == true &&
					nicknameNull == true && nicknameRegex == true &&
					phone1Null == true &&
					phone2Null == true && phone2Regex == true &&
					phone3Null == true && phone3Regex == true &&
					postcodeNull == true &&
					roadAddressNull == true &&
					detailAddressNull == true &&
					extraAddressNull == true
					){
					$('#phone').val($('#phone1').val()+$('#phone2').val()+$('#phone3').val());
					$('#address').val($('#roadAddress').val()+" "+$('#detailAddress').val()+$('#extraAddress').val());
					$('#id').attr("disabled",false);
					$('#signupForm').submit();
				}else{
					alert("모든 값을 입력해주세요.");
				}
			});
			
		})
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