<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminChat.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
    'use strict';
    
	  let socket;
	
	  function startChat() {
		  $("#startChatUser").hide();
		  $("#endChatUser").show();
		  $("#chatStatusMessage").show();
      const username = document.getElementById('username').value;
      if (username) {
        socket = new WebSocket('ws://192.168.50.65:9090/springProject3/webSocket/endPoint/' + username);
       // socket = new WebSocket('ws://49.142.157.251:9090/springProject3/webSocket/endPoint/' + username);

        socket.onmessage = (event) => {
        	if (event.data.startsWith("USER_LIST:")) {
            let inputUser = event.data.substring(10);
            updateUserList(inputUser.replace("admin",""));
          } 
        	else {
	          let dt = new Date();
	          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
	          let item = '<div class="d-flex flex-row mr-2"><span class="youWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
	          item += '<font color="brown">' + event.data.split(":")[0] + ' 로 부터</font><br/><font size="3">' + event.data.split(":")[1] + '</font></span></div>';
	          document.getElementById('messages').innerHTML += item;
	          document.getElementById('message').value = '';
	          document.getElementById('message').focus();
	          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);
        	}
        };
        
        document.getElementById('chat').style.display = 'block';
        document.getElementById('username').style.display = 'none';
        document.querySelector('button[onclick="startChat()"]').style.display = 'none';
      }
	  }
	  
	  function endChat() {
      location.reload();
		}
	  
	  // 사용자가 새롭게 추가되거나 접속종료시에 회원목록을 업데이트 한다.
	  let userCount = 0;
	  function updateUserList(userList) {
	    const users = userList.split(",");
	    userCount = users.length - 1;
	    $("#userCount").html("<font color='red'>"+userCount+"</font>명");
	    const usersElement = document.getElementById('users');
	    usersElement.innerHTML = '';  // Clear current list
	    users.forEach(user => {
        const item = document.createElement('option');
        item.textContent = user;
        if(item.text != "관리자") usersElement.appendChild(item);
	    });
		}
	
	  // 메세지 보내기(전송버튼클릭시)
	  document.addEventListener('DOMContentLoaded', () => {
      const form = document.getElementById('form');
      form.addEventListener('submit', (e) => {
        e.preventDefault();
        const target = document.getElementById('targetUser').value;
        const message = document.getElementById('message').value;
        if(userCount == 0 || target.trim() == "") {
        	alert("전송할 회원 아이디를 선택후 메세지를 전송해주세요");
        	return false;
        }
        else if(message.trim() == "") {
        	alert("메세지를 입력후 전송해주세요");
        	return false;
        }
        if (target && message) {
          socket.send(target + ":" + message);
          let dt = new Date();
          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
          let item = '<div class="d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
          item += '<font color="brown">' + target + ' 에게</font><br/><font size="3">' + message + '</font></span></div>';
          document.getElementById('messages').innerHTML += item;
          document.getElementById('message').value = '';
          document.getElementById('message').focus();
          $('#currentMessage').scrollTop($('#currentMessage')[0].scrollHeight);
        }
      });
	  });

	  
	  // 메세지 보내기(여러줄 처리하도록 함-Enter키 처리)
	  $(function(){
		  $('#message').keyup(function(e) {
			  e.preventDefault();		// 이전 스크립트 내용은 무시하고 아래의 내용을 처리하게 한다.
        const target = document.getElementById('targetUser').value;
        const message = document.getElementById('message').value;
		  	if (e.keyCode == 13) {
		  		if(!e.shiftKey) {
			  		if(target != '' && $('#message').val().trim() != '') {
				  		let dt = new Date();
		          let strToday = dt.getFullYear()+"-"+dt.getMonth()+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes();
		          let item = '<div class="d-flex flex-row-reverse mr-2"><span class="myWord p-2 m-1" style="font-size:11px">'+strToday+'<br/>';
		          item += '<font color="brown">' + target + ' 에게</font><br/><font size="3">' + message + '</font></span></div>';
		          item = item.replaceAll("\n","<br/>");
		          document.getElementById('messages').innerHTML += item;
		          document.getElementById('message').value = '';
		          document.getElementById('message').focus();
				  		$('#currentMessage').scrollTop($('#currentMessage').prop('scrollHeight'));
				  		socket.send(target + ":" + message.replaceAll("\n","<br/>"));
			  		}
		  		}
		  	}
		  });
	  });
	  
	  // 채팅할 유저 선책하기
	  function userChange() {
		  myform.targetUser.value = $("#users").val();
		  myform.message.focus();
	  }
	  
	  // 새로고침 차단
	  function doNotReload(event){
	    if((event.ctrlKey && (event.keyCode === 78 || event.keyCode === 82)) || event.keyCode === 116) {
        event.preventDefault();
        return false;
	    }
		}
		document.addEventListener("keydown", doNotReload);
  </script>
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
    }

    li {
      list-style: none;
    }

    #currentUser {
      width: 30%;
      height: 430px;
      float: left;
      border: 0px solid #ccc;
      padding: 10px;
    }
    #currentMessage {
      width: 70%;
      height: 420px;
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
  </style>
</head>
<body oncontextmenu="return false">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="section-box">
    <h2>관리자와 실시간 1:1 상담</h2>
    <div>(관리자 채팅창을 열어두면 사용자가 이용할수 있습니다.)</div>
    <hr class="border-secondary">
    <div id="startChatUser">
      <font color='red'><input type="text" id="username" value="${sMid}" readonly style="border:0px; width:50px;color:red" /></font>님 접속중입니다. '상담시작'버튼을 누르면 채팅창이 열립니다.
    </div>

    <button onclick="startChat()" class="btn btn-outline-success btn-sm">상담시작</button>
    <span id="endChatUser" style="display:none;">
      <span id="chatUser">
        <font color='red'><input type="text" id="username" value="${sMid}" readonly style="border:0px; width:50px;color:red" /></font>님 상담중입니다.
      </span>
      <button onclick="endChat()" id="endChatBtn" class="ms-3 btn btn-outline-warning btn-sm">채팅종료</button>
    </span>
    <button type="button" onclick="window.close()" id="endChatBtn" class="btn btn-outline-danger btn-sm">창닫기</button>
    <div id="chatStatusMessage" style="display:none">(현재 접속중인 회원을 선택 후 채팅을 전송해 주세요.)</div>
    <hr class="border-secondary">
    <div id="chat" style="display:none;">
      <form name="myform" id="form">
        <div id="currentUser">
          <h5 class="text-center">현재 접속중인 회원(<span id="userCount"></span>)</h5>
          <select name="users" id="users" size="18" class="form-control" onchange="userChange()"></select>
        </div>
        <div id="currentMessage">
          <h5>메세지 출력창</h5>
          <div id="messages"></div>
        </div>
        <div class="messageBox input-group">
          <input type="text" name="targetUser" id="targetUser" autocomplete="off" placeholder="접속회원을 선택하세요" readonly class="input-group-prepend me-1" />
          <textarea name="message" id="message" placeholder="메세지를 입력하세요." autocomplete="off" class="form-control"></textarea>
          <button class="input-group-append btn btn-success">메세지전송</button>
        </div>
      </form>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>
