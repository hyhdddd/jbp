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
  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
function frm_submit(form_name)
{
	var frm			= document.getElementById(form_name);

	if(frm.s_date_start.value=="")
	{
		alert("�� ���� �������� �Է����ּ���."); 
		return;
	}
	if(frm.s_date_end.value=="")
	{
		alert("�� ���� �������� �Է����ּ���."); 
		return;
	}

	ans=confirm("���� ��¥ �ٽ��ѹ� Ȯ�����ּ���. \n\n ��Ȯ�Ͻø� Ȯ���� �����ּ���.");
	if(ans==true)
	{
		frm.submit();
	}
} 
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  height='400'> 
	<td valign='top' align='center'>
		
		<!------------------ ���� ����  ------------------>    				
		
		<div class="sub_title"><img src="/images/common/sub08_t07.gif"></div>

		<form id="frm_delete" name="frm_delete" Method="POST" action="customer_del_ok.asp">		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
				<!--#include virtual="/include/asp/code_menu_list.asp"-->
			</td>
		</tr>
		<tr height="40">
			<th align="center" colspan="4">������ �ϰ�����</th>
		</tr>
		<tr width="100%" height="30">
			<td colspan="4" align="center"><b>������ : </b>
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_delete','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~<input type="text" name="s_date_end" size='9' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_delete','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height="30" >
			<td colspan="26" align="center">
				<a href="javaScript:frm_submit('frm_delete');"><img src="/images/button/btn_delete.gif"  border="0" align='absmiddle'></a>
			</td>
		</tr>
		</table>
	
		</form>
		<!------------------ ���� ����  ------------------>
	</td>
</tr>
<tr>
	<td>
		<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>