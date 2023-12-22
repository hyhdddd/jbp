  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  'Response.Expires = -1000
  'Response.CacheControl = "no-cache"
  'Response.AddHeader "Pragma", "no-cache"
  'Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"--> 
  <!--#include virtual="/include/asp/admin_chk.asp"-->   
  <%
  Login_chk(Session_m_id)
   
  g_article_idx1		= WORD_CHANGE(Request("g_article_idx1"),10)
  g_article_idx2		= WORD_CHANGE(Request("g_article_idx2"),10)

  start_date			= WORD_CHANGE(request("start_date"),20)
  end_date				= WORD_CHANGE(request("end_date"),20)
  m_id					= WORD_CHANGE(Request("m_id"),20)
  m_name				= WORD_CHANGE(Request("m_name"),20)
  sawon_chk				= WORD_CHANGE(Request("sawon_chk"),20)
  
  strsql = " select article_name from code_article where article_idx="&g_article_idx1
  Set objRs1=objCnn.Execute(strSql)

  article_com		= objRs1(0)

  If g_article_idx2<>"" then
	  strsql = " select article_name from code_article where article_idx="&g_article_idx2
	  Set objRs1=objCnn.Execute(strSql)

	  article_com1		= objRs1(0)
  End if
  %> 
  
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
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub05_t03.gif"></div>

		<table width='100%' border=0 id="board_table3">
		<tr height=30> 
			<td> 검색 내용 : 본사 사원별 유치현황 (<%=m_name%>님) </td>
		</tr>	
		<tr height=30>
			<td> 검색 기간 : (<%=start_date%> ~  <%=end_date%>)</td>		
		</tr>
		<tr height=30> 
			<td>검색 상품 : <%=article_com%>_<%=article_com1%></td>		
		</tr>
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>
			<Td class="head">No</td>
			<Td class="head">고객명</td>
			<Td class="head">상품명</td>
			<Td class="head">유치자</td>
			<Td class="head">유치일</td>
			<Td class="head">개통일</td>
			<Td class="head">개통상태</td>
		</tr>

 <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql_txt = "	and (A.g_date_yuchi>='"&start_date&" 00:00:00.000') "
  strSql_txt = strSql_txt & "	and (A.g_date_yuchi<='"&end_date&" 23:59:59.000') "	

  If m_id<>"" Then
    strSql_txt = strSql_txt & "	and (g_yuchi_m_id='"& m_id &"') "
  else
	strSql_txt = strSql_txt & "	and (g_yuchi_m_id in (select m_id from emp_list where m_dealer_code='"&o_code&"')) "
  End if

  strSql = " select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_yuchi_m_id , A.g_date_yuchi,"
  strSql = strSql & " A.g_date_gaetong, A.g_writeday, "
  strSql = strSql & " B.m_name as yuchi_name, C.article_name , D.article_name as article_name1,  "
  strSql = strSql & " E.gaetong_name, A.c_name "
  strSql = strSql & "		from customer_goods A left outer  "
  strSql = strSql & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id"
  strSql = strSql & "	   left	join code_article C on A.g_article_idx1=C.article_idx"
  strSql = strSql & "	   left	join code_article D on A.g_article_idx2=D.article_idx"
  strSql = strSql & "	   left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql = strSql & "				where A.g_article_idx1="& g_article_idx1&" "
  strSql = strSql & strSql_txt
  If g_article_idx2<>"" then
	strSql = stRsql & "					and A.g_article_idx2="& g_article_idx2 &" "
  End If 
  
  If sawon_chk="O" Or sawon_chk="X" then
	  strSql = strSql & "		and B.m_status='"& sawon_chk &"'"
  End if


  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
	

  recordcount	= objRs.recordcount
	
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=25>
			<td class='con5' colspan='7'> 고객 등록상품이 없습니다. </td>
		</tr>
  <%
	
  else
    
  totalpage				= objRs.pagecount
  objRs.absolutepage	= page
  recordcount			= objRs.recordcount

	i=1
	Do until objRs.EOF Or i>objRs.PageSize 
		g_goods_idx			= objRs("g_goods_idx")
		g_yuchi_m_id		= objRs("g_yuchi_m_id")
		g_date_yuchi		= Left(objRs("g_date_yuchi"),10)
		g_date_gaetong		= Left(objRs("g_date_gaetong"),10)
		yuchi_name			= objRs("yuchi_name")
		article_name		= objRs("article_name")
		g_writeday			= Left(objRs("g_writeday"),10)
		c_name				= objRs("c_name")
		m_name				= objRs("yuchi_name")
		article_name1		= objRs("article_name1")
		gaetong_name		= objRs("gaetong_name")
	%>
		<tr height=30>
			<td class='con5'><%=i%> </td>
			<td class='con4'><%=c_name%> </td>
			<td class='con4'><%=article_name%>-<%=article_name1%></td>
			<td class='con4'><%=yuchi_name%></td>
			<td class='con4'><%=g_date_yuchi%>&nbsp;</td>
			<td class='con4'><%=g_date_gaetong%></td>
			<td class="con4"><span class='blue'><%=gaetong_name%></span></td>
		</tr>
	<%
		i=i+1
		objRs.movenext
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
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "a_result_list_5_1.asp?start_date="&start_date&"&end_date="&end_date&"&g_article_idx1="&g_article_idx1&"&g_article_idx2="&g_article_idx2&"&m_name="&m_name&"&m_id="&m_id&"&sawon_chk="&sawon_chk&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>					
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
</table>				
</div>
	