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
	Response.end
  end If

  m_id					= WORD_CHANGE(Request("m_id"),20)
  m_dealer_code			= WORD_CHANGE(Request("m_dealer_code"),20)

  If m_id="" Or m_dealer_code="" Then
	Alert_back " ������ �߸��Ǿ����ϴ�."
	Response.End
  End if

  strSql = "select ISNULL(MAX(m_idx)+1,1) AS SEQ from emp_list_dealer"
  Set objRs=objCnn.Execute(strSql)

  m_idx=objRs(0)

  strSql = " insert into emp_list_dealer ("
  strSql = strSql & "  m_idx "
  strSql = strSql & ", m_id"
  strSql = strSql & ", m_dealer_code"
  strSql = strSql & ", m_writeday"
  strSql = strSql & "  ) "
  strSql = strSql & "  values("
  strSql = strSql & "  "& m_idx &" "
  strSql = strSql & ",'"& m_id &"'"
  strSql = strSql & ",'"& m_dealer_code &"'"
  strSql = strSql & ",getdate()"
  strSql = strSql & " )"
  set objRs=objCnn.Execute(strSql)  

  Alert_url " ��� ���� ������ ���/���� �Ǿ����ϴ�.","a_emp_regist.asp?m_id="&m_id
  %>
