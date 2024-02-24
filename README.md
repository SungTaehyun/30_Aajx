### To-do
- 회원 가입 버튼 클릭 시 ID중복 확인 후 가입하기

### JavaScript 변수, 객체 사용법
```
var id = document.getElementById("ID값");
var name = document.getElementByName("name값")
```

```
// Object
var obj = new Object();
obj.key = value;
obj['key'] = value;

var val = obj.key;
var val = obj['key'];

console.log(val); 

// equal op
console.log(100 == '100');
console.log(1 == true);

// strict equal op
console.log(100 === '100');
console.log(1 === true);
```

### XMLHttpRequest 사용법

```
// UNSENT (숫자 0) : XMLHttpRequest 객체가 생성됨.
// OPENED (숫자 1) : open() 메소드가 성공적으로 실행됨.
// HEADERS_RECEIVED (숫자 2) : 모든 요청에 대한 응답이 도착함.
// LOADING (숫자 3) : 요청한 데이터를 처리 중임.
// DONE (숫자 4) : 요청한 데이터의 처리가 완료되어 응답할 준비가 완료됨.

var httpRequest;
	// btnSend 버튼이 클릭되었을때 이벤트 추가
	document.getElementById("btnSend")
           .addEventListener('click', () => {
		// inputName 값 가져오기
		var inputName = document.getElementById("inputName").value;
		// 파라미터 담을 Object 선언
		var reqJson = new Object();
		reqJson.name = inputName;
		// XMLHttpRequest 객체 정의 
		httpRequest = new XMLHttpRequest();
		// xmlHttpRequest event
		// https://developer.mozilla.org/ko/docs/Web/API/XMLHttpRequest 

		// readyState 상태가 변경되면 
	    httpRequest.onreadystatechange = () => {
	    	// readyState DONE
		    if (httpRequest.readyState === XMLHttpRequest.DONE) {
						// httpRequest 상태(status) 가 OK(200)
			      if (httpRequest.status === 200) {
				    	var result = httpRequest.response;
			        document.getElementById("name").innerText = result.name;
			        document.getElementById("age").innerText = result.age;
			      } else if (httpRequest.status === 404) {
			        alert('404 Not Found');
			      } else if (httpRequest.status === 500) {
			        alert('500 Internal Server Error');
			      }
				}
	    };
			// Post 방식의 비동기 전송
	    httpRequest.open('POST', '/join.do', true);
			// Post 방식의 동기 전송
//	  httpRequest.open('POST', '/join.do', false);

	    // 요청 Header에 컨텐츠 타입은 Json 정의
	    httpRequest.setRequestHeader('Content-Type', 'application/json');
	    // Response Type을 Json으로 정의
	    httpRequest.responseType = "json";
	    // Json 형태로 전송
	    httpRequest.send(JSON.stringify(reqJson));
	});
```
