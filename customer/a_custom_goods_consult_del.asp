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
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),0)

  
  strSql = " delete customer_goods_consult where consult_idx="&consult_idx
  Set objRs=objCnn.Execute(strSql)


  '���� �̷� ���� (�����޸�/�ΰ�޸�� ���� �ֽŻ���,,,,)
  strSql = " select isnull(max(consult_idx),0) from customer_goods_consult where g_goods_idx="&g_goods_idx
  strSql = strSql & " and consult_type<>'G' and consult_type<>'H' "  
  Set objRs1=objCnn.Execute(strSql)

  m_consult_idx = objRs1(0)
  
  If m_consult_idx="0" Or m_consult_idx=0 Then

	strSql = " update customer_goods set "
	strSql = strSql & "  g_consult_type	= '' "
	strSql = strSql & ", g_consult_bigo	= '' "
	strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	set objRs=objCnn.Execute(strSql)
  Else

  	strSql = "select * from customer_goods_consult where consult_idx="&m_consult_idx
	Set objRs=objCnn.Execute(strSql)
    
	consult_type		= objRs("consult_type")
	consult_bigo		= objRs("consult_bigo")
    consult_bigo 		= CheckWord(consult_bigo)

	strSql = " update customer_goods set "
	strSql = strSql & "  g_consult_type	= '"&consult_type&"' "
	strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	set objRs=objCnn.Execute(strSql)
  End if

  Alert_url " �̷±��� ���� �Ǿ����ϴ�.","a_custom_goods_regist.asp?g_goods_idx="&g_goods_idx
  %>