  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  gita_bigo			= WORD_CHANGE(Request("gita_bigo"),0)

  strSql = "select * from code_gita where gita_idx=1"
  Set objRs = objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql = "INSERT INTO code_gita (gita_idx, gita_bigo) VALUES "
	strSql = strSql &" (1,'"& gita_bigo &"')"
	set objRs=objCnn.Execute(strSql) 
  Else
	strSql = " update code_gita set "
	strSql = strSql &" gita_bigo			= '"& gita_bigo &"'  "
	strSql = strSql &" where gita_idx		= 1 "
	set objRs=objCnn.Execute(strSql)
  End if


  Alert_url "코드가 등록/수정 되었습니다.","gita_regist.asp"
  %>