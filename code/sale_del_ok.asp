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
  if ad_c_code<>"A" then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if
  
  sale_idx		= WORD_CHANGE(Request("sale_idx"),20)
  'Response.write sale_idx
  'Response.end
  strSql = " select * from customer_goods where g_code_sale='"&sale_idx&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_sale where sale_idx='"&sale_idx&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","sale_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� ���� �����մϴ�. \n\n ���������� �������� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>