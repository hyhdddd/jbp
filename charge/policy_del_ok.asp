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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if

  policy_idx		= WORD_CHANGE(Request("policy_idx"),20)

  '��������� ����
  strSql ="delete charge_bundle where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  '���������� ����
  strSql ="delete charge_promise where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  '������ ����
  strSql ="delete charge_sale where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql ="delete charge_policy where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	
  
  '�̺񼭷� ����
  strSql ="delete charge_document where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	

  '�ΰ����񽺻���
  strSql ="delete charge_buga where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	

  Alert_url " �ڵ带 �����߽��ϴ�.","policy_list.asp"
  %>