<table width="1000" border=0>
<tr>
	<td width="490">
	<!----------------------- ����ȭ�� �系 �ڷ�� ���� ---------------->	
	<div class="title"><a href="/center/board_data1/board_list.asp?tname=board_data1"><img src="/images/common/main_board_t01.gif" alt="�系�ڷ��" /></a></div>
	<table border=0 width="490" cellspacing=1 cellpadding=0 id="board_table2">
		<colgroup><col width="340"/><col width="70"/><col width="80"/></colgroup>
		<tr>
			<th class="head" align='center'>����</th>
			<th class="head" align='center'>�����</th>
			<th class="head" align='center'>�����</th>
		</tr>
  <%  		  
   If ad_e_data1<>"N" Then 
  strSql = " select TOP 5 A.board_idx, A.board_m_id, B.m_name as board_name, A.board_title, A.board_contents, "
  strSql = strSql & " A.board_readnum, A.board_writeday "
  strSql = strSql & "	from board_data1 A  left outer join emp_list B ON A.board_m_id=B.m_id "
  strSql = strSql & "		order by A.board_idx desc"  
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
  		board_writeday	= FormatDatetime(objRs("board_writeday"),2)
  		
		if DateDiff("h",board_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if       		  		
%>
		<tr height="30">
			<td class="con1"><img src="/images/common/list01.gif" /><a href="/center/board_data1/board_content.asp?board_idx=<%=board_idx%>&tname=board_data1"><%=left(board_title,30)%> <%=new1%></a> </td>
			<td class="con4"><%=board_name%></td>
			<td class="con4"><%=board_writeday%></td>
		</tr>
  <%
	i=i+1
	objRs.movenext
	loop
  end If
  if i<6 then
  	for k=i to 5
  %>
		<tr height="30">
			<td class="con5">&nbsp;</td>
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
				<td class="con2">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
    Next 
  End If

  %>
	</table>
	</td>
	<!----------------------- ����ȭ�� �系 �ڷ�� ���� ---------------->	
	<td width="490">
	<!----------------------- ����ȭ�� �ŷ�ó �ڷ�� ���� ---------------->	
	<div class="title"><a href="/center/board_data2/board_list.asp?tname=board_data2"><img src="/images/common/main_board_t02.gif" alt="�ŷ�ó ��������" /></a></div>
	<table border=0 width="490" cellspacing=1 cellpadding=0 id="board_table2">
		<colgroup><col width="340"/><col width="70"/><col width="80"/></colgroup>
		<tr>
			<th class="head">����</th>
			<th class="head">�����</th>
			<th class="head">�����</th>
		</tr>
  <%  		  	
  If ad_e_data2<>"N" Then   
  strSql = " select TOP 5 A.board_idx, A.board_m_id, B.m_name as board_name, A.board_title, A.board_contents, "
  strSql = strSql & " A.board_readnum, A.board_writeday "
  strSql = strSql & "	from board_data2 A  left outer join emp_list B ON A.board_m_id=B.m_id "
  strSql = strSql & "		order by A.board_idx desc"  
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
  		board_writeday	= FormatDatetime(objRs("board_writeday"),2)
  		
		if DateDiff("h",board_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if       		  		
%>
		<tr height="30">
			<td class="con1"><img src="/images/common/list01.gif" /><a href="/center/board_data2/board_content.asp?board_idx=<%=board_idx%>&tname=board_data2"><%=left(board_title,30)%> <%=new1%></a> </td>
			<td class="con4"><%=board_name%></td>
			<td class="con4"><%=board_writeday%></td>
		</tr>
  <%
	i=i+1
	objRs.movenext
	loop
  end If


  if i<6 then
  	for k=i to 5
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
				<td class="con2">&nbsp;</td>
				<td class="con4">&nbsp;</td>
				<td class="con4">&nbsp;</td>
			</tr>
  <%
    Next 
  End If
  %>
	</table>
	</td>
</tr>
</table>

<!----------------------- ����ȭ�� �ŷ�ó �ڷ�� ���� ---------------->	

