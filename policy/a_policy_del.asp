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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)

  if ad_r_a_exact="N" then
 	Alert_URL session_m_name &" ���� ��ü ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  policy_idx		= WORD_CHANGE(request("policy_idx"),10)
             	
  strsql = "delete policy_list where policy_idx = "&policy_idx	
  Set objRs=objCnn.Execute(strSql) 	

  strsql = "delete policy_list_article where policy_idx = "&policy_idx	
  Set objRs=objCnn.Execute(strSql) 	

  strsql = "delete policy_list_dealer where policy_idx = "&policy_idx	
  Set objRs=objCnn.Execute(strSql) 	

  Alert_url "������ ��å�� ���� �Ǿ����ϴ�.","a_policy_list.asp"
  %>