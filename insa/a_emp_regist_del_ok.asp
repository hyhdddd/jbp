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
 
  if ad_i_a_emp="A" Then
  else
	Alert_back session_m_name&" ���� ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If
  
  m_id		= WORD_CHANGE(Request("m_id"),20)

  '������ ���̵�� ���� �Ұ���
  strSql = "select * from emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_id_chk = objRs("m_step")

  If m_id_chk="M" Then	
	  Alert_back "������ ����� ������ �� �����ϴ�."
	  Response.end
  End If
  
  '�� ��ġ ���� üũ
  strSql = " select * from customer_goods where g_yuchi_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ��ġ�� ���� �����մϴ�. \n\n �� ��ġ�ڸ� �ٲٽ��� ����� ������ �ּ���!"
		Response.end
  End If

  '��� ���� üũ
  strSql = " select * from customer_goods_consult where consult_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ����� ����� ���� �����մϴ�. \n\n �� ������ ������  ����� ������ �ּ���!"
		Response.end
  End If

  '�Խ��� �� üũ
  strSql = " select * from board_data1 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ����� �系�ڷ�� ���� �����մϴ�. \n\n ���� ������  ����� ������ �ּ���!"
		Response.end
  End If

  '�Խ��� �� üũ
  strSql = " select * from board_data2 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ����� �ŷ�ó �ڷ�� ���� �����մϴ�. \n\n ���� ������  ����� ������ �ּ���!"
		Response.end
  End If

  '�Խ��� �� üũ
  strSql = " select * from board_notice1 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ����� �系 �������� ���� �����մϴ�. \n\n ���� ������  ����� ������ �ּ���!"
		Response.end
  End If

  '�Խ��� �� üũ
  strSql = " select * from board_notice2 where board_m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
  Else
		Alert_back "�����ϰ��� �ϴ� ����� ����� �ŷ�ó �������� ���� �����մϴ�. \n\n ���� ������  ����� ������ �ּ���!"
		Response.end
  End If

  '�������� , �޿����� �߰� üũ �ؾ� ��.

  'Response.write m_id
  'Response.End
  
  '������� ����
  strSql ="delete emp_list where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  '������� ���� ����
  strSql ="delete emp_admin where m_id='"&m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url " ����� �����߽��ϴ�.","a_emp_list.asp"

  %>