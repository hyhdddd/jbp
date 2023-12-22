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

  If session_m_step<>"M" Then 
	Alert_URL session_m_name &" 님은 관리권한이 없습니다. ","/default.asp"
	Response.end
  End If
  
  
  s_date_start		= WORD_CHANGE(request("s_date_start"),20)	
  s_date_end		= WORD_CHANGE(request("s_date_end"),20)

  If s_date_start="" or s_date_end="" Then
    alert_url "날자선택을 정확히 해주십시요.","/code/customer_del.asp"
  Else
	
	strSql = " delete customer_goods_charge where g_goods_idx in "
	strSql = strSql & " (select g_goods_idx from customer_goods where (g_date_yuchi>='"&s_date_start&" 00:00:00') and (g_date_yuchi<='"&s_date_end&" 23:59:59')) "	
	Set objRs=objCnn.Execute(strSql)

	strSql = " delete customer_goods_charge_g where g_goods_idx in "
	strSql = strSql & " (select g_goods_idx from customer_goods where (g_date_yuchi>='"&s_date_start&" 00:00:00') and (g_date_yuchi<='"&s_date_end&" 23:59:59')) "	
	Set objRs=objCnn.Execute(strSql)

	strSql = "delete customer_goods_consult where g_goods_idx in "
	strSql = strSql & " (select g_goods_idx from customer_goods where (g_date_yuchi>='"&s_date_start&" 00:00:00') and (g_date_yuchi<='"&s_date_end&" 23:59:59')) "	
	Set objRs=objCnn.Execute(strSql)


	strSql = " delete customer_gaetong_log where g_goods_idx in "
	strSql = strSql & " (select g_goods_idx from customer_goods where (g_date_yuchi>='"&s_date_start&" 00:00:00') and (g_date_yuchi<='"&s_date_end&" 23:59:59')) "	
	Set objRs=objCnn.Execute(strSql)

	strSql = " delete customer_goods where (g_date_yuchi>='"&s_date_start&" 00:00:00') and (g_date_yuchi<='"&s_date_end&" 23:59:59') "	
	Set objRs=objCnn.Execute(strSql)

	Alert_url "일괄삭제가 정상적으로 처리되었습니다.","/code/customer_del.asp"

  End if
  %>