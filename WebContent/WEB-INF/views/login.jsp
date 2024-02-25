<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>CodePen - Flat Login Form</title>
  <!-- 필요한 CSS 파일 및 외부 라이브러리 등을 로드합니다. -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900'>
  <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Montserrat:400,700'>
  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <!-- JavaScript 코드를 작성합니다. -->
  <script type="text/javascript">
    var ctx = '${pageContext.request.contextPath}'; // JSP 내부의 EL(Expression Language)을 사용하여 컨텍스트 경로를 가져옵니다.
    
    window.onload = function(e) {
      console.log(ctx); // 컨텍스트 경로를 콘솔에 출력합니다.(경로가 설정됐는지 확인하기 위해)
      var btnCreate = document.getElementById('btnCreate'); // "create" 버튼을 가져옵니다.
      var regForm = document.getElementById('regForm'); // 회원가입 폼을 가져옵니다.
      
      regForm.onsubmit = function(){//var는 변수 선얺
        var memberId = document.getElementById('memberId').value; // 입력된 아이디를 가져옵니다.
        var passwd = document.getElementById('passwd').value; // 입력된 비밀번호를 가져옵니다.
        var memberName = document.getElementById('memberName').value; // 입력된 이름을 가져옵니다.
        var nickname = document.getElementById('nickname').value; // 입력된 닉네임을 가져옵니다.
        var email = document.getElementById('email').value; // 입력된 이메일을 가져옵니다.
        
        // 각 입력 필드의 값을 콘솔에 출력합니다.
        console.log(memberId);
        console.log(passwd);
        console.log(memberName);
        console.log(nickname);
        console.log(email); 
        
        // 모든 필드가 입력되었는지 확인합니다.
        if(memberId != '' && passwd != '' && memberName != '' && nickname != '' && email != ''){
          var param = new Object(); // 파라미터 객체를 생성합니다.
          param.memberId = memberId; // 파라미터에 아이디를 설정합니다.
          console.log(param);
          
          // XMLHttpRequest 객체를 생성합니다.
          httpRequest = new XMLHttpRequest();
          
          // XMLHttpRequest 이벤트 리스너를 설정합니다.
          httpRequest.onreadystatechange = () => {
            // 요청이 완료되면
            if (httpRequest.readyState === XMLHttpRequest.DONE) {
              // 응답 상태 코드가 200이면
              if (httpRequest.status === 200) {
                var result = httpRequest.response; // 응답 데이터를 가져옵니다.
                console.log(result); // 결과를 콘솔에 출력합니다.
                if(result!=0){
                	alert('id중복');
                	return false;
                }
                
                //회원가입 진행
                regForm.action = ctx + '/sign-up.do';
                regForm.submit();//위 코드와 같음.

                //document.getElementById("name").innerText = result.name; // 결과를 HTML에 출력합니다.
                //document.getElementById("age").innerText = result.age; // 결과를 HTML에 출력합니다.
              } else if (httpRequest.status === 404) { // 응답 상태 코드가 404이면
                alert('404 Not Found'); // 404 에러를 알립니다.
              } else if (httpRequest.status === 500) { // 응답 상태 코드가 500이면
                alert('500 Internal Server Error'); // 500 에러를 알립니다.
              }
            }
          };
          
          // POST 방식으로 서버에 요청을 보냅니다.
          httpRequest.open('POST', ctx+'/confirmId.do', true);
          httpRequest.setRequestHeader('Content-Type', 'application/json'); // 요청 헤더를 설정합니다.
          httpRequest.responseType = "json"; // 응답 타입을 JSON으로 설정합니다.
          
          // JSON 형태로 파라미터를 전송합니다.
          httpRequest.send(JSON.stringify(param));
          
          console.log('ready to submit');
        }
        return false; // 폼의 기본 동작을 막습니다.
      }
      
      console.log(btnCreate); // "create" 버튼을 콘솔에 출력합니다.
      
      var resultMsg = "${resultMsg}"; // JSP의 결과 메시지를 가져옵니다.
      if(resultMsg.length > 0) { // 결과 메시지가 존재하면
        alert(resultMsg); // 알림창에 결과 메시지를 표시합니다.
      }//resultMsg가 0이라는 값을 가지면, 보통 이는 회원가입이나 다른 양식의 제출이 성공했음을 의미( 성공적으로 처리되었다는 의미로 0을 반환)
    }
  </script>
</head>
<body>
<!-- 회원가입 폼을 구현합니다. -->
<div class="container">
  <div class="info">
    <h1>Flat Login Form</h1><span>Made with <i class="fa fa-heart"></i> by <a href="http://andytran.me">Andy Tran</a></span>
  </div>
</div>
<div class="form">
  <div class="thumbnail"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/169963/hat.svg"/></div>
  <form id="regForm" onsubmit="return false;" class="register-form" method="post"> <!-- 회원가입 폼을 구현합니다. -->
    <input type="text" placeholder="ID"  onclick="false" name="memberId" id="memberId" required/> <!-- 아이디 입력 필드를 구현합니다. -->
    <span id="idCheckMsg"></span> <!-- 아이디 중복 확인 결과를 표시하는 영역입니다. -->
    <input type="password" placeholder="Password" name="passwd" id="passwd" required/> <!-- 비밀번호 입력 필드를 구현합니다. -->
    <input type="text" placeholder="Name" name="memberName" id="memberName" required/> <!-- 이름 입력 필드를 구현합니다. -->
    <input type="text" placeholder="Nickname" name="nickname" id="nickname" required/>
    <input type="text" placeholder="Email address" name="email" id="email" required/>
    <button id="btnCreate">create</button>
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

  </script>
</body>
</html>