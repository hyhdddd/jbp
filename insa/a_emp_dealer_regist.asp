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
	Alert_url session_m_name &"���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
	Response.end
  end If
  
  m_id			= WORD_CHANGE(request("m_id"),20)

  strSql = "select * from emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	Alert_back "�߸��� ���� �Դϴ�."
	Response.End
  Else
	m_name		= objRs("m_name")
  End if

  %>  	


<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function send_dealer_chk(form_name)
	{
		var frm		= eval("document.all."+form_name);

		if (frm.m_dealer_code.value=="")
		{
			alert("����ü�� ������ �ּ���!");
			frm.m_dealer_code.focus();
			return;
		}

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
<tr bgcolor="#FFFFFF" > 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top' align='center'>

		<!------------------ ���� ����  ------------------>
		<div class="sub_title"><img src="/images/common/sub03_t02.gif"></div>

		<form action="a_emp_dealer_regist_ok.asp" method="post" name="frm_emp_regist"> 
		<input type="hidden" name="m_id" value="<%=m_id%>">				

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="board_table3">
		<tr height=25> 
			<th width='150'>�����</th>
			<td width='850'> <%=m_name%></td>
		</tr>
		<tr height='25'> 
			<th width="200">����ü ����</th>
			<td width="300"> 
				<select name="m_dealer_code" class="txtbox" style="width:100px;">
				<option value="">::��ü����::</option>

				<% 
				strSql = "select * from dealer_info where dealer_view='Y' order by dealer_name"
				Set objRs=objCnn.Execute(strSql)

				If objRs.eof Or objRs.bof Then
				
				Else
					Do Until objRs.eof	
						dealer_code		= objRs("dealer_code")
						dealer_name		= objRs("dealer_name")
				%>
				<option value="<%=dealer_code%>"><%=dealer_name%></option>
				<%
						objRs.movenext
					Loop
				End If 
				%>
				</select> 
				�ŷ����� ��ü�� ǥ�õ˴ϴ�.
			</td>
		</tr>
		<tr height='25'>
			<td colspan='2' align='center'>						
				<img src="/images/button/btn_save.gif" border="0" align="absmiddle" onClick="send_dealer_chk('frm_emp_regist');" onmouseover="this.style.cursor='hand';">										        				
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
