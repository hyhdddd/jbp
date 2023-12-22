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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)


  filename="업데이트실패목록(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

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
	td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	
//-->
</style>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<!------------------ 내용 시작  ------------------>

<table width="600" cellspacing=1 cellpadding=0 border=1>  
<tr height='30'>

<tr height="30">
	<th bgcolor='gray'>No</th> 
	<th bgcolor='gray'>가입자명</th>
	<th bgcolor='gray'>가입서비스번호</th>        
	<th bgcolor='gray'>개통일</th>        
	<th bgcolor='gray'>접수일</th>      
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
	<td><%=i%></td>
	<td><%=c_name%></td>
	<td><%=c_service_no%></td>
	<td><%=c_gaetong_date%></td>
	<td><%=c_jupsu_date%></td>
</tr>
  <%
	i=i+1
	objRs.movenext
  Loop
  %>
</table>
