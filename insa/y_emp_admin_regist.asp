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

  if ad_i_y_emp="N" then
	Alert_url session_m_name &" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
 
  m_id			= WORD_CHANGE(request("m_id"),20)
  m_name		= WORD_CHANGE(request("m_name"),20)

  %>  	


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
		ad_b_p_custom	= "N"										'������ - ������(����)
		ad_b_y_custom	= "N"										'������ - ������(�ŷ�ó)
		ad_b_a_custom	= "N"										'������ - ��ü ����ǰ(�Ϲ�)

		'���� ������
		ad_g_p_gamang	= "N"										'������ - ���� ������ ���
		ad_g_y_gamang	= "N"										'������ - ������ ������ ���
		ad_g_a_gamang	= "N"										'������ - ��ü ������ ���

		'insa Menu
		ad_i_a_emp		= "N"										'�λ���� - ��ü �������
		ad_i_y_emp		= "N"										'�λ���� - ���� �������
		ad_i_a_company	= "N"										'�λ���� - ��Ʈ�� ��������

		'�������� 
		ad_k_p_result	= "N"										'�������� - ���� ��������
		ad_k_y_result	= "N"										'�������� - ���� ��������
		ad_k_a_result	= "N"										'�������� - ��ü ��������

		'������� �޴�
		ad_r_y_exact	= "N"										'������� - ������ ���곻��
		ad_r_a_exact	= "N"										'������� - ��ü �������

		'������ �޴�
		ad_e_notice1	= "N"										'������ - �系 ��������
		ad_e_notice2	= "N"										'������ - �ŷ�ó ��������
		ad_e_data1		= "N"										'������ - �系 �ڷ��
		ad_e_data2		= "N"										'������ - �ŷ�ó �ڷ��
		
		'�ڵ� ����
		ad_c_duty		= "N"										'�ڵ���� - �μ��ڵ�
		ad_c_position	= "N"										'�ڵ���� - ��å�ڵ�
		ad_c_sale		= "N"										'�ڵ���� - ������
		ad_c_course		= "N"										'�ڵ���� - �������
		ad_c_gaetong	= "N"										'�ڵ���� - �����ڵ�
		ad_c_promise	= "N"										'�ڵ���� - ��ǰ����
		ad_c_article	= "N"										'�ڵ���� - ��ǰ�ڵ�	

	Else	
		'������
		ad_b_p_custom	= CheckAdmin(objRs("ad_b_p_custom"))		'������ - ������(����)
		ad_b_y_custom	= CheckAdmin(objRs("ad_b_y_custom"))		'������ - ������(�ŷ�ó)		
		ad_b_a_custom	= CheckAdmin(objRs("ad_b_a_custom"))		'������ - ��ü ����ǰ(�Ϲ�)

		'����������
		ad_g_p_gamang	= CheckAdmin(objRs("ad_g_p_gamang"))		'������ - ���� ������ ���
		ad_g_y_gamang	= CheckAdmin(objRs("ad_g_y_gamang"))		'������ - ������ ������ ���
		ad_g_a_gamang	= CheckAdmin(objRs("ad_g_a_gamang"))		'������ - ��ü ������ ���


		'insa Menu
		ad_i_a_emp		= CheckAdmin(objRs("ad_i_a_emp"))			'�λ���� - ��ü �������
		ad_i_y_emp		= CheckAdmin(objRs("ad_i_y_emp"))			'�λ���� - ���� �������
		ad_i_a_company	= CheckAdmin(objRs("ad_i_a_company"))		'�λ���� - ��Ʈ�� ��������

		'�������� 
		ad_k_p_result	= CheckAdmin(objRs("ad_k_p_result"))		'�������� - ���� ���� ����
		ad_k_y_result	= CheckAdmin(objRs("ad_k_y_result"))		'�������� - ���� ���� ����
		ad_k_a_result	= CheckAdmin(objRs("ad_k_a_result"))		'�������� - ��ü ���� ����

		'������� �޴�
		ad_r_y_exact	= CheckAdmin(objRs("ad_r_y_exact"))			'������� - ������ ���곻��
		ad_r_a_exact	= CheckAdmin(objRs("ad_r_a_exact"))			'������� - ��ü �������

		'������ �޴�
		ad_e_notice1	= CheckAdmin(objRs("ad_e_notice1"))			'������ - �系 ��������
		ad_e_notice2	= CheckAdmin(objRs("ad_e_notice2"))			'������ - �ŷ�ó ��������
		ad_e_data1		= CheckAdmin(objRs("ad_e_data1"))			'������ - �系 �ڷ��
		ad_e_data2		= CheckAdmin(objRs("ad_e_data2"))			'������ - �ŷ�ó �ڷ��		
	end if  	
  end If
  %>
		<div class="sub_title"><img src="/images/common/sub03_t01.gif"></div>

		<form action="y_emp_admin_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_id" value="<%=m_id%>">				
		<input type="hidden" name="m_name" value="<%=m_name%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=25> 
			<th width="200">�����</th>
			<td colspan='3'> <%=m_name%></td>
		</tr>
		<tr height='30'> 
			<td colspan='4' align='left'> * ������ </th>
		</tr>
		<tr height='30'> 
			<th width="200">���� ���Խ�û ����</th>
			<td width="200"> 
				<select name="ad_b_p_custom" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_b_p_custom="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_b_p_custom="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_b_p_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200">������ ���Խ�û ����</th>
			<td width="200"> 
				<select name="ad_b_y_custom" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_b_y_custom="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_b_y_custom="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_b_y_custom="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * ������ ���� </th>
		</tr>
		<tr height='30'> 
			<th width="200"> ���� ������ ����</th>
			<td width="200"> 
				<select name="ad_g_p_gamang" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_g_p_gamang="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_g_p_gamang="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_g_p_gamang="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200"> ������ ������ ���� </th>
			<td width="200"> 
				<select name="ad_g_y_diary" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_g_y_diary="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_g_y_diary="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_g_y_diary="W" Then %> selected <% End If %>> ���� ���� </option>
					<option value="E" <% If ad_g_y_diary="E" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * �λ� ���� </th>
		</tr>
		<tr height='30'> 
			<th width="200"> ���� ������� </th>
			<td width="200"> 
				<select name="ad_i_y_emp" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_i_y_emp="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_i_y_emp="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_i_y_emp="W" Then %> selected <% End If %>> ���� ���� </option>
					<option value="E" <% If ad_i_y_emp="E" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200"></th>
			<td width="200"></td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * ���� ���� </th>
		</tr>
		<tr height='30'> 
			<th width="200"> ���� �������� </th>
			<td width="200"> 
				<select name="ad_k_p_result" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_k_p_result="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_k_p_result="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_k_p_result="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200"> ���� �������� </th>
			<td width="200"> 
				<select name="ad_k_y_result" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_k_y_result="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_k_y_result="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_k_y_result="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * ���� ���� </th>
		</tr>
		<tr height='30'> 
			<th width="200"> ������ ���곻�� </th>
			<td width="200"> 
				<select name="ad_r_y_exact" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_r_y_exact="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_r_y_exact="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_r_y_exact="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200"></th>
			<td width="200"></td>
		</tr> 
		<tr height='30'> 
			<td colspan='4' align='left'> * �� ���� </th>
		</tr>
		<tr height='30'> 
			<th width="200"> �ŷ�ó �������� </th>
			<td width="200"> 
				<select name="ad_e_notice2" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_e_notice2="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_e_notice2="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_e_notice2="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
			<th width="200"> �ŷ�ó �ڷ�� </th>
			<td width="200"> 
				<select name="ad_e_data2" class="txtbox" style="width:100px;">
					<option value="N" <% If ad_e_data2="N" Then %> selected <% End If %>> ���� ���� </option>
					<option value="R" <% If ad_e_data2="R" Then %> selected <% End If %>> �б� ���� </option>
					<option value="W" <% If ad_e_data2="W" Then %> selected <% End If %>> ���� ���� </option>
				</select> 
			</td>
		</tr>
		<tr height='30'>
			<td colspan='4' align='center'>						
				<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_admin_chk();" onmouseover="this.style.cursor='hand';">									        				
				<a href ="/insa/y_emp_list.asp"><img src="/images/button/btn_list.gif" border="0" align="absmiddle"></a> 
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
