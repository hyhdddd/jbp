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
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  g_yuchi_m_id			= WORD_CHANGE(Request("g_yuchi_m_id"),20)
  
  If g_yuchi_m_id="" Or IsNull(g_yuchi_m_id) Then
	Alert "���� ID�� ��� ������ ���� �� �����ϴ�. \n\n �����ڿ� ������ �ּ���!"
	win_close()
  Else
	strSql = "select * from emp_list where m_id='"&g_yuchi_m_id&"'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		Alert "����� ���꿡 ���� ID�� �������� �ʾ� ������ ���� �� �����ϴ�. \n\n �����ڿ� ������ �ּ���!"
		win_close()
	Else
		m_status	= objRs("m_status")

		If m_status="X" Then
			Alert " ����� ���꿡 ����ڷ� �Ǿ� �־ ������ ���� �� �����ϴ�."
			win_close()
		End if
	End if
	
  End If
  
  
  dealer_name		= WORD_CHANGE(request("dealer_name"),20)	
  c_name			= WORD_CHANGE(request("c_name"),20)	
  c_type			= WORD_CHANGE(Request("c_type"),20)
  c_jumin1			= WORD_CHANGE(request("c_jumin1"),20)
  c_jumin2			= WORD_CHANGE(request("c_jumin2"),20)
  c_office_no		= WORD_CHANGE(request("c_office_no"),20)
  c_office_name		= WORD_CHANGE(request("c_office_name"),20)
  c_zipcode1		= WORD_CHANGE(request("c_zipcode1"),20)
  c_zipcode2		= WORD_CHANGE(request("c_zipcode2"),20)
  c_address			= WORD_CHANGE(request("c_address"),200)
  c_tel1			= WORD_CHANGE(request("c_tel1"),20)
  c_tel2			= WORD_CHANGE(request("c_tel2"),20)
  c_email			= WORD_CHANGE(request("c_email"),50)
  c_auth_chk		= WORD_CHANGE(request("c_auth_chk"),20)
  c_jumin_date		= WORD_CHANGE(request("c_jumin_date"),50)
  g_code_course_idx	= WORD_CHANGE(request("g_code_course_idx"),20)		'�������

  g_give_type		= WORD_CHANGE(request("g_give_type"),20)			'��������
  g_give_chk		= WORD_CHANGE(request("g_give_chk"),20)				'���ΰ���

  c_bank_cd			= WORD_CHANGE(request("c_bank_cd"),20)				'�����ڵ�
  c_bank_no			= WORD_CHANGE(request("c_bank_no"),20)				'���¹�ȣ
  c_bank_name		= WORD_CHANGE(request("c_bank_name"),20)			'������
  c_bank_jumin1		= WORD_CHANGE(request("c_bank_jumin1"),20)		'��ü���� �ֹι�ȣ(����� �ٸ����)
  c_bank_jumin2		= WORD_CHANGE(request("c_bank_jumin2"),20)			'��ü���� �ֹι�ȣ(����� �ٸ����)


  c_card_cd			= WORD_CHANGE(request("c_card_cd"),20)				'ī���
  g_card_no			= WORD_CHANGE(request("g_card_no"),20)				'ī���ȣ
  g_card_gigan		= WORD_CHANGE(request("g_card_gigan"),20)			'ī�� ��ȿ�Ⱓ
  g_card_gigan1		= WORD_CHANGE(request("g_card_gigan1"),20)		'ī�� ��ȿ�Ⱓ
  g_card_name		= WORD_CHANGE(request("g_card_name"),20)			'ī�� ��ȿ�Ⱓ
  g_card_jumin1		= WORD_CHANGE(request("g_card_jumin1"),20)			'ī�� ��ȿ�Ⱓ
  g_card_jumin2		= WORD_CHANGE(request("g_card_jumin2"),20)			'ī�� ��ȿ�Ⱓ

  '����ǰ ��������
  g_sp_bank_code	= WORD_CHANGE(request("g_sp_bank_code"),20)			'����ǰ �����ڵ�
  g_sp_bank_acount	= WORD_CHANGE(request("g_sp_bank_acount"),20)		'����ǰ �������
  g_sp_bank_name	= WORD_CHANGE(request("g_sp_bank_name"),20)			'����ǰ ���࿹����
  g_sp_bank_jumin1	= WORD_CHANGE(request("g_sp_bank_jumin1"),20)		'����ǰ ���࿹����
  g_sp_bank_jumin2	= WORD_CHANGE(request("g_sp_bank_jumin2"),20)		'����ǰ ���࿹����


  g_set				= WORD_CHANGE(request("g_set"),20)					'��Ʈ����
  g_bigo			= WORD_CHANGE(request("g_bigo"),0)

  g_move_tel1		= WORD_CHANGE(request("g_move_tel1"),20)
  g_move_name		= WORD_CHANGE(request("g_move_name"),20)
  g_move_jumin1		= WORD_CHANGE(request("g_move_jumin1"),20)
  g_move_jumin2		= WORD_CHANGE(request("g_move_jumin2"),20)
  g_move_date		= WORD_CHANGE(request("g_move_date"),20)
  g_move_tel2		= WORD_CHANGE(request("g_move_tel2"),20)
  g_move_company	= WORD_CHANGE(request("g_move_company"),20)
  g_move_memo		= WORD_CHANGE(request("g_move_memo"),20)

  strSql = "select * from code_gita where gita_idx=1"
  Set objRs = objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
	g_bigo		= objRs("gita_bigo")
  End If

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT language=JavaScript src="/include/js/common.js?v=20231110"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/emp_select.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/sale_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/service_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/promise_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/area_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/js_combine.asp"></SCRIPT>

<% If https_chk="off" Then %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% Else %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<% End If %>

<script language="Javascript">
window.onload	= function()
{
	style_view_chk('frm_custom_regist','A');
	style_view_chk('frm_custom_regist','B');
	style_view_settop('frm_custom_regist','A')
	style_view_settop('frm_custom_regist','B')
}
-->
</script>
<div class="outerContainer">

	<!------------------ ���� ����  ------------------>

	<div class="sub_title"><img src="/images/common/sub01_t01.gif"></div>

	
	<form id="frm_custom_regist" name="frm_custom_regist" action="p_custom_goods_trans_ok.asp" method="post" ENCTYPE="MULTIPART/FORM-DATA"> 
	<input type="hidden" name="g_jupsu_m_id" value="<%=g_yuchi_m_id%>">
	<input type="hidden" name="g_yuchi_m_id" value="<%=g_yuchi_m_id%>">

	<table width="100%" border=0 cellspacing="0" cellpadding="0" id="board_table3">
	<tr height="30">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;&nbsp;<span class='red' style="font-size:16px;"><b><%=dealer_name%></b></span></td>
	</tr>
	<tr height="30">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;�� ����</td>
	</tr>
	<Tr>
		<th width="130"> ���� </th>
		<td width="320">
			<input type="text" name="c_name" size="15" class="txtbox" value="<%=c_name%>" maxlength=20 OnKeyUp="EnterNextFocus('frm_custom_regist','c_office_no');">	</td>					
		<th width="130"> ���� </th>
		<td width="320"> 
			<input type="radio" name="c_type" value="C" style="border-style:none;" <% if c_type="C" then %> checked <% end if %>>���� 
			<input type="radio" name="c_type" value="O" style="border-style:none;" <% if c_type="O" then %> checked <% end if %>>����� 
			<input type="radio" name="c_type" value="F" style="border-style:none;" <% if c_type="F" then %> checked <% end if %>>�ܱ��� 
			</td>
	</tr>
	<tr>
		<th> �ֹι�ȣ </th>
		<td> 
			<input type="text" name="c_jumin1" class="txtbox" value="<%=c_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_jumin2'); fncNextFocus(this,6,'frm_custom_regist','c_jumin2');">-<input type="text" name="c_jumin2" class="txtbox" value="<%=c_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_office_no'); fncNextFocus(this,7,'frm_custom_regist','c_office_no');">
			<img src="/images/button/btn_black_chk.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="black_search('frm_custom_regist');">
		</td>
					
		<th> ����ڹ�ȣ</th>
		<td>
			<input type="text" name="c_office_no" class="txtbox" value="<%=c_office_no%>" size="20" maxlength="20"	style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_tel1'); fncNextFocus(this,10,'frm_custom_regist','c_tel1');" >
			&nbsp;&nbsp;
			��ǥ��
			<input type="text" name="c_office_name" class="txtbox" value="<%=c_office_name%>" size="15" maxlength="15" ></td>
	</tr>				
	<tr>
		<th> �ּ� </th>
		<td colspan="3">
			<input type="text" id="c_zipcode1" name="c_zipcode1" class="txtbox" value="<%=c_zipcode1%>" size="6" maxlength="6" OnKeyPress="onlyNumber()"  style="ime-mode:disabled;" readonly>
			<input type="text" id="c_address" name="c_address" class="txtbox" value="<%=c_address%>"  size="80" maxlength="80" OnKeyDown="enter_chk('c_tel1');"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('c_zipcode1','c_address');">		
		</td>
	</tr>	
	<tr>
		<th> ��ȭ </th>
		<td> 
			<input type="text" name="c_tel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_tel1%>" 
			OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','c_tel2');">&nbsp
			<font color="blue">* 02-000-0000 </font>
		</td>				
		<th> �ڵ��� </th>
		<td> 
			<input type="text" name="c_tel2" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','c_email');">
			<img src="/images/button/btn_black_chk.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="black_search_tel('frm_custom_regist','c_tel2');">
			
				<select name="c_tel2_com" class='txtbox'>
				<option value="">::��Ż�:: </option>
				<option value="SK" <% If c_tel2_com="SK" Then %> selected <% End If %>>SK</option>
				<option value="LG" <% If c_tel2_com="LG" Then %> selected <% End If %>>LG </option>
				<option value="KT" <% If c_tel2_com="KT" Then %> selected <% End If %>>KT</option>				
				<option value="SK�˶���" <% If c_tel2_com="SK�˶���" Then %> selected <% End If %>>SK�˶���</option>
				<option value="LG�˶���" <% If c_tel2_com="LG�˶���" Then %> selected <% End If %>>KT�˶���</option>
				<option value="KT�˶���" <% If c_tel2_com="KT�˶���" Then %> selected <% End If %>>LG�˶���</option>

				</select>
		</td>
	</tr>	
	<tr>						
		<th> �̸��� </th>
		<td> 
			<input type="text" name="c_email" class="txtbox" size="40" style="ime-mode:disabled;" value="<%=c_email%>" OnKeyUp="EnterNextFocus('frm_custom_regist','c_email');">
			<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('���� �̸����� �Է�(�ִ�30��)�� �ִ� �� �Դϴ�.');">
		</td>
		<th>  </th>
		<td> </td>
	</tr>
	<tr height="30">
		<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;���� ����</td>
	</tr>
	<tr>						
		<th> ���� ���� </th>
		<Td> 
			<input type="radio" name="g_give_type" value="A" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="A" Or g_give_type="" Then %> checked <% End If %> >������ü&nbsp;
			<input type="radio" name="g_give_type" value="B" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="B" Then %> checked <% End If %>>ī�峳��&nbsp;
			<input type="radio" name="g_give_type" value="C" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="C" Then %> checked <% End If %>>���γ���&nbsp;
			<input type="radio" name="g_give_type" value="D" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="D" Then %> checked <% End If %>>�ջ�û��
		</td>
		<th> ���� ����</th>
		<td>
			<input type="radio" name="g_give_chk" value="A" <% If g_give_chk="A" Or IsNull(g_give_chk) Or g_give_chk="" Then %> checked <% End if %>>����&nbsp;&nbsp;
			<input type="radio" name="g_give_chk" value="B" <% If g_give_chk="B" Then %> checked <% End if %>>�����&nbsp;&nbsp;
			<input type="radio" name="g_give_chk" value="C" <% If g_give_chk="C" Then %> checked <% End if %>>����&nbsp;&nbsp;
		</td>
	</tr>	
	<tr id="style_view_15">
		<th> �ջ� û�� </th>
		<td>
			<input type="radio" name="g_sum_money_chk" value="A" <% If g_sum_money_chk="A" Then %> checked <% End If %>> ��ȭ�� �ջ�&nbsp;&nbsp;
			<input type="radio" name="g_sum_money_chk" value="B" <% If g_sum_money_chk="B" Then %> checked <% End If %>> ���ͳ� �ջ�&nbsp;&nbsp;				
		</td>
		<th> �ջ� ���</th>
		<td> <input type="text" name="g_sum_money_txt" class="txtbox" value="<%=g_sum_money_txt%>" size="20" maxlength="20" onKeyUp="EnterNextFocus('frm_custom_regist','dealer_code');"> </td>
	</tr>						
	<tr id="style_view_01"> 
		<th>��������</th>
		<td>
			<select name="c_bank_cd" style="width:120px;">
			<option value="0" <% if c_bank_cd="0" then %> selected <% end if %>> �������� 
			<%				 
			strSql = " select * from code_bank order by bank_name Asc"
			Set objRs=objCnn.Execute(strSql)
			
			if objRs.BOF or objRs.EOF then
			else
				 
			i = 1
			Do until objRs.EOF   	
				bank_board_idx		= objRs("board_idx")
				bank_name			= objRs("bank_name")
			%>	
			<option value="<%=bank_board_idx%>" <% If c_bank_cd=CStr(bank_board_idx) Then %> selected <% End If %>><%=bank_name%></option>
			<% 
				objrs.MoveNext
				i=i+1 
			loop	
			  objRs.close
			end if					
			%> 
			</select>
			���¹�ȣ <input type="text" name="c_bank_no" class="txtbox" value="<%=c_bank_no%>" size="25" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); fncReplaceCheck(this,'/'); EnterNextFocus('frm_custom_regist','c_bank_name');" onBlur="BlurColor(this)"></td>
		<th> �� �� ��  </th>
		<td>
			<input type="text" name="c_bank_name" class="txtbox" value="<%=c_bank_name%>"  size="10" maxlength=10
			onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_custom_regist','c_bank_jumin1');"
			onFocus="FocusColor(this);this.select();">&nbsp;		
			�ֹι�ȣ<input type="text" name="c_bank_jumin1" class="txtbox" value="<%=c_bank_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_bank_jumin2'); fncNextFocus(this,6,'frm_custom_regist','c_bank_jumin2');">-<input type="text" name="c_bank_jumin2" class="txtbox" value="<%=c_bank_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_card_cd'); fncNextFocus(this,7,'frm_custom_regist','c_name');">

			
			<input type="checkbox" name="dong_il" value="Y" onclick="customer_dong_copy('frm_custom_regist',this,'A');"> <span class='blue'>*���� ����</span>
		</td>
	</tr>  
	<tr  id="style_view_02"> 
		<th>ī������</th>
		<td>
			<select name="c_card_cd" style="width:100px;">
			<option value="0" <% if c_card_cd="0" Or c_card_cd="" then %> selected <% end if %>> ī��� 
			<%
			strSql = " select * from code_card order by card_name Asc"
			Set objRs=objCnn.Execute(strSql)
			
			if objRs.BOF or objRs.EOF then
			else
				 
			i = 1
			Do until objRs.EOF   	
				card_board_idx		= objRs("board_idx")
				card_name			= objRs("card_name")
			%>	
			<option value="<%=card_board_idx%>" <% If c_card_cd=CStr(card_board_idx) Then %> selected <% End If %>><%=card_name%></option>
			<% 
				objrs.MoveNext
			i=i+1 
			loop	
			  objRs.close
			end if					
			%> 
			</select>				
			ī���ȣ <input type="text" name="g_card_no" class="txtbox" value="<%=g_card_no%>" size="30" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); fncReplaceCheck(this,'/'); EnterNextFocus('frm_custom_regist','g_card_gigan');" onBlur="BlurColor(this)"></td>
		<th> ��ȿ�Ⱓ </th>
		<td>
			<input type="text" name="g_card_gigan" class="txtbox" value="<%=g_card_gigan%>"  size="4" maxlength="4"
			onBlur="BlurColor(this)">��&nbsp;
			<input type="text" name="g_card_gigan1" class="txtbox" value="<%=g_card_gigan1%>"  size="2" maxlength="2"
			onBlur="BlurColor(this)">��&nbsp;
			</td>
	</tr> 
	<tr  id="style_view_09"> 
		<th>ī���� ��</th>
		<td>
			<input type="text" name="g_card_name" class="txtbox" value="<%=g_card_name%>" size="15" maxlength="15" onBlur="BlurColor(this)"></td>
		<th> �ֹι�ȣ </th>
		<td>
			<input type="text" name="g_card_jumin1" class="txtbox" value="<%=g_card_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);fncNextFocus(this,6,'frm_custom_regist','g_card_jumin2');">-<input type="text" name="g_card_jumin2" class="txtbox" value="<%=g_card_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">
			
			<input type="checkbox" name="dong_il" value="Y" onclick="customer_dong_copy('frm_custom_regist',this,'B');"> <span class='blue'>*���� ����</span>
			</td>
	</tr> 
	<tr height="30">
		<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;����ǰ ���� </td>
	</tr>
	<tr> 
		<th>����ǰ����</th>
		<td>
			<select name="g_sp_bank_code" style="width:120px;">
				<option value="0" <% if g_sp_bank_code="0" then %> selected <% end if %>> �������� 
			<%
			 
				strSql = " select * from code_bank order by bank_name Asc"
				Set objRs=objCnn.Execute(strSql)
				
				if objRs.BOF or objRs.EOF then
				else
					 
				i = 1
				Do until objRs.EOF   	
					bank_board_idx		= objRs("board_idx")
					bank_name			= objRs("bank_name")
			%>	
					<option value="<%=bank_board_idx%>" <% If g_sp_bank_code=CStr(bank_board_idx) Then %> selected <% End If %>><%=bank_name%></option>
			<% 
					objrs.MoveNext
					i=i+1 
				loop	
			   objRs.close
			   end if					
			%> 
			</select>
			���¹�ȣ <input type="text" name="g_sp_bank_acount" class="txtbox" value="<%=g_sp_bank_acount%>" size="25" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); fncReplaceCheck(this,'/'); EnterNextFocus('frm_custom_regist','g_sp_bank_name');" onBlur="BlurColor(this)"></td>
		<th>�� �� �� </th>
		<td>
			<input type="text" name="g_sp_bank_name" class="txtbox" value="<%=g_sp_bank_name%>"  size="10" maxlength=10
			onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_bank_jumin1');"
			onFocus="FocusColor(this);this.select();">&nbsp;

			�ֹι�ȣ<input type="text" name="g_sp_bank_jumin1" class="txtbox" value="<%=g_sp_bank_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_sp_bank_jumin2'); fncNextFocus(this,6,'frm_custom_regist','g_sp_bank_jumin2');">-<input type="text" name="g_sp_bank_jumin2" class="txtbox" value="<%=g_sp_bank_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">

			<input type="checkbox" name="g_sp_bank_chk" value="Y" onclick="g_sp_bank_copy('frm_custom_regist',this);"> <span class='blue'>* �� ���������� ����</span> </td>
	</tr> 
	<tr height="30">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ǰ ����1 &nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<th> ȸ�� ���� </th>
		<td colspan='3'>
			<select name="g_article_idx1" style="width:150px;"
			onchange="article_change(this,'frm_custom_regist',this.selectedIndex,'T'); area_change(this,'frm_custom_regist',this.selectedIndex); fnc_combine_change(this,'frm_custom_regist',this.selectedIndex,'g_code_combine1');">
			<option value="0" <% if g_article_idx1="0" then %> selected <% end if %>>:: ȸ�� ���� ::</option>
			<% 
			strSql = " select * from code_article where article_step2=0 "
			strSql = strSql & " and article_view='Y' "
			strSql = strSql & " order by article_order Asc"
			Set objRs=objCnn.Execute(strSql)

			if objRs.BOF or objRs.EOF then
			else						 
			i = 1
			Do until objRs.EOF   	
				article_idx			= objRs("article_idx")
				article_name		= objRs("article_name")
			%>	
				<option value="<%=article_idx%>" <% if g_article_idx1=article_idx then %> selected <% end if %>><%=article_name%></option>
			<% 
				objrs.MoveNext
				i=i+1 
			Loop
			End if
			%>	
			</select>
			
			&nbsp;&nbsp;&nbsp;				
			<select name="g_code_area" style="width:150px;background-color:#00FFAA;">
			<option value="0" selected> ::���� ����:: </option>
			</select>

			&nbsp;&nbsp;&nbsp;
			<b><span class='red'>
			<input type="radio" name="goods_cnt" value="1" onclick="style_view_chk('frm_custom_regist','B');" <% If g_set="A" Then  %> checked <% End If %>>�ܵ�&nbsp;
			<input type="radio" name="goods_cnt" value="2" onclick="style_view_chk('frm_custom_regist','B');" <% If g_set="B" Then  %> checked <% End If %>>DPS&nbsp;
			<input type="radio" name="goods_cnt" value="3" onclick="style_view_chk('frm_custom_regist','B');" <% If g_set="C" Then  %> checked <% End If %>>TPS </span>&nbsp;&nbsp;</b>

			
			<b><span class='blue'>
			<input type="checkbox" name="goods_settop1_chk" value="A" onclick="style_view_settop('frm_custom_regist','A');">��ž�߰�1&nbsp;
			<input type="checkbox" name="goods_settop2_chk" value="A" onclick="style_view_settop('frm_custom_regist','B');">��ž�߰�2&nbsp;
			</b>
		</td>
	</tr>
	<Tr>
		<th>��ǰ����</th>
		<td colspan='3'>				
			<select name="g_article_idx2" style="width:150px;" onchange="option_change(this,'frm_custom_regist',this.selectedIndex,'T'); sale_change(this,'frm_custom_regist',this.selectedIndex); service_change1(this,'frm_custom_regist',this.selectedIndex); promise_change1(this,'frm_custom_regist',this.selectedIndex);">
			<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ ���� 
			
			</select>
			<select name="g_option_idx" style="width:150px;">
			<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ �ɼ� </option>
			
			</select>				
			<select name="g_code_promise1" style="width:130px;">
			<option value="0" <% if g_code_promise_idx="0" then %> selected <% end if %>>���� ����           
			
			</select>
			<select name="g_code_sale" style="width:150px;">
			<option value="0" <% if sale_idx="0" then %> selected <% end if %>> ������ ���� 
			</select>
			<select name="g_code_service1" style="width:130px;">
			<option value="0"> �ΰ����� ���� </option>
			</select>
					
			<select name="g_code_combine1" class="txtbox" style="width:130px;">
			<option value="0">::���ռ���::</option>
			</select>	
			&nbsp;
			<input type="text" name="g_article_cnt1" class="txtbox" value="1" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">ȸ��
		</td>
	</tr>
	<tr> 
		<th>����ǰ</th>
		<td colspan='3'>
			<input type="text" class="txtbox" name="g_sp_name" value="<%=g_sp_name%>" size="23" maxlength="40" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price');">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			�ݾ� <input type="text" class="txtbox" name="g_sp_price" value="<%=g_sp_price%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_sp_date_start'); " style="ime-mode:disabled" id="g_sp_price" onclick="select_price(this.id)">�� 
			&nbsp;&nbsp;
			���޿����� <input type="text" class="txtbox" name="g_sp_date_start" size='10' value="<%=g_sp_date_start%>" readonly> <img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
			<select name="g_sp_give_type" style="background-color:#fdd9d9;">
			<option value="" <% If g_sp_give_type="" Then %> selected <% End If %>> ������ ���� </option>
			<option value="B" <% If g_sp_give_type="B" Then %> selected <% End If %>> ���� ���� </option>


			<!--
			<option value="E" <% If g_sp_give_type="E" Then %> selected <% End If %>> ����ǰ ���� </option>
			<option value="A" <% If g_sp_give_type="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
			<option value="C" <% If g_sp_give_type="C" Then %> selected <% End If %>> ������ ������� </option>
			<option value="F" <% If g_sp_give_type="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
			-->
			</select></td>

	</tr>	
	<tr>
		<th>���� ����ǰ</th>
		<td colspan='3'> 
			<input type="text" class="txtbox" name="g_sp_name_top1" value="<%=g_sp_name_top%>" size="23" maxlength="40" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			�ݾ� <input type="text" class="txtbox" name="g_sp_price_top1" value="<%=g_sp_price_top%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top1" onclick="select_price(this.id)">�� 
		</td>
	</tr>
	<tr height="30" id="style_view_03">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ǰ ����2</td>
	</tr>
	<Tr  id="style_view_04">
		<th>��ǰ����</th>
		<td colspan='3'>				
			<select name="g_article_idx2_1" style="width:150px;" onchange="option_change_1(this,'frm_custom_regist',this.selectedIndex,'T');sale_change1(this,'frm_custom_regist',this.selectedIndex);service_change2(this,'frm_custom_regist',this.selectedIndex);promise_change2(this,'frm_custom_regist',this.selectedIndex);">
			<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ ���� 
			</select>
			<select name="g_option_idx_1" style="width:150px;">
			<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ �ɼ� </option>				
			</select>				
			<select name="g_code_promise2" style="width:130px;">
			<option value="0" <% if g_code_promise_idx="0" then %> selected <% end if %>>���� ���� 				
			</select>
			<select name="g_code_sale1" style="width:150px;">
			<option value="0" <% if sale_idx="0" then %> selected <% end if %>> ������ ����   
			</select>
			<select name="g_code_service2" style="width:130px;">
			<option value="0"> �ΰ����� ���� </option>
			</select>
		
			&nbsp;
			<input type="text" name="g_article_cnt2" class="txtbox" value="1" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">ȸ��
		</td>
	</tr>
	<tr  id="style_view_05"> 
		<th>����ǰ</th>
		<td colspan='3'>
			<input type="text" class="txtbox" name="g_sp_name1" value="<%=g_sp_name1%>" size="23" maxlength="40" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price1');"
			onFocus="FocusColor(this);this.select();">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			�ݾ� <input type="text" class="txtbox" name="g_sp_price1" value="<%=g_sp_price1%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price1" onclick="select_price(this.id)">�� 
			&nbsp;&nbsp;
			���޿����� <input type="text" class="txtbox" name="g_sp_date_start1" size='10' value="<%=g_sp_date_start1%>" readonly> <img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start1&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
				<select name="g_sp_give_type1" style="background-color:#fdd9d9;">
				<option value="" <% If g_sp_give_type1="" Then %> selected <% End If %>> ������ ���� </option>
				<option value="B" <% If g_sp_give_type1="B" Then %> selected <% End If %>> ���� ���� </option>
				

				<!--
				<option value="E" <% If g_sp_give_type1="E" Then %> selected <% End If %>> ����ǰ ���� </option>
				<option value="A" <% If g_sp_give_type1="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
				<option value="C" <% If g_sp_give_type1="C" Then %> selected <% End If %>> ������ ������� </option>
				<option value="F" <% If g_sp_give_type1="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
				-->
				</select></td>

	</tr>
	<tr  id="style_view_30">
		<th>���� ����ǰ</th>
		<td colspan='3'> 
			<input type="text" class="txtbox" name="g_sp_name_top2" value="<%=g_sp_name_top%>" size="23" maxlength="40" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			�ݾ� <input type="text" class="txtbox" name="g_sp_price_top2" value="<%=g_sp_price_top%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top2" onclick="select_price(this.id)">�� 
		</td>
	</tr>
	<tr height="30"  id="style_view_06">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ǰ ����3</td>
	</tr>
	<Tr  id="style_view_07">
		<th>��ǰ����</th>
		<td colspan='3'>				
			<select name="g_article_idx2_2" style="width:150px;" onchange="option_change_2(this,'frm_custom_regist',this.selectedIndex,'T');sale_change2(this,'frm_custom_regist',this.selectedIndex);service_change3(this,'frm_custom_regist',this.selectedIndex);promise_change3(this,'frm_custom_regist',this.selectedIndex);">
			<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ ���� 
			</select>
			<select name="g_option_idx_2" style="width:150px;">
			<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ �ɼ� </option>
			</select>
			<select name="g_code_promise3" style="width:130px;">
			<option value="0" <% if g_code_promise_idx="0" then %> selected <% end if %>>���� ���� 
			</select>
			<select name="g_code_sale2" style="width:150px;">
			<option value="0" <% if sale_idx="0" then %> selected <% end if %>> ������ ����  
			</select>
			<select name="g_code_service3" style="width:130px;">
			<option value="0"> �ΰ����� ���� </option>
			</select>
						
			&nbsp;
			<input type="text" name="g_article_cnt3" class="txtbox" value="1" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">ȸ��
		</td>
	</tr>
	<tr id="style_view_08"> 
		<th>����ǰ</th>
		<td colspan='3'>
			<input type="text" class="txtbox" name="g_sp_name2" value="<%=g_sp_name2%>" size="23" maxlength="40" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price');"
			onFocus="FocusColor(this);this.select();">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			�ݾ� <input type="text" class="txtbox" name="g_sp_price2" value="<%=g_sp_price2%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price2" onclick="select_price(this.id)">�� 
			&nbsp;&nbsp;
			���޿����� <input type="text" class="txtbox" name="g_sp_date_start2" size='10' value="<%=g_sp_date_start2%>" readonly> <img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start2&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
				<select name="g_sp_give_type2" style="background-color:#fdd9d9;">
				<option value="" <% If g_sp_give_type2="" Then %> selected <% End If %>> ������ ���� </option>
				<option value="B" <% If g_sp_give_type2="B" Then %> selected <% End If %>> ���� ���� </option>


				<!--
				<option value="E" <% If g_sp_give_type2="E" Then %> selected <% End If %>> ����ǰ ���� </option>
				<option value="A" <% If g_sp_give_type2="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
				<option value="C" <% If g_sp_give_type2="C" Then %> selected <% End If %>> ������ ������� </option>
				<option value="F" <% If g_sp_give_type2="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
				-->
				</select></td>

	</tr>
		<tr id="style_view_31">
			<th>���� ����ǰ</th>
			<td colspan='3'> 
				<input type="text" class="txtbox" name="g_sp_name_top3" value="<%=g_sp_name_top%>" size="23" maxlength="40" >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�ݾ� <input type="text" class="txtbox" name="g_sp_price_top3" value="<%=g_sp_price_top%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top3" onclick="select_price(this.id)">�� 
			</td>
		</tr>


		<tr height="30" id="view_settop01">
			<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;<b style="color:blue">��ž �߰�1</b></td>
		</tr>
		<Tr height="30" id="view_settop02">
			<th width="100">��ǰ����</th>
			<td colspan='3' width="900">				
				<select name="g_article_idx2_4" style="width:150px;" onchange="fnc_option_change4(this,'frm_custom_regist',this.selectedIndex,'T'); fnc_sale_change4(this,'frm_custom_regist',this.selectedIndex); fnc_service_change4(this,'frm_custom_regist',this.selectedIndex); fnc_promise_change4(this,'frm_custom_regist',this.selectedIndex);">
				<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ ����</option> 
				</select>
				<select name="g_option_idx_4" style="width:150px;">
				<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ �ɼ� </option>
				</select>
				<select name="g_code_promise4" style="width:130px;">
				<option value="0" <% if g_code_promise_idx="0" then %> selected <% end if %>>���� ����  </option>         
				
				</select>
				<select name="g_code_sale4" style="width:150px;">
				<option value="0" <% if sale_idx="0" then %> selected <% end if %>> ������ ����  </option>
				</select>
				
				<select name="g_code_service4" style="width:130px;">
				<option value="0"> �ΰ����� ����</option>
				</select>
				
				&nbsp;
				<input type="text" name="g_article_cnt4" class="txtbox" value="1" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">ȸ��
			</td>
		</tr>
		<tr height="30" id="view_settop03"> 
			<th>����ǰ</th>
			<td colspan='3'>
				<input type="text" class="txtbox" name="g_sp_name4" value="<%=g_sp_name4%>" size="23" maxlength="40" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price');">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�ݾ� <input type="text" class="txtbox" name="g_sp_price4" value="<%=g_sp_price5%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled">�� 
				&nbsp;&nbsp;
				���޿����� <input type="text" class="txtbox" name="g_sp_date_start4" size='10' value="<%=g_sp_date_start4%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start2&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
				<select name="g_sp_give_type4" style="background-color:#fdd9d9;">
				<option value="" <% If g_sp_give_type4="" Then %> selected <% End If %>> ������ ���� </option>
				<option value="E" <% If g_sp_give_type4="E" Then %> selected <% End If %>> ����ǰ ���� </option>
				<option value="A" <% If g_sp_give_type4="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
				<option value="B" <% If g_sp_give_type4="B" Or g_sp_give_type="C" Then %> selected <% End If %>> ������ ���� </option>
				<option value="F" <% If g_sp_give_type4="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
				</select>
			</td>
		</tr>
		<tr height="30" id="view_settop04">
			<th>���� ����ǰ</th>
			<td colspan='3'> 
				<input type="text" class="txtbox" name="g_sp_name_top4" value="<%=g_sp_name_top4%>" size="23" maxlength="40" >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�ݾ� <input type="text" class="txtbox" name="g_sp_price_top4" value="<%=g_sp_price_top4%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top3" onclick="select_price(this.id)">�� 
			</td>
		</tr>

		<tr height="30" id="view_settop05">
			<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;<b style="color:blue">��ž �߰�2</b></td>
		</tr>
		<Tr height="30" id="view_settop06">
			<th width="100">��ǰ����</th>
			<td colspan='3' width="900">				
				<select name="g_article_idx2_5" style="width:150px;" onchange="fnc_option_change5(this,'frm_custom_regist',this.selectedIndex,'T'); fnc_sale_change5(this,'frm_custom_regist',this.selectedIndex); fnc_service_change5(this,'frm_custom_regist',this.selectedIndex); fnc_promise_change5(this,'frm_custom_regist',this.selectedIndex);">
				<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ ����</option> 
				</select>
				<select name="g_option_idx_5" style="width:150px;">
				<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ �ɼ� </option>
				</select>
				<select name="g_code_promise5" style="width:130px;">
				<option value="0" <% if g_code_promise_idx="0" then %> selected <% end if %>>���� ����  </option>         
				
				</select>
				<select name="g_code_sale5" style="width:150px;">
				<option value="0" <% if sale_idx="0" then %> selected <% end if %>> ������ ����  </option>
				</select>
				
				<select name="g_code_service5" style="width:130px;">
				<option value="0"> �ΰ����� ����</option>
				</select>
				
				&nbsp;
				<input type="text" name="g_article_cnt5" class="txtbox" value="1" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">ȸ��
			</td>
		</tr>
		<tr height="30" id="view_settop07"> 
			<th>����ǰ</th>
			<td colspan='3'>
				<input type="text" class="txtbox" name="g_sp_name5" value="<%=g_sp_name5%>" size="23" maxlength="40" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price');">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�ݾ� <input type="text" class="txtbox" name="g_sp_price5" value="<%=g_sp_price5%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled">�� 
				&nbsp;&nbsp;
				���޿����� <input type="text" class="txtbox" name="g_sp_date_start5" size='10' value="<%=g_sp_date_start5%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start2&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
				<select name="g_sp_give_type5" style="background-color:#fdd9d9;">
				<option value="" <% If g_sp_give_type5="" Then %> selected <% End If %>> ������ ���� </option>
				<option value="E" <% If g_sp_give_type5="E" Then %> selected <% End If %>> ����ǰ ���� </option>
				<option value="A" <% If g_sp_give_type5="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
				<option value="B" <% If g_sp_give_type5="B" Or g_sp_give_type="C" Then %> selected <% End If %>> ������ ���� </option>
				<option value="F" <% If g_sp_give_type5="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
				</select>
			</td>
		</tr>
		<tr height="30" id="view_settop08">
			<th>���� ����ǰ</th>
			<td colspan='3'> 
				<input type="text" class="txtbox" name="g_sp_name_top5" value="<%=g_sp_name_top5%>" size="23" maxlength="40" >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�ݾ� <input type="text" class="txtbox" name="g_sp_price_top5" value="<%=g_sp_price_top5%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top3" onclick="select_price(this.id)">�� 
			</td>
		</tr>

		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ȣ�̵�
			&nbsp;&nbsp;&nbsp;
			<input type="checkbox" name="dong_il" value="Y" onclick="customer_dong_copy('frm_custom_regist',this,'C');"> <span class='blue'>* �� �������� ����</span> </td>
		</tr>
		<tr>
			<th> ��ȭ ��ȣ </th>
			<td> <input type="text" name="g_move_tel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=g_move_tel1%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
			<th> �� �� �� </th>
			<td> <input type="text" name="g_move_name" class="txtbox" size="20" maxlength='20' value="<%=g_move_name%>"></td>
		</tr>
		<tr>
			<th> �ֹ� ��ȣ</th>
			<td> 
				<input type="text" name="g_move_jumin1" class="txtbox" value="<%=g_move_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_move_jumin2'); fncNextFocus(this,6,'frm_custom_regist','g_move_jumin2');">-<input type="text" name="g_move_jumin2" class="txtbox" value="<%=g_move_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);"></td>
			<th> �� �� ó</th>
			<td> 
				<input type="text" name="g_move_tel2" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=g_move_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
		</tr>
		<tr>
			<th> �߱� ����</th>
			<td>
				<input type="text" name="g_move_date" class="txtbox" size="40" maxlength='40' value="<%=g_move_date%>">
			</td>
			<th> ���� ��Ż� </th>
			<td>
				<select name="g_move_company" style="width:130px;">
				<option value="">:: ���� :: </option>
				<option value="SK" <% If g_move_company="SK" Then %> selected <% End If %>>SK</option>
				<option value="LG" <% If g_move_company="LG" Then %> selected <% End If %>>LG </option>
				<option value="KT" <% If g_move_company="KT" Then %> selected <% End If %>>KT</option>
				</select>

				�޸�<input type="text" name="g_move_memo" class="txtbox" size="30" maxlength='30' value="<%=g_move_memo%>">
			</td>
		</tr>
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��� ���� </td>
		</tr>
	<tr> 
		<th>��Ÿ ����</th>
		<td colspan='3'>
			<textarea name="g_bigo" class="txtbox" style="width:99%;height:150px;"><%=g_bigo%></textarea>
		</td>
	</tr>
	<tr height="30">
		<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;÷�� ���� </td>
	</tr>
	<tr> 
		<th>÷������1</th>
		<td> 
			<input type="file" name="g_file1" size="30" class="txtbox" onBlur="BlurColor(this)">
			<% If Len(g_file1)>0 Then %>
			<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
			<% End If %>
		</td>
		<th> ÷�� ����2 </th>
		<td> 
			<input type="file" name="g_file2" size="30" class="txtbox" onBlur="BlurColor(this)" 
		onFocus="FocusColor(this);this.select();">
			<% If Len(g_file2)>0 Then %>
			<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>"><%=filename2%></a>
			<% End If %>
		</td>
	</tr>
	<tr> 
		<th> ÷�� ����3 </th>
		<td > 
			<input type="file" name="g_file3" size="30" class="txtbox" onBlur="BlurColor(this)" 
		onFocus="FocusColor(this);this.select();">
			<% If Len(g_file3)>0 Then %>
			<a href="/include/asp/file_down.asp?fname=<%=filename3%>&fpath=<%=filepath3%>"><%=filename3%></a>
			<% End If %>
		</td>
		<th> ÷�� ����4 </th>
		<td> 
			<input type="file" name="g_file4" size="30" class="txtbox" onBlur="BlurColor(this)" 
		onFocus="FocusColor(this);this.select();">
			<% If Len(g_file4)>0 Then %>
			<a href="/include/asp/file_down.asp?fname=<%=filename4%>&fpath=<%=filepath4%>"><%=filename4%></a>
		<% End If %>
		</td>
	</tr>
	</table>
	<div class="button">
		<span onClick="custom_regist_all('P');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_save.gif"  border="0" align='absmiddle'></span>					
	</div>
	</form>
	<div id="select_price" style="visibility:hidden;"></div>
	<!------------------ ���� ����  ------------------>

</div>
	


