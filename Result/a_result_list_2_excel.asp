  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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

  filename="��ü��������_���ں� ������Ȳ(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename
  
  g_article_idx1		= WORD_CHANGE(Request("g_article_idx1"),10)
  start_date			= WORD_CHANGE(Request("start_date"),20)
  end_date				= WORD_CHANGE(Request("end_date"),20)

  between_date_cnt	= dateDiff("d",start_date,end_date)  

  strsql = " select article_name from code_article  where article_idx="&g_article_idx1
  Set objRs=objCnn.Execute(strSql)

  article_com		= objRs(0)

  strsql = " select count(*) from code_article where article_step1="& g_article_idx1 &" and article_step2>0"
  Set objRs=objCnn.Execute(strSql)

  article_cnt		= objRs(0)

  strsql = " select * from code_article where article_step1="& g_article_idx1 &" and article_step2>0 "
  strSql = strSql & " order by article_step1 asc, article_step2 asc "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	Alert_back "��ǰ �ڵ尡 �������� �ʾ� �˻��ϽǼ� �����ϴ�."
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
	td	{font: 9pt ����,GulimChe,Gulim;color: black;}
	
	.table_header 	{
		font-family: "����";
		padding: 5px 0px 3px 0px;
		background-color:#000000;
		color: white}
	.table_list1 { 
		font-family: "����";
		padding: 3px 1px 0px 3px; 
		font-size:12px ; 
		border-left: 1px solid #C7C7C7; 
		border-bottom: 1px solid #C7C7C7; 
		border-right: 1px solid #C7C7C7}
	.table_list2 { 
		font-family: "����";
		padding: 3px 1px 0px 3px; 
		font-size:12px ; 
		border-bottom: 1px solid #C7C7C7; 
		border-right: 1px solid #C7C7C7}
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">


		<table width='100%' border=0  id="board_table3">
		<tr height="30"> 
			<td>�˻� ���� : ��ġ���ں� ��ü ������Ȳ</td>
		</tr>				
		<tr height="30"> 
			<td>�˻� ��ǰ : <%=article_com%></td>
		</tr>
		<tr height="30"> 
			<td>�˻� �Ⱓ : (<%=start_date%> ~ <%=end_date%>)</td>
		</tr>		
		</table>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0>
		<tr height=30>                     
			<td width="150" class="table_header"> �� ¥ </font></td>
			<% For i=1 To article_cnt %>
			<td width="120" class="table_header"> <%=article_name(i)%> </td>
			<% Next %>
			<td width="120" class="table_header">�հ� </td>
		</tr>    					

<%
    for i=0 to between_date_cnt
	date_add	= DateAdd("d",i,start_date)
	db_year		= year(date_add)
	db_month	= month(date_add)
	db_day		= day(date_add)	

	strSql_txt = " and (year(g_date_gaetong)='"&db_year&"' and month(g_date_gaetong)='"&db_month&"' "
	strSql_txt = strSql_txt & " and day(g_date_gaetong)='"&db_day&"')  "

	strSql = " select * from "

	For j=1 To article_cnt
	strSql = strSql & "(select count(*) as cnt from customer_goods where "
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
			<td class="table_list1"><%=date_add%></td>
			<% For j=1 To article_cnt %>
			<td class="table_list2"><%=article_cnt1(j)%></td>
			<% Next %>
			<Td class="table_list2"><%=article_sum%></td>
		</tr>          	

<% 
		article_sum=0
  next    
%>	
		<tr height=30>
			<td class="table_list1">
				��  ��
			</td>
			<% For j=1 To article_cnt %>
			<td class="table_list2"><%=article_cnt_total(j)%></td>
			<% Next %>
			<Td class="table_list2"><%=article_sum_total%></td>
		</tr>        
		</table> 				
 	