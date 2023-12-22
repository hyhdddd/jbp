 <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />


<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
<tr height='30'>
	<td colspan='5'> 일괄 업데이트 실패 리스트 성공:( <span class='red'><%=success_chk%> 건</span> ) , 실패:( <span class='red'><%=fail_chk%> 건 </span>)</td>
</tr>
<tr height='30'>
	<td colspan='5'  style='text-align:right;'> <a href="a_custom_gaetong_batch06.asp"><img src="/images/button/btn_excel.gif"></a> </td>
</tr>
<tr height="30">
	<th class="head">No</th> 
	<th class="head">가입자명</th>
	<th class="head">가입서비스번호</th>        
	<th class="head">개통일</th>        
	<th class="head">접수일</th>      
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
