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
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  o_agree			= WORD_CHANGE(Request("o_agree"),0)					'��Ʈ�� ��û ���

  strSql = " update company_info set "
  strSql = strSql & "  o_agree			= '"& o_agree &"' "  
  strSql = strSql & "  where o_code = '"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url "��Ʈ�� ���� ����� ���� �Ǿ����ϴ�. ","/information/y_partner_agree.asp"
  %>