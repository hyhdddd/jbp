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
  Login_chk(Session_m_id)

  gaetong_default		= WORD_CHANGE(request("gaetong_default"),20)


  strSql = " update code_gaetong set gaetong_default=null "
  set objRs=objCnn.Execute(strSql)

  strSql = " update code_gaetong set gaetong_default='Y' where gaetong_code='"&gaetong_default&"'"
  set objRs=objCnn.Execute(strSql)


  Alert_url "적용되었습니다.","gaetong_list.asp"
  
  %>