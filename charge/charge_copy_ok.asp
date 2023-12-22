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
  t_policy_idx		= WORD_CHANGE(Request("t_policy_idx"),20)
  
  '약정코드 삭제후 복사
  strSql = "delete charge_promise where policy_idx="&t_policy_idx&""
  Set objRs=objCnn.Execute(strSql)
	
  strSql = "INSERT INTO charge_promise (o_code, policy_idx,option_idx, promise_idx, area_idx, promise_charge) "
  strSql = strSql & "	(SELECT o_code, "&t_policy_idx&",option_idx,promise_idx, area_idx, promise_charge "
  strSql = strSql & "		FROM charge_promise where o_code='"&o_code&"' and policy_idx="&policy_idx&") "
  Set objRs=objCnn.Execute(strSql)

  '할인탭코드 삭제후 복사
  strSql = "delete charge_sale where policy_idx="&t_policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql = "INSERT INTO charge_sale (o_code, policy_idx, option_idx, sale_idx, sale_charge, "
  strSql = strSql & "	sale_charge_dps, sale_charge_tps) "
  strSql = strSql & "	(SELECT o_code, "&t_policy_idx&",option_idx,sale_idx,sale_charge, sale_charge_dps, sale_charge_tps "
  strSql = strSql & "		FROM charge_sale where o_code='"&o_code&"' and policy_idx="&policy_idx&") "
  Set objRs=objCnn.Execute(strSql)

  '번들 수수료 삭제후 복사
  strSql = "delete charge_bundle where policy_idx="&t_policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql = "INSERT INTO charge_bundle (o_code, policy_idx, article_idx, bundle_dps_charge, bundle_tps_charge) "
  strSql = strSql & "	(SELECT o_code, "&t_policy_idx&",article_idx, bundle_dps_charge, bundle_tps_charge FROM charge_bundle where o_code='"&o_code&"' and policy_idx="&policy_idx&") "
  Set objRs=objCnn.Execute(strSql)

  '미비서류 삭제후 복사
  strSql = "delete charge_document where policy_idx="&t_policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql = "INSERT INTO charge_document (policy_idx, article_idx, document_idx, document_charge) "
  strSql = strSql & "	(SELECT "&t_policy_idx&",article_idx, document_idx, document_charge FROM charge_document where policy_idx="&policy_idx&") "
  Set objRs=objCnn.Execute(strSql)


  '부가서비스 삭제후 복사
  strSql = "delete charge_buga where policy_idx="&t_policy_idx&" "
  Set objRs=objCnn.Execute(strSql)

  strSql = "INSERT INTO charge_buga (policy_idx, g_article_idx2, service_idx, service_charge) "
  strSql = strSql &" (SELECT "& t_policy_idx &",g_article_idx2, service_idx, service_charge FROM charge_buga where policy_idx="& policy_idx &") "
  Set objRs=objCnn.Execute(strSql)


  '결합수수료
  strSql = "delete charge_combine where policy_idx="& t_policy_idx &" "
  Set objRs=objCnn.Execute(strSql)

  strSql = "INSERT INTO charge_combine (policy_idx, g_article_idx1, combine_idx, combine_charge) "
  strSql = strSql &" (SELECT "& t_policy_idx &",g_article_idx1, combine_idx, combine_charge FROM charge_combine where policy_idx="& policy_idx &") "
  Set objRs=objCnn.Execute(strSql)


  Alert_url "설정이 저장되었습니다.","policy_list.asp"
  %>