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

  c_m_gamang_idx		= WORD_CHANGE(Request("c_m_gamang_idx"),20)

  if ad_g_y_gamang="N" then
 	Alert_URL session_m_name &" ���� ���������� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  strSql="select * from customer_gamang where c_m_gamang_idx="&c_m_gamang_idx
  set objRs=objCnn.Execute(strSql)
  		
  if objRs.eof or objRs.bof Then
	Alert_url "�߸��� ���� �Դϴ�!","y_gamang_list.asp"
  else
  	c_m_m_id			= objRs("c_m_m_id")
  End If
  
  If c_m_m_id=session_m_id Then
	  strSql = " delete customer_gamang where c_m_gamang_idx="&c_m_gamang_idx
	  Set objRs=objCnn.Execute(strSql)

	  strSql = " delete customer_gamang_consult where c_m_gamang_idx="&c_m_gamang_idx
	  Set objRs=objCnn.Execute(strSql)

	  Alert_url " ����ǰ������ �����Ǿ����ϴ�.","y_gamang_list.asp"

  Else
	Alert_url "���� ���� ���� ���� ���� �մϴ�!","y_gamang_list.asp"
  End if

  %>