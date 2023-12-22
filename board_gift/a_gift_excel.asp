  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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

  filename="사은품신청(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  if ad_a_gift="N" then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 
 
  gift_idx			= WORD_CHANGE(Request("gift_idx"),20)

  
  strSql = " select A.gift_idx, A.gift_date, B.m_name, A.gift_writeday, A.gift_status, A.gift_money  "
  strSql = strSql &"	from board_gift A left outer "
  strSql = strSql &"		 join emp_list B ON A.gift_m_id=B.m_id "
  strSql = strSql &"		 where A.gift_idx="& gift_idx &" "
  Set objRs = objCnn.Execute(strSql)

  m_name		= objRs("m_name")


  %>

  
<meta http-equiv=Content-Type content='text/html; charset=ks_c_5601-1987'> 
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

<table width=1000 cellspacing="1" cellpadding="0" border=1>
<tr height='30'>
	<Th bgcolor='gray'>No</th>
	<Th bgcolor='gray'>은행명</th>
	<Th bgcolor='gray'>계좌번호</th>
	<Th bgcolor='gray'>금액</th>
	<Th bgcolor='gray'>예금주</th>
	<Th bgcolor='gray'>신청자</th>
</tr>
<%
	strSql = "select * from board_gift_bank where gift_idx="& gift_idx &" order by bank_idx asc"
	Set objRs = objCnn.Execute(strSql)
	
	i = 1 
	Do Until objRs.eof
		bank_idx			= objRs("bank_idx")
		bank_name			= objRs("bank_name")
		bank_no				= objRs("bank_no")
		bank_owner			= objRs("bank_owner")
		bank_money			= money_change(objRs("bank_money"))
  %>
<tr>
	<td><%=i%></td> 
	<td style="mso-number-format:\@"><%=bank_name%></td> 
	<td style="mso-number-format:\@"><%=bank_no%></td> 
	<td><%=bank_money%></td> 
	<td style="mso-number-format:\@"><%=bank_owner%></td> 
	<td style="mso-number-format:\@"><%=m_name%></td> 
</tr> 
  <%
		objRs.movenext
	Loop
  %>
</table>
