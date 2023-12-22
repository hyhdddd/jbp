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
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)
 
  if ad_e_data1="N" then
	Alert_url session_m_name &" 님은 사내 자료실 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end If

  tname		= "board_data1"
  search_key = WORD_CHANGE(request("search_key"),20)
  search_txt = WORD_CHANGE(request("search_txt"),20)

   
  timerStartTimer = Timer()
  PageSize=15
  	
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  %>
<!DOCTYPE html>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
function board_search(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);
	
	if(frm.search_txt.value=="")
	{
		alert("검색어를 입력해 주세요");
		return;
	}
	
	frm.submit();
}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center' height='400'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub07_t03.gif"></div>


		<form id='frm_board' name='frm_board' method='post' action='board_list.asp'>
		<input type="hidden" name="tname" value="<%=tname%>">

		<table width="100%" cellspacing=0 cellpadding=0 border=0 style='border-style:none'>
		<tr height=28>             
			<td align='left'>
				<select name="search_key">
				<option value="board_title"> 제목 </option>				
				<option value="board_contents"> 내용 </option>				
				</select>
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><span onClick="board_search('frm_board');"><img src="/images/button/btn_search01.gif" align='absmiddle' border=0></span>
			</td>
			<td align="right">
				<% if ad_e_data1="W" or ad_e_data1="E" or ad_e_data1="A" then %>
					<a href='board_write.asp?tname=<%=tname%>'>
					<img src="/images/button/btn_new.gif" align='absmiddle'  border="0"></a>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 사내자료실 등록권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>   
			</td>
		</tr>
		</table>

		</form>	


		<table width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td width=50  class="head">번호</td>
			<td width=600 class="head">제  목</td>
			<td class="head">등록인</td>
			<td width=50  class="head">파일</td>
			<td width=50  class="head">조회수</td>
			<td width=100 class="head">등록일</td>
		</tr>
  <% 
  strSql = " select A.board_idx, A.board_m_id, B.m_name as board_name, A.board_title, A.board_contents, "
  strSql = strSql & " A.board_readnum, A.board_writeday, "
  strSql = strSql & " A.board_fname1 from "&tname&" A  left outer join emp_list B ON A.board_m_id=B.m_id "
  strSql = strSql & "		where 1=1  "

  if search_key<>"" Then
	  strSql = strSql & "		and (A."&search_key&" like '%"&search_txt&"%') "
  end If
  
  strSql = strSql & "		order by A.board_idx desc"  
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td align="center" colspan='6'> 글이 존재하지 않습니다.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
	recordcount	= objRs.recordcount  	
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		board_idx		= objRs("board_idx")
  		board_m_id		= objRs("board_m_id")
  		board_name		= objRs("board_name")
  		board_title		= objRs("board_title")
  		board_contents	= objRs("board_contents")
  		board_readnum	= objRs("board_readnum")
  		board_writeday	= objRs("board_writeday")
  		board_fname1	= objRs("board_fname1")
  		
  		'파일명에서 확장자 뽑기
  		if len(board_fname1)>0 then
			filepath1	= o_code&"/"&tname&"/"&left(board_fname1, InstrRev(board_fname1,"/"))  
  	    	filename1	= mid(board_fname1, InstrRev(board_fname1,"/")+1)  
  			strExt		= ucase(Mid(board_fname1,Instr(board_fname1,".")+1))
			Ext_img		= file_strExt_chk(strExt)
  		end if

		if DateDiff("h",board_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if
  %>			  
		<tr height=30>
			<td class="con5"><%=i%></td>	
			<td class="con2">&nbsp;<a href="board_content.asp?board_idx=<%=board_idx%>&tname=<%=tname%>&page=<%=page%>"><%=board_title%> <%=new1%></a></td>	
			<td  class="con4"><%=board_name%></td>	
			<td  class="con4">
			<% if len(board_fname1)>0 then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><img src="<%=Ext_img%>" border=0></a>
			<% else %>&nbsp;<% end if %></td>	
			<td class="con4"><%=board_readnum%></td>	
			<td class="con4"><%=Left(board_writeday,10)%></td>	
		</tr>	
          
<% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
%>		  
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
			link_url = "board_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>

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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>