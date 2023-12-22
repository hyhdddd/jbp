<!----------------------- 사내 공지사항 시작 ---------------->	
<div id="main_notice">
	<div class="boxT">
						
		<table width="530" border=0 align="center" cellpadding=0 cellspacing=1 id="board_table1">
			<colgroup><col width="347"><col width="70" /><col width="80" /></colgroup>
			<tr>
				<td colspan='3'>
					<a href="/center/board_notice1/board_list.asp?tname=board_notice1"><img src="/images/common/main_notice_t01.gif" alt="사내공지사항" /></a></td>
			</tr>
			
  <%  	
  If ad_e_notice1<>"N" Then 
  strSql = " select top 5 A.board_idx, A.board_m_id, B.m_name as board_name, A.board_title, A.board_contents, A.board_notice_yn, "
  strSql = strSql & " A.board_readnum, A.board_writeday "
  strSql = strSql & "	from board_notice1 A  left outer join emp_list B ON A.board_m_id=B.m_id "
  strSql = strSql & "		order by A.board_notice_YN desc, A.board_idx desc"  
  set objRs=objCnn.Execute(strSql)
  i=1			
  if objRs.BOF or objRs.EOF then
  else	  				
  	do until objRs.eof
		board_idx		= objRs("board_idx")
  		board_m_id		= objRs("board_m_id")
  		board_name		= objRs("board_name")
  		board_title		= objRs("board_title")
  		board_contents	= objRs("board_contents")
  		board_readnum	= objRs("board_readnum")
  		board_writeday	= objRs("board_writeday")
		board_notice_yn	= objRs("board_notice_yn")

		If board_notice_yn="Y" then
			board_notice_chk	= "<img src='/images/common/list01.gif' align='absmiddle' /><img src='/images/button/btn_notice_top.gif' align='absmiddle' border=0>&nbsp;"
			bg_txt = "style='background-color:#F3F781'"
		Else
			board_notice_chk	= "<img src='/images/common/list01.gif' align='absmiddle' />"
			bg_txt = " "
  		End If

  		
		if DateDiff("h",board_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if       		  		
%>
			<tr height="30">
				<td class="con1"><%=board_notice_chk%><a href="/center/board_notice1/board_content.asp?board_idx=<%=board_idx%>&tname=board_notice1"><%=left(board_title,38)%> <%=new1%></a> </td>
				<td class="con4"><%=board_name%></td>
				<td class="con4"><%=Left(board_writeday,10)%></td>
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
				<td class="con1">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
	next
  end If
  
  Else
	For i=1 To 5
  %>
  			<tr height="30">
				<td class="con1">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
    Next 
  End If
  
  %>
	  </table>
		<!----------------------- 사내 공지사항 종료 ---------------->	
		<div style="margin-top:5px;"></div>
		<!----------------------- 거래처 공지사항 시작 ---------------->	
		<table width="530" border=0 align="center" cellpadding=0 cellspacing=0 id="board_table1">
			<colgroup><col width="347"><col width="70" /><col width="80" /></colgroup>
			<tr>
				<td colspan='3'>
					<a href="/center/board_notice2/board_list.asp?tname=board_notice2"><img src="/images/common/main_notice_t02.gif" alt="거래처 자료실" /></a></td>
			</tr>
  <%  		 
  If ad_e_notice2<>"N" Then 
  
  strSql = " select top 5 A.board_idx, A.board_m_id, B.m_name as board_name, A.board_title, A.board_contents, "
  strSql = strSql & " A.board_notice_yn, A.board_readnum, A.board_writeday "
  strSql = strSql & "	from board_notice2 A  left outer join emp_list B ON A.board_m_id=B.m_id "
  strSql = strSql & "		order by A.board_notice_YN desc, A.board_idx desc"  
  set objRs=objCnn.Execute(strSql)
  i=1			
  if objRs.BOF or objRs.EOF then
  else	  				
  	do until objRs.eof
		board_idx		= objRs("board_idx")
  		board_m_id		= objRs("board_m_id")
  		board_name		= objRs("board_name")
  		board_title		= objRs("board_title")
  		board_contents	= objRs("board_contents")
  		board_readnum	= objRs("board_readnum")
  		board_writeday	= objRs("board_writeday")
		board_notice_yn	= objRs("board_notice_yn")

		If board_notice_yn="Y" then
			board_notice_chk	= "<img src='/images/common/list01.gif' align='absmiddle' /><img src='/images/button/btn_notice_top.gif' align='absmiddle' border=0>&nbsp;"
			bg_txt = "style='background-color:#F3F781'"
		Else
			board_notice_chk	= "<img src='/images/common/list01.gif' align='absmiddle' />"
			bg_txt = " "
  		End If
  		
		if DateDiff("h",board_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if       		  		
%>
			<tr height="30">
				<td class="con1"><%=board_notice_chk%><a href="/center/board_notice2/board_content.asp?board_idx=<%=board_idx%>&tname=board_notice2"><%=left(board_title,38)%> <%=new1%></a> </td>
				<td class="con4"><%=board_name%></td>
				<td class="con4"><%=Left(board_writeday,10)%></td>
			</tr>
  <%
	i=i+1
	objRs.movenext
	loop
  end If

  if i<5 then
  	for k=i To 5
  %>
			<tr height="30">
				<td class="con1">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
	next
  end if	
  
  Else
	For i=1 To 5
  %>
  			<tr height="30">
				<td class="con1">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
    Next 
  End If
  %>
	  </table>
<!----------------------- 거래처 공지사항 종료 ---------------->						 

	</div>
	<div class="boxB"></div>
</div>