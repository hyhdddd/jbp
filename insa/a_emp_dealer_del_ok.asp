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

  if ad_i_a_emp="N" then
	Alert_url session_m_name &" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  
  m_id		= WORD_CHANGE(Request("m_id"),20)
  m_idx		= WORD_CHANGE(Request("m_idx"),20)
  
  '������� ����
  strSql ="delete emp_list_dealer where m_idx="&m_idx&" "
  Set objRs=objCnn.Execute(strSql)

  Alert_url " ����ü�� �����߽��ϴ�.","a_emp_regist.asp?m_id="+m_id
  %>