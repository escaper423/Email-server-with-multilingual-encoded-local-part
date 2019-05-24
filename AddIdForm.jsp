<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register - UTF-8 Mail Server</title>
<script language="javascript">
function doc_Load() {
    MyForm.username.focus();
}
</script>
</head>
<body onLoad=doc_Load()>
<table width=100% height=100%>
    <tr>
        <td align=center valign=center>
            <form name=MyForm action="addID.jsp" method="post">
            <h2>계정생성</h2>
            <table border="0" width="350">
                <tr>
                    <td align=right>사용자명 : </td>
                    <td><input type="text" name="username" size="25"></td>
                </tr>
                <tr>
                    <td align=right>비밀번호 : </td>
                    <td><input type="password" name="pwdHash" size="25"></td>
                </tr>
                <tr>
                    <td align=right>NickName : </td>
                    <td><input type="text" name="nickname" size="25"></td>
                </tr>
            </table>
            <p>
            <input style="width:80;" type="submit" value="생성">
            <input style="width:80;" type="reset" value="취소">
            </p>
        </td>
    </tr>
</table>
</body>
</html>
