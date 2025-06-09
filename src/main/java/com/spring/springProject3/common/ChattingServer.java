package com.spring.springProject3.common;

/*
 * import java.io.IOException; import java.util.Collections; import
 * java.util.HashMap; import java.util.Map; import java.util.stream.Collectors;
 * 
 * import javax.mail.Session; import javax.websocket.OnClose; import
 * javax.websocket.OnMessage; import javax.websocket.OnOpen; import
 * javax.websocket.server.PathParam; import
 * javax.websocket.server.ServerEndpoint;
 * 
 * @ServerEndpoint("/webSocket/endPoint/{username}") public class ChattingServer
 * { private static Map<String, Session> clients =
 * Collections.synchronizedMap(new HashMap<>());
 * 
 * // 처음 접속시에 수행한다.
 * 
 * @OnOpen public void onOpen(Session session, @PathParam("username") String
 * username) { clients.put(username, session); broadcastUserList(); }
 * 
 * // 접속 종료시에 수행한다.
 * 
 * @OnClose public void onClose(Session session, @PathParam("username") String
 * username) { clients.remove(username); broadcastUserList(); }
 * 
 * // 새로운 메세지가 전송되어 왔을때 수행한다.
 * 
 * @OnMessage public void onMessage(String message, @PathParam("username")
 * String username) throws IOException { String[] parts = message.split(":", 2);
 * if (parts.length == 2) { String targetUser = parts[0]; String msg = parts[1];
 * 
 * Session targetSession = clients.get(targetUser); if (targetSession != null)
 * targetSession.getBasicRemote().sendText(username + ": " + msg); } }
 * 
 * // 접속한 유저리스트 모두 담기(구분을 위해서 'USER_LIST:'뒤에 유저명들을 저장시킨다. 예)
 * USER_LIST:admin,hkd1234,kms1234) private void broadcastUserList() { String
 * userList = clients.keySet().stream().collect(Collectors.joining(",")); for
 * (Session session : clients.values()) { try {
 * session.getBasicRemote().sendText("USER_LIST:" + userList); } catch
 * (IOException e) { e.printStackTrace(); } } } }
 */
