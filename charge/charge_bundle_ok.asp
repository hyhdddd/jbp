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

  policy_idx		= WORD_CHANGE(request("policy_idx"),20)

  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("s_article_idx2"),20)

  strSql =  " select option_idx from code_article_option where option_view='Y' "
  strSql = strSql & " and article_idx="&s_article_idx2&" "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  
  Else
	Do Until objRs.eof
		option_idx			= objRs("option_idx")

		bundle_dps_charge	= "DPS_"&option_idx
		bundle_dps_charge	= request(bundle_dps_charge)

		bundle_tps_charge	= "TPS_"&option_idx
		bundle_tps_charge	= request(bundle_tps_charge)

		If bundle_dps_charge="" Or IsNull(bundle_dps_charge)=True Then
				bundle_dps_charge=0
		End if

		If bundle_tps_charge="" Or IsNull(bundle_tps_charge)=True Then
				bundle_tps_charge=0
		End if

		strSql = "select * from charge_bundle where policy_idx="&policy_idx&""
		strSql = strSql & " and article_idx="&option_idx&" "
		Set objRs2=objCnn.Execute(strSql)

		If objRs2.eof Or objRs.bof Then
			strSql ="insert into charge_bundle(o_code, policy_idx, article_idx, bundle_dps_charge,bundle_tps_charge) "
			strSql = strSql & " values('"&o_code&"',"&policy_idx&","&option_idx&","&bundle_dps_charge&" ,"
			strSql = strSql & " "&bundle_tps_charge&") "					
			Set objRs3=objCnn.Execute(strSql)
		Else
			strSql = " update charge_bundle Set bundle_dps_charge="&bundle_dps_charge&",bundle_tps_charge="&bundle_tps_charge
			strSql = strSql & " where o_code='"&o_code&"' and policy_idx="&policy_idx&" "
			strSql = strSql & "		and article_idx="&option_idx&" "
			'Response.write strSql
			Set objRs3=objCnn.Execute(strSql)
		End if

		objRs.movenext
    loop
  End if

  Alert_url "설정이 저장되었습니다.","charge_bundle.asp?policy_idx="&policy_idx&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&s_article_idx2
  %>