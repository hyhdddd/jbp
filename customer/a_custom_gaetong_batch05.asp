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

  strSql = "select count(*) from customer_up_temp where c_up_chk='O'"
  Set objRs= objCnn.execute(strSql)

  success_chk	= objRs(0)

  strSql = "select count(*) from customer_up_temp where c_up_chk='X'"
  Set objRs= objCnn.execute(strSql)

  fail_chk	= objRs(0)

  %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />


<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
<tr height='30'>
	<td colspan='5'> �ϰ� ������Ʈ ���� ����Ʈ ����:( <span class='red'><%=success_chk%> ��</span> ) , ����:( <span class='red'><%=fail_chk%> �� </span>)</td>
</tr>
<tr height='30'>
	<td colspan='5'  style='text-align:right;'> <a href="a_custom_gaetong_batch06.asp"><img src="/images/button/btn_excel.gif"></a> </td>
</tr>
<tr height="30">
	<th class="head">No</th> 
	<th class="head">�����ڸ�</th>
	<th class="head">���Լ��񽺹�ȣ</th>        
	<th class="head">������</th>        
	<th class="head">������</th>      
</tr>
  <%
  strSql = "select * from customer_up_temp where c_up_chk='X' order by board_idx asc"
  Set objRs=objCnn.Execute(strSql)
  
  i=1
  Do Until objRs.eof	
	board_idx		= objRs("board_idx")
	c_name			= objRs("c_name")
	c_service_no	= objRs("c_service_no")
	c_gaetong_date	= objRs("c_gaetong_date")
	c_jupsu_date	= objRs("c_jupsu_date")
  %>
<tr height='30'>
	<td class="con5"><%=i%></td>
	<td class='con4'><%=c_name%></td>
	<td class='con4'><%=c_service_no%></td>
	<td class='con4'><%=c_gaetong_date%></td>
	<td class='con4'><%=c_jupsu_date%></td>
</tr>
  <%
	i=i+1
	objRs.movenext
  Loop
  %>
</table>
