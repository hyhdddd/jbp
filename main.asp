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
  <!--#include virtual="/include/asp/Admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)
  %>
<!DOCTYPE html>
<head><title>::::::::::<%=o_com_name%> 관리시스템 ::::::::::</title>
<meta charset="euc-kr">
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<LINK href="/include/css/style.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
  <%

  strSql = " select p_idx,p_title,p_contents,p_width, p_height , p_top, p_left  from "
  strSql = strSql & " ( select top 4 p_idx,p_title,p_contents,p_width, p_height , p_top, p_left "
  strSql = strSql & "	  from popup where  p_view='Y' "
  strSql = strSql & "		  order by p_idx desc) A order by p_idx asc "
  Set objRs=objCnn.Execute(strSql)

  if not objRs.eof Then
		Do Until objRs.eof
  
		p_idx		= cint(objRs("p_idx"))
		p_height	= money_chk(objRs("p_height"))
		p_width		= money_chk(objRs("p_width"))
		p_top		= money_chk(objRs("p_top"))
		p_left		= money_chk(objRs("p_left"))
		
		cookie_var = "cookie"&p_idx
		cookie_chk	= request.Cookies("cookie")(cookie_var)
		'Response.write cookie_chk&":"&p_idx&"<br>"
	
		if len(cookie_chk)>0 then
			cookie_chk=cint(cookie_chk)
		end if
		
		if cookie_chk<>p_idx then
  %>
		<script language="javascript">
		NewWindow_popup('/information/popup_view.asp?p_idx=<%=p_idx%>','popups1<%=p_idx%>','<%=p_width%>','<%=p_height+40%>','<%=p_top%>','<%=p_left%>','yes');
		</script>
  <%
		End If		
			objRs.movenext
		loop
  end if
  %>    
<body>
<div class="outerContainer">
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="80" colspan="3">
			<!-- TOP MENU -->
			<!--#include virtual="/include/asp/cms_top.asp"-->	  </td>
	</tr>
	<tr>
		<td width="425" valign="top">
			<!-- CALENDAR -->
			 <!--#include virtual="/include/asp/cms_main_diary.asp"--> </td>
		<td width="15"></td>
		<td width="560" valign="top">	
			<!-- NOTICE -->
			<!--#include virtual="/include/asp/cms_main_notice.asp"-->	  </td>
	</tr>
	<tr>
		<td colspan="3">
			<!-- DATABOARD -->
			<!--#include virtual="/include/asp/cms_main_databoard.asp"-->	
		</td>
	</tr>
	<tr>
		<td colspan="3" valign="top">
			<!-- COUNSEL -->
			<!--#include virtual="/include/asp/cms_main_consult.asp"-->		
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<!-- BOTTOM -->
			<!--#include virtual="/include/asp/cms_bottom.asp"--></td>
	</tr>
</table>
</div>
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>