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

  p_idx		= WORD_CHANGE(Request("p_idx"),20)
 
  strSQL = " select top 1 p_idx,p_title,p_contents,p_width, p_height"
  strSQL = strSQL & " from popup "
  strSQL = strSQL & " where p_idx="&p_idx
  strSQL = strSQL & " order by p_idx desc"
  Set objRs=objCnn.Execute(strSql)

  if not objRs.eof then
	p_idx		= objRs("p_idx")
	p_title		= objRs("p_title")
	p_contents	= objRs("p_contents")
	p_width		= objRs("p_width")
	p_height	= objRs("p_height")
  end if
  %>
<!DOCTYPE html> 
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>


<body topmargin=0  leftmargin="0" marginwidth="0" marginheight="0">

<table width="100%" height="<%=p_height%>" border="0" cellspacing=0 cellpadding=0>
<form name="form1" action="popup_cookie_ok.asp"> 
  <tr>
    <td valign='top'><%=p_contents%></td>
  </tr>
</table>
<table width="100%" height="30" border="0" bgcolor=white>
  <tr>
    <td align='center' height='30'><input type="checkbox" name="popup" value="<%=p_idx%>" onclick="send_cookie();"><font style="FONT-SIZE:12px;COLOR:#1A5699;"> 오늘은 이창을 열지않음</font></td>
  </tr>
  </form>
</table>
<script>
<!--
  function send_cookie()
  {
  	document.forms[0].submit();
  }
-->
</script>
</body>
</html>