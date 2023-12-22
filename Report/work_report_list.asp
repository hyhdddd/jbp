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
  
  strSql = " select m_duty , m_dealer_code , all_decision , duty_decision from emp_list"
  strSql = stRSql & " where m_id='"&session_m_id &"'"
  set objRs=objCnn.Execute(stRsql)
  
  m_duty			= objRs("m_duty")
  all_decision		= objRs("all_decision")
  duty_decision		= objRs("duty_decision")
  m_dealer_code		= objRs("m_dealer_code")
  objRs.Close

  If UCase(m_dealer_code)<>UCase(o_code) Then
	Alert_back " 거래처 사원들은 사용할 수 없는 메뉴 입니다."
	Response.end
  End if
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
	function send_report(idx,page)
	{
		ans=confirm(" 결재후 상급자에게 보고 하시겠습니까?");
		if(ans==true)
		{
			location.href="work_report_return_ok.asp?w_board_idx="+idx+"&page="+page
		}
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
<tr bgcolor="#FFFFFF" height='400'> 
	<td valign='top' align='center'>
		<!------------------ 내용 시작  ------------------>
		<div class="sub_title"><img src="/images/common/sub11_t01.gif"></div>

		<div class="button">
			<% If all_decision="O" then %>
			<% Else %>
			<a href="work_report_regist.asp"><img src="/images/button/btn_new.gif" border="0"></a>					
			<% End If %>
		</div>
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table1">				
		<tr height=30>             
			<td rowspan='2' class="head" width="80">업무 날자</font></td>
			<td rowspan='2' class="head" width="80">작성자</font></td>
			<td rowspan='2' class="head" width="80">부 서</font></td>
			<td rowspan='2' class="head" width="80">직 급</font></td>
			<td rowspan='2' class="head" width="120">작성일</font></td>
			<td colspan='3' class="head" width="500" >현 결재 현황</td>
			<td rowspan='2' class="head" width="80">결제</td>
		</tr>
		<tr height=30>
			<td class="Head">담 당</td>
			<td class="Head">팀 장</td>
			<td class="Head">사 장</td>
		</tr>

<%  
  'step1
  strSql = " select A.w_board_idx, A.w_work_date, A.w_decision1_yn, A.w_decision2_yn, A.w_decision3_yn, "
  strSql = strSql & " A.w_decision1_day, A.w_decision2_day, A.w_decision3_day, A.w_writeday, "
  strSql = strSql & " B.m_name, B.all_decision , B.duty_decision, " 
  strSql = strSql & " C.duty_name, D.position_name " 
  strSql = strSql & "	from emp_work_report A left outer "
  strSql = strSql & "		     join emp_list B on A.w_m_id=B.m_id "
  strSql = strSql & "		left join code_duty C ON B.m_duty=C.duty_code "
  strSql = strSql & "		left join code_position D ON B.m_position=D.position_code " 
  strSql = strSql & "			Where (B.m_dealer_code='"& o_code &"')"

  if all_decision="O" then
	strSql = strSql & "		and (A.w_decision2_yn='Y' or A.w_decision2_yn='B') "
  Elseif duty_decision="O" Then
	strSql = strSql & "		and (A.w_m_id='"& session_m_id &"') " 
    strSql = strSql & "		 or (A.w_m_id in "
    strSql = strSql & "			(select m_id from emp_list where m_duty='"&m_duty &"') "
    strSql = strSql & "		and A.w_decision1_yn='Y')"
  Else
	strSql = strSql & "		and A.w_m_id='"& session_m_id &"'"
  End If

  strSql = strSql & "			order by  A.w_writeday desc "
  
  'Response.write strSql
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3
	
  if objRs.BOF or objRs.EOF Then
  	  paging_chk="X"
  %>
			<tr>
				<td colspan='9'> 작성된 업무일지가 존재하지 않습니다.</td>
			</tr>
  <%
  else
    
  totalpage = objRs.pagecount
  objRs.absolutepage = page
  	
  		 
  i = 1
  Do until objRs.EOF or  i>objRs.PageSize 
  	w_board_idx			= objRs("w_board_idx")
  	w_work_date			= objRs("w_work_date")
  	w_decision1_yn		= objRs("w_decision1_yn")
  	w_decision1_day		= objRs("w_decision1_day")
  	w_decision2_yn		= objRs("w_decision2_yn")
  	w_decision2_day		= objRs("w_decision2_day")
  	w_decision3_yn		= objRs("w_decision3_yn")
  	w_decision3_day		= objRs("w_decision3_day")
	w_writeday			= objRs("w_writeday")  

	m_name				= objRs("m_name")
  	duty_name			= objRs("duty_name")
  	position_name		= objRs("position_name")
	writer_all_decision = objRs("all_decision")
	writer_duty_decision= objRs("duty_decision")
  	
	if (DateDiff("h",w_decision1_day,Now()) < 22) or (DateDiff("h",w_decision2_day,Now()) < 22) or (DateDiff("h",w_decision3_day,Now()) < 22) then 
        new1="&nbsp; <img src='/images/Common/icon_new.gif' align='absmiddle' border=0>"
	else
		new1="&nbsp;"	
    end if
  
  if writer_all_decision="O" then
  		w_decision1_yn=" &nbsp;"
  		w_decision2_yn=" &nbsp;"
  Elseif writer_duty_decision="O" Then
  		w_decision1_yn=" &nbsp;"
  Else
  End If  	
%>			  
	
		<tr height="30">
			<td class="con5"><a href="work_report_view.asp?w_board_idx=<%=w_board_idx%>&page=<%=page%>"><%=w_work_date%></a></td>
			<td class="con4"><%=m_name%><%=new1%></td>
			<td class="con4"><%=duty_name%></td>
			<td class="con4"><%=position_name%></td>
			<td class="con4"><%=Left(w_writeday,10)%>&nbsp;<%=FormatDateTime(w_writeday,4)%></td>
			<td class="con4"><%=w_decision1_yn%></td>     
			<td class="con4"><%=w_decision2_yn%></td>     
			<td class="con4"><%=w_decision3_yn%></td>     
			<td class="con4"><a href="#" Onclick="send_report('<%=w_board_idx%>','<%=page%>');">결재및 보고</a></td>    
		</tr>	
 <%
  	objrs.MoveNext
  	i=i+1 
  loop

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
			link_url = "work_report_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
		
		<!------------------ 내용 시작  ------------------>
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
