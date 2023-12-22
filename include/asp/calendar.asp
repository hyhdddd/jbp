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
  <!--#include virtual="/include/asp/Config.asp"-->
  <%
  code1			= WORD_CHANGE(Request("code1"),20)
  code2			= WORD_CHANGE(Request("code2"),20)
  code3			= WORD_CHANGE(Request("code3"),20)
  form_name		= WORD_CHANGE(Request("form_name"),20)
  %>  

<title>:::::::Center CMS:::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="/include/css/style.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
 function select_date(year,month,day)
 {
	<%
	if code2="" or code3="" then
	%>
	opener.document.all.<%=form_name%>.<%=code1%>.value=year+"-"+month+"-"+day;
	<%
	else
	%>
	opener.document.all.<%=form_name%>.<%=code1%>.value=year;
 	opener.document.all.<%=form_name%>.<%=code2%>.value=month;
 	opener.document.all.<%=form_name%>.<%=code3%>.value=day;
	<%
	end if 
	%> 	
	if(year=="0")
	{
	<%
	if code2="" or code3="" then
	%>
	opener.document.all.<%=form_name%>.<%=code1%>.value="";
	<%
	else
	%>
	opener.document.all.<%=form_name%>.<%=code1%>.value="";
 	opener.document.all.<%=form_name%>.<%=code2%>.value="";
 	opener.document.all.<%=form_name%>.<%=code3%>.value="";
	<%
	end if 
	%>
	}
 	self.close();
 }
 
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<%
  	today_year=year(now())
  	today_month=month(now())
  	today_day=day(now())
  	
  	calendar_year  = WORD_CHANGE(request("calendar_year"),20)
  	calendar_month = WORD_CHANGE(request("calendar_month"),20)
  	calendar_day   = WORD_CHANGE(request("calendar_day"),20)
  	

	if len(today_day)=1 then
		today_day="0"&today_day
	end if
	
	if len(today_month)=1 then
		today_month="0"&today_month
	end if		

  	today = today_year&"-"&today_month&"-"&today_day


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
	<table border="0" cellpadding="0" cellspacing="1" width="100%" id="board_table2">
	<tr height=30>
		<td class="con1">
			&nbsp;&nbsp;<img src="/images/Common/pop_bullet01.gif">&nbsp;
			<img src="/images/Common/title_Calendar.gif">&nbsp;
		</td>
	</tr>
	<tr>
		<td height=30 align='center'>
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year-1%>&calendar_month=<%=calendar_month%>&calendar_day=<%=calendar_day%>"><img src='/images/button/btn_icon01.gif' border=0 align='absmiddle'></a>
			<b><%=calendar_year%>년</b>
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year+1%>&calendar_month=<%=calendar_month%>&calendar_day=<%=calendar_day%>"><img src='/images/button/btn_icon02.gif' border=0 align='absmiddle'></a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<% if CInt(calendar_month)="1" then %>
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year-1%>&calendar_month=12&calendar_day=<%=calendar_day%>">
			<% else %>						
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year%>&calendar_month=<%=calendar_month-1%>&calendar_day=<%=calendar_day%>">
			<% end if %>
			<img src='/images/button/btn_icon01.gif' border=0 align='absmiddle'></a>
			<b><%=calendar_month%>월</b>
			<% if calendar_month="12" then %>
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year+1%>&calendar_month=1&calendar_day=<%=calendar_day%>">
			<% else %>						
			<a href="calendar.asp?code1=<%=code1%>&code2=<%=code2%>&code3=<%=code3%>&form_name=<%=form_name%>&calendar_year=<%=calendar_year%>&calendar_month=<%=calendar_month+1%>&calendar_day=<%=calendar_day%>">
			<% end if %>
			
			<img src='/images/button/btn_icon02.gif' border=0 align='absmiddle'></a>
		</td>
	</tr>
	<tr>
		<td>		
			<table border=0 cellpadding="0" cellspacing="0" width="100%" id="board_table3">
			<tr> 
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
		<%		
		col=0
		response.write "<tr height=30>"
		
		col=col+1
		for i=1 to first_day-1
		
		%> 
           		<td class="table_list1" width="14%"">&nbsp;</td>
		<%
                	col=col+1
                next
                
                j=0
		
		for i=1 to total_days
			
			if len(i)=1 then
				day_i="0"&i
			else
				day_i=i
			end if
			
			if len(calendar_month)=1 then
				calendar_month="0"&calendar_month
			end if		

			today_chk=calendar_year&"-"&calendar_month&"-"&day_i
			if cstr(today)=cstr(today_chk) then 
		  		td_color="style='background-color:#FF8000;'"
			else
		  		td_color="bgcolor='white'"  
			end if
		%> 
              		<td class="table_list2" <%=td_color%>> 
			<%      
			if col=1 then 
		        	day_color_chk="#CC0033" 
			elseif col=7 then 
				day_color_chk="blue"
			else 
				day_color_chk="black"	
			end if
	
		%> 
               			<span onclick="select_date('<%=calendar_year%>','<%=calendar_month%>','<%=day_i%>');" onmouseover="this.style.cursor='hand';"><%=i%></span></td>
		<%
			if col=7 then 
				response.write "</tr><tr height=30>"
				col=0
			end if

			col=col+1
		next

		if col<>1 then 
			do until col=8
		%> 
              		<td width="14%" height="30" align="left" valign="top" bgcolor="white">&nbsp;</td>
		<%
				col=col+1
			loop
		end if
		%> 
          		<tr height=30>
					<td colspan='7' bgcolor='white' align='right'>
						<span onclick="select_date(0,0,0);" onmouseover="this.style.cursor='hand';">
						<img src="/images/button/btn_no_date.gif" border=0 align='absmiddle'> </span>
						<span onclick="select_date('<%=today_year%>','<%=today_month%>','<%=today_day%>');" onmouseover="this.style.cursor='hand';">
						<img src="/images/button/btn_today.gif" border=0 align='absmiddle'> </span>
						</td>
				</tr>
				</table>
			</td>					
    	</tr>
	</table>
				