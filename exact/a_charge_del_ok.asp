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
  if ad_r_a_exact<>"A" Then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	 

  g_charge_idx			= WORD_CHANGE(request("g_charge_idx"),20)
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  
  strSql = " delete customer_goods_charge where g_charge_idx="&g_charge_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " ȯ�� �� �߰������� ���� �Ǿ����ϴ�.","a_charge_list.asp?g_goods_idx="&g_goods_idx
  DBClose()
  %>