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

  document_idx			= WORD_CHANGE(request("document_idx"),20)
  document_name			= WORD_CHANGE(request("document_name"),20)
  document_view			= WORD_CHANGE(request("document_view"),20)
  article_idx			= WORD_CHANGE(Request("article_idx"),20)
 
  if document_idx<>"" then  
	strSql = " update code_document set "
	strSql = strSql & " document_name = '"& document_name &"'"
	strSql = strSql & ", document_view = '"& document_view &"'"
	strSql = strSql & " where document_idx="&document_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url " �ڵ尡 ���� �Ǿ����ϴ�. ","document_list.asp"
	Response.end
  else   
	strSql = "Select ISNULL(MAX(document_idx)+1,1) from code_document "
	set objRs=objCnn.Execute(strSql)
	document_idx	= objRs(0)

	strSql = "INSERT INTO code_document (document_idx, article_idx, document_view, document_name, "
	strSql = strSql & " document_order, document_writeday) VALUES "
	strSql = strSql & " ("& document_idx &","&article_idx&", '"& document_view &"',"
	strSql = strSql & " '" & document_name & "',"& document_idx &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url " �ڵ尡 ��ϵǾ����ϴ�.","document_list.asp"
  %>