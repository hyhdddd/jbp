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
  if ad_c_code<>"A" Then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If

  area_idx			= WORD_CHANGE(Request("area_idx"),20)

  If area_idx="" Then
	Alert_back " ������ �߸��Ǿ����ϴ�."
	Response.end
  End If
  
  '���� �� ��� ��ǰ �˻�
  strSql = "select * from customer_goods where g_code_area="&area_idx&" "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql = "delete code_area where area_idx="&area_idx
	Set objRs=objCnn.Execute(strSql)
	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. ","area_list.asp"
	Response.End		
  Else
	alert_back " �� �ڵ带 ����ϴ� ���� ���� �մϴ�. \n\n ����ǰ�� ��� ������ �����Ͻ� �� �ֽ��ϴ�."
	Response.end
  End If
  %>