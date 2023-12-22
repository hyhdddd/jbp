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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)

  mail_list_idx = WORD_CHANGE(request("mail_list_idx"),20)
  message_idx   = WORD_CHANGE(request("message_idx"),20)
  message_chk	= WORD_CHANGE(request("message_chk"),20)
  
  strSql = " select * from mail_list where board_idx="&mail_list_idx
  set objRs=objCnn.Execute(strSql)
  
  if objRs.bof or objRs.eof Then
	Alert_back " 잘못된 접근입니다."
	Response.End 
  else
  	message_idx		= objRs("message_idx")
  	to_m_id			= objRs("to_m_id")
  	receipt_status	= objRs("receipt_status")
  	
  	'받은메일 내용보기이면 수신 처리 합니다.(받은메일, 미수신 상태)
  	if mail_list_idx<>"" and message_chk="to" and receipt_status="X" then
		strSql = "update mail_list set receipt_status='O', receipt_day=getdate() where board_idx="&mail_list_idx
		set objRs0=objCnn.Execute(strSql)
  	end if
  	
  	strSql = " select * from mail_message where board_idx="&message_idx
  	set objRs1=objCnn.Execute(strSql)
  	
  	send_m_id		= objRs1("send_m_id")
  	subject			= objRs1("subject")
  	contents		= objRs1("contents")
  	filename1		= objRs1("file1")
  	writeday		= objRs1("writeday")	'보낸날짜

	if len(filename1)>0 then
		filepath1=o_code&"/mail"&left(filename1, InstrRev(filename1,"/"))  
   		filename1=mid(filename1, InstrRev(filename1,"/")+1)  
	end if
  	
  	strSql = " select A.m_name, A.m_id, B.duty_name , D.dealer_name , E.position_name     " 
	strSql = strSql & "	from emp_list A left outer "
	strSql = strSql & "		Join code_duty B ON A.m_duty=B.duty_code "
	strSql = strSql & "		left join dealer_info D ON A.m_dealer_code=D.dealer_code " 
	strSql = strSql & "		left Join code_position E ON A.m_position=E.position_code "
	strSql = strSql & "			where (A.m_id='"&send_m_id&"') "
  	set objRs2=objCnn.Execute(strSql)
	send_m_id			= objRs2("m_id")
  	send_name_emp		= objRs2("m_name")
  	send_dealer_name	= objRs2("dealer_name")
  	send_duty_name		= objRs2("duty_name")
  	send_position_name	= objRs2("position_name")
  	
  end if
  %>
  <meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_editorarea.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_internal.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_showtableborders_gecko.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body>
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
		<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr height="400"> 
	<td valign='top'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub13_t05.gif"></div>
				
		<TABLE width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">
		<tr>  
			<th width="150">보낸이</th>
			<td width="650">
				&nbsp;<a href="mail_write.asp?emp_name=<%=send_name_emp%>"><%=send_name_emp%> (<%=send_m_id%>) 님 <%=send_duty_name%>&nbsp; <%=send_position_name%>&nbsp;(<%=send_dealer_name%>)</a></td>
		</tr>
<% If message_chk="send" Then %>
		<tr height="30">	
			<th>수신인</th>
			<td>
				<table width=100% border=0 cellspacing=0 cellpadding=0 id="board_table1">      							
			<%

  	strSql = " select B.m_name, A.to_m_id, C.duty_name , D.dealer_name , E.position_name     " 
	strSql = strSql & "	from mail_list A left outer "
	strSql = strSql & "		Join emp_list B ON A.to_m_id=B.m_id "
	strSql = strSql & "		left Join code_duty C ON (B.m_duty=C.duty_code) "
	strSql = strSql & "	   left join dealer_info D ON B.m_dealer_code=D.dealer_code " 
	strSql = strSql & "		left Join code_position E ON B.m_position=E.position_code "
	strSql = strSql & "			where (A.message_idx="&message_idx&") "
  	set objRs1=objCnn.Execute(strSql)


	if objRs1.eof or objRs1.bof then
	else
		do until objRs1.eof
			to_m_id				= objRs1("to_m_id")
		  	to_name_emp			= objRs1("m_name")
		  	to_dealer_name		= objRs1("dealer_name")
		  	to_duty_name		= objRs1("duty_name")
		  	to_position_name	= objRs1("position_name")
	%>
					<tr height=30>
						<td style="text-align:left;">&nbsp;<a href="mail_write.asp?emp_name=<%=to_name_emp%>"><%=to_name_emp%> (<%=to_m_id%>) 님  <%=duty_name%>&nbsp; <%=to_position_name%>&nbsp;(<%=to_dealer_name%>)</a>
						</td>
					</tr>			
													
	<%
			objRs1.movenext
		loop		
	end if	
	objRs1.close
	%>

	
			
						</table>
					</td>
				</tr>  					
  <% ElseIf message_chk="to" then %>
				<tr>	
					<th>수신인</th>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0 id="board_table1"> 					
	<% 	
  	strSql = " select B.m_name, A.to_m_id, C.duty_name , D.dealer_name , E.position_name     " 
	strSql = strSql & "	from mail_list A left outer "
	strSql = strSql & "		Join emp_list B ON A.to_m_id=B.m_id "
	strSql = strSql & "		left Join code_duty C ON B.m_duty=C.duty_code "
	strSql = strSql & "		left join dealer_info  D ON B.m_dealer_code=D.dealer_code "  
	strSql = strSql & "		left Join code_position E ON B.m_position=E.position_code "
	strSql = strSql & "			where (A.message_idx="&message_idx&") and A.to_m_id='"& session_m_id &"'"
  	set objRs2=objCnn.Execute(strSql)

	to_m_id				= objRs2("to_m_id")
  	to_name_emp			= objRs2("m_name")
  	to_dealer_name		= objRs2("dealer_name")
  	to_duty_name		= objRs2("duty_name")
  	to_position_name	= objRs2("position_name")
	%>
						<tr height=25>
							<td style="text-align:left;">&nbsp;<a href="mail_write.asp?emp_name=<%=to_name_emp%>"><%=to_name_emp%> (<%=to_m_id%>) 님  <%=to_duty_name%>&nbsp; <%=to_position_name%>&nbsp;(<%=to_dealer_name%>)</a>
							</td>
						</tr>														
						</table>
					</td>
				</tr>  					
  <% End If %>	      
				<tr>	
					<th> 제 목 </th>
					<td>&nbsp;&nbsp;<%=subject%></td>
				</tr>      					
				<tr height=200>	
					<td colspan='2'>
						<table width=95% border=0 cellspacing=0 cellpadding=0 id="board_table3" align='center'>
						<tr height=200>
							<Td valign='top' >
								<span class="description1"><%=replace(contents,"<br />","<br>")%></span>
							</td>
						</tr>
						</table>
					</td>		
				</tr>	
				<tr>	
					<th> 첨부파일 </th>
					<td>
						&nbsp;<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>">
						<%=filename1%></a>
					</td>
				</tr>
				</table>	
				<div class="button">	
					<% 
						if message_chk="send" then 
							list_url="mail_send_list.asp"
						elseif message_chk="send_search" then 
							list_url="mail_send_list_search.asp"
						elseif message_chk="to" then
							list_url="mail_to_list.asp"
						elseif message_chk="del" then
							list_url="mail_del_list.asp"
						end if
					%>        							

					<a href="<%=list_url%>"><img src="/images/button/btn_list.gif"  border="0"></a> 
					<span onmouseover="this.style.cursor='hand';" onClick="Confirm('메일을 삭제하시겠습니까?','mail_del_ok.asp?mail_list_idx=<%=mail_list_idx%>&message_idx=<%=message_idx%>&message_chk=<%=message_chk%>');"> <img src="/images/button/btn_delete.gif" border=0></span>
					<a href="mail_write.asp?message_idx=<%=message_idx%>"><img src="/images/button/btn_mail_backsend.gif" border=0></a>
					</td>
				</tr>
				
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