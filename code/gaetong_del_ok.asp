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
  Login_chk(Session_m_id)
 
  if ad_c_code="A" Then
  else
	Alert_back session_m_name &" ���� �������� �ڵ� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  gaetong_idx		= WORD_CHANGE(Request("gaetong_idx"),20)

  strSql = " select gaetong_code from code_gaetong where gaetong_idx="&gaetong_idx
  Set objRs=objCnn.Execute(strSql)

  gaetong_code = objRs(0)


  strSql = " select * from customer_goods where g_code_gaetong_idx='"&gaetong_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_gaetong where gaetong_code='"&gaetong_code&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","gaetong_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� ���� �����մϴ�. \n\n ���������� �ڵ带 �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>