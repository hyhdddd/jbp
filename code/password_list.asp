  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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
<Script language="javaScript">
<!--
	function frm_submit(form_name)
	{
		var frm			= document.getElementById(form_name);

		if(frm.c_name.checked==false && frm.c_tel1.checked==false && frm.c_tel2.checked==false && frm.c_address.checked==false && frm.g_address.checked==false && frm.c_jumin2.checked==false && frm.c_email.checked==false && frm.g_bank_no.checked==false && frm.g_bank_jumin2.checked==false && frm.g_card_no.checked==false && frm.g_card_gigan.checked==false && frm.g_sp_bank_acount.checked==false && frm.g_sp_bank_jumin2.checked==false && frm.g_move_jumin2.checked==false && frm.g_move_tel1.checked==false && frm.g_move_tel2.checked==false && frm.g_card_jumin2.checked==false)
		{
			alert(" �ϳ� �̻��� �������ּ���!"); 
			return;
		}


		ans=confirm("�ѹ� ó���� �����ʹ� ������ �Ұ����մϴ�. �����ϰ� ó���� �ֽñ� �ٶ��ϴ�. \n\n ��ŷó�� �Ͻðڽ��ϱ�?");

		if (ans==true)
		{
			frm.submit();
		}

	} 
-->
</Script>

<style>

/*��ư*/

.button_orange{
border:1px solid #ff7000;
-webkit-border-radius: 3px;
-moz-border-radius: 3px;
border-radius: 3px;
font-size:11px;
color:#fff;
padding: 4px 12px 0 12px;
text-decoration:none;
display:inline-block;
background-color: #ff7000;
}

.button_orange:hover{
border:1px solid #6c6c6c;
color: #fff;
background-color: #6c6c6c;
}
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top' align='center'>
				
		<div class="sub_title"><img src="/images/common/sub08_t08.gif"></div>

		<form id="frm_password" name="frm_password" Method="POST" action="password_regist_ok.asp">

		<table width="100%" border="1" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<!--#include virtual="/include/asp/code_menu_list.asp"-->
			</td>
		</tr>
		</table>

		<!------------------ ���� ����  ------------------>			
		
		<TABLE width="1000" cellspacing=1 cellpadding=0 border=0 id="board_table3">  
		<tr height="40">
			<th align="center" colspan="8">������ �ϰ� (*) ó��</th>
		</tr>
		<tr height="30">
			<!-------- ���� --------->
			<td width="150" class='con5'>����(3��°) : <input type="checkbox" name="c_name" value="Y" checked></td>

			<!-------- ��ȭ��ȣ --------->
			<td width="150" class='con5'>��ȭ��ȣ : <input type="checkbox" name="c_tel1" value="Y" checked></td>

			<!-------- �ڵ��� --------->
			<td width="150" class='con5'>�ڵ��� : <input type="checkbox" name="c_tel2" value="Y" checked></td>

			<!-------- �ּ� --------->
			<td width="150" class='con5'>�ּ� : <input type="checkbox" name="c_address" value="Y" checked></td>

			<!-------- ��ġ��� --------->
			<td width="150" class='con5'>��ġ��� : <input type="checkbox" name="g_address" value="Y" checked></td>

			<!-------- �ֹι�ȣ --------->
			<td width="150" class='con5'>�ֹι�ȣ : <input type="checkbox" name="c_jumin2" value="Y" checked></td>

			<!-------- �̸��� --------->
			<td width="150"  class='con5'>�̸��� : <input type="checkbox" name="c_email" value="Y" checked></td>
		</tr>
		<tr height="30">
			<!-------- ���ΰ��� --------->
			<td width="150" class='con5'>���ΰ���  : <input type="checkbox" name="g_bank_no" value="Y" checked></td>

			<!-------- �����ֹι�ȣ --------->
			<td width="150" class='con5'>�����ֹι�ȣ : <input type="checkbox" name="g_bank_jumin2" value="Y" checked></td>

			<!-------- ī���ȣ --------->
			<td width="150" class='con5'>ī���ȣ : <input type="checkbox" name="g_card_no" value="Y" checked></td>

			<!-------- ��ȿ�Ⱓ --------->
			<td width="150"  class='con5'>��ȿ�Ⱓ : <input type="checkbox" name="g_card_gigan" value="Y" checked></td>

			<!-------- ����ǰ���� --------->
			<td width="150"  class='con5'>����ǰ����  : <input type="checkbox" name="g_sp_bank_acount" value="Y" checked></td>

			<!-------- ����ǰ �ֹι�ȣ --------->
			<td width="150"  class='con5'>����ǰ �ֹι�ȣ : <input type="checkbox" name="g_sp_bank_jumin2" value="Y" checked></td>

			<!-------- ��ȣ�̵� �ֹι�ȣ --------->
			<td width="150"  class='con5'>��ȣ�̵� �ֹι�ȣ : <input type="checkbox" name="g_move_jumin2" value="Y" checked></td>
		</tr>
		<tr height="30">
			<!-------- ��ȣ�̵� ����ó --------->
			<td width="150"  class='con5'>��ȣ�̵� ����ó : <input type="checkbox" name="g_move_tel1" value="Y" checked></td>

			<!-------- ��ȣ�̵� �޴��� --------->
			<td width="150"  class='con5'>��ȣ�̵� �޴���: <input type="checkbox" name="g_move_tel2" value="Y" checked></td>

			<!-------- ī�� �ֹι�ȣ --------->
			<td width="150"  class='con5'>ī�� �ֹι�ȣ : <input type="checkbox" name="g_card_jumin2" value="Y" checked></td>

			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>
			<td width="150"  class='con5'></td>

			
		</tr>
		<tr height="30">
			<td colspan="8" class='con2' >&nbsp;&nbsp;&nbsp;
				<span style='color:red;'>* �ѹ� ��ŷó���� �����ʹ� ������ �Ұ��� �ϴ� �����ϰ� ó���� �ֽñ� �ٶ��ϴ�.</span></td>
		</tr>
		<tr height='30'>
			<td width="150" class='con5'>����Ⱓ</td>
			<td colspan="26" class='con5'>������ : 
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_password','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~<input type="text" name="s_date_end" size='9' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_password','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height="30" >
			<td colspan="26" class='con5' align="center" class="etcmenu">
				<a href="javaScript:frm_submit('frm_password');" class="etc_txt"><b class='button_orange'> �����ϱ�</b></a>
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
