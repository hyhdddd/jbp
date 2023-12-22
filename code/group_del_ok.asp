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
	Alert_back session_m_name &" 님은 개통정보 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  group_idx		= WORD_CHANGE(Request("group_idx"),20)

  strSql = " select group_code from code_group where group_idx="&group_idx
  Set objRs=objCnn.Execute(strSql)

  group_code = objRs(0)

  strSql = " select * from dealer_info where dealer_group_code='"&group_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete code_group where group_code='"&group_code&"'"
	Set objRs=objCnn.Execute(strSql)

	'번들 수수료설정 해당 그룹코드 삭제
	strSql ="select policy_idx from charge_policy where group_code='"&group_code&"'"
	Set objRs1=objCnn.Execute(strSql)

	Do Until objRs1.eof 
		policy_idx = objRs1("policy_idx")

		'약정 수수료설정 해당 그룹코드 삭제
		strSql ="delete charge_bundle where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)


		'약정 수수료설정 해당 그룹코드 삭제
		strSql ="delete charge_promise where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		'할인탭 수수료설정 해당 그룹코드 삭제
		strSql ="delete charge_sale where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		strSql ="delete charge_policy where policy_idx="&policy_idx&" "
		Set objRs=objCnn.Execute(strSql)

		objRs1.movenext
	loop
	

	Alert_url " 코드를 삭제했습니다.","group_list.asp"
  Else
  	Alert_back " 삭제하고자 하는 코드를 사용하는 딜러점이 존재합니다. \n\n 거래처정보관리에서 정산그룹을 바꾸신후 코드를 지워주시기 바랍니다."
	Response.end
  End if  
  %>