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

  article_idx			= WORD_CHANGE(Request("article_idx"),20)
  If article_idx="" Then
	Alert_back " ������ �߸��Ǿ����ϴ�."
	Response.end
  End If
  
  strSql = " select * from code_article where article_idx="&article_idx
  Set objRs=objCnn.Execute(strSql)

  article_step1	= objRs("article_step1")
  article_step2	= objRs("article_step2")

  strSql = " select * from code_article_option where article_idx="&article_idx
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
	Alert_back " ��ǰ �ɼ��� �����մϴ�. \n\n �ɼ��� ���� ������� ��ǰ�� �����ֽñ� �ٶ��ϴ�."
	Response.end
  End if
  
  If article_step2>0 Then
    strSql = "select * from customer_goods where g_article_idx2="&article_idx&" " 
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = "delete code_article where article_idx="&article_idx
		Set objRs=objCnn.Execute(strSql)
	Else
		alert_back " �� ��ǰ�� ����ϴ� ���� ���� �մϴ�. \n\n ����ǰ�� ��� ������ �����Ͻ� �� �ֽ��ϴ�."
		Response.end
	End if
  Else
	'ȸ����� �� ��� ��ǰ �˻�
    strSql = "select * from customer_goods where g_article_idx1="&article_step1&" " 
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then

	Else
		alert_back " �� ��ǰ�� ����ϴ� ���� ���� �մϴ�. \n\n ����ǰ�� ��� ������ �����Ͻ� �� �ֽ��ϴ�."
		Response.end
	End If
	
	strSql = " select * from code_article where article_step1="&article_idx&" and article_step2>0"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = "delete code_article where article_idx="&article_idx
		Set objRs=objCnn.Execute(strSql)
	Else
		Alert_back " ���� ��ǰ�� �����մϴ�. \n\n ��ǰ�� ���� ������� ��ǰ�� �����ֽñ� �ٶ��ϴ�."
		Response.end		
	End if
  End If

  Alert_url "��ǰ�� ���� �Ǿ����ϴ�. ","article_list.asp"
  Response.End		
  
  %>