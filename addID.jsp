<%@page import="punycode.Punycode"%>
<%@page import="com.sun.xml.internal.messaging.saaj.util.ByteInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.io.*"%>
<%@page import="com.sun.mail.pop3.*"%>
<%@page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>UTF-8 Mail Server - Register</title>
</head>
<%
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	request.setCharacterEncoding("UTF-8");
	String username = request.getParameter("username"), pwdHash = request.getParameter("pwdHash");
	String nickname = request.getParameter("nickname");
	String url = request.getParameter("url");
	String user = request.getParameter("user");
	String password = request.getParameter("password");

	MessageDigest md;
	ByteArrayOutputStream bos;
	ByteArrayInputStream bis;

	try {
		// 1. Driver를 로딩한다. 
		Class.forName("com.mysql.jdbc.Driver");
		out.println("MySQL Driver의 로딩이 정상적으로 이뤄졌습니다.");

		// 2. Connection 얻어오기 
		con = DriverManager.getConnection(
				"jdbc:mysql://utf8.iptime.org:3306/test?autoReconnect=true", "yjg",
				"yjg1004");
		out.println("데이터베이스의 연결에 성공하였습니다.");

		// 3. Statement 얻기 --> 쿼리문 작성하여 적용하기 위한 용도 
		stmt = con.createStatement();
		
		boolean[] b=new boolean[16];
		StringBuffer sbUsername, temp;
		temp = new StringBuffer(username);
		sbUsername = Punycode.encode(temp, b);
		
		String finalUsername = null;
		if(sbUsername.toString().equals(username+"-"))
			finalUsername = username;
		else
			finalUsername = "xn--"+sbUsername.toString();
		
		try {
			md = MessageDigest.getInstance("SHA");
			byte[] digest = md.digest(pwdHash.getBytes("iso-8859-1"));
			bos = new ByteArrayOutputStream();
			OutputStream encodedStream = MimeUtility.encode(bos,
					"base64");
			encodedStream.write(digest);
			pwdHash = bos.toString("iso-8859-1");
		} catch (IOException ioe) {
			throw new RuntimeException("Fatal error: " + ioe);
		} catch (MessagingException me) {
			throw new RuntimeException("Fatal error: " + me);
		}
		System.out.println(pwdHash);
		// 4. 쿼리문 실행 -->> insert into (자동으로 commit 됩니다.) 
		String sql = "INSERT INTO `test`.`users` (`username`, `pwdHash`, `pwdAlgorithm`, `useForwarding`, `useAlias`, `alias`) VALUES ('"
				+ finalUsername
				+ "','"
				+ pwdHash
				+ "', 'SHA', '0', '0', '"+nickname+"')";
		stmt.executeUpdate(sql);
		rs = stmt.executeQuery(sql);

		rs.close();
		stmt.close();
		con.close();
	} catch (ClassNotFoundException cnfe) {
		out.println("com.mysql.jdbc.Driver를 찾을 수 없습니다.");
	} catch (SQLException sql) {
		out.println("Connection 실패!");
	} catch (Exception e) {
		out.println(e.toString());
	} finally {
		out.println("성공!!");
		response.sendRedirect("./index.jsp");
	}
%>