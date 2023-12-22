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

  if ad_c_code="A" Then
  else
	Alert_back session_m_name&" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  board_idx		= WORD_CHANGE(Request("board_idx"),20)
  message_chk	= "O"
  

  strSql = " select count(*) from customer_goods where g_card_cd="&board_idx& " "
  Set objRs=objCnn.Execute(strSql)
  
  
  If objRs(0)="0" Or objRs(0)=0  Then
  Else
	Message_txt1 = "고객정보 ("&objRs(0)&"건) "
	Message_chk = "X"
  End If
  
  If Message_chk="X" Then
  	Alert_back Message_txt1 & " 에서 코드를 사용하고 있으므로 삭제할 수 없습니다."
	Response.end
  Else

	strSql ="delete code_card where board_idx="& board_idx &" "
	Set objRs=objCnn.Execute(strSql)

	Alert_url " 코드를 삭제했습니다.","card_list.asp"
  End if  
  %>