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

  strSql = " select * from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  o_com_name	= objRs("o_com_name")
  %>   
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function sms_send(frm_name)
	{
		var frm=eval("document.all."+frm_name);
		ans=confirm(" SMS�� ���� ��û �Ͻðڽ��ϱ�?");
		if(ans==true)
		{
			frm.submit();
		}
	}
-->
</script>
<body topmargin=0 leftmargin=0 bgcolor="#FFFFFF" text="#000000">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<div class="outerContainer_pop">
<!------------------ ���� ����  ------------------>
<div class="sub_title"><img src="/images/common/sub12_t04_2.gif"></div>

<form name="frm_sms" method="post" action="http://entersoft.kr/sms/sms_pay_ok.asp">
<input type="hidden" name="s_m_id"		value="<%=Session_m_id%>">
<input type="hidden" name="s_o_code"	value="<%=o_code%>">

<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3">
<tr height="50">
	<th width="100"> ��ü�� </th>
	<td>&nbsp;<%=o_com_name%> </td>
</tr>
<tr height="50">
	<th width="100"> ��û��<br>�Ա��ڸ� </th>
	<td>&nbsp;<%=session("m_name")%></td>
</tr>
<tr height="50">
	<th>���� �Ǽ�<br>(�Ǵ� 20��)</th>
	<Td>
		&nbsp; <input type="radio" name="sms_cnt" style="border-style:none;" value="1000" checked> 1,000 ��(22,000�� VAT����) &nbsp;&nbsp;&nbsp;
		<input type="radio" name="sms_cnt"style="border-style:none;" value="2000"> 2,000 ��(44,000�� VAT����) <br>
		&nbsp; <input type="radio" name="sms_cnt" style="border-style:none;" value="3000"> 3,000 ��(66,000�� VAT����) &nbsp;&nbsp;&nbsp;
		<input type="radio" name="sms_cnt" style="border-style:none;" value="5000"> 5,000 ��(110,000�� VAT����)
	</td>
</tr>
<tr height="50">
	<th width="100"> ���� ���¹�ȣ </th>
	<td>&nbsp; <span class='blue'>(����) 132-055-917955 </span></td>
</tr>
<tr height="50">
	<th width="100"> ������ </th>
	<td>&nbsp; <span class='blue'> �־ȱ�(���ͼ���Ʈ) </span></td>
</tr>
<tr height="50">
	<td colspan='2'>
		&nbsp;&nbsp;&nbsp;* ���¹�ȣ�� ���� ������ �� <span class='red'>������ �Ա�</span>�� �ֽø� ���ͼ���Ʈ ���� Ȯ�� ��
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��� ������ �帳�ϴ�.&nbsp;&nbsp;<span class='blue'>�ΰ����� ���� �Դϴ�.</span>
	</td>
</tr>
</table>
</form>

<div class="button">
	<a href="javascript:self.close()""><img src="/images/button/btn_close.gif" border=0 align="absmiddle"></a> 
	<a href="javascript:sms_send('frm_sms');"><img src="/images/button/btn_regist.gif" border=0 align="absmiddle"></a>
</div>				
<!------------------ ���� ����  ------------------>
</div> 