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

  c_m_gamang_idx		= WORD_CHANGE(Request("c_m_gamang_idx"),10)

  strSql = " delete customer_gamang where c_m_gamang_idx="&c_m_gamang_idx
  Set objRs=objCnn.Execute(strSql)

  strSql = " delete customer_gamang_consult where c_m_gamang_idx="&c_m_gamang_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 고객상품정보가 삭제되었습니다.","a_gamang_list.asp"
  %>