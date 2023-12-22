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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  policy_idx		= WORD_CHANGE(Request("policy_idx"),20)

  '번들수수료 삭제
  strSql ="delete charge_bundle where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  '약정수수료 삭제
  strSql ="delete charge_promise where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  '할인탭 삭제
  strSql ="delete charge_sale where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql ="delete charge_policy where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	
  
  '미비서류 삭제
  strSql ="delete charge_document where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	

  '부가서비스삭제
  strSql ="delete charge_buga where policy_idx="&policy_idx&" "
  Set objRs=objCnn.Execute(strSql)	

  Alert_url " 코드를 삭제했습니다.","policy_list.asp"
  %>