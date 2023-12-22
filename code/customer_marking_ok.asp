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
	Alert_back session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	response.end
  end If
  
  o_marking				= WORD_CHANGE(money_chk(request("o_marking")),20)

  strSql = "update company_info set o_marking="& o_marking &""

  Set objRs=objCnn.Execute(strsql)

  Alert_url "저장 되었습니다.","customer_marking.asp"
  %>