<br>
<div id="calendar">
<table width="1000" border=0>
<tr>
	<td width="490" align='center' valign='top'>
		<!----------------------- 나의 상담 내역 ---------------->	
		<div class="title"><img src="/images/common/main_consult_t01.gif" border=0></div>
		<table border=0 cellspacing=1 cellpadding=0 width="490" id="board_table2">
		<col width="70"/><col width="280"/><col width="70"/><col width="70"/>
		<tr>             
			<th class="head">고객명</th>
			<th class="head">상담내용</th>
			<th class="head">상담상태</th>
			<th class="head">상담일</th>
		</tr>

	 
	<%
		If ad_b_p_custom<>"N" Then
			url_link = "/customer/p_custom_goods_regist.asp"		
		End If

		If ad_b_y_custom<>"N" Then
			url_link = "/customer/y_custom_goods_regist.asp"		
		End If

		If ad_b_g_custom<>"N" Then
			url_link = "/customer/g_custom_goods_regist.asp"		
		End If

		If ad_b_m_custom<>"N" Then
			url_link = "/customer/m_custom_goods_regist.asp"		
		End If

		If ad_b_a_custom<>"N" Then
			url_link = "/customer/a_custom_goods_regist.asp"		
		End If


	  strSql = " select top 5 A.consult_idx, A.g_goods_idx, A.consult_type, "
	  strSql = strSql & " A.consult_bigo, A.consult_date, A.consult_writeday , B.m_name , C.c_name "
	  strSql = strSql & "	from customer_goods_consult A left outer "
	  strSql = stRSql & "		join emp_list B on A.consult_m_id=B.m_id "
	  strSql = strSql & "		join customer_goods C ON A.g_goods_idx=C.g_goods_idx "
	  strSql = strSql & "			Where (A.consult_m_id='"&session_m_id&"') "
	  strsql = strSql & "			order by A.consult_idx desc"
	  set objRs=objCnn.Execute(strSql)
	  i=1
	  Do until objRs.eof
		consult_idx			= objRs("consult_idx")		
		g_goods_idx			= objRs("g_goods_idx")
		consult_type		= objRs("consult_type")
		consult_type_txt	= fnc_consult_txt(consult_type)

		consult_bigo		= objRs("consult_bigo")
		consult_writeday	= objRs("consult_writeday")
		m_name				= objRs("m_name")
		c_name				= objRs("c_name")
		consult_date		= objRs("consult_date")
		
		if DateDiff("h",consult_writeday,Now()) < 22 then 
				new1=" <img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
			else
				new1="&nbsp;"	
		end if	
		
	%>		
		<tr height=30>             
			<td class="con5">
				<a href="<%=url_link%>?g_goods_idx=<%=g_goods_idx%>" onmouseover="toggle_calendar(document.all.<%="HideShow3"&i%>);" onmouseout="toggle_calendar(document.all.<%="HideShow3"&i%>);"><%=c_name%></a></td>
			<td class="con2">
				<a href="<%=url_link%>?g_goods_idx=<%=g_goods_idx%>" onmouseover="toggle_calendar(document.all.<%="HideShow3"&i%>);" onmouseout="toggle_calendar(document.all.<%="HideShow3"&i%>);"><%=left(consult_bigo,23)%><%=new1%></a>
				<%				
					consult_bigo		= replace(consult_bigo,chr(13) & chr(10),"<br>")
				%>

				<div id="<%="HideShow3"&i%>" style="visibility:hidden;position:absolute; z-index:1" class="pop"> 
					<div class="pop_head">상담 사원</div>
					<div class="pop_con"><%=m_name%></div>
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
			</td>			
			<td class="con4"><%=consult_type_txt%>&nbsp;</td>
			<td class="con4"><%=left(consult_writeday,10)%></td>
		</tr>
			  
	<% 
			objRs.MoveNext
			i=i+1 
		loop
		
		
	  if i<6 then
		for k=i to 5
	%>
		<tr height="30">
			<td class="con5">&nbsp;</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">&nbsp;</td>
		</tr>
	  <%
		i=i+1
		Next
	  End if
	%>		  
		</table>
		<!----------------------- 나의 상담내역 종료 ---------------->	
	</td>
	<td width="490" align='right' valign='top'>
		<!----------------------- 나의 받은 메일 ---------------->	
		<div class="title"><a href="/center_mail/mail_to_list.asp"><img src="/images/common/main_mail_t01.gif" border=0></a></div>
		<table border=0 width="490" cellspacing=1 cellpadding=0 id="board_table2">
			<colgroup><col width="40"/><col width="300"/><col width="70"/><col width="80"/></colgroup>
			<tr>
				<th class="head">상태</th>
				<th class="head">제목</th>
				<th class="head">보낸사람</th>
				<th class="head">받은날짜</th>
			</tr>
  <%  		  	   

  strSql = " select Top 5 A.board_idx, A.message_idx, A.receipt_day, B.subject, B.file1, B.writeday, "
  strSql = strSql & " A.receipt_status,A.receipt_day, C.m_name "
  strSql = strSql & "	from mail_list A Left outer "
  strsql = strSql & "		join mail_message B ON A.message_idx=B.board_idx "
  strSql = strsql & "		join emp_list C ON B.send_m_id=C.m_id "
  strSql = strSql & "			where A.to_m_id='"& session_m_id &"' "
  strSql = strSql & "				and (A.message_del='X')"
  strSql = strSql & "					order by A.board_idx desc "
  set objRs=objCnn.Execute(strSql)
  i=1			
  if objRs.BOF or objRs.EOF then
  else	  				
  	do until objRs.eof
		board_idx			= objRs("board_idx")
		message_idx			= objRs("message_idx")
		subject				= Left(objRs("subject"),24)
		file1				= objRs("file1")		
		m_name				= objRs("m_name")	
		receipt_status		= objRs("receipt_status")	
		writeday			= objRs("writeday")
		receipt_day			= objRs("receipt_day")

		if receipt_status = "O" then
			mail_icon="<img src='/images/common/mail_read_yes.gif' alt='메일 읽음 ("&receipt_day&")'>"
		else
			mail_icon="<img src='/images/common/mail_read_no.gif' alt='메일 읽지 않음'>"
		end if		

  		'파일명에서 확장자 뽑기
  		if len(file1)>0 then
			filepath1	= "/file_data/"&o_code&"/mail/"&left(file1, InstrRev(file1,"/"))  
  	    	filename1	= mid(file1, InstrRev(file1,"/")+1)  
  			strExt		= ucase(Mid(file1,Instr(file1,".")+1))
			Ext_img		= file_strExt_chk(strExt)
			Ext_img		= "<img src='"& Ext_img &"' border='0'>"
		Else
			Ext_img		= "&nbsp;"
  		end if


		if DateDiff("h",writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if
%>
		<tr height=30> 
				<td class="con5"><%=mail_icon%></td>
				<td class="con2">&nbsp;
					<a href="/center_mail/mail_view.asp?mail_list_idx=<%=board_idx%>&message_idx=<%=message_idx%>&message_chk=to"><%=subject%><%=new1%></td>
				<td class="con4"><a href="/center_mail/mail_write.asp?emp_name=<%=m_name%>"><%=m_name%></a></td>
				<td class="con4"><%=Left(writeday,10)%></td>
		</tr>	
  <%
	i=i+1
	objRs.movenext
	loop
  end If
  if i<5 then
  	for k=i to 5
  %>
		<tr height="30">
			<td class="con5">&nbsp;</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">&nbsp;</td>
			<td class="con4">&nbsp;</td>
		</tr>
  <%
	next
  end if	
  %>
		</table>
		<!----------------------- 나의 받은 메일 종료 ---------------->	
	</td>
</tr>
</table>