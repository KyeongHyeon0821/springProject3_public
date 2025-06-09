<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>chatEndUserWin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
	  let socket;
	
	  function startChat() {
		  $("#endChatBtn").show();
		  $("#chatBackScreen").hide();
		  $("#adminTitle").hide();
		  
      const username = document.getElementById('username').value;
      if (username) {
        socket = new WebSocket('ws://192.168.50.65:9090/springProject3/webSocket/endPoint/' + username);
        //socket = new WebSocket('ws://49.142.157.251:9090/springProject3/webSocket/endPoint/' + username);

        // 상대방 유저가 접속/종료 하거나, 메세지를 날릴때 처리되는 곳
        socket.onmessage = (event) => {
        	if (event.data.startsWith("USER_LIST:")) {
        		let inputUser = event.data.substring(10);
            if((inputUser.split(",").length - 1) < 1) {
            	alert("현재 관리자가 미접속중입니다.\n관리자가 접속되어 있을때 실시간 상담이 가능합니다.");
            	location.reload();
            }
          } 
        	else {
	          let date = new Date();
	          let strToday = date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
	          let item = '<div class="d-flex flex-row mr-2"><span class="youWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
	          item += '<font color="brown" style="font-size:0.7em"> 관리자 로 부터</font><br/><span style="font-size:1em">' + event.data.split(":")[1] + '</span></span></div>';
	          document.getElementById('messages').innerHTML += item;
	          document.getElementById('message').value = '';
	          document.getElementById('message').focus();
	          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);
        	}
        };
        
        // 웹소켓 접속을 종료할때 처리되는 코드
        socket.onclose = () => {};

        // 소켓 접속후 기본 아이디를 화면에 출력시켜주고 있다.(접속 종료후도 계속 유지된다.)
        document.getElementById('chat').style.display = 'block';
        document.getElementById('username').style.display = 'none';
        document.querySelector('button[onclick="startChat()"]').style.display = 'none';
        document.getElementById('currentId').innerHTML = '<font color="red"><b>${sMid}</b></font>';
      }
	  }
	  
	  // 채팅 종료
	  function endChat() {
		  //alert('상담을 종료합니다.');
      window.close();
		}
	  
	  // 메세지 보내는 사용자의 메세지 출력폼에서 '전송'버튼을 눌렀을때 처리(socket.send())
	  document.addEventListener('DOMContentLoaded', () => {
      const form = document.getElementById('form');
      form.addEventListener('submit', (e) => {
        e.preventDefault();
        let target = "admin";
        const message = document.getElementById('message').value;
        if(message.trim() == "") {
        	alert("메세지를 입력후 전송해주세요");
        	return false;
        }
        if (target && message) {
          socket.send(target + ":" + message);
          let dt = new Date();
          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
          let item = '<div class="d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
          target = '관리자';
          item += '<font color="brown" style="font-size:0.7em">' + target + ' 에게</font><br/><span style="1em">' + message + '</span></span></div>';
          document.getElementById('messages').innerHTML += item;
          document.getElementById('message').value = '';
          document.getElementById('message').focus();
          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);
        }
      });
	  });

	  
	  // 메세지 보내기(여러줄 처리) - 메세지 입력후 엔터키 또는 시프트엔터키에 대한 처리후 메세지 보내기
	  $(function(){
		  $('#message').keyup(function(e) {
			  e.preventDefault();
			  let target = "관리자";
        const message = document.getElementById('message').value;
		  	if (e.keyCode == 13) {
		  		if(!e.shiftKey) {
			  		if(target != '' && $('#message').val().trim() != '') {
				  		let dt = new Date();
		          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
		          let item = '<div class="d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
		          item += '<font color="brown" style="font-size:0.7em">' + target + ' 에게</font><br/><span style="font-size:1em">' + message + '</span></span></div>';
		          item = item.replaceAll("\n","<br/>");
		          document.getElementById('messages').innerHTML += item;
		          document.getElementById('message').value = '';
		          document.getElementById('message').focus();
				  		$('#currentMessage').scrollTop($('#currentMessage').prop('scrollHeight'));
		          target = 'admin';
				  		socket.send(target + ":" + message.replaceAll("\n","<br/>"));
			  		}
		  		}
		  	}
		  });
	  });
	  
	  // 종료(x)버튼클릭시 수행처리내용
	  $(window).bind("beforeunload", function (e){
		  return "창을 닫으실래요?";
		 });
	  
	  // 새로고침 차단하기
	  function doNotReload(event){
	    if((event.ctrlKey && (event.keyCode === 78 || event.keyCode === 82)) || event.keyCode === 116) {
        event.preventDefault();
        return false;
	    }
		}
		document.addEventListener("keydown", doNotReload);
  </script>
  <style>
    li {
      list-style: none;
    }
    
    #currentMessage {
      width: 100%;
      height: 220px;
      float: left;
      border: 1px solid #ccc;
      padding-left: 10px;
      background-color: #eee;
      overflow: auto;
    }
    .messageBox {
      clear: both;
      padding-top: 10px;
    }
    .myWord {
      background-color: yellow;
    }
    .youWord {
      background-color: skyblue;
    }
    .form-text {
      font-size: 0.9rem;
      color: #888;
    }
  </style>
</head>
<body oncontextmenu="return false">
<div class="container">
  <div id="adminTitle">
	  <h4 class="text-center">채팅상담</h4>
	  <h1 class="form-text text-center m-0">관리자 접속시에만 채팅이 가능합니다.</h1>
	  <hr class="border-secondary">
  </div>
  <div>접속중인 사용자 : 
	  <input type="text" id="username" value="${sMid}" readonly style="border:0px;text-align:center;color:red;font-weight:bolder;width:100px" />
	</div>
	<div>
	  <button onclick="startChat()" class="btn btn-success form-control">상담시작</button>
	  <button onclick="endChat()" id="endChatBtn" class="btn btn-warning form-control" style="display:none;">상담종료</button>
  </div>
  <div id="chatBackScreen" class="text-center mt-3">
    <img src="${ctp}/images/logo.png" width="180px"/>
  </div>
  <div id="chat" class="mt-1" style="display:none;">
    <form name="myform" id="form">
	    <div id="currentMessage">
	    	<h5>메세지 출력창</h5>
	    	<div id="messages"></div>
	    </div>
      <div class="messageBox input-group">
	      <textarea name="message" id="message" placeholder="메세지를 입력하세요." class="form-control"></textarea>
	      <button class="input-group-append btn btn-success">메세지전송</button>
      </div>
      <div class="text-center" style="font-size:0.7em">(메세지 입력후 '전송'버튼을 누르세요)</div>
    </form>
  </div>
</div>
</body>
</html>