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
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	 

  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),20)

  If g_charge_idx<>"" Then 
	strSql = " select * from customer_goods_charge where g_charge_idx="&g_charge_idx
	Set objRs=objCnn.Execute(strSql)

	g_charge_idx		= objRs("g_charge_idx")
	g_charge_type		= objRs("g_charge_type")
	g_goods_idx			= objRs("g_goods_idx")
	
	g_charge_promise	= money_chk(objRs("g_charge_promise"))
	g_charge_sp_top		= money_chk(objRs("g_charge_sp_top"))
	g_charge_sp			= money_chk(objRs("g_charge_sp"))
	g_charge_sale		= money_chk(objRs("g_charge_sale"))
	g_charge_gita		= money_chk(objRs("g_charge_gita"))
	g_charge_bundle		= money_chk(objRs("g_charge_bundle"))
	g_charge_document	= money_chk(objRs("g_charge_document"))
	g_charge_buga		= money_chk(objRs("g_charge_buga"))
	g_charge_combine	= money_chk(objRs("g_charge_combine"))

	g_charge_bigo		= objRs("g_charge_bigo")
	g_charge_bigo_doc	= objRs("g_charge_bigo_doc")
	g_charge_date1		= objRs("g_charge_date1")				'���� ������
	g_charge_date2		= objRs("g_charge_date2")				'���� �Ϸ���
  Else
	g_charge_type="A"
  End If 
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">
function fnc_exact_del(g_charge_idx,g_goods_idx)
{
	ans=confirm("�� �߰������� �����Ͻðڽ��ϱ�? ");
	if(ans==true)
	{
		url="a_charge_del_ok.asp?g_charge_idx="+g_charge_idx+"&g_goods_idx="+g_goods_idx;
		location.replace(url);
	}
}


function fnc_exact_regist(form_name)
{
	var frm	 = document.getElementById(form_name);
	
	frm.submit();
}
    

</script>

<div class="outerContainer">

	<form id="frm_custom" name="frm_custom" action="a_charge_regist_ok.asp" METHOD="POST"> 
	<input type="hidden" name="g_charge_idx" value="<%=g_charge_idx%>">
	<input type="hidden" name="g_goods_idx" value="<%=g_goods_idx%>">

	<table width=100% border=0 cellspacing="0" cellpadding="0" class="table_css">
	<tr height='30'>
		<td class='con9' colspan='2' style='text-align:left;'>&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;<b>�� �Է� ���� </b></td>
	</tr>

	<tr height="30"> 
		<th width='15%' class="head_Gray_TLB"> ����������  </th> 
		<td width='85%' class="list_TLBR_left">
			<input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_promise" value="<%=g_charge_promise%>">�� 
			&nbsp;&nbsp;&nbsp;&nbsp;
			<% If g_charge_type="G" Then %>
				<input type="hidden" name="g_charge_type" value="G">
			<% Else %>
				<input type="radio" name="g_charge_type" value="A" <% If g_charge_type="A" Then %> checked <% End If %>>�߰�
				<input type="radio" name="g_charge_type" value="B" <% If g_charge_type="B" Then %> checked <% End If %>>ȯ��
				<input type="radio" name="g_charge_type" value="C" <% If g_charge_type="C" Then %> checked <% End If %>>VOC ȯ��
			<% End If %>
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���� ����ǰ����  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sp_top" value="<%=g_charge_sp_top%>">�� </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ����ǰ����  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sp" value="<%=g_charge_sp%>">��</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ������ ���� </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_sale" value="<%=g_charge_sale%>">�� </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> �̺񼭷�  </th>
		<td class="list_LBR_left"> 
			<% If g_charge_idx="" Or g_charge_type<>"G" Then %>
				<input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_document" value="<%=g_charge_document%>">�� &nbsp;&nbsp;&nbsp;<span class='red'>�Ϲ������� ��츸 �ڵ���� �˴ϴ�.</span>
			<% Else %>
				<%=money_change(g_charge_document)%> �� &nbsp;&nbsp;&nbsp;<span class='red'> (�ڵ����)</span>
			<% End If %>
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ��Ÿ����  </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_gita" value="<%=g_charge_gita%>">��</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���� ������ </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_bundle" value="<%=g_charge_bundle%>">�� </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> �ΰ����� </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_buga" value="<%=g_charge_buga%>">�� </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���ռ����� </th>
		<td class="list_LBR_left"><input type="text" class="txtbox" size='10' maxlength="9" name="g_charge_combine" value="<%=g_charge_combine%>">�� </td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���� ����  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date1" class="txtbox" size='10' value="<%=g_charge_date1%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date1&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���� �Ϸ�  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_date2" class="txtbox" size='10' value="<%=g_charge_date2%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_charge_date2&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"> 
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> ���� ���  </th>
		<td class="list_LBR_left">
			<input type="text" name="g_charge_bigo" class="txtbox" size='40' value="<%=g_charge_bigo%>" >
		</td>
	</tr>
	<tr height="30"> 
		<th class="head_Gray_LB"> �̺񼭷� ���  </th>
		<td class="list_LBR_left">
			<% If g_charge_idx="" Or g_charge_type<>"G" Then %>
			<input type="text" name="g_charge_bigo_doc" class="txtbox" size='40' value="<%=g_charge_bigo_doc%>" >&nbsp;&nbsp;<span class='red'> �Ϲ������� ��츸 �ڵ� �Է� �˴ϴ�. </span>
			<% Else %>
				<%=g_charge_bigo_doc%> &nbsp;&nbsp;<span class='red'>(�ڵ� �Է�) </span>
			<% End If %>
		</td>
	</tr>
	</table>

	<div class="alignRight">
		<a href="a_charge_list.asp?g_goods_idx=<%=g_goods_idx%>"><span class="btn_m_white01"> �������</span></a>

		<% if ad_r_a_exact="E" or ad_r_a_exact="A" then %>
			<span onClick="fnc_exact_regist('frm_custom');" class="btn_m_white01">�����ϱ�</span>
			<% If g_charge_idx<>""Then %>
			<span onClick="fnc_exact_del('<%=g_charge_idx%>','<%=g_goods_idx%>');" class="btn_m_white01">�����ϱ�</span>
			<% End If %>
		<% Else %>
			<a href ='javascript:alert("<%=session_m_name%> ���� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><span class="btn_m_white01">�����ϱ�</span></a>
		<% End If %>

	</div>
	</form>
</div>