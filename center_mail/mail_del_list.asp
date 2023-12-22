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
  %>
<!DOCTYPE html>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
	function toggle_img(src)
	{
		allchecked=document.getElementById('allcheck').value;
		var form=document.all.mail_del_frm.elements;
		
		if(allchecked==0)
		{
			document.getElementById('allcheck').value="1";
			document.getElementById('toggle_img1').src = "/images/button/btn_allselect_cancel.gif";
			
			for( var i=0; i<form.length; i++) 
        		{
                		var ele = form.elements[i];
                		if(ele.name == 'mail_del')
                        		ele.checked = true;
        		}	

		}	
		else
		{
			document.getElementById('allcheck').value="0";
			document.getElementById('toggle_img1').src = "/images/button/btn_allselect.gif";

			for( var i=0; i<form.length; i++) 
        		{
                		var ele = form.elements[i];
                		if(ele.name == 'mail_del')
                        		ele.checked = false;
        		}	

		}
	}	
	
	function mail_del_submit()
	{
		var form=document.all.mail_del_frm.elements;
		
		mail_del_chk="";
		for( var i=0; i<form.length; i++) 
        	{
                	var ele = form.elements[i];
                	if(ele.name == 'mail_del')
                	{
                		if(ele.checked == true)
                			mail_del_chk="O";
                	}		
        	}	
        		
        	if(mail_del_chk=="O")
        	{
        		var ans=confirm(" 선택한 메일을 삭제하시겠습니까?");
        		if(ans==true)
        		{
        			document.all.mail_del_frm.submit();
        		}
        		else
        		{
        			return;
        		}	        		
        	}
        	else
        	{
        		alert(" 삭제할 메일을 하나이상 체크하세요!");
        		return;
        	}	
	}
	
-->
</script>
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
		<div class="sub_title"><img src="/images/common/sub13_t04.gif"></div>

		<form id="mail_del_frm" name="mail_del_frm" action="mail_del_list_ok.asp" method="form">
		<input type="hidden" name="allcheck" value="0">
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>  
			<td class="Head" width="50">번호</td>
			<td class="Head" width="100">선택</td>
			<td class="Head" width="550">제목</td>
			<td class="Head" width="100">파일수</td>
			<td class="Head" width="100">보낸사람</td>
			<td class="Head" width="100">발송일</td>
		</tr>
<%
  if request("page")="" then
	page=1
  else 
      	page=request("page")
  end if
      
  if request("block")="" then
      	nowblock=0
  else
      	nowblock=request("block")
  end if  
   
  strSql = " select A.board_idx,A.message_idx,B.subject,B.file1, B.writeday,"
  strSql = strSql & " A.receipt_status, C.m_name "
  strSql = strSql & "	from mail_list A Left outer "
  strSql = strSql & "		join mail_message B ON A.message_idx=B.board_idx"
  strSql = strSql & "		Join emp_list C ON B.send_m_id=C.m_id "
  strSql = strSql & "			where A.to_m_id='" & session_m_id & "' "
  strSql = strSql & "				and (A.message_del='O') "
  strSql = strSql & "					order by A.delete_day desc "
  'response.write stRsql 	
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3
	
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height=30>
			<td class="con5" colspan='6'> 지운메일이 존재하지 않습니다. </td>
		</tr>
  <%
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page
  	
  		 
  i = 1
  Do until objRs.EOF Or i>objRs.PageSize         
		mail_list_idx	= objRs("board_idx")
		message_idx		= objRs("message_idx")
		subject			= objRs("subject")
		file1			= objRs("file1")
		writeday		= objRs("writeday")
		send_name		= objRs("m_name")


		if DateDiff("h",writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if


  		'파일명에서 확장자 뽑기
  		if len(file1)>0 then
			filepath1	= o_code&"/mail/"&left(file1, InstrRev(file1,"/"))  
  	    	filename1	= mid(file1, InstrRev(file1,"/")+1)  
  			strExt		= ucase(Mid(file1,Instr(file1,".")+1))
			Ext_img		= file_strExt_chk(strExt)
  		end if

%>      						
		<tr height="30">             
			<td class="con5"><%=i%></td>
			<td class="con4">
				<input type="checkbox" style="border-style:none;" name="mail_del" value="<%=mail_list_idx%>"></td>
			<td class="con2">
				<a href="mail_view.asp?mail_list_idx=<%=mail_list_idx%>&message_idx=<%=message_idx%>&message_chk=del"><%=subject%><%=new1%></td>
			<td class="con4"><%=filecnt%></td>
			<td class="con4">
				<a href="mail_write.asp?emp_name=<%=send_name%>"><%=send_name%></a></td>
			<td class="con4"><%=Left(writeday,10)%></td>
		</tr>
         
<% 
    	objrs.MoveNext
    	i=i+1 
  loop
  objRs.close    
  End if
%>	
		<tr height=30>             
			<td colspan='6' class="con2">
				<img id="toggle_img1" src="/images/button/btn_allselect.gif" valign='abmiddle' onClick="toggle_img(this.src);"> &nbsp;
				<img src="/images/button/btn_alldelete.gif" valign='abmiddle' onclick="mail_del_submit();"> &nbsp;
			</td>
		</tr>
		</table>
		<div class="pagelist">
			<%
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "mail_del_list.asp?"
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
