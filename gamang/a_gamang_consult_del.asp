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

  if session_m_step="M" Then
  else
 	Alert_URL session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
	Response.end
  end if	 

  consult_idx			= WORD_CHANGE(request("consult_idx"),20)
  c_m_gamang_idx		= WORD_CHANGE(request("c_m_gamang_idx"),20)
  
  strSql = " delete customer_gamang_consult where consult_idx="&consult_idx
  Set objRs=objCnn.Execute(strSql)


  '���� �̷� ���� (�����޸�/�ΰ�޸�� ���� �ֽŻ���,,,,)
  strSql = " select isnull(max(consult_idx),0) from customer_gamang_consult where c_m_gamang_idx="&c_m_gamang_idx  
  Set objRs1=objCnn.Execute(strSql)

  m_consult_idx = objRs1(0)
  
  If m_consult_idx="0" Or m_consult_idx=0 Then

	strSql = " update customer_gamang set "
	strSql = strSql & "  c_m_consult_type	= '' "
	strSql = strSql & ", c_m_consult_bigo	= '' "
	strSql = strSql & "	where c_m_gamang_idx	= "&c_m_gamang_idx&" "
	set objRs=objCnn.Execute(strSql)
  Else

  	strSql = "select * from customer_gamang_consult where consult_idx="&m_consult_idx
	Set objRs=objCnn.Execute(strSql)
    
	consult_type		= objRs("consult_type")
	consult_bigo		= objRs("consult_bigo")

	strSql = " update customer_gamang set "
	strSql = strSql & "  c_m_consult_type	= '"&consult_type&"' "
	strSql = strSql & ", c_m_consult_bigo	= '"&consult_bigo&"' "
	strSql = strSql & "	where c_m_gamang_idx	= "&c_m_gamang_idx&" "
	set objRs=objCnn.Execute(strSql)
  End If
  
  Alert_url " �̷±��� ���� �Ǿ����ϴ�.","a_gamang_regist.asp?c_m_gamang_idx="&c_m_gamang_idx
  %>