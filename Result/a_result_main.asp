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
 
  if ad_k_a_result="N" then
	Alert_url session_m_name &" 님은 실적관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if
  
  yea = year(date)
  mon = month(date)
  dayy = day(date)

  if Cint(mon) < 10 then	mon = "0" & mon		end if
  if Cint(dayy) < 10 then	dayy = "0" & dayy	end if 

  start_date	= yea &"-"& mon &"-01"
  end_date		= yea &"-"& mon &"-"& dayy

  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
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
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		<table width="100%" border=0 cellspacing="0" cellpadding="0">
		<tr> 
		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub05_t03.gif"></div>

		<form method="post" name="frm_a_result"> 
		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">				
		<tr height="30"> 
			<th width=150>조회 기간</th>
			<td>   			
				<input type="text" class="txtbox" name="start_date" size='10' value="<%=start_date%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=start_date&code2=&code3=&form_name=frm_a_result','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~
				<input type="text" class="txtbox" name="end_date" size='10' value="<%=end_date%>" readonly	onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=end_date&code2=&code3=&form_name=frm_a_result','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>		          
		</tr>
		<tr height=30> 
			<th> 회사명 </td>
			<td>
				<select name="g_article_idx1" style="width:120px;" onblur="BlurColor(this);" onFocus="FocusColor(this);">
				<option value="0"> 회사 선택           
					<% 
					strSql = " select * from code_article where article_step2=0 order by article_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else
				 
					i = 1
					Do until objRs.EOF   	
						article_idx		= objRs("article_idx")
						article_name	= objRs("article_name")
					%>	
						<option value="<%=article_idx%>"><%=article_name%></option>
					<% 
						objRs.MoveNext
						i=i+1 
					Loop
					End if
				%>	
				</select>
			</td>
		</tr>
		<tr height=30> 
			<th> 조회 내용	</th>
			<td>
				<select name="result" class="txtbox" size=15 style="width:650px;">
					<option value="1"> 검색 일자별 유치현황 </option>
					<option value="2"> 검색 일자별 개통현황 </option>
					<option value="3"> 협력점별 유치현황 </option>
					<option value="4"> 협력점별 개통현황 </option>
					<option value="5"> 직영사원별 유치현황 </option>
					<option value="6"> 직영사원별 개통현황 </option>
					<option value="7"> 상부점별 유치현황 </option>
					<option value="8"> 상부점별 개통현황 </option>
				</select> 
			</td>		          
		</tr>
		<tr height=30>
			<td colspan='2' align='center'> 
				<span onClick="result_search02('frm_a_result');"><img src="/images/button/btn_search.gif" align='absmiddle' border=0></span>
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