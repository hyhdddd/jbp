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
  
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  bank_name		= WORD_CHANGE(request("bank_name"),20)
   
  if board_idx<>"" then  
	strSql = " update code_bank set "
	strSql = strSql & "  bank_name = '"& bank_name &"' where board_idx="&board_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. ","bank_list.asp"  
  else  
	strSql = "Select ISNULL(MAX(board_idx)+1,1) from code_bank "
	set objRs=objCnn.Execute(strSql)
	board_idx	= objRs(0)
	
	strSql = "INSERT INTO code_bank (board_idx, bank_name) VALUES "
	strSql = strSql & "("&board_idx&",'" & bank_name & "')"
	set objRs=objCnn.Execute(strSql) 

  Alert_url "�ڵ尡 ��ϵǾ����ϴ�.","bank_list.asp"
  End if
  %>