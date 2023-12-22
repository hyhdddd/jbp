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

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
		<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr   align='center'> 
	<td valign='top' align='center' height='400'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub13_t02.gif"></div>

		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0  id="board_table2">
		<tr>
			<th class="head" width="20">No</th>
			<th class="head" width="60">상태</th>
			<th class="head" width="450">제목</th>
			<th class="head" width="60">첨부파일</th>
			<th class="head" width="100">보낸사람</th>
			<th class="head" width="100">발송일</th>
		</tr>
  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  strSql = " select A.board_idx, A.message_idx, A.receipt_day, B.subject, B.file1, B.writeday, "
  strSql = strSql & " A.receipt_status,A.receipt_day, C.m_name "
  strSql = strSql & "	from mail_list A Left outer "
  strsql = strSql & "		join mail_message B ON A.message_idx=B.board_idx "
  strSql = strsql & "		join emp_list C ON B.send_m_id=C.m_id "
  strSql = strSql & "			where A.to_m_id='"& session_m_id &"' "
  strSql = strSql & "				and (A.message_del='X')"
  strSql = strSql & "					order by A.board_idx desc "

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
		board_idx			= objRs("board_idx")
		message_idx			= objRs("message_idx")
		subject				= objRs("subject")		
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
			filepath1	= o_code&"/mail/"&left(file1, InstrRev(file1,"/"))  
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
			<td class="con5"><%=i%></td>
			<td class="con4"><%=mail_icon%></td>
			<td class="con2">
				<a href="mail_view.asp?mail_list_idx=<%=board_idx%>&message_idx=<%=message_idx%>&message_chk=to"><%=subject%><%=new1%></td>
			<td class="con4"><%=Ext_img%></td>
			<td class="con4"><a href="mail_write.asp?emp_name=<%=m_name%>"><%=m_name%></a></td>
			<td class="con4"><%=Left(writeday,10)%></td>
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
			link_url = "mail_to_list.asp?"
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