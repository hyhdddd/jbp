  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <%
  strSql = "select * from emp_list where m_step='M'"
  Set objRs=objCnn.Execute(strSql)
  
  m_name		= objRs("m_name")
  m_id			= objRs("m_id")
  m_passwd		= objRs("m_passwd")
  
  session("m_name")		= m_name
  session("m_id")		= m_id
  session("m_step")		= "M"
  session("o_code")		= o_code

  Win_link "/default.asp"
  %>
