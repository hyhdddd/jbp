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
 
  If session_m_step<>"M" Then
	Alert_url session_m_name&" ���� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  End If 
  
  strSql="select * from company_info where o_code='"& o_code &"'"  	
  set objRs=objCnn.Execute(strSql)
  		
  o_com_name		= objRs("o_com_name")				'ȸ�� ��
  o_office_no1		= objRs("o_office_no1")				'ȸ�� ����� ��ȣ1
  o_office_no2		= objRs("o_office_no2")				'ȸ�� ����� ��ȣ2
  o_office_no3		= objRs("o_office_no3")				'ȸ�� ����� ��ȣ3
  o_name			= objRs("o_name")					'ȸ�� ��ǥ�ڸ�
  o_judi_no1		= objRs("o_judi_no1")				'ȸ�� ���ε�Ϲ�ȣ1
  o_judi_no2		= objRs("o_judi_no2")				'ȸ�� ���ε�Ϲ�ȣ2
  o_zipcode1		= objRs("o_zipcode1")				'ȸ�� �����ȣ1
  o_zipcode2		= objRs("o_zipcode2")				'ȸ�� �����ȣ2
  o_address			= objRs("o_address")				'ȸ�� �ּ�
  o_type1			= objRs("o_type1")					'ȸ�� ����
  o_type2			= objRs("o_type2")					'ȸ�� ����
  o_tel1			= objRs("o_tel1")					'��ǥ ��ȭ1
  o_tel2			= objRs("o_tel2")					'��ǥ ��ȭ2
  o_tel3			= objRs("o_tel3")					'��ǥ ��ȭ3
  o_fax1			= objRs("o_fax1")					'��ǥ �ѽ�1
  o_fax2			= objRs("o_fax2")					'��ǥ �ѽ�2
  o_fax3			= objRs("o_fax3")					'��ǥ �ѽ�3

  %>  

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<% If https_chk="off" Then %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% Else %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<% End If %>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr bgcolor="#FFFFFF" height='400' valign='top'> 
	<td>
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub12_t02.gif"></div>
				
		<form name="frm_join" action="company_info_regist_ok.asp" method="post"  ENCTYPE="MULTIPART/FORM-DATA">

		<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height="30">
			<th> ȸ��� </th>
			<td colspan='3'><input size="24" name="o_com_name" class="txtbox" OnKeyUp="EnterNextFocus('frm_join','m_name');" value="<%=o_com_name%>"></td>
		</tr>
		<tr height="30">
			<th> ����ڹ�ȣ</th>
			<td colspan='3'>
				<input type="text" class="txtbox" name="o_office_no1" size="3" maxlength="3" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_office_no2'); fncNextFocus(this,3,'frm_join','o_office_no2');" value="<%=o_office_no1%>"> -
				<input type="text" class="txtbox" name="o_office_no2" size="2" maxlength="2" style="ime-mode:disabled;"  onFocus="FocusColor(this);this.select();" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_office_no3'); fncNextFocus(this,2,'frm_join','o_office_no3');" value="<%=o_office_no2%>"> -
				<input type="text" class="txtbox" name="o_office_no3" size="5" maxlength="5" style="ime-mode:disabled;"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_name'); fncNextFocus(this,5,'frm_join','o_name');" value="<%=o_office_no3%>">					
			</td>
		</tr>
		<tr height="30">
			<th width="120"> ��ǥ�� </th>
			<td width="280"><input size="14" name="o_name" class="txtbox" OnKeyUp="EnterNextFocus('frm_join','m_htel1');" value="<%=o_name%>"></td>
			<th width="120"> ����(�ֹ�)��Ϲ�ȣ </th>
			<td width="280">
				<input class="txtbox" name="o_judi_no1" type="text" size="7" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_judi_no2'); fncNextFocus(this,6,'frm_join','o_judi_no2');" value="<%=o_judi_no1%>"> - 
				<input class="txtbox" name="o_judi_no2" type="text" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_zipcode1'); fncNextFocus(this,7,'frm_join','o_zipcode1');" value="<%=o_judi_no2%>"></td>
		</tr>
		<tr height="30"> 
			<th> ȸ���ּ� </th>
			<td colspan='3'> 
				<input  type="text" class="txtbox" size="6" maxlength="6" id="o_zipcode1" name="o_zipcode1" readonly value="<%=o_zipcode1%>">
				<input class="txtbox" type="text" size="60" maxlength="60" id="o_address" name="o_address"  value="<%=o_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('o_zipcode1','o_address');">
			</td>
		</tr>
		<tr height="30">
			<th>����</th>
			<td><input size="20" name="o_type1" class="txtbox" OnKeyUp="EnterNextFocus('frm_join','o_type2');" value="<%=o_type1%>"></td>
			<th>����</th>
			<td>
				<input class="txtbox" name="o_type2" type="text" size="20" maxlength="20" value="<%=o_type2%>"></td>
		</tr>
		<tr height="30"> 
			<th> ��ǥ��ȭ </th>
			<td> 
				<input class="txtbox" size="4" maxlength="4" name="o_tel1" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_tel2');  fncNextFocus(this,4,'frm_join','o_tel2');"  value="<%=o_tel1%>">- 
				<input class="txtbox" size="4" maxlength="4" name="o_tel2" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_tel3'); fncNextFocus(this,4,'frm_join','o_tel3');" value="<%=o_tel2%>">- 
				<input class="txtbox" size="4" maxlength="4" name="o_tel3" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this);" value="<%=o_tel3%>">
			</td>
			<th> ��ǥ�ѽ� </th>
			<td> 
				<input class="txtbox" size="4" maxlength="4" name="o_fax1" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_fax2');  fncNextFocus(this,4,'frm_join','o_fax2');"  value="<%=o_fax1%>">- 
				<input class="txtbox" size="4" maxlength="4" name="o_fax2" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_join','o_fax3'); fncNextFocus(this,4,'frm_join','o_fax3');" value="<%=o_fax2%>">- 
				<input class="txtbox" size="4" maxlength="4" name="o_fax3" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this);" value="<%=o_fax3%>">
			</td>
		</tr>	
		<tr height="30"> 
			<th>ȸ��ΰ�</th>
			<td colspan='3'> 
				<input type="file" name="g_file1" size="50" class="txtbox" onBlur="BlurColor(this)" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(g_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
				<% End If %>
				<span class='red'>* �̹��� ������ : 240 * 40</span><br>
			</td>
		</tr>
		</table>
		</form>

		<div class="button"><img src="/images/button/btn_save.gif" onClick="company_edit('frm_join');" onMouseOver="this.style.cursor='hand';"></div>
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

