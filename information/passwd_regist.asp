  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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
				* ���� ��й�ȣ�� �Է��� ���ο� ��й�ȣ�� �Է��ϼ���. <br>
				* ������ �ѹ� ����� ��й�ȣ�� ���̻� ����Ͻ� �� �����ϴ�.(���� �ΰ� �����ϴ�.)
			</td>
		</tr>
		<tr height=30> 
			<th width="150">��� �̸�</th>
			<td width="650"><%=m_name%></td>
		</tr>
		<tr height=30> 
			<th>��� ���̵�</th>
			<td><%=session_m_id%></td>
		</tr>			
		<tr height=30> 
			<th>���� ��й�ȣ</th>
			<td><input type="password" class="txtbox" name="passwd1" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		<tr height=30> 
			<th>�� ��й�ȣ</th>
			<td><input type="password" class="txtbox" name="passwd2" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		<tr height=30> 
			<th>�� ��й�ȣ Ȯ��</th>
			<td><input type="password" class="txtbox" name="passwd3" size="20" maxlength="20" style="ime-mode:disabled"></td>
		</tr>
		</table>
			
		<div class="button">
				<span onClick="send_passwd();"><img src="/images/button/btn_save.gif" alt="����" border="0" align='absmiddle'></span> 
		</div>
		</form>			
		<!------------------ ���� ����  ------------------>			
	</td>		
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>