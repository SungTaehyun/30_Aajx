<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>CodePen - Flat Login Form</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900'>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Montserrat:400,700'>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script type="text/javascript">
	window.onload = function(e) {
		var resultMsg = "${resultMsg}";
		if(resultMsg.length > 0) {
			alert(resultMsg);
		}
	}
</script>
</head>
<body>
<!-- partial:index.partial.html -->
<div class="container">
  <div class="info">
    <h1>Flat Login Form</h1><span>Made with <i class="fa fa-heart"></i> by <a href="http://andytran.me">Andy Tran</a></span>
  </div>
</div>
<div class="form">
  <div class="thumbnail"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/169963/hat.svg"/></div>
  <form class="register-form" action="<c:url value='/sign-up.do'/>" method="post">
    <input type="text" placeholder="ID" name="memberId" id="memberId" required/>
    <span id="idCheckMsg"></span>
    <input type="password" placeholder="Password" name="passwd" required/>
    <input type="text" placeholder="Name" name="memberName" required/>
    <input type="text" placeholder="Nickname" name="nickname" required/>
    <input type="text" placeholder="Email address" name="email" required/>
    <button>create</button>
    <p class="message">Already registered? <a href="#">Sign In</a></p>
  </form>
  <form class="login-form">
    <input type="text" placeholder="ID" name="memberId" required/>
    <input type="password" placeholder="Password" name="passwd" required/>
    <button>login</button>
    <p class="message">Not registered? <a href="#">Create an account</a></p>
  </form>
</div>
<video id="video" autoplay="autoplay" loop="loop" poster="polina.jpg">
  <source src="http://andytran.me/A%20peaceful%20nature%20timelapse%20video.mp4" type="video/mp4"/>
</video>
<!-- partial -->
  <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
  <script  src="${pageContext.request.contextPath}/resources/js/script.js"></script>
  <script>
  	$(document).ready(function(){
  		// ID 중복 확인
  		$('#memberId').on('focusout', function(){
  			// 6자리 이하 가입 막기
  			var memberId = $("#memberId").val();
  			if(memberId.trim() == '' || memberId.length <= 6) {
				$("#idCheckMsg").css("color", "red").text("ID는 7자리 이상이어야 합니다.");
				return false;
			}
  			// Ajax로 전송
			$.ajax({
				url: './confirmId.do',
				type: 'POST',
				data: {
					'memberId': memberId
				},
				dataType:'json',
				success: function(result) { // 컨트롤러에서 넘어온 result를 받는다.
					if(result == "0") {
						$("#idCheckMsg").css("color", "green").text("사용 가능한 ID입니다.");
					} else {
						$("#idCheckMsg").css("color", "red").text("ID 중복입니다.");
						$("#memberId").val('');
					}
				},
				error:function(){
	                alert("에러입니다");
	            }
			}); // ajax end
  		});
  	})
  </script>
</body>
</html>