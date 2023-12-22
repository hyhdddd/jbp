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

  w_board_idx		= WORD_CHANGE(Request("w_board_idx"),10)
  page				= WORD_CHANGE(Request("page"),10)
  w_work_date		= Left(now,10)

  if w_board_idx<>"" then  
    strSql = " select A.w_board_idx,A.w_m_id,A.w_work_date, A.w_work_today, "
	strSql = strSql & " A.w_work_tomorrow, A.w_work_request, A.w_decision1_yn, A.w_decision2_yn, A.w_decision3_yn,"
	strSql = strSql & " B.m_name, C.duty_name "  
    strSql = strSql & "		 from emp_work_report A Left outer "
	strSql = strSql & "			join emp_list B ON A.w_m_id=B.m_id "
	strSql = strSql & "			left join code_duty C ON B.m_duty=C.duty_code "
	strSql = strSql & "				Where (A.w_board_idx="&w_board_idx&") "
    set objRs=objCnn.Execute(stRSql)
  
    w_m_id				= objRs("w_m_id")
    w_work_today		= objRs("w_work_today")
    w_work_tomorrow		= objRs("w_work_tomorrow")
    w_work_request		= objRs("w_work_request")
    m_name				= objRs("m_name")  
    duty_name			= objRs("duty_name")  
	w_work_date			= Left(objRs("w_work_date"),10)

  Else
	w_m_id				= session_m_id
    strSql = " select A.m_name , B.duty_name "
	strSql = strsql & "	from emp_list A left outer "
	strSql = strSql & "		join  code_duty B ON A.m_duty=B.duty_code "
	strSql = strSql & "			Where A.m_id='"& session_m_id &"'"     
    set objRs=objCnn.Execute(stRSql)
    m_name	 	= objRs("m_name")
    duty_name	= objRs("duty_name")
  end If
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
	function sendit()
	{
		
		var frm=document.all.frm_Report;
		if(frm.session_m_id.value=="")
		{
			alert(" 로그인후 사용해 주세요! ");
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
<tr bgcolor="#FFFFFF"> 
	<td valign='top'>
				<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub11_t01.gif" border=0></div>

		<form name="frm_Report" action="work_report_regist_ok.asp" ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="w_board_idx"  value="<%=w_board_idx%>">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<input type="hidden" name="page"  value="<%=page%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30> 
			<th width="150">등 록 자</th>
			<td width="250"><input type='text' class="txtbox" name='m_name' size=10 value='<%=m_name%>' onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" readonly></td>
			<th width="150"> 팀 명 </th>
			<td width="250"><input type='text' class="txtbox"  name='duty_name' size=10 value='<%=duty_name%>' onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();" readonly></td>
		</tr>
		<tr height=30> 
			<th>작성 일자 </th>
			<td colspan='3'>
				<input class="txtbox" type="text" name="w_work_date" size='10' readonly value="<%=w_work_date%>" onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=w_work_date&code2=&code3=&form_name=frm_Report','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">

			</td>
		</tr>
		<tr height='30'> 
			<th> 금일 업무내용 </th>
			<td colspan='3'><textarea name="w_work_today" cols="100" rows="9"><%=w_work_today%></textarea></td>
		</tr>
		<tr height=100> 
			<th> 익일 업무예정 </th>
			<td colspan='3'><textarea name="w_work_tomorrow" cols="100" rows="9"><%=w_work_tomorrow%></textarea></td>
		</tr>
		<tr height='30'> 
			<th> 기타 요청사항 </th>
			<td colspan='3'><textarea name="w_work_request" cols="100" rows="9"><%=w_work_request%></textarea></td>
		</tr>
		<tr height=30> 
			<th> 파일 </th>
			<td colspan='3'><input type="file" class="txtbox" name="w_board_fname1" size="40"></td>
		</tr>
		</table>

		<div class="button">
			<% If UCase(session_m_id)=UCase(w_m_id) Then %>
			<img src="/images/button/btn_save.gif" align="absmiddle" onclick="sendit();" onmouseover="this.style.cursor='hand';">
			<% Else %>
			<img src="/images/button/btn_save.gif" align="absmiddle" onclick="alert('작성자만 수정가능합니다.');" onmouseover="this.style.cursor='hand';">
			<% End If %>
		</div>
		</form>	
		<!------------------ 내용 시작  ------------------>			
	</td>
</tr>  
<tr height='30'>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>