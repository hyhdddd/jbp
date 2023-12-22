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

  if ad_r_y_exact="N" then
 	Alert_URL session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	
  
  policy_idx		= WORD_CHANGE(request("policy_idx"),10)
  page				= WORD_CHANGE(request("page"),10)
  policy_passwd1	= WORD_CHANGE(Request("policy_passwd"),20)
  
  strSql = " Select m_dealer_code from emp_list where m_id='"&Session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs(0)
  objRs.close

  strSql = " select  A.policy_idx, B.policy_date, B.policy_file1, B.policy_title, B.policy_writeday, "
  strSql = strSql & " B.policy_passwd "
  strSql = strSql & "	from policy_list_dealer A left outer "
  strSql = strSql & "		join policy_list B ON A.policy_idx=B.policy_idx "
  strSql = stRSql & "		where A.policy_idx="&policy_idx &" and A.dealer_code='"& m_dealer_code &"' " 
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objrs.bof Then
  else
	policy_idx		= objRs("policy_idx") 
	policy_passwd	= objRs("policy_passwd") 


	If policy_passwd="" Or IsNull(policy_passwd) Then
	Else
		If policy_passwd=policy_passwd1 Then
		Else
			If policy_passwd1<>"" Then
				alert_url "비밀번호가 일치하지 않습니다.","y_policy_passwd_chk.asp?policy_idx="&policy_idx
			else
				alert_url "비밀번호를 입력해 주세요!","y_policy_passwd_chk.asp?policy_idx="&policy_idx
			End if
			Response.end
		End if
	End If 

	policy_title	= objRs("policy_title")
	policy_date		= fnc_date_change(objRs("policy_date"))

	policy_writeday	= objRs("policy_writeday")
	policy_file1	= objRs("policy_file1")

	if len(policy_file1)>0 then
		filepath1	= o_code&"/policy/"&left(policy_file1, InstrRev(policy_file1,"/"))  
  		filename1	= mid(policy_file1, InstrRev(policy_file1,"/")+1)  
    end If

  End if
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_editorarea.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_internal.css" rel="stylesheet" type="text/css" />
<link href="/include/editor/editor/css/fck_showtableborders_gecko.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">

		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub16_t01.gif" width='100%'></div>

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height=30>
			<th><%=policy_title%>&nbsp;&nbsp;&nbsp;
			<a href="/policy/y_policy_excel.asp?policy_idx=<%=policy_idx%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a></td>
		</tr>
		<tr height="30"> 
			<td align="right" colspan='4'>
				<% if len(policy_file1)>1 then %>
				<b><a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=mid(policy_file1,8)%></a></b>
				<% end if %>&nbsp;
			</td>
		</tr>
		<tr height=250>
			<td valign='top'> 
  <%
  strSql = " select  policy_txt from policy_list_article where policy_idx="&policy_idx &" order by policy_idx asc" 
  Set objRs=objCnn.Execute(strSql)

  Do Until objRs.eof 
		policy_txt	= objRs("policy_txt")
  %>		
		<%=policy_txt%>
  <%
	objRs.movenext
  loop
  %>
			
			</td>
		</tr>
		<tr height="30"> 
			<td  align="right">       
				<a href="javascript:self.close();"><img src="/images/button/btn_close.gif"  border="0"></a> 
			</td>
		</tr> 
		</table>
		<!------------------ 내용 종료  ------------------>					          

    
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>