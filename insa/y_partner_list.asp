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
  if ad_i_a_company="N" then
	Alert_url session_m_name &" ���� �ŷ�ó ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  search_key		= WORD_CHANGE(request("search_key"),20)
  search_txt		= WORD_CHANGE(request("search_txt"),20)

  %>  
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr height="400"> 
	<td valign='top' align='center'>
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub03_t04.gif"></div>

		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">
		<tr height="30">
			<td class="description">&nbsp;&nbsp;* �α������������� ��û�� ��Ʈ�� ��û ����Ʈ�� ��Ÿ ���ϴ�.</td>
		</tr>
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=25>             
			<td class="head">�̸�</td>
			<td class="head">��û ���̵�</td>
			<td class="head">��û ��й�ȣ</td>
			<td class="head">�ֹε�Ϲ�ȣ</td>
			<td class="head">����ó</td>
			<td class="head">ȸ���</td>
			<td class="head">����ڹ�ȣ</td>
			<td class="head">��û��</td>
		</tr>

  <%
  strSql = " select A.board_idx, A.m_name, A.m_id, A.m_jumin1, A.m_jumin2, A.m_tel1,A.m_tel2, "
  strSql = strSql & " A.m_passwd, A.d_writeday , A.dealer_name, A.dealer_com_no from dealer_partner_info A "
  strSql = strSql & "			order by A.board_idx desc"
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
	
  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page  	
  		 
  i = 1
  Do until objRs.EOF Or i>objRs.PageSize 
  	board_idx			= objRs("board_idx")			'��� �Ϸù�ȣ
  	m_name				= objRs("m_name")			'��� �̸�
	m_id				= objRs("m_id")				'��� ���̵�
	m_passwd			= objRs("m_passwd")			'��� ��й�ȣ
	m_tel1				= objRs("m_tel1")			'��� ����ó
	m_tel2				= objRs("m_tel2")			'��� ����ó
	m_jumin1			= objRs("m_jumin1")			'�ֹι�ȣ1
	m_jumin2			= objRs("m_jumin2")			'�ֹι�ȣ2
	dealer_name			= objRs("dealer_name")		'�ŷ�ó ��
	dealer_com_no		= objRs("dealer_com_no")	'����ڹ�ȣ
	d_writeday			= objRs("d_writeday")		'��û��
  %>	
		<tr height=30>
			<td><a href="y_partner_view.asp?board_idx=<%=board_idx%>"><%=m_name%></a></td>
			<td><%=m_id%></td>
			<td><%=m_passwd%></td>
			<td><%=m_jumin1%>-<%=m_jumin2%></td>
			<td><%=m_tel1%></td>
			<td><%=dealer_name%></td>
			<td><%=dealer_com_no%></td>
			<td><%=d_writeday%></td>
		</tr>

  <% 
  	objrs.MoveNext
  	i=i+1 
  Loop
  End if
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
			link_url = "y_partner_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>						
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>