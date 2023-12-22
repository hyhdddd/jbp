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
  <%
  session("m_id")=""
  session.abandon  	

  '끊어지지 않는 세션을 위한 쿠키값
  Response.Cookies("m_id1").expires=date+1
  Response.Cookies("m_id1")=""

  strSql = "Delete emp_login_info where DATEDIFF(dd,m_writeday,GETDATE())>180 "
  Set objRs=objCnn.Execute(strSql)

  Win_link "/main.asp"
  %>
