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
  <%
  strSql = " select * from company_info where o_code='"&o_code&"'"
  Set objRs=objCnn.Execute(strSql)

  o_agree		= objRs("o_agree")
  
  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<!--link href="/include/css/style.css" rel="stylesheet" type="text/css" /-->

<style>
/* ��Ʈ�� ���� ��û */
@charset "euc-kr";
html, body { width:100%;height:100%;margin:0;padding:0; }

/* Type Selector */
body, table, tr, td, p, br, div, ul, li, dl, dd, dt, input, textarea, select { font-family:����, ����, "����", Dotum, "����", Gulim, Tahoma, Verdana, AppleGothic, Sans-serif; color:#666;font-size:12px; }
img, fieldset, button{border:none;}
hr, button img{display:none;}
li{list-style:none; }
html:first-child select{padding-right:6px; height:20px;} /* Opera 9 & Below Fix */ 
option {padding-right:6px;} /* Firefox Fix */
legend {position:absolute; top:0; left:0; width:0; height:0; overflow:hidden; visibility:hidden; font-size:0; line-height:0;} /* For Screen Reader */ 

form { margin:0px; }

img {border:0px;}

a:link, a:visited, a:active { text-decoration:none;color:#666666; }
a:hover { text-decoration:underline; }

.is_textarea { border:solid 1px #d9d9d9;width:98%;height:120px; }
.is_textarea2 { border:solid 1px #d9d9d9;width:98%;height:50px; }
.input { border:solid 1px #d9d9d9; }

.is_agree { width:600px;padding-top:4px;padding-bottom:4px;background:#f7f7f7;text-align:center; }
.is_agree2 { width:600px;height:25px;border-bottom:solid 1px #d9d9d9;background:#f7f7f7; }

.is_title { font-weight:bold;height:30px; }

.is_label { width:100px;height:30px;border-bottom:solid 1px #d9d9d9; }
.is_input { width:500px;height:30px;border-bottom:solid 1px #d9d9d9; }
.is_input2 { width:200px;height:30px;border-bottom:solid 1px #d9d9d9; }
.is_input3 { width:500px;padding-top:4px;padding-bottom:4px;border-bottom:solid 1px #d9d9d9; }
</style>

<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<% If https_chk="off" Then %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% Else %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<% End If %>

<script language="javascript">
<!--
	function id_chk1()
	{
		var frm=document.all.frm_emp_regist;
		if(checkSpecialChar(frm.m_id.value)==false)
		{
			alert("���̵� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
			frm.m_id.focus();
			return;
		}

   		if((frm.m_id.value.length<4) || (frm.m_id.value.length>10))
	   	{
   			alert("���̵�� 4���̻� 10�� ���Ϸ� �Է��� �ּ���");
   			frm.m_id.focus();
	   		return;
   		}	 
		m_id = frm.m_id.value;
		aspname	= "/insa/y_partner_id_chk.asp?m_id="+m_id;
		NewWindow(aspname,'partner_id_chk','0','0','no');
	}

	// �����׸� üũ
	function address_copy(form_name,chk)
	{
		var frm=eval("document.all."+form_name);

		if(chk.checked==true)
		{
			frm.dealer_zipcode1.value=frm.m_zipcode1.value;
			frm.dealer_address.value=frm.m_address.value;
		}
		else
		{
			frm.dealer_zipcode1.value="";
			frm.dealer_address.value="";
		}
	}
-->
</script>

<div align="center"><img src="/images/Common/is_title.gif"></div>

<form action="y_partner_regist_ok.asp" method="post" name="frm_emp_regist"> 
<input type="hidden" name="id_chk" value="">

<table cellpadding="0" cellspacing="0" align="center">

<tr><td class="is_agree" colspan="4"><textarea class="is_textarea" name="m_agree"><%=o_agree%></textarea></td></tr>
<tr><td class="is_agree2" colspan="4"><input type="checkbox" name="strAgree">�� ����� �����մϴ�.</td></tr>

<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ���̵�</td>
	<td class="is_input" colspan="3">
		<input type="text" class="input" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled">
		<img src="/images/Common/btn_chk_id.gif" align='absmiddle' onclick="id_chk1();">
	</td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> �� ��</td>
	<td class="is_input" colspan="3">
		<input type="text" class="input" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
	</td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ��й�ȣ �Է�</td>
	<td class="is_input2"><input type="password" name="m_passwd" class="input" value="<%=m_passwd%>" size="20" maxlength="20"   style="ime-mode:disabled;"></td>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ��й�ȣ Ȯ��</td>
	<td class="is_input2"><input type="password" name="m_passwd1" class="input" value="<%=m_passwd%>"size="20" maxlength="20"   style="ime-mode:disabled;"></td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> �� ��</td>
	<td class="is_input" colspan="3">
		<input  type="text" class="input" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
		<input class="input" type="text" size="50" maxlength="60" id="m_address" name="m_address"  value="<%=m_address%>"><img src="/images/Common/btn_zipsearch.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">
	</td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ����ó</td>
	<td class="is_input2"><input type="text" name="m_tel1" class="input" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=m_tel1%>" 
		OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_emp_regist','m_tel2');"></td>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> �ڵ��� </td>
	<td class="is_input2"><input type="text" name="m_tel2" class="input" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=m_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> E-Mail</td>
	<td class="is_input" colspan="3">
		<input type="text" class="input"  name="m_email" size="60" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_emp_regist','dealer_name');">
	</td>
</tr>
<tr><td height="10"></td></tr>
<tr><td class="is_title" colspan="4">	<img src="/images/Common/info_company.gif"></td></tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ȸ �� ��</td>
	<td class="is_input" colspan="3">
		<input type="Text" class="input" name="dealer_name" size="25"  value="<%=dealer_name%>"  maxlength="30" onBlur="BlurColor(this)" onKeyUp="EnterNextFocus('frm_emp_regist','dealer_bank_name');">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio"  name="dealer_com_yn" value="Y" checked>�����&nbsp;&nbsp;	
		<input type="radio"  name="dealer_com_yn" value="N" <%=business_chk2%>>��  ��
	</td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ��ǥ�ڸ�</td>
	<td class="is_input2"><input type="Text" class="input" name="dealer_bank_name" size="25" value="<%=dealer_bank_name%>" onBlur="BlurColor(this)"></td>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ����ڹ�ȣ</td>
	<td class="is_input2"><input type="Text" class="input" name="dealer_com_no" size="25" value="<%=dealer_com_no%>" onBlur="BlurColor(this)"></td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ȸ�� �ּ�</td>
	<td class="is_input" colspan="3">
		<input  type="text" class="input" size="6" maxlength="6" id="dealer_zipcode1" name="dealer_zipcode1" readonly value="<%=dealer_zipcode1%>">
		<input class="input" type="text" size="50" maxlength="60" id="dealer_address" name="dealer_address" value="<%=dealer_address%>"><img src="/images/Common/btn_zipsearch.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('dealer_zipcode1','dealer_address');">
		<input type="checkbox" name="g_juso_chk" value="Y" onclick="address_copy('frm_emp_regist',this);"> <span class='blue'>*�� �ּ� ����</span>
	</td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ��ǥ��ȭ</td>
	<td class="is_input2"><input type="text" name="dealer_tel1" class="input" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel1%>" 
		OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_emp_regist','dealer_tel2');"></td>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> �ѽ���ȣ</td>
	<td class="is_input2"><input type="text" name="dealer_tel2" class="input" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
</tr>
<tr>
	<td class="is_label"><img src="/images/Common/bullet.gif" align="absmiddle"> ���</td>
	<td class="is_input3" colspan="3"><textarea class="input" rows="3" name="is_textarea2" cols="75"></textarea></td>
</tr>
<tr><td colspan="4" height="40" align="center">
	<img src="/images/Common/btn_confirm.gif" align="absmiddle" onClick="send_partner_regist();" onmouseover="this.style.cursor='hand';">
	<img src="/images/Common/btn_cancel.gif" align="absmiddle" onClick="self.close();" onmouseover="this.style.cursor='hand';">
</td></tr>
</table>

</form>	


