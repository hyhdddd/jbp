  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)
  	
  strSql="select * from emp_list where m_id='"& session_m_id &"'"  	
  set objRs=objCnn.Execute(strSql)
  		
  m_name		= objRs("m_name")  
  %>  

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr bgcolor="#FFFFFF"  height='400'> 
	<td>

		<div class="sub_title"><img src="/images/common/sub12_t01.gif"></div>

		<form action="passwd_regist_ok.asp" method="post" name="frm_passwd"> 			
		<table border="0" cellspacing="0" width="100%" cellpadding="0" id="board_table3">
		<Tr>
			<td colspan='2' class="description"><br> 
				* 현재 비밀번호를 입력후 새로운 비밀번호를 입력하세요. <br>
				* 예전에 한번 사용한 비밀번호는 더이상 사용하실 수 없습니다.(변경 로고가 남습니다.)
			</td>
		</tr>
		<tr height=30> 
			<th width="150">사원 이름</th>
			<td width="650"><%=m_name%></td>
		</tr>
		<tr height=30> 
			<th>사원 아이디</th>
			<td><%=session_m_id%></td>
		</tr>			
		<tr height=30> 
			<th>기존 비밀번호</th>
			<td><input type="password" class="txtbox" name="passwd1" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		<tr height=30> 
			<th>새 비밀번호</th>
			<td><input type="password" class="txtbox" name="passwd2" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		<tr height=30> 
			<th>새 비밀번호 확인</th>
			<td><input type="password" class="txtbox" name="passwd3" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		</table>
			
		<div class="button">
				<span onClick="send_passwd();"><img src="/images/button/btn_save.gif" alt="저장" border="0" align='absmiddle'></span> 
		</div>
		</form>			
		<!------------------ 내용 종료  ------------------>			
	</td>		
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>