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
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_gaetong_code	= WORD_CHANGE(Request("s_gaetong_code"),20)
  
   
  %>
<!DOCTYPE html>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
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
	<td width="100%" valign='top'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub13_t03.gif"></div>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0  id="board_table2">
		<tr height='30'>
			<td colspan='4' class='con3'><a href="mail_send_list_search.asp"><b>보낸메일 검색하기</b></a>&nbsp;</td>
		</tr>
		<tr>
			<th class="head" width="50">No</th>
			<th class="head" width="500">제목</th>
			<th class="head" width="100">받는사람</th>
			<th class="head" width="150">발송일</th>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " Select A.board_idx as message_idx, A.subject, A.writeday, B.board_idx as mail_list_idx, C.m_name from mail_message A left outer "
  strSql = strSql & "	join (select message_idx,min(board_idx) as board_idx, min(to_m_id)as to_m_id from mail_list group by message_idx) B ON A.board_idx=B.message_idx "
  strSql = strSql & "	left join emp_list C ON B.to_m_id=C.m_id "
  strSql = strSql & " 		where A.message_del='X' and A.send_m_id='"&session_m_id&"' "
  strSql = strSql & "			order by A.board_idx Desc "


  'Response.write strSql&"<br>"
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
	
  recordcount	= objRs.recordcount
	
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height="30">
			<td class="con5" colspan='6'> 받은 메일이 없습니다. </td>
		</tr>
  <%
  else
	i=1

    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount  	
  		 
	i = 1
	Do until objRs.EOF Or i>objRs.PageSize 
		message_idx			= objRs("message_idx")
		subject				= objRs("subject")		' 유치자 아이디
		writeday			= fnc_date_change(objRs("writeday"))		' 유치일
		
		mail_list_idx		= objRs("mail_list_idx")
		m_name				= objRs("m_name")

		
	%>
		<tr height=30> 
			<td class="con5"><%=i%></td>
			<td class="con2">
				<a href="mail_view.asp?mail_list_idx=<%=mail_list_idx%>&message_idx=<%=message_idx%>&message_chk=send"><%=subject%></td>
			<td class="con4"><a href="mail_write.asp?emp_name=<%=m_name%>"><%=m_name%></a></td>
			<td class="con4"><%=writeday%></td>
		</tr>					
	<%
		i=i+1
		objRs.movenext
	Loop
  End If
  
  objRs.close
%>		  
		</TABLE>
	
		<div class="pagelist">
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "mail_send_list.asp?"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>    
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