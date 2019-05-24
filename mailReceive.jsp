<%@page import="punycode.Punycode"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<%
	request.setCharacterEncoding("UTF-8");
	String mailPop3Host = "utf8.iptime.org";
	String mailStoreType = "pop3";
	String mailUser = (String)session.getAttribute("mailUser_encoded");
	String mailPassword = (String)session.getAttribute("mailPassword");
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd, hh:mm");
	int msg_num;
	String fr = new String();
	session.setMaxInactiveInterval(60*60);

	try {
/* 		boolean[] b=new boolean[16];
		StringBuffer sbUsername, temp;
		temp = new StringBuffer(mailUser);
		sbUsername = Punycode.encode(temp, b); */
//		mailUser = URLEncoder.encode(mailUser, "UTF-8");
		Properties properties = new Properties();
		properties.put("mail.pop3.host", mailPop3Host);
		Session emailSession = Session.getDefaultInstance(properties);
		POP3Store emailStore = (POP3Store) emailSession.getStore(mailStoreType);
		emailStore.connect((String)session.getAttribute("mailUser_encoded"), mailPassword);
		Folder emailFolder = emailStore.getFolder("INBOX");
		emailFolder.open(Folder.READ_ONLY);
%>
<style type="text/css">
.subject {
	-moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
	box-shadow: inset 0px 1px 0px 0px #ffffff;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed
		), color-stop(1, #dfdfdf));
	background: -moz-linear-gradient(center top, #ededed 5%, #dfdfdf 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed',
		endColorstr='#dfdfdf');
	background-color: #ededed;
	-webkit-border-top-left-radius: 0px;
	-moz-border-radius-topleft: 0px;
	border-top-left-radius: 0px;
	-webkit-border-top-right-radius: 0px;
	-moz-border-radius-topright: 0px;
	border-top-right-radius: 0px;
	-webkit-border-bottom-right-radius: 0px;
	-moz-border-radius-bottomright: 0px;
	border-bottom-right-radius: 0px;
	-webkit-border-bottom-left-radius: 0px;
	-moz-border-radius-bottomleft: 0px;
	border-bottom-left-radius: 0px;
	text-indent: 0px;
	display: inline-block;
	color: #777777;
	font-family: Arial;
	font-size: 17px;
	font-weight: bold;
	font-style: normal;
	height: 100%;
	line-height: 50px;
	width: 100%;
	text-decoration: none;
	text-align: center;
	text-shadow: 1px 1px 0px #ffffff;
}

.subject:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #dfdfdf
		), color-stop(1, #ededed));
	background: -moz-linear-gradient(center top, #dfdfdf 5%, #ededed 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf',
		endColorstr='#ededed');
	background-color: #dfdfdf;
}

.subject:active {
	position: relative;
	top: 1px;
}
</style>

<h2>
	<center>편지 수신함</center>
</h2>
<form action="mailDelete.jsp" method="post">
	<p align="right">
		<input type="submit" value="선택삭제">
	</p>
	<table border="0" cellspacing="1">
		<tr>
			<th bgcolor="#dddddd" width="170px"><b><center>Sender</center></b></th>
			<th bgcolor="#aaaaaa" width="450px"><b><center>Subject</center></b></th>
			<th bgcolor="#dddddd" width="170px"><b><center>SentDate</center></b></th>
			<th bgcolor="#aaaaaa" width="30px"><b><center>Select</center></b></th>
		</tr>
		<%
				Message[] messages = emailFolder.getMessages();
					for (int i = 0; i < messages.length; i++) {
						Message message = messages[i];
						msg_num = message.getMessageNumber();
						fr = message.getFrom()[0].toString();
						if(fr.startsWith("=") == true)
						{
							fr = message.getFrom()[0].toString().split("=")[2].replace("<", "").replace(">", "");
						}
			%>

		<tr>
			<th bgcolor="#aaaaaa"><center>
					<%
						String tolocal="";
						String todomain="";
						int toindex = 0;
						for(int j = 0 ; j < fr.length(); j++)
						{
							if(fr.charAt(j)=='@')
							{
								toindex=j;
								break;
							}
						}
						tolocal=fr.substring(0,toindex);
						todomain=fr.substring(toindex+1);
						boolean[] b=new boolean[16];
						if (tolocal.startsWith("xn--"))
						{
							tolocal = tolocal.substring(4);
							StringBuffer sbUsername, temp;
							System.out.println("tolocal : "+tolocal);
							temp = new StringBuffer(tolocal);
							sbUsername = Punycode.decode(temp, b);
							tolocal=sbUsername.toString();
							System.out.println("tolocal(mailReceive) : "+sbUsername.toString());
						}
						out.println(tolocal + "@" + todomain);
					%>
				</center></th>
			<th>
				<%-- <a
					href="receivedMail.jsp?mailUser=<%=mailUser%>&mailPassword=<%=mailPassword%>&msg_num=<%=message.getMessageNumber()%>"
					class="subject"><%=message.getSubject()%></a></th> --%> <a
				href="receivedMail.jsp?msg_num=<%=message.getMessageNumber()%>"
				class="subject"><center><%=message.getSubject()%></center></a>
			</th>
			<th bgcolor="#aaaaaa">
				<%
						out.println(sdf.format(message.getSentDate()));
					%>
			</th>
			<th bgcolor="#dddddd"><input type="checkbox" name="isSelected"
				value=<%=message.getMessageNumber()%>></th>
		</tr>

		<%
				}
			%>
	</table>
	<input type="hidden" name="mailUser" value="<%=mailUser%>"> <input
		type="hidden" name="mailPassword" value="<%=mailPassword%>">

</form>
<form name=Form action="mailForm.jsp" method="post">
	<input type="hidden" name="mailUser" value="<%=mailUser%>"> <input
		type="hidden" name="mailPassword" value="<%=mailPassword%>">
</form>

<%
	emailFolder.close(false);
		emailStore.close();
	} catch (NoSuchProviderException e) {
		out.println(e);
		e.printStackTrace();
	} catch (MessagingException e) {
		e.printStackTrace();
		out.println(e);
	} catch (IOException e) {
		e.printStackTrace();
		out.println(e);
	}
%>
