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

  if ad_r_a_exact="N" then
 	Alert_URL session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	

  s_group_code			= WORD_CHANGE(request("s_group_code"),20)
  s_policy_date			= WORD_CHANGE(Request("s_policy_date"),20)
  s_policy_date_hour	= WORD_CHANGE(Request("s_policy_date_hour"),20)
  s_policy_date_minute	= WORD_CHANGE(Request("s_policy_date_minute"),20)
  e_policy_date			= WORD_CHANGE(Request("e_policy_date"),20)
  e_policy_date_hour	= WORD_CHANGE(Request("e_policy_date_hour"),20)
  e_policy_date_minute	= WORD_CHANGE(Request("e_policy_date_minute"),20)

  If s_policy_date<>"" Then
	s_policy_date1	= s_policy_date & " "&s_policy_date_hour&":"&s_policy_date_minute&":00"
  End if

  If e_policy_date<>"" Then
	e_policy_date1	= e_policy_date & " "&e_policy_date_hour&":"&e_policy_date_minute&":00"
  End if

   
  timerStartTimer = Timer()
  PageSize=15
  	
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/css/style_button.css" rel="stylesheet" type="text/css" />

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
<tr bgcolor="#FFFFFF"  align='center' height=400> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub16_t02.gif"></div>

		<form name='frm_board' method='post' action='a_policy_list.asp'>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		<tr height='30'>
			<td  style="border-style:none;">
				&nbsp;<b>정책검색:</b>&nbsp;
				<input type="text" name="s_policy_date" class="txtbox" size='10' value="<%=Left(s_policy_date,10)%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_policy_date&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">

				<select name="s_policy_date_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>						
				<option value="<%=ii%>" <% If s_policy_date_hour=CStr(i) Then %> selected <% End If %>><%=ii%>시 </option>
				<% Next %>
				</select>
				<select name="s_policy_date_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If s_policy_date_minute=CStr(i) Then %> selected <% End If %>><%=ii%>분 </option>
					<% Next %>
				</select>		
				~				
				<input type="text" name="e_policy_date" class="txtbox" size='10' value="<%=Left(e_policy_date,10)%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_policy_date&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="e_policy_date_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>						
				<option value="<%=ii%>" <% If e_policy_date_hour=CStr(i) Then %> selected <% End If %>><%=ii%>시 </option>
				<% Next %>
				</select>
				<select name="e_policy_date_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If e_policy_date_minute=CStr(i) Then %> selected <% End If %>><%=ii%>분 </option>
					<% Next %>
				</select>
				&nbsp;&nbsp;&nbsp;
				<select name="s_group_code" style="width:110px;">
				<option value="">:: 정산그룹 ::
				<%
				strSql = " select * from code_group order by group_name asc"
				set objRs=objCnn.Execute(strSql)
					
				Do until objRs.EOF 
					group_code		= objRs("group_code")
					group_name		= objRs("group_name")
				%>
				<option value="<%=group_code%>"  <% if s_group_code=group_code then %> selected <% end if %>> <%=group_name%> 
				<%
					objRs.movenext
				Loop
				objRs.close
				%>
				</select>

				<img src="/images/button/btn_search01.gif" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="submit();">
			</td>
		</tr>
		</table>

		</form>	

		<table width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height=30>             
			<td width=50  class="head">번호</td>
			<td width=400 class="head">제 목</td>
			<td width=150 class="head">정책일자</td>
			<td width=150 class="head">그룹명</td>
			<td width=50 class="head">파일</td>
			<td width=100 class="head">등록일</td>
		</tr>
  <% 
  strSql = " select A.policy_idx, A.policy_date, A.policy_file1, A.policy_title, A.policy_writeday, B.group_name "
  strSql = strSql & "  from policy_list A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code  "

  strSql = stRSql & "		where 1=1 " 

  If s_group_code<>"" Then
	strSql = stRSql & " and A.group_code='"& s_group_code &"' "
  End if

  If s_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date>='"& s_policy_date1 &"' "
  End If

  If e_policy_date<>"" Then
	strSql = strSql &		" and  A.policy_date<='"& e_policy_date1 &"' "
  End If
  
  
  strSql = strSql & "			order by A.policy_idx desc"  
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td class="con5" colspan='8'> 글이 존재하지 않습니다.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		policy_idx		= objRs("policy_idx") 
		policy_title	= objRs("policy_title")
		policy_date		= fnc_date_change(objRs("policy_date"))
		policy_writeday	= objRs("policy_writeday")
		group_name		= objRs("group_name")
		policy_file1	= objRs("policy_file1")


  		'파일명에서 확장자 뽑기
  		if len(policy_file1)>0 then
			filepath1	= o_code&"/policy/"&left(policy_file1, InstrRev(policy_file1,"/"))  
  	    	filename1	= mid(policy_file1, InstrRev(policy_file1,"/")+1)  
  			strExt1		= ucase(Mid(policy_file1,Instr(policy_file1,".")+1))
			Ext_img1		= file_strExt_chk(strExt1)
  		end If	

		if DateDiff("h",policy_writeday,Now()) < 22 then 
         	new1="&nbsp;<img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
        else
        	new1="&nbsp; "	
       	end if
  %>			  
		<tr height=30>
			<td class="con5"><%=i%></td>	
			<td class="con2"><a href="a_policy_view.asp?policy_idx=<%=policy_idx%>"><%=policy_title%> <%=new1%></a></td>	
			<td class="con4"><%=policy_date%> </td>	
			<td class="con4"><%=group_name%></td>	
			<td class="con4">
				<% if len(policy_file1)>0 then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><img src="<%=Ext_img1%>" border=0></a>
				<% else %>&nbsp;<% end if %></td>		
			<td class="con4"><%=Left(policy_writeday,10)%></td>	
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
			link_url = "a_policy_list.asp?s_policy_date="&s_policy_date&"&s_policy_date_hour="&s_policy_date_hour&"&s_policy_date_minute="&s_policy_date_minute&"&e_policy_date="&e_policy_date&"&e_policy_date_hour="&e_policy_date_hour&"&e_policy_date_minute="&e_policy_date_minute&"&s_group_code="&s_group_code&"&"
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
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>