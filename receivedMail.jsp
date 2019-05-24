<%@page import="punycode.Punycode"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Received Mail</title>
</head>
<body>
	<%@page import="java.io.IOException"%>
	<%@page import="java.util.Properties"%>
	<%@page import="javax.mail.Folder"%>
	<%@page import="javax.mail.Message"%>
	<%@page import="javax.mail.MessagingException"%>
	<%@page import="javax.mail.NoSuchProviderException"%>
	<%@page import="javax.mail.Session"%>
	<%@page import="javax.mail.internet.*"%>
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
	<center>
		<h2>Received Mail</h2>
		<%
			request.setCharacterEncoding("UTF-8");
			Object msg_content;
			String mailPop3Host = "utf8.iptime.org";
			String mailStoreType = "pop3";
			String mailUser = (String)session.getAttribute("mailUser_encoded");
			String mailPassword = (String)session.getAttribute("mailPassword");
			int msg_num = Integer.parseInt(request.getParameter("msg_num"));
			try {
				mailUser = URLEncoder.encode(mailUser, "UTF-8");
				Properties properties = new Properties();
				properties.put("mail.pop3.host", mailPop3Host);
				Session emailSession = Session.getDefaultInstance(properties);
				POP3Store emailStore = (POP3Store) emailSession.getStore(mailStoreType);
				emailStore.connect(mailUser, mailPassword);
				Folder emailFolder = emailStore.getFolder("INBOX");
				emailFolder.open(Folder.READ_ONLY);

				Message[] messages = emailFolder.getMessages();
				for (int i = 0; i < messages.length; i++) {
					Message message = messages[i];
					if ((message.getMessageNumber()) == msg_num) {
						String fr = message.getFrom()[0].toString();
						if(fr.startsWith("=") == true)
						{
							fr = message.getFrom()[0].toString().split("=")[2].replace("<", "").replace(">", "");
						}
				
		%>
		<table border=0 cellspacing=3 width="500px">
			<tr>
				<th bgcolor="#dddddd" width="70px">보낸이</th>
				<td width="*" bgcolor="#bbbbbb">
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
				</td>
			</tr>
			<tr>
				<th bgcolor="#dddddd" width="70px">받는이</th>
				<td width="*" bgcolor="#bbbbbb"><%=(String)session.getAttribute("mailUser_display")%></td>
			</tr>
			<tr>
				<th bgcolor="#dddddd" width="70px">제목</th>
				<td width="*" bgcolor="#bbbbbb">
					<%
						out.println(message.getSubject());
					%>
				</td>
			</tr>
			<tr>
				<th bgcolor="#dddddd" width="70px">내용</th>
				<td width="*" bgcolor="#bbbbbb">
					<%
						msg_content = message.getContent();
						if(msg_content instanceof String)
							out.println(msg_content);
						else if(msg_content instanceof MimeMultipart){
							out.println(((MimeMultipart)msg_content).getBodyPart(0).getContent());
					}
					%>
				</td>
			</tr>
		</table>
		<%
			} else continue;
				}
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
	</center>
</body>
</html>