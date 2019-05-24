<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.net.URLDecoder"%>
<head>
	<title>UTF-8 E-Mail Server - Contact Form</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<link rel="stylesheet" type="text/css" href="style.css" />
</head>

<body>
	<div id="page-wrap">	
		<div id="contact-area">

			<form method="post" action="mailSend.jsp">
				<pre><sender>Sender:    <%=(String)session.getAttribute("sender_display") %></sender><br /><br /></pre>
				<label for="Receiver">Receiver:</label>
				<input type="text" name="receiver"  /><br />
				<label for="Subject">Subject:</label>
				<input type="text" name="subject"  />	
				<label for="Message">Message:</label><br />
				<textarea name="content" rows="20" cols="20" ></textarea>

				<input type="submit" name="submit" value="Submit" class="submit-button" />
			</form>
			</table>
			<div style="clear: both;"></div>
		</div>
	</div>

</body>

</html>