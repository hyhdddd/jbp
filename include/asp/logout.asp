  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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

  '�������� �ʴ� ������ ���� ��Ű��
  Response.Cookies("m_id1").expires=date+1
  Response.Cookies("m_id1")=""

  strSql = "Delete emp_login_info where DATEDIFF(dd,m_writeday,GETDATE())>180 "
  Set objRs=objCnn.Execute(strSql)

  Win_link "/main.asp"
  %>
