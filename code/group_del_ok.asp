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
	Alert_back session_m_name &" ���� �������� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  group_idx		= WORD_CHANGE(Request("group_idx"),20)

  strSql = " select group_code from code_group where group_idx="&group_idx
  Set objRs=objCnn.Execute(strSql)

  group_code = objRs(0)

  strSql = " select * from dealer_info where dealer_group_code='"&group_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_group where group_code='"&group_code&"'"
	Set objRs=objCnn.Execute(strSql)

	'���� �����ἳ�� �ش� �׷��ڵ� ����
	strSql ="select policy_idx from charge_policy where group_code='"&group_code&"'"
	Set objRs1=objCnn.Execute(strSql)

	Do Until objRs1.eof 
		policy_idx = objRs1("policy_idx")

		'���� �����ἳ�� �ش� �׷��ڵ� ����
		strSql ="delete charge_bundle where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)


		'���� �����ἳ�� �ش� �׷��ڵ� ����
		strSql ="delete charge_promise where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		'������ �����ἳ�� �ش� �׷��ڵ� ����
		strSql ="delete charge_sale where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		strSql ="delete charge_policy where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		objRs1.movenext
	loop
	

	Alert_url " �ڵ带 �����߽��ϴ�.","group_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� �������� �����մϴ�. \n\n �ŷ�ó������������ ����׷��� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>