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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <% 
  if ad_r_y_exact="N" then
 	Alert_back session_m_name &" ���� �ŷ�ó ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	

  e_exact_idx	 = WORD_CHANGE(Request("e_exact_idx"),20)

  %>

<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function exact_request(form_name,chk)
	{
		var frm=eval("document.all."+form_name);
		
		if(frm.exact_passwd.value=="")
		{
			alert("��й�ȣ�� �Է��� �ּ���!")
			frm.exact_passwd.focus();
			return;
		}
		frm.submit();

	}
-->
</script>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">������ ���곻����</li>
		</ul>
		</div>

		<form name="frm_board" action="y_exact_regist.asp"  METHOD="POST">
		<input type="hidden" name="e_exact_idx"  value="<%=e_exact_idx%>">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30> 
			<th width='150' align='center'>���꼭 ��й�ȣ</th>
			<td width='850'> <input type="password" name="exact_passwd" class='txtbox' size='20' maxlength='20'></td>
		</tr>

		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="y_exact_list.asp?&page=<%=page%>"><img src="/images/button/btn_list.gif"></a>&nbsp;&nbsp;

				<img src="/images/button/btn_confirm.gif" onmouseover="this.style.cursor='hand';" onclick="exact_request('frm_board');">
				
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