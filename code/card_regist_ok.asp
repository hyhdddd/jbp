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
  card_name		= WORD_CHANGE(request("card_name"),20)
   
  if board_idx<>"" then  
	strSql = " update code_card set "
	strSql = strSql & "  card_name = '"& card_name &"' where board_idx="&board_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "�ڵ尡 ���� �Ǿ����ϴ�. ","card_list.asp"  
  else  
	strSql = "Select ISNULL(MAX(board_idx)+1,1) from code_card "
	set objRs=objCnn.Execute(strSql)
	board_idx	= objRs(0)
	
	strSql = "INSERT INTO code_card (board_idx, card_name) VALUES "
	strSql = strSql & "("&board_idx&",'" & card_name & "')"
	set objRs=objCnn.Execute(strSql) 

  Alert_url "�ڵ尡 ��ϵǾ����ϴ�.","card_list.asp"
  End if
  %>