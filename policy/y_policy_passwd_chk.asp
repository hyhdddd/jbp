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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->

  <%
  Login_chk(Session_m_id)
  
  if ad_r_y_exact="N" then
 	Alert_URL session_m_name &" ���� �ŷ�ó ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  policy_idx	 = WORD_CHANGE(Request("policy_idx"),10)

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
		
		if(frm.policy_passwd.value=="")
		{
			alert("��й�ȣ�� �Է��� �ּ���!")
			frm.policy_passwd.focus();
			return;
		}
		frm.submit();

	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
		
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub16_t01.gif" width='100%'></div>

		<div style="width:400px;height:150px;margin-left:250px;margin-top:70px;border:5px solid #eeeeee;padding:30 30 30 30;">
		<form name="frm_board" action="y_policy_view.asp"  METHOD="POST">
		<input type="hidden" name="policy_idx"  value="<%=policy_idx%>">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30> 
			<th width='150' align='center'>��åǥ ��й�ȣ</th>
			<td>&nbsp;&nbsp;<input type="password" name="policy_passwd" class='txtbox' size='20' maxlength='20'></td>
		</tr>
		<tr height="60">            
			<td align='center' colspan="2"><br> 
				<img src="/images/button/btn_confirm.gif" onmouseover="this.style.cursor='hand';" onclick="exact_request('frm_board');">
				
			</td>
		</tr>
		</form>	
		</table>
		</div>
</div>
		<!------------------ ���� ����  ------------------>					          
