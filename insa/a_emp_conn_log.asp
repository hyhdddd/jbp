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

  if session_m_step<>"M" then
	Alert_url session_m_name &" ���� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  
  m_id		= WORD_CHANGE(Request("m_id"),20)

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  %>  
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="100%" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"  align='center' height='400'> 
	<td valign='top' align='center'>
		<!------------------ ���� ����  ------------------>
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height='30'>
			<td colspan='8' style='text-align:right;'> 
				<a href="a_emp_conn_log.asp"> ��ü ���� �α� ���� </a>&nbsp;&nbsp;|&nbsp;&nbsp; 
				<a href="a_emp_conn_log_excel.asp?m_id=<%=m_id%>"> �����ٿ�ε� </a>&nbsp;&nbsp;&nbsp; 
			</td>
		</tr>
		<tr height=25>
			<td class="head">No</td>
			<td class="head">�����</td>
			<td class="head">���� ���̵�</td>
			<td class="head">���� ��й�ȣ</td>
			<td class="head">���� IP</td>
			<td class="head">��������</td>
			<td class="head">���</td>
			<td class="head">���ӽð�</td>
		</tr>

  <%
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
  Do until objRs.EOF Or i>objRs.PageSize 
  	board_idx			= objRs("board_idx")			'��� �Ϸù�ȣ
	m_id1				= objRs("m_id")
  	m_name				= objRs("m_name")				'��� �̸�
	m_passwd			= objRs("m_passwd")
	m_passwd			= "<span class='red'>******</span>"
	m_ipinfo			= objRs("m_ipinfo")
	m_bigo				= objRs("m_bigo")
	m_writeday			= fnc_date_change(objRs("m_writeday"))
	m_status			= objRs("m_status")
	
  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con4"><a href="a_emp_conn_log.asp?m_id=<%=m_id1%>&page=<%=page%>&search_txt=<%=search_txt%>&search_key=<%=search_key%>&s_dealer_code=<%=s_dealer_code%>"><%=m_name%></a></td>
			<td class="con4"><%=m_id1%></td>
			<td class="con4"><%=m_passwd%></td>
			<td class="con4"><%=m_ipinfo%></td>
			<td class="con4"><%=m_status%></td>
			<td class="con4"><%=m_bigo%></td>
			<td class="con4"> <%=m_writeday%></td>     
		</tr>

  <% 
  	objrs.MoveNext
  	i=i+1 
  Loop
  End if
  objRs.close
  %>	
		</table>
		<div class="pagelist">		
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :������ Request ��
			mychoice=10
			link_url = "a_emp_conn_log.asp?m_id="&m_id&"&search_txt="&search_txt&"&search_key="&search_key&"&s_dealer_code="&s_dealer_code&"&list_cnt="&list_cnt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> �� ] </span></b>
		</div>
		<!------------------ ���� ����  ------------------>
	</td>
</tr>  
</table>
</div>
