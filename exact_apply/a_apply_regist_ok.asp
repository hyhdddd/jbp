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
  if ad_a_gift="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If	
  
  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)
  apply_date		= WORD_CHANGE(Request("apply_date"),20)
  apply_idx			= WORD_CHANGE(Request("apply_idx"),20)
  apply_status		= WORD_CHANGE(Request("apply_status"),20)
  apply_m_id		= session_m_id
  
  If apply_date="" Then
	Alert_back "�߸��� �����Դϴ�."
	Response.end
  End If
  
  If apply_idx<>"" Then
	strSql = " update exact_apply set "
	strSql = strSql &"  apply_date		= '"& apply_date &"' "
	strSql = strSql &", apply_status	= '"& apply_status &"' "
	strSql = strSql &"  where apply_idx	=  "& apply_idx
	set objRs=objCnn.Execute(strSql)
  Else
	strSql = "Select ISNULL(MAX(apply_idx)+1,1) from exact_apply"
	set objRs=objCnn.Execute(strSql)
	apply_idx	= objRs(0)
	  
	strSql = " INSERT INTO exact_apply (apply_idx, apply_date, apply_m_id, apply_status, apply_writeday)"
	strSql = strSql &" values ("
	strSql = strSql &"   "& apply_idx &" "
	strSql = strSql &", '"& apply_date &"' "
	strSql = strSql &", '"& apply_m_id &"' "
	strSql = strSql &", '"& apply_status &"' "
	strSql = strSql &", getdate()) "
	set objRs=objCnn.Execute(strSql)
  End If
  
  Alert_url "������ ��û�� �Ϸ� �Ǿ����ϴ�.","a_apply_list.asp?page="&page
  DBClose() 
  %>
