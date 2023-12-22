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
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  Search_key		= WORD_CHANGE(Request("search_key"),20)
  Search_txt		= WORD_CHANGE(Request("search_txt"),20)
  group_code		= WORD_CHANGE(Request("group_code"),20)

  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/mail_emp_info_all.asp"></SCRIPT>
<script language="javascript">
<!--
function sel_ok(dealer_code,dealer_name)
{
	aa=window.opener.OnConditionAdded(dealer_name,dealer_code );
	self.close();
}

-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="540" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<table width="100%" border=0 cellspacing="0" cellpadding="0">
		<tr> 
            
            <td width=100% valign="top" align='center'>
				<!------------------ 내용 시작  ------------------>
				<form name="mail_frm"  method="post">
				<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
				<tr height='30'>
					<td colspan='7' class='con2'>
						<select name="search_key" valign='absmiddle' class="txtbox">
						<option value="dealer_name"> 업체명 </option>	
						</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send('mail_frm');"><img src="/images/button/btn_search01.gif" onClick="Search('mail_frm');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
						
					</td>
				</tr>
				<tr height=30>             
					<td class="head" width=30>No</td>
					<td class="head" width=200>협력점</td>
				</tr>
				
<% 
  strSql = "select * from dealer_info where dealer_group_code='"&group_code&"' and dealer_view='Y' "

  If search_txt<>"" then
	strSql = strSql & "			and  "&search_key&" like '%"&search_txt&"%'"
  End If

  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3



  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
				<tr height=30>
					<td class="con5" colspan='7'> 글이 존재하지 않습니다.</td>	
				</tr>		
  <%
  Else 
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
		dealer_code		= objRs("dealer_code")
		dealer_name		= objRs("dealer_name")
  %>
				<tr height='30'>
					<td class='con5'><%=i%></td>
					<td class='con4'><a href="javascript:sel_ok('<%=dealer_code%>','<%=dealer_name%>');"><%=dealer_name%></a>
					</td>
				</tr>
  <%
	objRs.movenext
	i=i+1
  Loop

  End if
  %>
  
				</table>
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
					link_url = "a_policy_add.asp?group_code="&group_code&"&"
					%>
					<!--#include virtual="/include/asp/list_paging.asp"-->
				</div>
				<!------------------ 내용 종료  ------------------>

				
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</body>