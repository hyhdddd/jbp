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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"--> 
  <!--#include virtual="/include/asp/admin_chk.asp"-->   
  <%
  Login_chk(Session_m_id)

  filename="전체실적관리_본사사원 개통현황(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename
  
  g_article_idx1		= WORD_CHANGE(Request("g_article_idx1"),10)
  start_date			= WORD_CHANGE(Request("start_date"),20)
  end_date				= WORD_CHANGE(Request("end_date"),20)
  sawon_chk				= WORD_CHANGE(Request("sawon_chk"),20)

  If sawon_chk="" Or sawon_chk="O" Then
	sawon_chk="O"			' 종사자
	sawon_txt="종사자"
  ElseIf sawon_chk="X" Then
	sawon_txt="퇴사자"
  ElseIf sawon_chk="A" Then
	sawon_txt="전체사원"  
  End If

  between_date_cnt	= dateDiff("d",start_date,end_date)  

  strsql = " select article_name from code_article where article_idx="&g_article_idx1
  Set objRs=objCnn.Execute(strSql)

  article_com		= objRs(0)

  strsql = " select count(*) from code_article where article_step1="& g_article_idx1 &" and article_step2>0"
  Set objRs=objCnn.Execute(strSql)

  article_cnt		= objRs(0)

  strsql = " select * from code_article where article_step1="& g_article_idx1 &" and article_step2>0 "
  strSql = strSql & " order by article_step1 asc, article_step2 asc "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	Alert_back "상품 코드가 존재하지 않아 검색하실수 없습니다."
	Response.end
  End if

  Dim article_idx(50)
  Dim article_name(50) 
  
  Dim article_cnt1(50)
  Dim article_cnt_total(50)
  article_sum_total = 0
  i=1
  Do Until objRs.eof
	article_idx(i)		= objRs("article_idx")
	article_name(i)		= objRs("article_name")
	objRs.movenext
	i=i+1
  Loop  
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
	
	.head 	{
		font-family: "돋움";
		padding: 5px 0px 3px 0px;
		background-color:#000000;
		color: white}
	.con5 { 
		font-family: "돋움";
		padding: 3px 1px 0px 3px; 
		font-size:12px ; 
		border-left: 1px solid #C7C7C7; 
		border-bottom: 1px solid #C7C7C7; 
		border-right: 1px solid #C7C7C7}
	.con4 { 
		font-family: "돋움";
		padding: 3px 1px 0px 3px; 
		font-size:12px ; 
		border-bottom: 1px solid #C7C7C7; 
		border-right: 1px solid #C7C7C7}
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

		<table width='100%' border=0 id="board_table3">
		<tr height=30> 
			<td>검색 내용 : 본사 사원별 개통현황 (<span class='red'><%=sawon_txt%></span>)</td>
		</tr>				
		<tr height=30> 
			<td>검색 상품 : <%=article_com%></td>
		</tr>
		<tr height=30> 
			<td>검색 기간 : (<%=start_date%> ~ <%=end_date%>)</td>
		</tr>		
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0>
		<tr height=30>                     
			<td width="150" class="head"> 종 사 자</td>
			<% For i=1 To article_cnt %>
			<td width="120" class="head">
				<%=article_name(i)%> </td>
			<% Next %>
			<td width="120" class="head">합계 </td>
		</tr>    					

<%
  strSql = "select m_name, m_id, m_status from emp_list "
  strSql = strSql & "	where m_dealer_code='"& o_code &"'"

  If sawon_chk="O" Or sawon_chk="X" then
	  strSql = strSql & "		and m_status='"& sawon_chk &"'"
  End if

  strSql = strSql & "		order by m_name asc "
  set objRs1=objCnn.Execute(strSql)
    
  Do until objRs1.EOF
	m_name		= objRs1("m_name")
    m_id		= objRs1("m_id")
    m_status	= objRs1("m_status")
  
	If m_status="X" then
		status_txt	= "<span class='blue'> "& m_name &"</span>"
	Else
		status_txt	= m_name
	End if

	strSql_txt = " and (g_date_gaetong>='"&start_date&" 00:00:00.000') "
	strSql_txt = strSql_txt & "	and (g_date_gaetong<='"&end_date&" 23:59:59.000') "	
	strSql_txt = strSql_txt & "	and (g_yuchi_m_id='"& m_id &"') "


	strSql = " select * from "

	For j=1 To article_cnt
	strSql = strSql & "(select count(*) as cnt from customer_goods where g_article_idx1="& g_article_idx1 &" and g_article_idx2="&article_idx(j) & " "
	strSql = strSql & strSql_txt & " ) A"&j&" ,"
	Next
    
	
	strSql = Left(strSql,Len(strSql)-1)
	'Response.write strSql &"<br><br>"
    Set objRs=objCnn.Execute(strSql)
  
	For j=1 To article_cnt
		article_cnt1(j)		= objRs(j-1)
		article_cnt_total(j)= article_cnt_total(j) + article_cnt1(j)
		article_sum			= article_sum+article_cnt1(j)
	next
     	
	article_sum_total = article_sum_total + article_sum     	
%>		  
		<tr height=30>
			<td class='con5'><%=status_txt%>
			</td>
			<% For j=1 To article_cnt %>
			<td class='con4'>
				<% If article_cnt1(j)>0 Then %><%=article_cnt1(j)%>
				<% Else %>
					&nbsp;
				<% End if %>
			</td>
			<% Next %>
			<Td class='con4'> 
				<% If article_sum>0 Then %><%=article_sum%>
				<% Else %>
					&nbsp;
				<% End If %>
			</td>
		</tr>          	

<% 
		article_sum=0
		objRs1.movenext
  Loop
%>	
		<tr height=30>
			<td class='con5'>
				합  계
			</td>
			<% For j=1 To article_cnt %>
			<td class='con4'>
				<% If article_cnt_total(j)>0 Then %><%=article_cnt_total(j)%>
				<%				
				   Else 
					response.write "&nbsp;"
				   End if 
				 %>
			</td>
			<% Next %>
			<Td class='con4'> 
				<% If article_sum_total>0 Then %><%=article_sum_total%>
				<% Else %>
					&nbsp;
				<% End If %>
			</td>
		</tr>        
		</table>          										
		<!------------------ 내용 종료  ------------------>
	