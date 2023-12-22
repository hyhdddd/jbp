  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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

	Alert_url "코드가 수정 되었습니다. ","card_list.asp"  
  else  
	strSql = "Select ISNULL(MAX(board_idx)+1,1) from code_card "
	set objRs=objCnn.Execute(strSql)
	board_idx	= objRs(0)
	
	strSql = "INSERT INTO code_card (board_idx, card_name) VALUES "
	strSql = strSql & "("&board_idx&",'" & card_name & "')"
	set objRs=objCnn.Execute(strSql) 

  Alert_url "코드가 등록되었습니다.","card_list.asp"
  End if
  %>