<%@page import="punycode.Punycode"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String mailPop3Host = "utf8.iptime.org";
		String mailStoreType = "pop3";
		String mailUser = request.getParameter("mailUser");
		String mailPassword = request.getParameter("mailPassword");
		session.setAttribute("sender_display", mailUser + "@" +mailPop3Host);
		session.setAttribute("mailUser_display", mailUser);
		try {
			boolean[] b=new boolean[16];
			StringBuffer sbUsername, temp;
			temp = new StringBuffer(mailUser);
			sbUsername = Punycode.encode(temp, b);
			/* System.out.println(sbUsername.toString()); */
			String finalUsername = null;
			if(sbUsername.toString().equals(mailUser+"-"))
				finalUsername = mailUser;
			else
				finalUsername = "xn--"+sbUsername.toString();
			mailUser = finalUsername;
			Properties properties = new Properties();
			properties.put("mail.pop3.host", mailPop3Host);
			Session emailSession = Session.getDefaultInstance(properties);
			POP3Store emailStore = (POP3Store)emailSession.getStore(mailStoreType);
			emailStore.connect(mailUser, mailPassword);
			
			session.setAttribute("sender_encoded", mailUser + "@" +mailPop3Host);
			session.setAttribute("mailUser_encoded", mailUser);
			session.setAttribute("mailPassword", mailPassword);
			response.sendRedirect("./LoggedIn.jsp");
		}

		catch (NoSuchProviderException e) {
			out.println(e);
			e.printStackTrace();
			session.removeAttribute("mailUser_display");
			session.removeAttribute("sender_display");
			session.removeAttribute("sender_encoded");
			session.removeAttribute("mailUser_encoded");
			session.removeAttribute("mailPassword");
			%>
		<script language="javascript">
			alert("로그인 오류");
		</script>
			<%
			response.sendRedirect("./index.jsp");
			
		} catch (MessagingException e) {
			e.printStackTrace();
			out.println(e);
			
			session.removeAttribute("mailUser_display");
			session.removeAttribute("sender_display");
			session.removeAttribute("sender_encoded");
			session.removeAttribute("mailUser_encoded");
			session.removeAttribute("mailPassword");
			%>
			<script language="javascript">
				alert("로그인 오류");
			</script>
			<%
			response.sendRedirect("./index.jsp");
		} catch (IOException e) {
			e.printStackTrace();
			out.println(e);
			session.removeAttribute("mailUser_display");
			session.removeAttribute("sender_display");
			session.removeAttribute("sender_encoded");
			session.removeAttribute("mailUser_encoded");
			session.removeAttribute("mailPassword");
			%>
			<script language="javascript">
				alert("로그인 오류");
			</script>
			<%
			response.sendRedirect("./index.jsp");
			
		}
	%>
</body>
</html>