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
 	Alert_back session_m_name &" ���� ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	

  policy_idx		= WORD_CHANGE(Request("policy_idx"),20)
  s_group_code		= WORD_CHANGE(Request("s_group_code"),20)
  s_policy_date		= WORD_CHANGE(Request("s_policy_date"),20)
  e_policy_date		= WORD_CHANGE(Request("e_policy_date"),20)

  If policy_idx<>"" then
  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code"
  strSql = strSql & "			where A.policy_idx="&policy_idx
  Set objRs=objCnn.Execute(strSql)

  group_code	= objRs("group_code")
  group_name	= objRs("group_name")
  policy_date	= fnc_date_change(objRs("policy_date"))
  End If
  
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function send_gicho(form_name)
	{
		var frm=eval("document.all."+form_name);

		if (frm.t_policy_idx.value=="0")
		{
			alert("��� �׷��� ������ �ּ���!");
			frm.t_policy_idx.focus();
			return;
		}

		if(frm.t_policy_idx.value==frm.policy_idx.value)
		{
			alert("���� �׷�� ������ �׷��� ���� �޶�� �մϴ�.");
			frm.t_policy_idx.focus();
			return;
		}

		ans=confirm("���� ��� ����׷쿡 �����ڷᰡ �� �ִ� ���, ���� �ڷḦ ��� ������ ���簡 �˴ϴ�. \n\n ���ʰ��Ḧ �����Ͻðڽ��ϱ�?");
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
	<td valign='top' align='center' height='400'>
		
		<!------------------ ���� ����  ------------------>    								
		
		<div class="sub_title"><img src="/images/common/sub06_t05.gif"></div>

		<form name="frm_group" Method="POST" action="charge_copy_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		</table>

		<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3">
		<tr height='30'>
			<td colspan='2'> &nbsp;&nbsp;&nbsp;&nbsp;
				* ���� �׷���� �����ᰡ '������ �׷��' ���� ��� ����Ǹ�, ������ �׷�� ��������å�� �� ������ ��� ������ ���簡 �˴ϴ�.
		</tr>
		<tr height="30">
			<td colspan='4'>&nbsp;&nbsp; <b> * ������ ��å �����ڷ� ���� </td>
		</tr>
		<Tr>
			<th width="110"> �׷�� ���� </th>
			<td width="890">&nbsp; <%=policy_date%>_<%=group_name%> &nbsp;&nbsp;<span class='red'> --></span> &nbsp;&nbsp;
				<select name="t_policy_idx">
				<option value="0"> :: ���� ��� ���� :: </option>
  <%			
  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code and B.group_use='Y' "
  strSql = strSql & "			where A.policy_idx<>"&policy_idx&" "

  If s_group_code<>"" Then
	strSql = strSql &		" and  A.group_code='"& s_group_code &"' "
  End if

  If s_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date>='"& s_policy_date &"' "
  End if

  If e_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date<='"& e_policy_date &"' "
  End If
  
  strSql = strSql & " "

  strSql = strSql & "			order by policy_date Desc, writeday desc "
  Set objRs=objCnn.Execute(strSql)

    Do Until objRs.eof 
	  policy_idx		= objRs("policy_idx")
	  policy_date		= fnc_date_change(objRs("policy_date"))
	  group_code		= objRs("group_code")
	  group_name		= objRs("group_name")
	  writeday			= fnc_date_change(objRs("writeday"))
  %>
				<option value="<%=policy_idx%>"> <%=policy_date%>_<%=group_name%> </option>
  <%
	  objRs.movenext
	loop
  %>
				</select>
			</td>
		</tr>
		</table>

		<div class="alignCenter"><span class="btn_m_white01" onclick="send_gicho('frm_group');">�����ϱ�</span></div>
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
