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
  	
  strSql="select o_agree from company_info where o_code='"& o_code &"'"  	
  set objRs=objCnn.Execute(strSql)
  		
  o_agree		= objRs("o_agree")  
  %>  

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function send_agree()
	{
		ans=confirm("����� �����Ͻðڽ��ϱ�?");
		if(ans==true)
		{
			document.all.frm_agree.submit();
		}
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td>
		<table width="100%" border=0 cellspacing="0" cellpadding="0">
		<tr> 
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub12_t05.gif"></div>

		<form action="y_partner_agree_ok.asp" method="post" name="frm_agree"> 			
		<table border="0" cellspacing="0" width="100%" cellpadding="0" id="board_table3">
		<tr height="30">
			<td class="description">
				* �α��� ������ ��Ʈ�� ���� ��û �������� ����� ��Ÿ���ϴ�.</td>
		</tr>
		<tr height=30> 
			<td width="100%" align='center'>
				<textarea class="txtbox" rows="20" name="o_agree" cols="150"><%=o_agree%></textarea>
			</td>
		</tr>
		</table>
			
		<div class="button">
				<span onClick="send_agree();"><img src="/images/button/btn_save.gif" alt="����" border="0" align='absmiddle'></span> 
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