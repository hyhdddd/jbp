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
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"--> 
  <!--#include virtual="/include/asp/admin_chk.asp"-->   
  <%
  Login_chk(Session_m_id)
  
  g_article_idx1		= WORD_CHANGE(Request("g_article_idx1"),10)
  start_date			= WORD_CHANGE(Request("start_date"),20)
  end_date				= WORD_CHANGE(Request("end_date"),20)
  sawon_chk				= WORD_CHANGE(Request("sawon_chk"),20)

  If sawon_chk="" Or sawon_chk="O" Then
	sawon_chk="O"			' ������
	sawon_txt="������"
  ElseIf sawon_chk="X" Then
	sawon_txt="�����"
  ElseIf sawon_chk="A" Then
	sawon_txt="��ü���"  
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
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub05_t03.gif"></div>

		<table width='100%' border=0 id="board_table3">
		<tr height=30> 
			<td>�˻� ���� : ���� ����� ��ġ��Ȳ (<span class='red'><%=sawon_txt%></span>)</td>
		</tr>				
		<tr height=30> 
			<td>�˻� ��ǰ : <%=article_com%></td>
		</tr>
		<tr height=30> 
			<td>�˻� �Ⱓ : (<%=start_date%> ~ <%=end_date%>)
			<a href="/result/a_result_list_5_excel.asp?g_article_idx1=<%=g_article_idx1%>&start_date=<%=start_date%>&end_date=<%=end_date%>&sawon_chk=<%=sawon_chk%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
			</td>
		</tr>
		<tr height=30>
			<td align='right'>
				<form name="frm" method="post" action="a_result_list_5.asp">
				<input type="hidden" name="start_date" value="<%=start_date%>">
				<input type="hidden" name="end_date" value="<%=end_date%>">
				<input type="hidden" name="sawon_chk" value="<%=sawon_chk%>">
				<a href="a_result_list_5.asp?g_article_idx1=<%=g_article_idx1%>&start_date=<%=start_date%>&end_date=<%=end_date%>&sawon_chk=O"><img src="/images/button/btn_sawon1.gif" align="absmiddle" border=0></a>
				<a href="a_result_list_5.asp?g_article_idx1=<%=g_article_idx1%>&start_date=<%=start_date%>&end_date=<%=end_date%>&sawon_chk=X"><img src="/images/button/btn_sawon2.gif" align="absmiddle" border=0></a>
				<a href="a_result_list_5.asp?g_article_idx1=<%=g_article_idx1%>&start_date=<%=start_date%>&end_date=<%=end_date%>&sawon_chk=A"><img src="/images/button/btn_sawon3.gif" align="absmiddle" border=0>
				<select name="g_article_idx1" style="width:120px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="submit();">
					<% 
					strSql = " select * from code_article where article_step2=0 order by article_order Asc"
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
			<td width="150" class="head"> �� �� ��</td>
			<% For i=1 To article_cnt %>
			<td width="120" class="head">
				<%=article_name(i)%> </td>
			<% Next %>
			<td width="120" class="head">�հ� </td>
		</tr>    					

<%
  strSql = "select m_name, m_id from emp_list where 1=1 "

  If sawon_chk="O" Or sawon_chk="X" then
	  strSql = strSql & "		and m_status='"& sawon_chk &"'"
  End if

  strSql = strSql & "		order by m_name asc "
  
  'Response.write strSql
  set objRs1=objCnn.Execute(strSql)
    
  Do until objRs1.EOF
	m_name		= objRs1("m_name")
    m_id		= objRs1("m_id")

	strSql_txt = " and (g_date_yuchi>='"&start_date&" 00:00:00.000') "
	strSql_txt = strSql_txt & "	and (g_date_yuchi<='"&end_date&" 23:59:59.000') "	
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
			<td class='con5'>
				<a href="a_result_list_5_1.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&m_id=<%=m_id%>&m_name=<%=m_name%>"><%=m_name%></a>
			</td>
			<% For j=1 To article_cnt %>
			<td class='con4'>
				<% If article_cnt1(j)>0 Then %>
				<a href="a_result_list_5_1.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=article_idx(j)%>&m_id=<%=m_id%>&m_name=<%=m_name%>"><%=article_cnt1(j)%></a>
				<% Else %>
					&nbsp;
				<% End if %>
			</td>
			<% Next %>
			<Td class='con4'> 
				<% If article_sum>0 Then %>
				<a href="a_result_list_5_1.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&m_id=<%=m_id%>&m_name=<%=m_name%>"><%=article_sum%>
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
				��  ��
			</td>
			<% For j=1 To article_cnt %>
			<td class='con4'>
				<% If article_cnt_total(j)>0 Then %>
				<a href="a_result_list_5_1.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=article_idx(j)%>&sawon_chk=<%=sawon_chk%>"><%=article_cnt_total(j)%></a>
				<%
				   Else 
					response.write "&nbsp;"
				   End if 
				 %>
			</td>
			<% Next %>
			<Td class='con4'> 
				<% If article_sum_total>0 Then %>
					<a href="a_result_list_5_1.asp?start_date=<%=start_date%>&end_date=<%=end_date%>&g_article_idx1=<%=g_article_idx1%>&sawon_chk=<%=sawon_chk%>"><%=article_sum_total%></a>
				<% Else %>
					&nbsp;
				<% End If %>
			</td>
		</tr>        
		</table>          										
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