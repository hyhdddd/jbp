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
  
  if ad_b_a_custom="N" then
	Alert_URL session_m_name & " ���� �� �������� ������ �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/main.asp"
	Response.end
  End if

  	today_year=year(now())
  	today_month=month(now())
  	today_day=day(now())
  	
  	calendar_year  = WORD_CHANGE(request("calendar_year"),20)
  	calendar_month = WORD_CHANGE(request("calendar_month"),20)
  	calendar_day   = WORD_CHANGE(request("calendar_day"),20)
  	
  	today=today_year&"-"&today_month&"-"&today_day
  	
  	if calendar_year="" or calendar_month="" then 
  	   calendar_year=today_year
  	   calendar_month=today_month
 	end if 		

  		
  	if calendar_month=1 or calendar_month=3 or calendar_month=5 or calendar_month=7 or calendar_month=8 or calendar_month=10 or calendar_month=12 then 
  	  	total_days=31
  	elseif calendar_month=2 then 
  	  if ((calendar_year mod 4 =0) and (calendar_year mod 100 <> 0) or (calendar_year mod 400 = 0)) then
  	    	total_days=29
  	  else
  	    	total_days=28
          end if
  	elseif calendar_month=4 or calendar_month=6 or calendar_month=9 or calendar_month=11 then
  	  	total_days=30
	end if  
  		
	date1=calendar_year&"-"&calendar_month&"-1"
	first_day=Weekday(date1)

	%>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<body>
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ ���� ����  ------------------>
		<div class="sub_title"><img src="/images/common/sub01_t06.gif"></div>
		<div class="calendar_title"><%=calendar_year%>�� <%=calendar_month%>��</div>		

		<table border=0 cellpadding="0" cellspacing="0" width="100%" id="calendar">
		<tr> 
			<td class="sunday">��</td>
			<td class="day">��</td>
			<td class="day">ȭ</td>
			<td class="day">��</td>
			<td class="day">��</td>
			<td class="day">��</td>
			<td class="day">��</td>
		</tr>
		<%		
		col=0
		response.write "<tr>"
		
		col=col+1
		for i=1 to first_day-1
		
		%> 
              				<td align="left" valign="top" class="date1">&nbsp;</td>
		<%
              col=col+1
		next
        j=0		

		for i=1 to total_days
			today_chk=calendar_year&"-"&calendar_month&"-"&i
			
			if cstr(today)=cstr(today_chk) then 
		  		td_color="gray"
			else
		  		td_color="white"  
			end If
			
			If col="1" Then
				class_name="date1"
			Else
				class_name="date2"
			End if
		%> 
					<td align="left" valign="top" bgcolor="<%=td_color%>"  class="<%=class_name%>"> 		
						<%=i%>
						<Br>
	 <%
	strSql = " SELECT A.consult_idx, A.g_goods_idx, A.consult_m_id, A.consult_type, "
	strSql = strSql & " A.consult_date, A.consult_bigo, "
	strSql = strSql & " A.consult_writeday, C.m_name, D.c_name "
	strSql = strSql & "		FROM customer_goods_consult A "
	strSql = strSql & "			 join emp_list C on A.consult_m_id=C.m_id "
	strSql = strSql & "		left join customer_goods D on A.g_goods_idx=D.g_goods_idx "
	strSql = strSql & "				where year(A.consult_date)='"&calendar_year&"' "
	strSql = strSql & "					and month(A.consult_date)='"&calendar_month&"'"
	strSql = strSql & "					and day(A.consult_date)='"&i&"'"
	strSql = strSql & "					and A.consult_date_view='Y'"
	Set objRs=objCnn.Execute(strSql)
	'response.write strSql
	
	do until objRs.eof
		consult_idx			= objRs("consult_idx")
		consult_date		= objRs("consult_date")						'�����Ͻ�
		consult_bigo		= objRs("consult_bigo")						'��㳻��
		consult_bigo		= replace(consult_bigo,chr(13) & chr(10),"<br>")
		consult_type		= objRs("consult_type")						'�������
		consult_type_txt	= fnc_consult_txt(consult_type)
		m_name				= objRs("m_name")				
		consult_writeday	= objRs("consult_writeday")
		c_name				= objRs("c_name")
		g_goods_idx			= objRs("g_goods_idx")

		if DateDiff("h",consult_writeday,Now()) < 22 then 
				new1=" <img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
		else
				new1=""	
		end If
 %> 
					<a href="/customer/a_custom_goods_regist.asp?g_goods_idx=<%=g_goods_idx%>" onmouseover='toggle_calendar(document.all.<%="HideShow1"&j%>);' onmouseout='toggle_calendar(document.all.<%="HideShow1"&j%>);'>��<%=c_name%></a><%=new1%><br>
						<div id='<%= "HideShow1"&j%>' style="visibility:hidden;position:absolute; z-index:1" class="pop"> 
							<div class="pop_head">�����</div>
							<div class="pop_con"><%=m_name%></div>
							<div class="pop_head">��������</div>
							<div class="pop_con"><%=consult_date%></div>
							<div class="pop_head">�������</div>
							<div class="pop_con"><%=consult_type_txt%></div>
							<div class="pop_head">��㳻��</div>
							<div class="pop_con"><%=consult_bigo%></div>
						</div>
                <%		
				objRs.movenext
				j=j+1
			loop
		%> 
                       </td>
		<%
			if col=7 then 
				response.write "</tr><tr>"
				col=0
			end if

			col=col+1
		next

		if col<>1 then 
			do until col=8
		%> 
              		<td  class="date2" align="left" valign="top">&nbsp;</td>
		<%
				col=col+1
			loop
		end if
		%> 
          		</table>
				<div class="calendar_month">
						[<a href='a_custom_goods_diary.asp?calendar_year=<%=calendar_year-1%>&calendar_month=<%=calendar_month%>'><%=calendar_year-1%>��</a>]         					
						[<a href='a_custom_goods_diary.asp?calendar_year=<%=calendar_year+1%>&calendar_month=<%=calendar_month%>'><%=calendar_year+1%>��</a>]
						<br><br>
						<% for i=1 to 12 %>
						[<a href='a_custom_goods_diary.asp?calendar_year=<%=calendar_year%>&calendar_month=<%=i%>'><%=i%>��</a>]
						<% next %>
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