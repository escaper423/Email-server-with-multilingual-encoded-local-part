<%@page import="punycode.Punycode"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%@page import="javax.mail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="javax.activation.*" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.util.Properties" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="javax.mail.Folder" %>
<%@page import="javax.mail.Message" %>
<%@page import="javax.mail.Session" %>
<%@page import="javax.mail.Store" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="java.util.Properties" %>
<%@page import="java.sql.*" %>
<%@page import="java.security.*" %>
<%@page import="javax.mail.*"%>
<%@page import="java.io.*" %>
<%@page import="com.sun.mail.pop3.*" %>
<%@page import="java.net.*" %>
<%@page import="java.io.IOException" %>
<%@page import="java.util.Properties" %>

<%@page import="javax.mail.Folder" %>
<%@page import="javax.mail.Message" %>
<%@page import="javax.mail.MessagingException" %>
<%@page import="javax.mail.NoSuchProviderException" %>
<%@page import="javax.mail.Session" %>
<%@page import="com.sun.mail.pop3.*" %>

<%
	
	request.setCharacterEncoding("UTF-8");
	String sender=(String)session.getAttribute("sender_encoded");
	String receiver=request.getParameter("receiver");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	String tolocal="";
	String todomain="";
	
	boolean[] b=new boolean[16];
	session.setMaxInactiveInterval(60*60);
	int toindex=0;
	
	for(int i = 0 ; i < sender.length(); i++)
	{
		if(sender.charAt(i)=='@')
		{
			toindex=i;
			break;
		}
	}
	
	/* 	
	tolocal=sender.substring(0,toindex);
	todomain=sender.substring(toindex+1);
	System.out.print("sender(mailSend) : "+sender);
	 */
	for(int i = 0 ; i < receiver.length(); i++)
	{
		if(receiver.charAt(i)=='@')
		{
			toindex=i;
			break;
		}
	}
	tolocal=receiver.substring(0,toindex);
	todomain=receiver.substring(toindex+1);
	StringBuffer rsb= new StringBuffer(tolocal);
	
	if (todomain.equals("eai3.pusan.ac.kr") || todomain.equals("eai6.pusan.ac.kr") || todomain.equals("utf8.iptime.org"))
	{
		StringBuffer sbUsername, temp;
		temp = new StringBuffer(tolocal);
		sbUsername = Punycode.encode(temp, b);
		receiver="xn--"+sbUsername.toString()+"@"+todomain;
		if(sbUsername.toString().equals(tolocal+"-"))
			receiver=tolocal+"@"+todomain;
	}
	
	System.out.print("Receiver : "+receiver+" / Sender : "+sender);
	
	/*
	String word = MimeUtility.encodeWord(tolocal,"utf-8","B");
	word = word+"<"+word+"@"+todomain+">";
	
	System.out.print("\n"+word);
	
	receiver=IDN.toASCII(word)+"@"+todomain;
	receiver=tolocal+"@"+todomain;
	*/
	
	String server="utf8.iptime.org";
	
	try{
		Properties properties=new Properties();
		properties.put("mail.smtp.host",server);
		properties.put("mail.mime.address.strict", "false");
		properties.put("mail.mime.charset", "UTF-8");   
		Session s = Session.getDefaultInstance(properties, null);
		Message message = new MimeMessage(s);
		Address sender_address=new InternetAddress(sender);
		Address receiver_address=new InternetAddress(receiver);
		
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO,receiver_address);
		message.setSubject(subject);
		message.setContent(content,"text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
		
		Transport transport=s.getTransport("smtp");
		transport.connect(server,"syc",null);
		transport.sendMessage(message,message.getAllRecipients());
		transport.close();
		out.println("<h3>메일이 정상적으로 전송되었습니다.</h3>");
	}
	catch(Exception e){
		out.println("FAIL");
		e.printStackTrace();
	}
%>