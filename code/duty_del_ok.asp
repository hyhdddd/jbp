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

  duty_idx		= WORD_CHANGE(Request("duty_idx"),20)

  strSql = " select duty_code from code_duty where duty_idx="&duty_idx
  Set objRs=objCnn.Execute(strSql)

  duty_code = objRs(0)

  strSql = " select * from emp_list where m_duty='"&duty_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_duty where duty_code='"&duty_code&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ带 �����߽��ϴ�.","duty_list.asp"
  Else
  	Alert_back " �����ϰ��� �ϴ� �ڵ带 ����ϴ� ����� �����մϴ�. \n\n ����������� �μ��� �ٲٽ��� �ڵ带 �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if  
  %>