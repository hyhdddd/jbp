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
  Response.AddHeader "X-Content-Type-Options", "no-sniff"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_c_code<>"A" then
	Alert_back session_m_name &"님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if
  
  combine_idx		= WORD_CHANGE(Request("combine_idx"),20)

  strSql ="delete code_combine where combine_idx="& combine_idx &" "
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 코드를 삭제했습니다.","combine_list.asp"
  DBClose()
  %>