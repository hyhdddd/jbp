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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_c_code="N" then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if

  sale_idx			= WORD_CHANGE(request("sale_idx"),20)
  sale_name			= WORD_CHANGE(request("sale_name"),20)
  sale_view			= WORD_CHANGE(request("sale_view"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  
  article_step1		= WORD_CHANGE(Request("article_step1"),20)
  article_step2		= WORD_CHANGE(Request("article_step2"),20)

  if sale_idx<>"" then  
	strSql = " update code_sale set "
	strSql = strSql & " sale_name = '"& sale_name &"', "
	strSql = strSql & " sale_view = '"& sale_view &"', "
	strSql = strSql & " article_idx = "& article_idx &" "
	strSql = strSql & " where sale_idx='"&sale_idx&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. ","sale_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
	Response.end
  else    
	strSql = "Select ISNULL(MAX(sale_idx)+1,1) from code_sale "
	set objRs=objCnn.Execute(strSql)
	sale_idx		= objRs(0)

	strSql = "INSERT INTO code_sale (sale_idx, article_idx, o_code, sale_name,sale_view, sale_order, sale_writeday) VALUES "
	strSql = strSql & " ("& sale_idx &","&article_idx&",'" & o_code & "','" & sale_name & "','"& sale_view &"',"& sale_idx &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "�ڵ尡 ��ϵǾ����ϴ�.","sale_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
  %>