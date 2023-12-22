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
  start_date			= WORD_CHANGE(Request("start_date"),20)
  end_date				= WORD_CHANGE(Request("end_date"),20)

  between_date_cnt	= dateDiff("d",start_date,end_date)  

  strsql = " select article_name from code_article "
  strSql = strSql & " where article_idx="&g_article_idx1
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
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>  
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

		<div class="sub_title"><img src="/images/common/sub05_t01.gif"></div>

		<table width='100%' border=0  cellspacing="0" cellpadding="0" id="board_table3">
		<tr height="30"> 
			<td>검색 내용 : 나의 일자별 유치현황</td>
		</tr>				
		<tr height="30"> 
			<td>검색 상품 : <%=article_com%></td>
		</tr>
		<tr height="30"> 
			<td>검색 기간 : (<%=start_date%> ~ <%=end_date%>)</td>
		</tr>
		<tr>
			<td align='right'>
				<form name="frm" method="post" action="p_result_list_1.asp">
				<input type="hidden" name="start_date" value="<%=start_date%>">
				<input type="hidden" name="end_date" value="<%=end_date%>">
				<select name="g_article_idx1" style="width:120px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="submit();">
					<% 
					strSql = " select * from code_article where article_step2=0 "
					strSql = strSql & "		order by article_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else
						i = 1
						Do until objRs.EOF   	
							article_idx1		= objRs("article_idx")
							article_name1		= objRs("article_name")
						%>	
						<option value="<%=article_idx1%>" <% If g_article_idx1=CStr(article_idx1) Then %> selected <% End If %>><%=article_name1%></option>
						<% 
							objRs.MoveNext
							i=i+1 
						Loop
					End if
				%>	
				</select>						
			</td></form>
		</tr>
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>                     
			<th width=150 class="head"> 날 짜 </td>
			<% For i=1 To article_cnt %>
			<th width="120" class="head"><%=article_name(i)%></td>
			<% Next %>
			<th width="120" class="head">합계</td>
		</tr>    					

<%
    for i=0 to between_date_cnt
	date_add	= DateAdd("d",i,start_date)
	db_year		= year(date_add)
	db_month	= month(date_add)
	db_day		= day(date_add)	

	strSql_txt = " and (year(g_date_yuchi)='"&db_year&"' and month(g_date_yuchi)='"&db_month&"' "
	strSql_txt = strSql_txt & " and day(g_date_yuchi)='"&db_day&"') "
	strSql_txt = strSql_txt & " and g_yuchi_m_id='"&session_m_id&"' "

	strSql = " select * from "

	For j=1 To article_cnt
	strSql = strSql & "(select count(*) as cnt from customer_goods where  "
	strSql = strSql & "		g_article_idx1="& g_article_idx1 &" and g_article_idx2="&article_idx(j) & " "
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
			<td class="con5">
				<a href="p_result_list_1_1.asp?start_year=<%=db_year%>&start_month=<%=db_month%>&start_day=<%=db_day%>&g_article_idx1=<%=g_article_idx1%>">
				<%=date_add%></a>
			</td>
			<% For j=1 To article_cnt %>
			<td class="con4">
				<% If article_cnt1(j)>0 Then %>
				<a href="p_result_list_1_1.asp?start_year=<%=db_year%>&start_month=<%=db_month%>&start_day=<%=db_day%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=article_idx(j)%>"><%=article_cnt1(j)%></a>
				<% Else %>
					&nbsp;
				<% End if %>
			</td>
			<% Next %>
			<Td class="con4"> 
				<% If article_sum>0 Then %>
				<a href="p_result_list_1_1.asp?start_year=<%=db_year%>&start_month=<%=db_month%>&start_day=<%=db_day%>&g_article_idx1=<%=g_article_idx1%>"><%=article_sum%>
				<% Else %>
					&nbsp;
				<% End If %>
			</td>
		</tr>          	

<% 
		article_sum=0
  next    
%>	
		<tr height=30>
			<td class="con5">
				합  계
			</td>
			<% For j=1 To article_cnt %>
			<td class="con4">
				<% If article_cnt_total(j)>0 Then %>
					<a href="p_result_list_1_2.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=article_idx(j)%>"><%=article_cnt_total(j)%></a>
				<%
				   Else 
					response.write "&nbsp;"
				   End if 
				 %>
			</td>
			<% Next %>
			<Td class="con4"> 
				<% If article_sum_total>0 Then %>
					<a href="p_result_list_1_2.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=article_idx(j)%>">
					<%=article_sum_total%></a>
				<% Else %>
					&nbsp;
				<% End If %>
			</td>
		</tr>        
		</table>
		<!------------------ 내용 종료  ------------------>
        		
	</td>
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>				
</div>
	