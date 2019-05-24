<%@page import="punycode.Punycode"%>
<%@page import="javax.mail.Flags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.io.IOException"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Folder"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.NoSuchProviderException"%>
<%@page import="javax.mail.Session"%>
<%@page import="com.sun.mail.pop3.POP3Store"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.activation.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String host = "utf8.iptime.org";
		String mailUser = (String)session.getAttribute("mailUser");
		String password = (String)session.getAttribute("mailPassword");
		String selected[] = request.getParameterValues("isSelected");
		session.setMaxInactiveInterval(60*60);

		if (selected == null) {
			out.println("<h3>선택된 메일이 없습니다.</h3>");
		}
		else
		{

			// Get a mail session
			Session emailSession = Session.getInstance(
					System.getProperties(), null);

			// Get the pop 3 store
			POP3Store emailStore = (POP3Store) emailSession
					.getStore("pop3");
			emailStore.connect(host, (String)session.getAttribute("mailUser_encoded") , password);

			// Get folder
			Folder folder = emailStore.getFolder("INBOX");

			/*
			 * first thing, the folder needs to be opened as READ_WRITE and not as
			 * READ_ONLY in order to enable changing the status of the messages
			 */

			folder.open(Folder.READ_WRITE);

			// Get Count
			int count = folder.getMessageCount();
			if (count == 0)
				System.out.println("Mail is not present");

			for (int i = 0; i < selected.length; i++) {
				System.out.println(Integer.parseInt(selected[i]));
				javax.mail.Message msg = folder.getMessage(Integer
						.parseInt(selected[i]));

				
				msg.setFlag(Flags.Flag.DELETED, true);
				msg = null;
			}

			folder.close(true); // actually make the delete work
			emailStore.close();
			out.println("<h3>메일이 정상적으로 삭제되었습니다.</h3>");
		}
	%>
</body>
</html>