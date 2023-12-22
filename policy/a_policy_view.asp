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
  
  policy_idx		= WORD_CHANGE(request("policy_idx"),10)
  page				= WORD_CHANGE(request("page"),10)
  
  strSql = " select  A.policy_idx, B.policy_date, B.policy_title, A.policy_txt, B.policy_passwd, A.policy_txt, "
  strSql = strSql & "  B.policy_file1   from policy_list_article A left outer join policy_list B on A.policy_idx=B.policy_idx "
  strSql = stRSql & "		where A.policy_idx="&policy_idx &" " 

  Set objRs=objCnn.Execute(strSql)
	policy_title = objRs("policy_title")
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>


<script language="javascript">
<!--
	function board_del_ok(url)
	{
		ans=confirm("정책을 삭제하시겠습니까?");
		if(ans==true)
		{
			location.replace(url);
		}
	}

	function send_policy(frm)
	{
		var frm=eval("document.all."+frm);

		if (frm.policy_title.value=="")
		{
			alert("제목을 입력해 주세요!");
			frm.policy_title.focus();
		}

		frm.submit();
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub16_t02.gif"></div>

		<form name="frm_board" method="post"  ENCTYPE="MULTIPART/FORM-DATA" action="a_policy_view_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height=30>
			<th colspan='2'><%=policy_title%>
				&nbsp;&nbsp;&nbsp;
				<a href="/policy/a_policy_excel.asp?policy_idx=<%=policy_idx%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				&nbsp;&nbsp;&nbsp;
				<% if len(policy_file1)>1 then %>
				<b><a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=mid(policy_file1,8)%></a></b>
				<% end if %>&nbsp;
			</th>
		</tr>
		<tr height=250>
			<td valign='top' colspan='2'> 

  <%
  strSql = " select  A.policy_idx, B.policy_date, B.policy_title, A.policy_txt, B.policy_passwd, A.policy_txt, "
  strSql = strSql & "  B.policy_file1   from policy_list_article A left outer join policy_list B on A.policy_idx=B.policy_idx "
  strSql = stRSql & "		where A.policy_idx="&policy_idx &" order by A.board_idx asc" 
  Set objRs=objCnn.Execute(strSql)

  i=1
  Do Until objRs.eof
	policy_idx		= objRs("policy_idx") 
	policy_title	= objRs("policy_title")
	policy_date		= fnc_date_change(objRs("policy_date"))

	policy_passwd	= objRs("policy_passwd")
	policy_file1	= objRs("policy_file1")
	policy_txt		= objRs("policy_txt")
	
    if len(policy_file1)>0 then
		filepath1	= o_code&"/policy/"&left(policy_file1, InstrRev(policy_file1,"/"))  
  		filename1	= mid(policy_file1, InstrRev(policy_file1,"/")+1)  
    end If

  %>

			<%=policy_txt%> 
  <%
	objRs.movenext
  Loop
  %>

			</td>
		</tr>
		<tr height="30"> 
			<td align="right" colspan='2'  style="border-style:none;">       
				<a href="a_policy_list.asp?tname=<%=tname%>&page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0" align='absmiddle'></a> 

				<a href="a_policy_regist.asp?policy_idx=<%=policy_idx%>"><img src="/images/button/btn_rewrite.gif" border=0 align='absmiddle'></a>
				<% 
				If ad_r_a_exact="A" Then 
				%>
					<a href="javascript:board_del_ok('a_policy_del.asp?policy_idx=<%=policy_idx%>')"><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></a> 
				<%
				else
				%>
					<span onclick='javascript:alert("정산관리(모든권한) 권한이 없습니다.");'><img src="/images/button/btn_delete.gif" border="0" align='absmiddle'></span>
				<%
				end if 
				%>

				
			</td>
		</tr> 
		</table>
		</form>
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