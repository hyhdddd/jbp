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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  page				= WORD_CHANGE(Request("page"),20)
  apply_date		= WORD_CHANGE(Request("apply_date"),20)
  apply_m_id		= session_m_id
  
  If apply_date="" Then
	Alert_back "�߸��� �����Դϴ�."
	Response.end
  End If
  
  strSql = "Select ISNULL(MAX(apply_idx)+1,1) from exact_apply"
  set objRs=objCnn.Execute(strSql)
  apply_idx	= objRs(0)
	  
  strSql = " INSERT INTO exact_apply (apply_idx, apply_date, apply_m_id, apply_status, apply_writeday)"
  strSql = strSql &" values ("
  strSql = strSql &"   "& apply_idx &" "
  strSql = strSql &", '"& apply_date &"' "
  strSql = strSql &", '"& apply_m_id &"' "
  strSql = strSql &", '��û', getdate()) "
  set objRs=objCnn.Execute(strSql)

  Alert_url "������ ��û�� �Ϸ� �Ǿ����ϴ�.","p_apply_list.asp?page="&page
  DBClose() 
  %>
