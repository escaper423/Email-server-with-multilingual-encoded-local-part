# 다국어 계정 지원 이메일 서버 
## 개발환경
- <b>개발언어 및 환경</b> : Java(JSP), Mysql, James 2.3.2(오픈소스 메일서버)
- <b>개발인원</b> : 4
- <b>역할</b> : 수신함 페이지 구현 및 테스트

## 개요
  기존에 사용되는 메일 서버들은 계정의 Localpart(ID 부분)을 ASCII 형식의 문자만 지원하고 있기 때문에, 다국어 형식을 지원하지 않는다. 많은 사람들이 메일계정을 가지고 있지만 아쉽게도 현실은 한국사람이 한글로 된 메일계정을 사용하지 못하고 영어로 된 계정을 사용하고 있는 현실이다. 그렇기 때문에 이 프로젝트를 통하여 한글계정 및 다국어계정을 지원하는 메일서버를 구현함으로써 프로그래밍에 대한 전반적인 능력을 향상시키고, 또 학부 교과 과정에서 배울 수 없었던 메일서버를 직접 구현 해 봄으로써, 해당지식에 대한 전반적인 지식을 얻는 것을 목표로 한다.
  
## 요구조건 및 분석
  메일서버를 만들고 그에 따른 Interface를 구현하는 것으로 나눌 수 있다. 메일서버는 UTF-8로 작성된 계정ID를 보내고 읽을 수 있어야 하며 그 계정ID를 토대로 DB를 이용하여 검색이 가능해야 하기 때문에 DB에 대한 전반적인 지식 또한 필요하기 때문에 학습이 필요 할 것이다. 그리고 메일을 국내외 대형포털 사이트와 주고 받는 것이 가능하게 구현하기 위해서 UTF-8이 아닌 국제규격에 맞는 ID형식으로 메일을 보내는 방법도 생각해야 할 것이다.

## 설계 구조
![email1](https://user-images.githubusercontent.com/41889090/139930740-16b82012-d726-4a03-8683-42049f6688e1.jpg)
### POP3 / IMAP (Client)
- 유저가 메일서버에서 메일을 받기위한 프로토콜이라고 할수 있다. 즉 메일서버에 자신에게 온 메일이 있는지 사용자 프로그램(아웃룩이나 daum메일등) 에서 수시로 체크하고 메일을 가져온다.
IMAP또한 마찬가지이다. 단 POP3와 차이점은 메일을 서버에서 가져올떄 삭제하지 않고 다시 가져 올 수 있다는 점이다.
- 이 프로젝트에서 중점적으로 구현한 부분이며, Java, JSP, Javamail API 등을 사용하여 구현하였으며, 사용자 계정 및 메일의 내용은 MySQL을 사용하여 데이터베이스의 형태로 관리한다.

### SMTP (Server)
- 인터넷에서 이메일을 보내기 위해 이용되는 프로토콜이다. 사용하는 TCP 포트번호는 25번이다. 상대 서버를 지시하기 위해서 DNS의 MX레코드가 사용된다. RFC2821에 따라 규정되어 있다. 메일 서버간의 송수신뿐만 아니라, 메일 클라이언트에서 메일 서버로 메일을 보낼 때에도 사용되는 경우가 많다. SMTP는 텍스트 기반의 프로토콜로서 요구/응답 메시지뿐 아니라 모든 문자가 7bit ASCII로 되어있어야 한다고 규정되어 있다. 이 때문에 문자 표현에 8비트 이상의 코드를 사용하는 언어나 첨부파일과 자주 사용되는 각종 바이너리는 마임(MIME)이라고 불리는 방식으로 7비트로 변환되어 전달된다. SMTP는 메세지를 생성하는 방법을 규정하지 않는다. 메세지 생성을 위하여 로컬 편집이나 단순한 전자 우편 응용이 사용된다. 메세지가 생성되면 호출된 SMTP가 메세지를 받고 TCP를 이용하여 다른 호스트의 SMTP에게 전달한다.
- 오픈소스 메일서버인 James (2.3.2버전)를 사용하여 SMTP 메일 서버의 역할을 수행하도록 하였다. 또한 구축한 메일 서버에 MySQL을 연동하여, 사용자 및 메일 정보를 기존의 관리방식인 파일이 아닌, 데이터베이스의 형태로 더욱 편리하게 관리할 수 있도록 하였다.


## 구현 상세
- ### 사용자 계정 생성, 로그인/로그아웃
     사용자 계정 생성 화면<br>
   ![formregister](https://user-images.githubusercontent.com/41889090/140027160-172ba16f-9fca-4533-a5d0-1afafa299d5d.jpg)<br><br>
     사용자 계정 생성 시, 아래 그림과 같이 비밀번호를 인코딩하여 저장한다.<br>
   ![password](https://user-images.githubusercontent.com/41889090/140026553-5db4201f-979d-4da5-a9f7-6366bbee45dc.JPG)<br><br>
     로그인 화면<br>
   ![image](https://user-images.githubusercontent.com/41889090/140029805-177447f1-d760-4607-8063-d896e140e94e.png)

   


- ### 메일 송신 기능 (다국어 지원서버, 일반 메일서버 모두 가능)
  구축한 메일 서버에서 메일을 송신하는 화면<br>
  ![sendmail](https://user-images.githubusercontent.com/41889090/140027580-92531e1a-7453-40b1-8f03-a09634649507.jpg)<br><br>
  송신한 메일이 제대로 수신이 되는지 확인<br>
  ![image](https://user-images.githubusercontent.com/41889090/140028221-b0434e6c-b712-4228-80f5-1f84a9b9e1cd.png)<br><br>
  상용 메일 서버와의 송/수신 테스트 및 확인. 예시에서는 gmail을 대상으로 테스트 하였다.<br>
  ![image](https://user-images.githubusercontent.com/41889090/140027909-126217f3-e357-4af2-811f-ffd8157baa96.png)
   

- ### 메일 수신함 기능 (메일 조회, 삭제 등 가능)
  아래의 그림과 같이 수신함을 구현하였다. 선택 체크박스를 통해 삭제할 메일을 선택할 수 있고, 위의 선택삭제 버튼을 통해 복수개의 메일을 한 번에 
  삭제할 수 있다.<br>
![image](https://user-images.githubusercontent.com/41889090/140028621-353f43a1-d122-4407-8faf-f2b7424d8a5d.png)<br><br>
  또한 상용 메일서버에서 작성한 메일을 정상적으로 수신 가능한지 테스트하였다.
  ![image](https://user-images.githubusercontent.com/41889090/140029059-6f71f5d3-66f5-4b8e-a98c-8c6693b73397.png)

- ### Local part encoding
  SMTP 서버에 접속해 메일을 전송할수 있는 sendmail 클라이언트를 작성하였는데 javax.mail.internet 패키지를 사용하여 메일서버를 구축하였다
  이 패키지를 이용하여 메일을 전송할 시에 local 파트에 아스키외에 문자, 즉 한글이 올경우 javax.mail.internet.addressexception 에러가 발생하여 메일 전송이 되질 않는다.
  이를 해결하기 위해 로컬과 도메인 파트를 따로 떼어낸 뒤에 로컬 파트에 모종의 인코딩 기법을 사용하여 이 부분을 코드화 한 후에 전송하여야 한다. 메세지 양식에서 이러한 인코딩을 적용하는 방법으로 base64 Encoding이라는 방식이 있으며, 이는 RFC4648 (http://tools.ietf.org/html/rfc4648) 의 표준을 따른다. 이를 메시지 양식 (여기서는 MIME Message 방식을 사용하며, 이는 RFC2047의 표준을 따른다. http://tools.ietf.org/html/rfc2047 ) 에 적용하면 아래와 같은 형태로 나타나게 된다.

  ex) 테스트1@localhost - > =?UTF-8?B? 6raM7IOB7ZiB?=@localhost

  일반적으로 MIME Message에서는 =으로 시작과 끝을 구분하고, ?를 경계로 하여 각각 코드, 인코딩 방식, 인코드된 로컬 파트로 나뉘게 된다. 즉 위에 따르면 UTF-8은 인코드될 코드명을 말하고, B는 base64 방식으로 인코드 시킴을 이야기한다.

  이외에 해결 방안으로 퓨니 코드(Punycode) 라는 것이 있는데, 이는 Unicode를 ASCII 기반의 텍스트로 인코딩하는 방법을 나타낸 것으로, 유니코드가 지원하는 모든 언어로 국제화 도메인을 쓸 수 있게 한 IDNA의 일부로서 설명되고 있는데, 이를 local part에 적용시켜 다국어 계정 간 이메일 송수신이 가능하게 할 수 있다. 여기서 지원하는 퓨니코드는 앞에 ‘xn—‘이 붙게 되는데 다음과 같은 형태로 변환된다.
  테스트1@utf8.iptime.org -> xn--1-9e5f988awlb@utf8.iptime.org
  즉 Non-ASCII 로 된 local part를 ASCII 문자로 코드화 시킴으로서, Non-ASCII 문자를 허용하지 않는 SMTP 서버에서도 다국어 계정 간 메일 송수신이 가능하게 할 수 있다. 다만 이 경우 양 측 서버가 모두 퓨니코드를 지원해야 할 것이다
  
## 성과 및 요약
-	WIndows환경에서 java의 오픈소스 메일서버인 james 2.3.2를 통해서 메일서버를 구축하였다. (SMTP Server 부분)
-	MySql(DB)와의 연동을 통해서 사용자의 계정정보 관리 및 송수신한 메일의 데이터를 효과적으로 관리할 수 있도록 구현
-	JSP를 사용하여 구축한 메일서버가 제공하는 서비스를 웹 브라우저 상에서 이용할 수 있도록 하였다. (POP3 Client 부분)
-	구현한 서버를 도메인으로 사용하는 사용자끼리 메일을 주고 받을 수 있게 구현하였으며, gmail같은 외부 상용 메일서비스와 의 송/수신도 원활하게 되고 있음을 확인하였다.
- UTF-8 또는 Punycode를 이용하여 다국어의 사용자 계정을 지원할 수 있다.



