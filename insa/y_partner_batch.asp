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
  if ad_i_a_company="N" then
	Alert_url session_m_name &" ���� �ŷ�ó��� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  
  board_idx			= WORD_CHANGE(request("board_idx"),20)
  
 
  strSql = " select * from dealer_partner_info where board_idx="&board_idx
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.bof Then
  Else
	dealer_name			= objRs("dealer_name")
	dealer_com_yn		= objRs("dealer_com_yn")
	dealer_com_no		= objRs("dealer_com_no")
'	dealer_bank_name	= objRs("dealer_bank_name")			' ���� ������
'	dealer_bank_cd		= CStr(objRs("dealer_bank_cd"))		' ���� �ڵ�
'	dealer_bank_no		= objRs("dealer_bank_no")			' ���� ���¹�ȣ
	dealer_zipcode1		= objRs("dealer_zipcode1")			' ȸ�� �����ȣ1
	dealer_zipcode2		= objRs("dealer_zipcode1")			' ȸ�� �����ȣ2
	dealer_address		= objRs("dealer_address")			' ȸ�� �ּ�			

	board_idx			= objRs("board_idx")
	m_id				= objRs("m_id")
	m_name				= objRs("m_name")
	m_passwd			= Trim(objRs("m_passwd"))
'	m_jumin1			= objRs("m_jumin1")
'	m_jumin2			= objRs("m_jumin2")
	m_zipcode1			= objRs("m_zipcode1")
	m_zipcode2			= objRs("m_zipcode2")
	m_address			= objRs("m_address")
	m_email				= objRs("m_email")
	m_tel1				= objRs("m_tel1")
	m_tel2				= objRs("m_tel2")
	m_bigo				= objRs("m_bigo")
'	m_bank_name			= objRs("dealer_bank_name")
'	m_bank_cd			= objRs("dealer_bank_cd")
'	m_bank_no			= objRs("dealer_bank_no")
	dealer_tel1			= objRs("dealer_tel1")
	dealer_tel2			= objRs("dealer_tel2")
'	dealer_com_jumin	= m_jumin1&"-"&m_jumin2
  End if

 If dealer_com_yn="Y" Then
	business_chk1 = "checked"
 Else
	business_chk2 = "checked"
 End If


 if len(dealer_file1)>0 then
	filepath1="/file_data/"& o_code &"/partner_info/"	
 end If
 if len(dealer_file2)>0 Then
	filepath2="/file_data/"& o_code &"/partner_info/"	
end If
 %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
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
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
				
		<!------------------ ���� ����  ------------------>
		<div class="sub_title"><img src="/images/common/sub03_t05.gif"></div>
		
		<form name="frm_dealer" Method="POST" action="y_partner_batch_ok.asp" ENCTYPE="MULTIPART/FORM-DATA">
		<input type="hidden" name="partner_idx" value="<%=board_idx%>">
		<input type="hidden" name="m_dealer_admin" value="O">

		<input type="hidden" name="m_idx" value="<%=m_idx%>">				
		<input type="hidden" name="page" value="<%=page%>">								
		<input type="hidden" name="y_chk" value="X">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='4' class="description"> 
				* ȸ��� �ŷ��ϴ� ��� �ŷ�ó�� ������ �Է��ϴ� ������ �Դϴ�.  <br>
				* �ŷ�ó ������ '�ŷ�ó ������� , �� �μ�/�ΰ�ó�� �� �������� ���� �� �ֽ��ϴ�. <br>
				<span class='red'>* �ѹ� ����� �ŷ�ó �ڵ�/ID�� ������ �Ұ��� �մϴ�. <br>
				* �ŷ�ó ������ ��Ȯ�� �Է��Ͻð� �����Ͻñ� �ٶ��ϴ�. <br></span>
			</td>
		</tr>
		<tr height="35"> 
			<td colspan='4'><img src="/images/common/partner_com_title.gif" align="absmiddle"></td>
		</tr>
		<tr height=30> 
			<th width="130">�ŷ�ó ��ȣ</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_name" maxlength="20" size="20"  value="<%=dealer_name%>"  maxlength="30">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio"  name="dealer_com_yn" value="Y" <%=business_chk1%>>�����&nbsp;&nbsp;	
				<input type="radio"  name="dealer_com_yn" value="N" <%=business_chk2%>>��  ��
			</td>
			<th width="130">�ŷ� ����</th>
			<td width="370">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox"  name="dealer_insu" value="Y"  checked >������&nbsp;&nbsp;	
				<input type="checkbox"  name="dealer_ingea" value="Y">�����
			</td>
		</tr>
		<tr height=25>
			<th width="130">����ڹ�ȣ</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_com_no" maxlength="12" size="20" value="<%=dealer_com_no%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;
				<font color="blue">* 000-00-00000 </font>
			</td>
			<th> E-Mail </th>
			<Td> 
				<input type="text" name="dealer_email" class="txtbox" maxlength="30" size="20" style="ime-mode:disabled;" value="<%=m_email%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service1');">
			</td>
		</tr>
		<tr>
			<th>����</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_service1" maxlength="20" size="20" value="<%=dealer_service1%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service2');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('ȸ�� ����(�ִ�8��)�� �Է��� �ִ� �� �Դϴ�.');">		
			</td>
			<th>����</th>
			<Td> 
				<input type="text" name="dealer_service2" class="txtbox" maxlength="20" size="20" value="<%=dealer_service2%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_bank_cd');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('ȸ�� ����(�ִ�8��)�� �Է��� �ִ� �� �Դϴ�.');">
			</td>
		</tr>
		<tr> 
			<th>�ŷ�����</th>
			<td>
				<select name="dealer_bank_cd" class="txtbox">
				<option value="0" <% if dealer_bank_cd="0" then %> selected <% end if %>> ���� ���� 
			<% 
			strSql= " select board_idx,bank_name from code_bank order by bank_name ASC"
			set objRs1=objCnn.Execute(strSql)

			Do until objRs1.EOF
				bank_board_idx	= objRs1(0)
				bank_name		= objRs1(1)
			%>                      							
				<option value="<%=bank_board_idx%>" <% if Cstr(bank_board_idx)=dealer_bank_cd then %> selected 
				<% end if %>><%=bank_name%></option>
			<%
				objRs1.movenext
			Loop
			%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('�ŷ�ó ������ �Է��� �ִ� �� �Դϴ�.');">
			</td>
			<th>���¹�ȣ</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_no" maxlength="20" size="20"  value="<%=dealer_bank_no%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel1');">&nbsp;
				<font color="blue">* 000-000-000000 </font>
			</td>
		</tr>
		
		<tr>
			<th> ��ǥ��ȭ </th>
			<Td> 
				<input type="text" name="dealer_tel1" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel2');">&nbsp
				<font color="blue">* 02-000-0000 </font>
			</td>				
			<th> �ѽ���ȣ </th>
			<Td> 
				<input type="text" name="dealer_tel2" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;
				<font color="blue">* 010-000-0000 </font>
			</td>
		</tr>
		<tr height=25>
			<th> ȸ�� �ּ�</th>
			<td colspan='3' class="table_list2">
				<input  type="text" class="txtbox" size="6" maxlength="6" id="dealer_zipcode1" name="dealer_zipcode1" readonly value="<%=dealer_zipcode1%>">
				<input class="txtbox" type="text" size="70" maxlength="70" id="dealer_address" name="dealer_address" readonly value="<%=dealer_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('dealer_zipcode1','dealer_address');">
			</td>
		</tr>
		<tr> 
			<th>����׷켳��</th>
			<td>
				<select name="dealer_group_code" class="txtbox">
				<option value="0" <% if dealer_group_code="0" then %> selected <% end if %>> �׷� ���� 
				<% 
				strSql= " select group_code,group_name from code_group order by group_name ASC"
				set objRs1=objCnn.Execute(strSql)

				Do until objRs1.EOF
					group_code		= objRs1(0)
					group_name		= objRs1(1)
				%>                      							
				<option value="<%=group_code%>" <% if dealer_group_code=group_code then %> selected <% end if %>><%=group_name%></option>
				<%
					objRs1.movenext
				Loop
				%>
				</select>
			</td>
			<th>  </th>
			<td>  </td>
		</tr>	
		<tr> 
			<th>÷������1</th>
			<td colspan='3'> 
				<input type="file" name="dealer_file1" size="62" class="txtbox" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file1%>&fpath=<%=filepath1%>"><%=dealer_file1%></a>
				<% End If %>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('�ŷ�ó�� ����� �纻/���� �纻/�ֹε���� �纻 ���� �����Ҽ� �ֽ��ϴ�.(�����̸��� �ִ�20��)');">
			</td>
		</tr>
		<tr> 
			<th>÷�� ����2</th>
			<td colspan='3'> 
				<input type="file" name="dealer_file2" size="62" class="txtbox" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file2)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file1%>&fpath=<%=filepath2%>"><%=dealer_file2%></a>
				<% End If %>

			</td>
		</tr>

		
		<tr>
			<td colspan='4' class='con2'><br>&nbsp;</td>
		</tr>
		<tr height="35"> 
			<td colspan='4'><img src="/images/common/total_staff_title.gif" align="absmiddle"></td>
		</tr>
		<tr height='30'> 
			<th class='con9'>���̵�</th>
			<td> 
				<input type="text" class="txtbox" name="m_id" size="16" maxlength="14"  value="<%=m_id%>" style="ime-mode:disabled">				
			</td>
			<th>��� ��й�ȣ</th>
			<td> 
				<input type="password" name="m_passwd" class="txtbox" value="<%=m_passwd%>" size="20" maxlength="20"   style="ime-mode:disabled;">
			</td>
		</tr>
		<tr height='30'> 
			<th>�� ��</th>
			<td> 
				<input type="text" class="txtbox" name="m_name" size="10" maxlength="20" value="<%=m_name%>">
			</td>
			<th></th>
			<td>  
			</td>
		</tr>
		<tr height='30'> 
			<th>�μ� �ڵ�</th>
			<td> 
				<select name="m_duty" class="txtbox" style="width:100px;">
					<option value="0"  <% if m_duty="0" then %> selected <% end if %>> ��  �� 
					<% 
					strSql = " select * from code_duty order by duty_code asc"
					set objRs1=objCnn.Execute(strSql)
					
					Do until objRs1.EOF 
						duty_code	= objRs1("duty_code")
						duty_name	= objRs1("duty_name")
					%>
						<option value="<%=duty_code%>"  <% if m_duty=duty_code then %> selected <% end if %>> 
						<%=duty_name%> 
					<%
						objRs1.movenext
					Loop
					objRs1.close
					%>
				</select> 
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('�μ��ڵ�� �ڵ���� - �μ��ڵ���� �޴����� ���/���� �Ҽ� �ֽ��ϴ�.');">&nbsp;&nbsp;&nbsp;				
			</td>
			<th>����/����</th>
			<td> 
				<select name="m_position" style="width:100px;">
					<option value="0" <% if m_position="0" then %> selected <% end if %>>�� ��
					<% 
					strSql = " select * from code_position order by position_code asc"
					set objRs1=objCnn.Execute(strSql)
					
					Do until objRs1.EOF 
						position_code		= objRs1("position_code")
						position_name		= objRs1("position_name")
					%>
						<option value="<%=position_code%>"  <% if m_position=position_code then %> selected <% end if %> >
						<%=position_name%> 
					<%
						objRs1.movenext
					loop
					%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('��å�ڵ�� �ڵ���� - ��å�ڵ���� �޴����� ���/���� �Ҽ� �ֽ��ϴ�.');">
			</td>
		</tr>              
		<tr height='30'> 
			<th>�� ��(�����ȣ)</th>
			<td colspan="3"> 
				<input  type="text" class="txtbox" size="6" maxlength="6" id="m_zipcode1" name="m_zipcode1" readonly value="<%=m_zipcode1%>">
				<input class="txtbox" type="text" size="60" maxlength="60" id="m_address" name="m_address" readonly value="<%=m_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('m_zipcode1','m_address');">
			</td>
		</tr>
		<tr height='30'> 
			<th>����ó</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel1" size="20" value="<%=m_tel1%>" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_dealer','m_tel2');">
			</td>			
			<th>�޴���</th>
			<td> 
				<input type="text" class="txtbox" name="m_tel2" size="20" value="<%=m_tel2%>" style="ime-mode:disabled"  onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_dealer','m_email');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>E-Mail</th>
			<td colspan="3"> 
				<input type="text" class="txtbox"  name="m_email" size="25" style="ime-mode:disabled;"  value="<%=m_email%>"  onKeyUp="EnterNextFocus('frm_dealer','m_login_ip');">
			</td>			
		</tr>
		<tr height='30'> 
			<th>�α��� IP</th>
			<td colspan="3"> 
				<input type="text" class="txtbox" name="m_login_ip" size="25"  style="ime-mode:disabled;"  value="<%=m_login_ip%>" > <span class='red'> �Է� ���� : 123.123.123.123 (�α��� IP�� ����� ������ Ư�� ��ǻ�Ϳ����� ������ �˴ϴ�.) </span>
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('IP �Է��ϸ� �Էµ� IP �� �α����� �����մϴ�. \n\n �������� �α����� �����ϰ� �ҷ��� IP �Է¸� ���� ���ʽÿ�!');">
			</td>			
		</tr>  
		<tr height='30'> 
			<th>�޿� ���� Ÿ�� </th>
			<td colspan="3"> 
				<INPUT type=radio style="border-style:none;" value="A" name="m_pay_type" <% if m_pay_type="A" Or pay_type="" then %> checked <% end if %>>������ &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="B" name="m_pay_type" <% if m_pay_type="B" then %> checked <% end if %>>����� &nbsp;&nbsp;&nbsp;
				<INPUT type=radio style="border-style:none;" value="C" name="m_pay_type" <% if m_pay_type="C" then %> checked <% end if %>>������ (���������� ���� �޿�)&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr height='30'> 
			<th> �Ի���</th>
			<td>
				<input class="txtbox" type="text" name="m_in_date" size='10' readonly value="<%=m_in_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_in_date&code2=&code3=&form_name=frm_dealer','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
			</td>
			<th> �����</th>
			<td>
				<input class="txtbox" type="text" name="m_out_date" size='10' readonly value="<%=m_out_date%>"
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=m_out_date&code2=&code3=&form_name=frm_dealer','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
			</td>		
		</tr>		                		
		<tr height='30'> 
			<th>���� ����</th>
			<td> 
				<INPUT type="radio" value="O" name="m_status" <% if m_status="O" Or m_status="" Or IsNull(m_status) then %> checked <% end if %>>
				������ 
				<INPUT type="radio" value="X" name="m_status" <% if m_status="X" then %> checked <% end if %>>
				�����
				&nbsp;<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onMouseOver="this.style.cursor='hand';" onClick="alert('����ڷ� ���õ� ����� �α��θ� �� �� �����ϴ�.');">
				</td>
			<th>�ξ� ������</th>
			<td> 
				<select name="m_family_no">
				<option value="1" <% If m_family_no="1" Then %> selected <% End If %>> 1�� </option>
				<option value="2" <% If m_family_no="2" Then %> selected <% End If %>> 2�� </option>
				<option value="3" <% If m_family_no="3" Then %> selected <% End If %>> 3�� </option>
				<option value="4" <% If m_family_no="4" Then %> selected <% End If %>> 4�� </option>
				<option value="5" <% If m_family_no="5" Then %> selected <% End If %>> 5�� </option>
				<option value="6" <% If m_family_no="6" Then %> selected <% End If %>> 6�� </option>
				<option value="7" <% If m_family_no="7" Then %> selected <% End If %>> 7�� </option>
				<option value="8" <% If m_family_no="8" Then %> selected <% End If %>> 8�� </option>
				<option value="9" <% If m_family_no="9" Then %> selected <% End If %>> 9�� </option>
			</td>
		</tr>   
		<tr height='30'> 
			<th>��Ÿ����</th>
			<td colspan="3"> 
				<textarea wrap="hard" rows="3" name="m_bigo" cols="100" class="txtbox"><%=m_bigo%></textarea>
			</td>
		</tr>
		<tr height=30> 
			<td colspan='4' align='right'>
				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<a href ="y_partner_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%>���� �ŷ�ó ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<img src="/images/button/btn_save.gif" border=0 align="absmiddle" onclick="partner_dealer_all();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� �ŷ�ó ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %> 								
			</td>	
		</tr>
		</table>
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

