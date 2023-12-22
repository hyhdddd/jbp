  <!-----------------------  일정 관리 --------------------------->
  <%
	today_year		= year(now())
  	today_month		= month(now())
  	today_day		= day(now())  	

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
  	  if ((calendar_month mod 4 =0) and (calendar_month mod 100 <> 0) or (calendar_month mod 400 = 0)) then
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
<style>

/* Main Calendar BLOCKS*/
#main_calendar {width:425px;font:11px dotum;}
#main_calendar .boxT{width:425px;background:url(/images/common/main_cal_bg.gif) repeat-y top;}
#main_calendar .boxB{width:425px;height:2px;background:url(/images/common/main_cal_bg.gif) repeat-y bottom;}
#main_calendar .title{margin:0px 0 10px 145px;text-align:left;font:12px dotum;color:#022c74;font-weight:bold;}
#main_calendar .day{width:55px;height:40px;text-align:center;padding:;background:url(/images/common/main_cal_bg_day01.gif);font:11px dotum;color:#449fd4;font-weight:bold;}
#main_calendar .sunday{width:55px;height:40px;text-align:center;padding:;background:url(/images/common/main_cal_bg_day02.gif);font:11px dotum;color:#ba44d4;font-weight:bold;}
#main_calendar .date1{font:11px dotum;padding:3px;background:#f9f9f9;border-right:1px solid #b8ddf3;border-bottom:1px solid #b8ddf3;}
#main_calendar .pop{width:380px;padding:5px;border:1px solid #ece2c3;background:#fdfdfa;}
#main_calendar .pop_head{float:left;margin-top:0px;width:70px;text-align:center;padding:3px 0 1px 0;border-right:1px solid #ece2c3;color:#966614;}
#main_calendar .pop_con{float:left;margin-top:0px;width:300px;text-align:left;padding:3px 5px 1px 5px;}

</style>
<div id="main_calendar">
	<div class="boxT">


		<div class="title" style="padding-top:15px;">
			<% if calendar_month="1" then %>
			<a href="/main.asp?calendar_year=<%=calendar_year-1%>&calendar_month=12">
			<% else %>						
			<a href="/main.asp?calendar_year=<%=calendar_year%>&calendar_month=<%=calendar_month-1%>">
			<% end if %>

			<img src='/images/button/btn_icon_left.gif' border=0 align='absmiddle'></a>

			<%=calendar_year%>년 <%=calendar_month%>월 나의 고객 일정

			<% if calendar_month="12" then %>
			<a href="/main.asp?calendar_year=<%=calendar_year+1%>&calendar_month=1">
			<% else %>						
			<a href="/main.asp?calendar_year=<%=calendar_year%>&calendar_month=<%=calendar_month+1%>">
			<% end if %>
			
			<img src='/images/button/btn_icon_right.gif' border=0 align='absmiddle'></a>
		
		</div>
			
			
			
			<table width="392" border="0" align="center" cellpadding="0" cellspacing="1">								
			<tr>
				<td class="sunday">일</td>
				<td class="day">월</td>
				<td class="day">화</td>
				<td class="day">수</td>
				<td class="day">목</td>
				<td class="day">금</td>
				<td class="day">토</td>								
			</tr>


			
		<%		
		col=0
		response.write "<tr height=50>"
		
		col=col+1

		for i=1 to first_day-1
		
		%> 
			<td width="14%" align="left" valign="top" bgcolor="white" class="date1">&nbsp;</td>
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
			end if
		%> 
			<td width="14%" align="left" valign="top" bgcolor="<%=td_color%>"  class="date1"> 
                <% 		            
		            
			if col=1 then 
		        	day_color_chk="#CC0033" 
			elseif col=7 then 
				day_color_chk="blue"
			else 
				day_color_chk="black"	
			end if
		%> 
            <%=i%><Br>
  <%
		If ad_b_p_custom<>"N" Then
			diary_url = "/customer/p_custom_goods_regist.asp"		
		End If

		If ad_b_y_custom<>"N" Then
			diary_url = "/customer/y_custom_goods_regist.asp"		
		End If

		If ad_b_g_custom<>"N" Then
			diary_url = "/customer/g_custom_goods_regist.asp"		
		End If

		If ad_b_m_custom<>"N" Then
			diary_url = "/customer/m_custom_goods_regist.asp"		
		End If

		If ad_b_a_custom<>"N" Then
			diary_url = "/customer/a_custom_goods_regist.asp"		
		End If

		
		strSql = " SELECT A.consult_idx, A.g_goods_idx, A.consult_m_id, A.consult_type, "
		strSql = strSql & " A.consult_date, A.consult_bigo, A.consult_writeday, "
		strSql = strSql & " C.m_name as emp_name , D.c_name "
		strSql = strSql & "		FROM customer_goods_consult A "
		strSql = strSql & "			join emp_list C on A.consult_m_id=C.m_id "
		strSql = strSql & "			join customer_goods D on A.g_goods_idx=D.g_goods_idx "
		strSql = strSql & "				where A.consult_m_id='"&session_m_id&"'"
		strSQl = strSql & "					and year(A.consult_date)='"&calendar_year&"' "
		strSql = strSql & "					and month(A.consult_date)='"&calendar_month&"'"
		strSql = strSql & "					and day(A.consult_date)='"&i&"'"
		strSql = strSql & "					and A.consult_date_view='Y'"
		Set objRs=objCnn.Execute(strSql)
		'response.write strSql
		
		do until objRs.eof
			consult_idx			= objRs("consult_idx")
			consult_date		= objRs("consult_date")				'추진일시
			consult_bigo		= objRs("consult_bigo")				'상담내용
			consult_bigo = replace(consult_bigo,chr(13) & chr(10),"<br>")					 		

			consult_type		= objRs("consult_type")				'상담종류
			consult_type_txt	= fnc_consult_txt(consult_type)

			emp_name			= objRs("emp_name")				
			consult_writeday	= objRs("consult_writeday")
			c_name				= objRs("c_name")
			g_goods_idx			= objRs("g_goods_idx")
	
			if DateDiff("h",writeday,Now()) < 22 then 
					new1=" <img src='/images/new.gif' align='absmiddle' border=0>"
			else
					new1=""	
			end if
		 %> 
				<a href="<%=diary_url%>?g_goods_idx=<%=g_goods_idx%>" onmouseover="toggle_calendar(document.all.<%="HideShow1"&j%>);" onmouseout="toggle_calendar(document.all.<%="HideShow1"&j%>);">
				<img src="/images/Common/icon_new.gif" border=0></a>
				<div id="<%= "HideShow1"&j%>" style="visibility:hidden;position:absolute; z-index:1" class="pop"> 
					<div class="pop_head">상담 사원</div>
					<div class="pop_con"><%=emp_name%></div>
					<div class="clear"></div>
					<div class="pop_head">고 &nbsp;객 &nbsp;명</div>
					<div class="pop_con"><%=c_name%></div>
					<div class="clear"></div>
					<div class="pop_head">추진 일정</div>
					<div class="pop_con"><%=consult_date%></div>
					<div class="clear"></div>
					<div class="pop_head">상담 종류</div>
					<div class="pop_con"><%=consult_type_txt%></div>
					<div class="clear"></div>
					<div class="pop_head">상담 내용</div>
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
				response.write "	</tr><tr height=50>"
				col=0
			end if

			col=col+1
		next

		if col<>1 then 
			do until col=8
		%> 
              				<td width="14%" align="left" valign="top" bgcolor="white" class="date1">&nbsp;</td>
		<%
				col=col+1
			loop
		end if
		%> 
		</tr>
		</table>
				

	</div>
	<div class="boxB"></div>
</div>
<!----------------------- 일정관리 종료--------------------->