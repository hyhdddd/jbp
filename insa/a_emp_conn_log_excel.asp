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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  filename="���ӷα�(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  Login_chk(Session_m_id)
  Login_chk(Session_o_code)

  m_id		= WORD_CHANGE(Request("m_id"),20)

  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">

<style type="text/css">
<!--  
	A:link    {color:#000000;text-decoration:none;}
	A:visited {color:#000000;text-decoration:none;}
	A:active  {color:#000000;text-decoration:none;}
	A:hover  {color:#8CC84B;text-decoration:none}

	body 
	{
		scrollbar-face-color: #ffffff; scrollbar-shadow-color: #666666; 
		scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff; 
		scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;
		scrollbar-arrow-color: #666666
	}
	td	{font: 9pt ����,GulimChe,Gulim;color: black;}	
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<!------------------ ���� ����  ------------------>

<table width="1200" cellspacing=1 cellpadding=0 border=1>  
<tr height='30'>
	<td bgcolor='gray' width="50">No</td>
	<td bgcolor='gray' width="100">�����</td>
	<td bgcolor='gray' width="100">���� ���̵�</td>
	<td bgcolor='gray' width="120">���� IP</td>
	<td bgcolor='gray' width="50">��������</td>
	<td bgcolor='gray' width="250">���</td>
	<td bgcolor='gray' width="120">���ӽð�</td>

</tr>
<%
if request("page")=""		then  page=1		Else page=Request("page")			end if
if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select  A.board_idx, A.m_id, B.m_name, A.m_passwd, A.m_ipinfo, a.m_bigo, A.m_status, A.m_writeday "
  strSql = strSql & " from emp_login_info A left outer "
  strSql = stRSql & "		 join emp_list B on A.m_id=B.m_id "

  If m_id="" Then
  else
  strSql = strSql & "			where  A.m_id='"& m_id &"' "
  End If 

  strSql = strSql & "					order by A.m_writeday desc"
  'Response.write stRSql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
	
  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page  	
  recordcount	= objRs.recordcount  		 
  i = 1
  Do until objRs.EOF
  	board_idx			= objRs("board_idx")			'��� �Ϸù�ȣ
	m_id1				= objRs("m_id")
  	m_name				= objRs("m_name")				'��� �̸�
	m_passwd			= objRs("m_passwd")
	'm_passwd			= "<span class='red'>******</span>"
	m_ipinfo			= objRs("m_ipinfo")
	m_bigo				= objRs("m_bigo")
	m_writeday			= fnc_date_change(objRs("m_writeday"))
	m_status			= objRs("m_status")
	
  %>	
		<tr height=30>
			<td><%=i%></td>
			<td><%=m_name%></td>
			<td><%=m_id1%></td>
			<td><%=m_ipinfo%></td>
			<td><%=m_status%></td>
			<td><%=m_bigo%></td>
			<td> <%=m_writeday%></td>     
		</tr>

  <% 
  	objrs.MoveNext
  	i=i+1 
  Loop
  End if
  objRs.close
  %>	


</table>
	

       		