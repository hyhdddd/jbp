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

  if ad_i_a_emp="N" then
	Alert_url session_m_name&" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
 
  If session_m_step="M" Then
  Else
	Alert_url session_m_name&" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  End If 

  m_id			= WORD_CHANGE(request("m_id"),20)
  m_name		= WORD_CHANGE(request("m_name"),20)

  %>  	

<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function send_admin_chk()
	{
		var frm=document.all.frm_emp_regist;
		ans=confirm(" ���� ������ �����Ͻðڽ��ϱ�?");
		
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
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

				<!------------------ ���� ����  ------------------>
<%
  	
  if m_id="" Then
	Alert_back " ������ �߸��Ǿ����ϴ�."
	Response.end
  else
    strSql="select * from emp_admin where m_id='"&m_id&"'"  	
	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof Or objRs.eof Then
		'������
		ad_b_p_custom	= "N"										'������ - ����
		ad_b_y_custom	= "N"										'������ - �ŷ�ó
		ad_b_a_custom	= "N"										'������ - ��ü
		ad_b_g_custom	= "N"										'������ - �����
		ad_b_m_custom	= "N"										'������ - ��纰

		'�������� ����
		ad_b_p_excel	= "N"										'������ - ����_����
		ad_b_y_excel	= "N"										'������ - ����_������
		ad_b_a_excel	= "N"										'������ - ����_��ü
		ad_b_g_excel	= "N"										'������ - ����_�����
		ad_b_m_excel	= "N"										'������ - ����_��纰

		'���� ������
		ad_g_p_gamang	= "N"										'������ - ���� ������
		ad_g_y_gamang	= "N"										'������ - ������ ������
		ad_g_a_gamang	= "N"										'������ - ��ü ������

		'insa Menu
		ad_i_a_emp		= "N"										'�λ���� - ��ü �������
		ad_i_y_emp		= "N"										'�λ���� - �ŷ�ó �������
		ad_i_a_company	= "N"										'�λ���� - �ŷ�ó �������

		ad_p_a_pay		= "N"										'�޿����� - ��ü
		'�������� 
		ad_k_p_result	= "N"										'�������� - ���� ���� ����
		ad_k_y_result	= "N"										'�������� - �ŷ�ó ���� ����
		ad_k_a_result	= "N"										'�������� - ��ü ���� ����

		'������� �޴�
		ad_r_p_exact	= "N"										'������� - ���� �������
		ad_r_y_exact	= "N"										'������� - �ŷ�ó �������
		ad_r_a_exact	= "N"										'������� - ��ü �������
		ad_r_g_exact	= "N"										'������� - �ΰ�ó �������

		'������ �޴�
		ad_e_notice1	= "N"										'������ - �系 ��������
		ad_e_notice2	= "N"										'������ - �ŷ�ó ��������
		ad_e_data1		= "N"										'������ - �系 �ڷ��
		ad_e_data2		= "N"										'������ - �ŷ�ó �ڷ��
		
		'�ڵ� ����
		ad_c_code		= "N"										'�ΰ����� - �ڵ����
		ad_c_sms		= "N"										'�ΰ����� - sms����
		ad_c_popup		= "N"										'�ΰ����� - �˾�����
		ad_c_black		= "N"										'�ΰ����� - ������Ʈ ����
		ad_c_fee		= "N"										'�ΰ����� - ���ǥ ����

		ad_p_gift		= "N"
		ad_a_gift		= "N"

	Else	
		'������
		ad_b_p_custom	= CheckAdmin(objRs("ad_b_p_custom"))		'������ - ������(����)
		ad_b_y_custom	= CheckAdmin(objRs("ad_b_y_custom"))		'������ - ������(�ŷ�ó)		
		ad_b_a_custom	= CheckAdmin(objRs("ad_b_a_custom"))		'������ - ��ü ����ǰ(�Ϲ�)
		ad_b_g_custom	= CheckAdmin(objRs("ad_b_g_custom"))		'������ - �ΰ�ó ��
		ad_b_m_custom	= CheckAdmin(objRs("ad_b_m_custom"))		'������ - ��� ������

		'�������Ѽ���
		ad_b_p_excel	= CheckAdmin(objRs("ad_b_p_excel"))			'������ - ����_����
		ad_b_y_excel	= CheckAdmin(objRs("ad_b_y_excel"))			'������ - ����_������
		ad_b_a_excel	= CheckAdmin(objRs("ad_b_a_excel"))			'������ - ����_��ü
		ad_b_g_excel	= CheckAdmin(objRs("ad_b_g_excel"))			'������ - ����_�����
		ad_b_m_excel	= CheckAdmin(objRs("ad_b_m_excel"))			'������ - ����_��纰

		'����������
		ad_g_p_gamang	= CheckAdmin(objRs("ad_g_p_gamang"))		'������ - ���� ������
		ad_g_y_gamang	= CheckAdmin(objRs("ad_g_y_gamang"))		'������ - ������ ������
		ad_g_a_gamang	= CheckAdmin(objRs("ad_g_a_gamang"))		'������ - ��ü ������

		'insa Menu
		ad_i_a_emp		= CheckAdmin(objRs("ad_i_a_emp"))			'�λ���� - ��ü �������
		ad_i_y_emp		= CheckAdmin(objRs("ad_i_y_emp"))			'�λ���� - �ŷ�ó �������
		ad_i_a_company	= CheckAdmin(objRs("ad_i_a_company"))		'�λ���� - �ŷ�ó �������

		'�������� 
		ad_k_p_result	= CheckAdmin(objRs("ad_k_p_result"))		'�������� - ���� ���� ����
		ad_k_y_result	= CheckAdmin(objRs("ad_k_y_result"))		'�������� - �ŷ�ó ���� ����
		ad_k_a_result	= CheckAdmin(objRs("ad_k_a_result"))		'�������� - ��ü ���� ����

		'������� �޴�
		ad_r_p_exact	= CheckAdmin(objRs("ad_r_p_exact"))			'������� - ���� �������
		ad_r_y_exact	= CheckAdmin(objRs("ad_r_y_exact"))			'������� - �ŷ�ó �������
		ad_r_a_exact	= CheckAdmin(objRs("ad_r_a_exact"))			'������� - ��ü �������
		ad_r_g_exact	= CheckAdmin(objRs("ad_r_g_exact"))			'������� - �ΰ� �������

		'������ �޴�
		ad_e_notice1	= CheckAdmin(objRs("ad_e_notice1"))			'������ - �系 ��������
		ad_e_notice2	= CheckAdmin(objRs("ad_e_notice2"))			'������ - �ŷ�ó ��������
		ad_e_data1		= CheckAdmin(objRs("ad_e_data1"))			'������ - �系 �ڷ��
		ad_e_data2		= CheckAdmin(objRs("ad_e_data2"))			'������ - �ŷ�ó �ڷ��


		'�ΰ����� ����
		ad_c_sms		= CheckAdmin(objRs("ad_c_sms"))				'�ΰ����� - sms ����
		ad_c_code		= CheckAdmin(objRs("ad_c_code"))			'�ΰ����� - �ڵ����
		ad_c_popup		= CheckAdmin(objRs("ad_c_popup"))			'�ΰ����� - popup ����
		ad_c_black		= CheckAdmin(objRs("ad_c_black"))			'�ΰ����� - ������Ʈ ����
		ad_c_fee		= CheckAdmin(objRs("ad_c_fee"))				'�ΰ����� - ���ǥ ����
		ad_a_marking	= CheckAdmin(objRs("ad_a_marking"))	

		ad_p_gift		= CheckAdmin(objRs("ad_p_gift"))	
		ad_a_gift		= CheckAdmin(objRs("ad_a_gift"))	

	end if  	
  end If
  %>
		<div class="sub_title"><img src="/images/common/sub03_t02.gif"></div>

		<form action="a_emp_admin_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_id" value="<%=m_id%>">				
		<input type="hidden" name="m_name" value="<%=m_name%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=30> 
			<th width="200">�����</th>
			<td colspan='3'> <%=m_name%></td>
		</tr>
		<tr height='30'> 
			<td colspan='4' align='left'>&nbsp; <b> * ������ </b></th>
		</tr>
		<tr height='30'> 
			<th width="150">���� ���Խ�û ���� </th>
			<td width="350"> 
				<select name="ad_b_p_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_p_custom="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_b_p_custom="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_b_p_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_b_p_custom="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_b_p_custom="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_p_excel" value="Y" <% If ad_b_p_excel="Y" Then %> checked <% End If %>>�����ٿ�
			</td>
		</tr>
		<tr>
			<th width="150">������ ���Խ�û ����</th>
			<td width="350"> 
				<select name="ad_b_y_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_y_custom="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_b_y_custom="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_b_y_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_b_y_custom="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_b_y_custom="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_y_excel" value="Y" <% If ad_b_y_excel="Y" Then %> checked <% End If %>>�����ٿ�
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>��ü ���Խ�û ����</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_a_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_a_custom="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_b_a_custom="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_b_a_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_b_a_custom="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_b_a_custom="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_a_excel" value="Y" <% If ad_b_a_excel="Y" Then %> checked <% End If %>>�����ٿ�

			</td>			
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>����� �� ����</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_g_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_g_custom="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_b_g_custom="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_b_g_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_b_g_custom="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_b_g_custom="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_g_excel" value="Y" <% If ad_b_g_excel="Y" Then %> checked <% End If %>>�����ٿ�

			</td>			
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'>��纰 �� ����</td>
			<td width="850" colspan='3'> 
				<select name="ad_b_m_custom" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_b_m_custom="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_b_m_custom="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_b_m_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_b_m_custom="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_b_m_custom="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
				&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="ad_b_m_excel" value="Y" <% If ad_b_m_excel="Y" Then %> checked <% End If %>>�����ٿ�

			</td>			
		</tr> 
		<tr height='25'> 
			<td colspan='4' align='left'><b> * ������ ���� </b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> ���� ������ ����</th>
			<td width="850"> 
				<select name="ad_g_p_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_p_gamang="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_g_p_gamang="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_g_p_gamang="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_g_p_gamang="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_g_p_gamang="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> ������ ������ ����</td>
			<td width="850"> 
				<select name="ad_g_y_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_y_gamang="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_g_y_gamang="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_g_y_gamang="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_g_y_gamang="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_g_y_gamang="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> ��ü ������ ����</td>
			<td width="850"> 
				<select name="ad_g_a_gamang" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_g_a_gamang="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_g_a_gamang="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_g_a_gamang="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_g_a_gamang="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_g_a_gamang="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * �λ� ���� </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> ��ü ��� ���� </td>
			<td width="850"> 
				<select name="ad_i_a_emp" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_a_emp="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_i_a_emp="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_i_a_emp="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_i_a_emp="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_i_a_emp="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> ���� ������� </th>
			<td width="850"> 
				<select name="ad_i_y_emp" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_y_emp="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_i_y_emp="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_i_y_emp="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_i_y_emp="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_i_y_emp="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> ������ ���� ���� </td>
			<td width="850"> 
				<select name="ad_i_a_company" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_i_a_company="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_i_a_company="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_i_a_company="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_i_a_company="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_i_a_company="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * ���� ���� </b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> ���� �������� </th>
			<td width="850"> 
				<select name="ad_k_p_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_p_result="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_k_p_result="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_k_p_result="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_k_p_result="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_k_p_result="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> ���� �������� </th>
			<td width="850"> 
				<select name="ad_k_y_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_y_result="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_k_y_result="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_k_y_result="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_k_y_result="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_k_y_result="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> ��ü �������� </td>
			<td width="850"> 
				<select name="ad_k_a_result" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_k_a_result="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_k_a_result="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_k_a_result="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_k_a_result="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_k_a_result="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td colspan='4' align='left'><b> * ���� ���� <b></th>
		</tr>
		<tr height='25'> 
			<th width="150"> ���� ���� ������ </th>
			<td width="850"> 
				<select name="ad_r_p_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_p_exact="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_r_p_exact="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_r_p_exact="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<th width="150"> ������ ���� ������ </th>
			<td width="850"> 
				<select name="ad_r_y_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_y_exact="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_r_y_exact="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_r_y_exact="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_r_y_exact="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_r_y_exact="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr>
			<td width="150" class='con6'> ��ü ��������� ������ </td>
			<td width="850"> 
				<select name="ad_r_a_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_a_exact="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_r_a_exact="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_r_a_exact="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_r_a_exact="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_r_a_exact="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr>
			<td width="150" class='con6'> ����� ������� </td>
			<td width="850"> 
				<select name="ad_r_g_exact" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_r_g_exact="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_r_g_exact="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_r_g_exact="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_r_g_exact="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_r_g_exact="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 

		<tr>
			<td width="150" class='con6'> ������/����ǰ ��û </td>
			<td width="850"> 
				<select name="ad_p_gift" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_p_gift="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_p_gift="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_p_gift="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_p_gift="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_p_gift="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr>
			<td width="150" class='con6'> ������/����ǰ ���� </td>
			<td width="850"> 
				<select name="ad_a_gift" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_a_gift="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_a_gift="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_a_gift="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_a_gift="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_a_gift="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 

		<tr height='25'> 
			<td colspan='2' align='left'><b> * �� ���� </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> �系 �������� </td>
			<td width="850"> 
				<select name="ad_e_notice1" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_notice1="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_e_notice1="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_e_notice1="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_e_notice1="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_e_notice1="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> ������ �������� </th>
			<td width="850"> 
				<select name="ad_e_notice2" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_notice2="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_e_notice2="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_e_notice2="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_e_notice2="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_e_notice2="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td width="150" class='con6'> �系 �ڷ�� </td>
			<td width="850"> 
				<select name="ad_e_data1" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_data1="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_e_data1="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_e_data1="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_e_data1="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_e_data1="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr>
			<th width="150"> ������ �ڷ�� </th>
			<td width="850"> 
				<select name="ad_e_data2" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_e_data2="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_e_data2="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_e_data2="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_e_data2="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_e_data2="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='25'> 
			<td colspan='2' align='left'><b> * �ΰ����� ���� </b></th>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> SMS ���� </td>
			<td width="850"> 
				<select name="ad_c_sms" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_sms="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_c_sms="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_c_sms="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_c_sms="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_c_sms="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> �ڵ� ���� </td>
			<td width="850"> 
				<select name="ad_c_code" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_code="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_c_code="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_c_code="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_c_code="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_c_code="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> �˾� ���� ���� </td>
			<td width="850"> 
				<select name="ad_c_popup" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_popup="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_c_popup="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_c_popup="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_c_popup="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_c_popup="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> �� ����Ʈ ���� </td>
			<td width="850"> 
				<select name="ad_c_black" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_black="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_c_black="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_c_black="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_c_black="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_c_black="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> ���ǥ ���� </td>
			<td width="850"> 
				<select name="ad_c_fee" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_c_fee="N" Then %> selected <% End If %>> ���� ���� </option>
				<option value="R" <% If ad_c_fee="R" Then %> selected <% End If %>> �б� ���� </option>
				<option value="W" <% If ad_c_fee="W" Then %> selected <% End If %>> ���� ���� </option>
				<option value="E" <% If ad_c_fee="E" Then %> selected <% End If %>> ���� ���� </option>
				<option value="A" <% If ad_c_fee="A" Then %> selected <% End If %>> ��� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='25'> 
			<td width="150" class='con6'> ��ŷ��å </td>
			<td width="850"> 
				<select name="ad_a_marking" class="txtbox" style="width:100px;">
				<option value="N" <% If ad_a_marking="N" Then %> selected <% End If %>> ��ŷ���� </option>
				<option value="A" <% If ad_a_marking="A" Then %> selected <% End If %>> ��ŷ������ </option>
				</select> 
			</td>
		</tr>
		<tr height='25'>
			<td colspan='2' align='center' style="text-align:center;">						
				<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_admin_chk();" onmouseover="this.style.cursor='hand';">										        				
				<a href ="/insa/a_emp_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a> 
			</td>
		</tr>
		</form>	
		</table>
			
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
</body>
</html>
