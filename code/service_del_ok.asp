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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)

  if ad_c_code="A" Then
  else
	Alert_back session_m_name &" ���� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  service_idx		= WORD_CHANGE(Request("service_idx"),20)
  'Response.write service_idx
  'Response.end
  strSql = " select * from customer_goods where g_code_service='"&service_idx&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_service where service_idx='"&service_idx&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","service_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� ���� �����մϴ�. \n\n ���������� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>