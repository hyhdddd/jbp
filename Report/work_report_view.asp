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

 
  strSql = " select m_duty , all_decision , duty_decision from emp_list"
  strSql = stRSql & " where m_id='"&session_m_id &"'"
  set objRs=objCnn.Execute(stRsql)
  
  m_duty			= objRs("m_duty")
  all_decision		= objRs("all_decision")
  duty_decision		= objRs("duty_decision")

  if w_board_idx<>"" then  
	strSql = " select A.w_board_idx, A.w_work_date, A.w_decision1_yn, A.w_decision2_yn, A.w_decision3_yn, "
	strSql = strSql & " A.w_decision1_day, A.w_decision2_day, A.w_decision3_day, A.w_writeday, "
	strSql = strSql & " A.w_decision2_txt, A.w_decision2_id, A.w_decision3_txt, A.w_decision3_id, "
	strSQl = strSql & " A.w_work_today, A.w_work_tomorrow, w_work_request, A.w_board_fname1,"
	strSql = strSql & " B.m_name, B.all_decision , B.duty_decision, " 
	strSql = strSql & " C.duty_name, D.position_name " 
	strSql = strSql & "	from emp_work_report A left outer "
	strSql = strSql & "		     join emp_list B on A.w_m_id=B.m_id "
	strSql = strSql & "		left join code_duty C ON B.m_duty=C.duty_code "
	strSql = strSql & "		left join code_position D ON B.m_position=D.position_code " 
	strSql = strSql & "			Where (m_dealer_code='"& o_code &"')"
	strSql = strSql & "				and w_board_idx="&w_board_idx
	set objRs=objCnn.Execute(stRSql)

		w_work_date			= objRs("w_work_date")
		w_decision1_yn		= objRs("w_decision1_yn")
		w_decision1_day		= objRs("w_decision1_day")
		w_decision2_yn		= objRs("w_decision2_yn")
		w_decision2_txt		= objRs("w_decision2_txt")
		w_decision2_id		= objRs("w_decision2_id")
		w_decision2_day		= objRs("w_decision2_day")
		w_decision3_yn		= objRs("w_decision3_yn")
		w_decision3_txt		= objRs("w_decision3_txt")
		w_decision3_id		= objRs("w_decision3_id")
		w_decision3_day		= objRs("w_decision3_day")

		If IsNull(w_decision2_day)=False And w_decision2_day<>"" Then
			w_decision2_day	= Left(w_decision2_day,10) & " "& FormatDateTime(w_decision2_day,4)
		end if

		If IsNull(w_decision3_day)=False And w_decision3_day<>"" Then
			w_decision3_day	= Left(w_decision3_day,10) & " "& FormatDateTime(w_decision3_day,4)
		end if

		w_writeday			= objRs("w_writeday")  
		w_work_today		= objRs("w_work_today")
		w_work_tomorrow		= objRs("w_work_tomorrow")
		w_work_request		= objRs("w_work_request")

		w_work_today		= replace(w_work_today,chr(13) & chr(10),"<br>")   	
		w_work_today		= replace(w_work_today," ","&nbsp;")   	
		w_work_tomorrow		= replace(w_work_tomorrow,chr(13) & chr(10),"<br>")   	
		w_work_tomorrow		= replace(w_work_tomorrow," ","&nbsp;")   	
		w_work_request		= replace(w_work_request,chr(13) & chr(10),"<br>")  
		w_work_request		= replace(w_work_request," ","&nbsp;")   	
		w_board_fname1		= objRs("w_board_fname1")
 		
  		'파일명에서 확장자 뽑기
  		if len(w_board_fname1)>0 then
			filepath1	= o_code&"/emp_work_report/"&left(w_board_fname1, InstrRev(w_board_fname1,"/"))  
  	    	filename1	= mid(w_board_fname1, InstrRev(w_board_fname1,"/")+1)  
  		end If

		If duty_decision="O" Then 
		else
			If IsNull(w_decision2_txt)=False then
			w_decision2_txt		= replace(w_decision2_txt,chr(13) & chr(10),"<br>")  
			w_decision2_txt		= replace(w_decision2_txt," ","&nbsp;")   	
			End If
		End if
		
		If all_decision="O" Then
		else
			If IsNull(w_decision3_txt)=False then
			w_decision3_txt		= replace(w_decision3_txt,chr(13) & chr(10),"<br>")  
			w_decision3_txt		= replace(w_decision3_txt," ","&nbsp;")   	
			End if
		End if



		m_name				= objRs("m_name")
		duty_name			= objRs("duty_name")  
  else
    strSql = " select A.m_name , B.duty_name "
	strSql = strsql & "	from emp_list A left outer "
	strSql = strSql & "		join  code_duty B ON A.m_duty=B.duty_code "
	strSql = strSql & "			Where A.m_id='"& session_m_id &"'"     
    set objRs=objCnn.Execute(stRSql)
    m_name	 	= objRs("m_name")
    'job_position1=objRs("job_position1")
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

	
	function board_del_ok(url)
	{
		ans=confirm("글을 삭제하시겠습니까?");
		if(ans==true)
		{
			location.replace(url);
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
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub11_t01.gif" border=0></div>

		<form name="frm_Report" action="work_report_view_ok.asp" METHOD="POST">
		<input type="hidden" name="w_board_idx"  value="<%=w_board_idx%>">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<input type="hidden" name="page"  value="<%=page%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height='30'> 
			<th width="150">등 록 자</th>
			<td width="250"><%=m_name%></td>
			<th width="150"> 팀 명 </th>
			<td width="250"><%=duty_name%></td>
		</tr>
		<tr height='30'> 
			<th>작성 일자 </th>
			<td colspan='3'><%=w_work_date%></td>
		</tr>
		<tr height=80> 
			<th> 금일 업무내용 </th>
			<td colspan='3'><%=w_work_today%></td>
		</tr>
		<tr height=80>  
			<th> 익일 업무예정 </th>
			<td colspan='3'><%=w_work_tomorrow%></td>
		</tr>
		<tr height=80> 
			<th> 기타 요청사항 </th>
			<td colspan='3'><%=w_work_request%></td>
		</tr>
		<tr height=40> 
			<th> 첨부 파일 </th>
			<td colspan='3'>
				<% if len(filename1)>0 then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
				<% else %>&nbsp;<% end if %>
			</td>
		</tr>
  <% 
  if all_decision="O" Then
  %>
		<tr height='30'> 
			<th> 과장(팀장) 지시사항 <br>(<%=w_decision2_day%>)</th>
			<td colspan='3'><%=w_decision2_txt%></td>
		</tr>				
		<tr height='30'> 
			<th> 사장 지시사항 </th>
			<td colspan='3'> 
				<input type="hidden" name="indication_chk"  value="3">
				<textarea name="w_decision3_txt" cols="110" rows="8"><%=w_decision3_txt%></textarea></td>
		</tr>
  <%
  Elseif duty_decision="O" Then
  %>
		<tr height='30'> 
			<th> 과장(팀장) 지시사항 <br>(<%=w_decision2_day%>)</th>
			<td colspan='3'> 
				<input type="hidden" name="indication_chk"  value="2">
				<textarea name="w_decision2_txt" cols="110" rows="8"><%=w_decision2_txt%></textarea></td>
		</tr>
		<tr height='30'> 
			<th> 사장 지시사항 <br>(<%=w_decision3_day%>) </th>
			<td colspan='3'><%=w_decision3_txt%></td>
		</tr>
  <%
  Else
  %>
		<tr height='30'> 
			<th> 과장(팀장) 지시사항 <br>(<%=w_decision2_day%>) </th>
			<td colspan='3'><%=w_decision2_txt%>&nbsp;</td>
			</tr>
		<tr height='30'> 
			<th> 사장 지시사항 <br>(<%=w_decision3_day%>)</th>
			<td colspan='3'><%=w_decision3_txt%>&nbsp;</td>
		</tr>
  <%
  End If  	
  %>
		</table>

		<div class="button">
			<a href="work_report_list.asp"><img src="/images/button/btn_list.gif" border=0></a>
			<img src="/images/button/btn_save.gif" onclick="sendit();" onmouseover="this.style.cursor='hand';">
			<% If w_board_idx<>"" Then %>
			<a href="work_report_regist.asp?w_board_idx=<%=w_board_idx%>"><img src="/images/button/btn_Rewrite.gif" border=0>
			<% End If %>

			<% If session_m_step="M" Then %>
				<a href="javascript:board_del_ok('work_report_del.asp?w_board_idx=<%=w_board_idx%>')"><img src="/images/button/btn_delete.gif" border="0"></a> 	
			<% End If %>

		</div>
		</form>					
	</td>
</tr>  
<tr height='30'>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>