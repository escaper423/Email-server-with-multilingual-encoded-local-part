<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>UTF-8 Mail Server</title>
<script language="javascript">
function doc_Load() {
    MyForm.hostname.focus();
}

</script>

<style type="text/css">
.headframe {
	position: relative;
	float: left;
	top: 1px; width: 100%;
	min-height: 80px;
	text-align: center;
}

.idframe {
	position: relative;
	text-align: center;
	width: 100%;
	min-height: 80px;
}

.classname {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) );
	background:-moz-linear-gradient( center top, #ededed 5%, #dfdfdf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf');
	background-color:#ededed;
	-webkit-border-top-left-radius:6px;
	-moz-border-radius-topleft:6px;
	border-top-left-radius:6px;
	-webkit-border-top-right-radius:6px;
	-moz-border-radius-topright:6px;
	border-top-right-radius:6px;
	-webkit-border-bottom-right-radius:6px;
	-moz-border-radius-bottomright:6px;
	border-bottom-right-radius:6px;
	-webkit-border-bottom-left-radius:6px;
	-moz-border-radius-bottomleft:6px;
	border-bottom-left-radius:6px;
	text-indent:0;
	border:1px solid #dcdcdc;
	display:inline-block;
	color:#777777;
	font-family:arial;
	font-size:15px;
	font-weight:bold;
	font-style:normal;
	height:30px;
	line-height:30px;
	width:80px;
	text-decoration:none;
	text-align:center;
	text-shadow:1px 1px 0px #ffffff;
}
.classname:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) );
	background:-moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed');
	background-color:#dfdfdf;
}.classname:active {
	position:relative;
	top:1px;
}</style>

</head>
<body onLoad=doc_Load()>
	<div class="headframe">
		<img src="output_CekJ36.gif">
	</div>
	<div class="idframe">
		<table width="100%" height="20%">
			<tr>
				<td align=center valign=middle>
					<form name=MyForm action="LoggingIn.jsp" method="post">
						<table border="0" width="180px">
							<tr>
								<td align=right>ID </td>
								<td><input type="text" name="mailUser" size="19"></td>
							</tr>

							<tr>
								<td align=right>PW </td>
								<td><input type="password" name="mailPassword" size="19"></td>
							</tr>
						</table>
						<input type="submit" value="로그인" class="classname"> 
						<a href="AddIdForm.jsp" class="classname">회원 가입</a>
					</form>
				</td>
			</tr>
		</table>
	</div>


</body>
</html>
