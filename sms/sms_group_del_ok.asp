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
 
  if ad_b_a_custom="A" Then
  else
	Alert_back session_m_name &" ���� �������� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  group_idx		= WORD_CHANGE(Request("group_idx"),10)

  strSql = " select * from SMS_GROUP_EMP where group_idx='"&group_idx&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete sms_group where group_idx='"&group_idx&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","sms_group_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ忡 �Ҽӵ� ����� �����մϴ�. \n\n �Ҽ��� ��� ������� �ڵ带 ������ �ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>