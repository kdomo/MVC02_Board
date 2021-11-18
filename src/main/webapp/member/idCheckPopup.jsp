<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>  
</head>
<body>
<form action="/idCheckProc.mem" method="post">
	<div class="container">
		<div class="row mb-4">
			<div class="col-8 mb-3">
				<input type="text" class="form-control" id="idInput" name="idInput" placeholder="아이디" value="${idInput}">
			</div>
			<div class="col-4 mb-3">
				<button type="submit" class="btn btn-dark col-12" id="btn_check">아이디 확인</button>
            </div>
		</div>
		<div class="row mb-4">
		    <div class="col mb-3">
                <h5>확인결과 : </h5>
            </div>
		</div>
		<div class="row mb-4">
            <div class="col mb-3">
            	<c:if test="${rs eq 'unavailable'}">
            		<p id="rs">사용이 불가능한 아이디입니다.</p>
            	</c:if>
            	<c:if test="${rs eq 'available'}">
            		<p id="rs">사용이 가능한 아이디입니다.</p>
            	</c:if>
            </div>
		</div>
		<div class="row justify-content-center pt-4">
            <div class="col-4 d-flex justify-content-center">
                <button type="button" class="btn btn-secondary col-sm-12" id="btn_back">취소</button>
                <button type="button" class="btn btn-dark col-sm-12" id="btn_submit">사용</button>
            </div>
		</div>
	</div>
</form>
<script>
	let rs = document.getElementById("rs");
	let btn_submit = document.getElementById("btn_submit");
	let btn_back = document.getElementById("btn_back");
	let idInput = document.getElementById("idInput");
	
	if(rs.innerHTML == "사용이 가능한 아이디입니다."){
		rs.style.color = "green";
	}else{
		rs.style.color = "red";
		btn_submit.disabled = true;
	}
	
	btn_back.addEventListener("click",function(){
		self.close();
	})
	btn_submit.addEventListener("click",function(){
		opener.document.signupForm.id.value = idInput.value;
		opener.document.signupForm.id.disabled = true;
		self.close();
	})
</script>
</body>
</html>