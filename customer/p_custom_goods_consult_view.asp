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

  consult_idx			= WORD_CHANGE(request("consult_idx"),20)
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  consult_date_view		= WORD_CHANGE(request("consult_date_view"),20)

  If consult_date_view="Y" Then
	consult_date_view="N"
  Else
	consult_date_view="Y"
  End if

  strSql = " update customer_goods_consult set "
  strSql = strSql & "  consult_date_view	= '"&consult_date_view&"' "
  strSql = strSql & "	where consult_idx	= "&consult_idx&" "
  set objRs=objCnn.Execute(strSql)

  Alert_url " 수정 되었습니다.","p_custom_goods_regist.asp?g_goods_idx="&g_goods_idx
  %>