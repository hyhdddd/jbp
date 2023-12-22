 <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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
  if ad_r_a_exact<>"A" Then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 

  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),20)
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  
  strSql = " delete customer_goods_charge where g_charge_idx="&g_charge_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 환수 및 추가정산이 삭제 되었습니다.","a_charge_list.asp?g_goods_idx="&g_goods_idx
  DBClose()
  %>