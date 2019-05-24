<%@page import="punycode.Punycode"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
<%@page import="java.net.URLDecoder"%>
<html>
<head>
<title>UTF-8 Mail Server</title>
<script type="text/javascript">

</script>
<style type="text/css">
.urbangreymenu {
	position: relative;
	float: left;
	width: 200px;
	min-height: 100px;
	margin-left: 70px;
}

.urbangreymenu .headerbar {
	font: bold 16px Verdana;
	color: white;
	background: #606060 url(media/arrowstop.gif) no-repeat 8px 6px;
	/*last 2 values are the x and y coordinates of bullet image*/
	margin-bottom: 0; /*bottom spacing between header and rest of content*/
	text-transform: uppercase;
	padding: 7px 0 7px 31px; /*31px is left indentation of header text*/
}

.urbangreymenu ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	margin-bottom: 0;
	/*bottom spacing between each UL and rest of content*/
}

.urbangreymenu ul li {
	padding-bottom: 2px; /*bottom spacing between menu items*/
}

.urbangreymenu ul li a {
	font: normal 14px Arial;
	color: black;
	background: #E9E9E9;
	display: block;
	padding: 5px 0;
	line-height: 17px;
	padding-left: 8px; /*link text is indented 8px*/
	text-decoration: none;
}

.urbangreymenu ul li a:visited {
	color: black;
}

.urbangreymenu ul li a:hover { /*hover state CSS*/
	color: white;
	background: black;
}

.headframe {
	position: relative;
	top: 1px;
	width: 100%;
	min-height: 30px;
	margin-left: 300px;
}

.idframe {
	position: relative;
	margin-left: 80px;
	min-height: 30px;
	widtn: 200px;
}

#subframe {
	position: absolute;
	margin-left: 80px;
	margin-top: 50px;
	width: 800px;
	height: 800px;
}
</style>



</head>
<body>
<%
session.setMaxInactiveInterval(60*60);
%>

	<div class="headframe">
		<img src="output_CekJ36.gif">
	</div>
	<div class="idframe">
		<table>
			<tr>
			
				<td><%=(String)session.getAttribute("mailUser_display")%>님 환영합니다!</td>
			</tr>
		</table>
	</div>

	<div class="urbangreymenu">

		<h3 class="headerbar">사용자 메뉴</h3>
		<ul >
			<li><a href="mailForm.jsp" target="subframe">메일 보내기</a></li>
			<li><a href="mailReceive.jsp" target="subframe">받은 편지함</a></li>
			<li><a href="aboutTeam.jsp" target="subframe">팀 소개</a></li>
			<li><a href="notice.jsp" target="subframe">공지 사항</a></li>
			<li><a href="loggingOut.jsp">로그 아웃</a></li>
		</ul>
	</div>
	<IFRAME name="subframe" id="subframe" src="notice.jsp"
			width=100% height=100% frameborder=0 scrolling=yes></IFRAME>


</body>
</html>
