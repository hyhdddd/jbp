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
  s_date_start		= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end		= WORD_CHANGE(Request("s_date_end"),20)
  
  s_link_txt ="search_key="&search_key&"&search_txt="&search_txt&"&s_date_start="&s_date_start&"&s_date_end="&s_date_end
  %>
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

		<form action="mail_send_list_search.asp" name="frm_custom_regist" METHOD="POST"> 

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0  id="board_table2">
		<tr>
			<td colspan='6' style="text-align:left;border-style:none;">
				<select name="Search_key">
				<option value="subject"> 제목+내용 </option>
				<option value="m_name" > 받는사람 </option>
				</select>

				보낸날짜			
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~<input type="text" name="s_date_end" size='9' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><img src="/images/button/btn_search01.gif" onClick="submit();" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>
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
  strSql = strSql & "	join mail_list B ON A.board_idx=B.message_idx "
  strSql = strSql & "	left join emp_list C ON B.to_m_id=C.m_id "
  strSql = strSql & " 		where A.message_del='X' and A.send_m_id='"&session_m_id&"' "

  If search_txt<>"" Then
	If Search_key="subject" Then
		strSql = strSql & "	and (A.subject like '%"&search_txt&"%' or A.contents like '"&search_txt&"')"
	End if
	If Search_key="m_name" Then
		strSql = strSql & "	and (C.m_name like '%"&search_txt&"%')"
	End if
  End If
  
  If s_date_start<>"" And s_date_end<>"" Then 
  strSql = strSql & "		and (A.writeday>='"&s_date_start&" 00:00:00') "
  strSql = strsql & "		and (A.writeday<='"&s_date_end&" 23:59:59') "		
  End if

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
				<a href="mail_view.asp?mail_list_idx=<%=mail_list_idx%>&message_idx=<%=message_idx%>&message_chk=send_search"><%=subject%></td>
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
		</form>
		
		<div class="pagelist">
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "mail_send_list_search.asp?"&s_link_txt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b>
			<span class='blue'>[ <%=recordcount%> 건 ] </span>
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