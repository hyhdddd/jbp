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

  if ad_c_code="N" then
	Alert_back session_m_name &" ���� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	response.end
  end If

  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/css/style_button.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
function frm_submit(form_name)
{
	var frm			= document.getElementById(form_name);
	frm.submit();
} 
-->
</script>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr bgcolor="#FFFFFF"  height='400'> 
	<td valign='top' align='center'>

		<!------------------ ���� ����  ------------------>    				

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">�ڵ���� </li>
		</ul>
		</div>

		<form id="frm_delete" name="frm_delete" Method="POST" action="customer_marking_ok.asp">		
	
		<!--#include virtual="/include/asp/code_menu_list.asp"-->

		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_css">
		<tr height="40">
			<th colspan="4" class="head_Gray_TLBR">��ŷ ��å �Ⱓ�� ������ �ּ��� (�Ⱓ���� �����Ͱ� ��ŷ�˴ϴ�.) </th>
		</tr>
		<tr height="30">
			<td colspan="4" class="list_LBR_center"><b>��ŷ�Ⱓ : </b>
				<select name="o_marking" class="txtbox" style="width:100px;">
				<option value="0" <% If o_marking="0" Then %> selected <% End If %>>��ŷ���� </option>
				<option value="1" <% If o_marking="1" Then %> selected <% End If %>>1��  </option>
				<option value="3" <% If o_marking="3" Then %> selected <% End If %>>3��  </option>
				<option value="7" <% If o_marking="7" Then %> selected <% End If %>>1�� </option>
				<option value="14" <% If o_marking="14" Then %> selected <% End If %>>2�� </option>
				<option value="30" <% If o_marking="30" Then %> selected <% End If %>>1���� </option>
				<option value="60" <% If o_marking="60" Then %> selected <% End If %>>2���� </option>
				<option value="90" <% If o_marking="90" Then %> selected <% End If %>>3���� </option>
				</select>
			</td>
		</tr>
		<tr height="30" >
			<td colspan="26" align="center" style="text-align:center;">
				<a href="javaScript:frm_submit('frm_delete');" class="btn_m_white01">�����ϱ�</a>
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