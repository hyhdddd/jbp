  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Server.ScriptTimeout = 50000 
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  StartTimer = Timer()
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if		

  policy_idx			= WORD_CHANGE(Request("policy_idx"),20)
  group_code			= WORD_CHANGE(Request("group_code"),20)
  page					= WORD_CHANGE(Request("page"),20)
  s_group_code			= WORD_CHANGE(Request("s_group_code"),20)

  strSql = "select policy_date from charge_policy where policy_idx="&policy_idx
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  s_policy_date = fnc_date_change(objRs("policy_date"))		'적용 시작일

  strSql = " select min(policy_date) from charge_policy "
  strSql = strSql & " where group_code='"&group_code&"' and policy_date>'"&s_policy_date&"' "
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	e_policy_date   = "null"
  Else
	If IsNull(objRs(0)) Then
		e_policy_date ="null"
	else
		e_policy_date	= fnc_date_change(objRs(0))	
	End if
  End If

  '이 기간중 유치건  불러오기

  strSql = "select g_goods_idx, g_article_idx1, g_code_promise, g_article_idx2, g_option_idx, g_sp_give_type, g_sp_price, g_code_sale, g_code_service, g_code_combine, "  
  strSql = strSql & " g_sp_price_top, g_set, g_code_area, g_code_document	from customer_goods "
  strSql = strSql & "		where g_trans_in_dealer in (select dealer_code from dealer_info "
  strSql = strSql & "			where dealer_group_code='"& group_code &"')"
  strSql = strSql & "				and g_date_yuchi>='"& s_policy_date &"' "

  If e_policy_date<>"null" then
	  strSql = strSql & "		and g_date_yuchi<'"&e_policy_date&"' "
  End If
  'Response.write strSql
  Set objRs1=objCnn.Execute(strSql)
  i=0

  Do Until objRs1.eof 
	g_goods_idx			= objRs1("g_goods_idx")
	g_code_promise		= objRs1("g_code_promise")
	g_article_idx1		= objRs1("g_article_idx1")
	g_article_idx2		= objRs1("g_article_idx2")
	g_option_idx		= objRs1("g_option_idx")
	g_sp_give_type		= objRs1("g_sp_give_type")
	g_sp_price			= objRs1("g_sp_price")
	g_sp_price_top		= money_chk(objRs1("g_sp_price_top"))
	g_code_sale			= objRs1("g_code_sale")
	g_set				= objRs1("g_set")
	g_code_service		= money_chk(objRs1("g_code_service"))
	g_code_area			= money_chk(objRs1("g_code_area"))
	g_code_document		= money_chk(objRs1("g_code_document"))
	g_code_combine		= money_chk(objRs1("g_code_combine"))

	'사은품 불러오기(유치자지급)
	If g_sp_give_type="A" Or g_sp_give_type="E" Then
		g_charge_sp		= 0
	Else
		g_charge_sp		=  money_chk(g_sp_price)
	End If
	
	g_charge_sp_top		= g_sp_price_top

	'수수료정책  불러오기
	strSql = " select A.promise_charge, B.sale_charge, B.sale_charge_dps, B.sale_charge_tps, "
	strSql = strSql & " C.bundle_dps_charge, C.bundle_tps_charge, D.document_charge, E.service_charge, F.combine_charge "
	strSql = strSql & " from  "
	strSql = strSql & "		(select	isnull(sum(promise_charge),0) as promise_charge from charge_promise "
	strSql = strSql & "			where option_idx="& g_option_idx &" and promise_idx="& g_code_promise &" "
	strSql = strSql & "				and policy_idx="& policy_idx &" and area_idx="& g_code_area &" ) A, "

	strSql = strSql & "		(select	isnull(sum(sale_charge),0) as sale_charge,  "
	strSql = strSql & "				isnull(sum(sale_charge_dps),0) as sale_charge_dps,  "
	strSql = strSql & "				isnull(sum(sale_charge_tps),0) as sale_charge_tps from charge_sale "
	strSql = strSql & "			where option_idx="& g_option_idx &" and sale_idx="& g_code_sale &" "
	strSql = strSql & "				and policy_idx="& policy_idx &" ) B, "

	strSql = strSql & "		(select	isnull(sum(bundle_dps_charge),0) as bundle_dps_charge ,  "
	strSql = strSql & "				isnull(sum(bundle_tps_charge),0) as bundle_tps_charge from charge_bundle "	
	strSql = strSql & "			where article_idx="& g_option_idx &" and policy_idx="& policy_idx &" ) C, "

	strSql = strSql & "		(select	isnull(sum(document_charge),0) as document_charge	from charge_document "
	strSql = strSql & "			where policy_idx="& policy_idx &" and article_idx="& g_article_idx1 &" "
	strSql = strSql & "				and document_idx in ("& g_code_document &"))  D, "

	strSql = strSql & "		(select	isnull(sum(service_charge),0) as service_charge	from charge_buga "
	strSql = strSql & "			where policy_idx="& policy_idx &" and service_idx="& g_code_service &")  E, "

	strSql = strSql & "		(select	isnull(sum(combine_charge),0) as combine_charge	from charge_combine "
	strSql = strSql & "			where policy_idx="& policy_idx &" and combine_idx="& g_code_combine &")  F "

	Set objRs=objCnn.Execute(strSql)
	
	'약정수수료
    g_promise_charge	= money_chk(objRs("promise_charge"))
	
	'할인탭
	g_charge_sale		= money_chk(objRs("sale_charge"))
	g_charge_sale_dps	= money_chk(objRs("sale_charge_dps"))
	g_charge_sale_tps	= money_chk(objRs("sale_charge_tps"))


	If g_set="B" Then
		g_charge_sale		= money_chk(g_charge_sale_dps)
	ElseIf g_set="C" Then
		g_charge_sale		= money_chk(g_charge_sale_tps)	
	Else
		g_charge_sale		= money_chk(g_charge_sale)
	End If	

	'번들 수수료
	bundle_dps_charge	= money_chk(objRs("bundle_dps_charge"))
	bundle_tps_charge	= money_chk(objRs("bundle_tps_charge"))

	If g_set="B" Then
		g_charge_bundle		= bundle_dps_charge
	ElseIf g_set="C" Then
		g_charge_bundle		= bundle_tps_charge	
	Else
		g_charge_bundle		= "0"
	End If

	'미비서류 차감
	g_charge_document		= money_chk(objRs("document_charge"))
	g_charge_buga			= money_chk(objRs("service_charge"))
	g_charge_combine		= money_chk(objRs("combine_charge"))


    strSql = "select g_charge_idx from customer_goods_charge where g_goods_idx="& g_goods_idx &"  and g_charge_type='G'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof then
		'정산입력	
		strSql =" insert into customer_goods_charge(g_goods_idx, o_code, g_charge_type, g_charge_promise, "
		strSql = strSql & " g_charge_sp_top, g_charge_sp, g_charge_sale, g_charge_document, g_charge_bundle, g_charge_buga, g_charge_combine, "
		strSql = strSql & " g_charge_writeday) "
		strSql = strSql & " values ("&g_goods_idx&",'"&o_code&"','G',"&g_promise_charge&","
		strSql = strSql & " "& g_charge_sp_top &","& g_charge_sp &","& g_charge_sale &","&g_charge_document &", "
		strSql = strSql & " "& g_charge_bundle &", "& g_charge_buga &", "& g_charge_combine &", getdate())"
		'Response.write strsQl
		Set objRs=objCnn.Execute(strSql)
	Else
		g_charge_idx	= objRs("g_charge_idx")

		strSql = " update customer_goods_charge set "
		strSql = strSql &"  g_charge_promise	="& g_promise_charge &" "
		strSql = strSql &", g_charge_sp_top		= "& g_charge_sp_top &" "
		strSql = strSql &", g_charge_sp			= "& g_charge_sp &" "
		strSql = strSql &", g_charge_sale		= "& g_charge_sale &" "
		strSql = strSql &", g_charge_document	= "& g_charge_document &" "
		strSql = strSql &", g_charge_bundle		= "& g_charge_bundle &" "
		strSql = strSql &", g_charge_buga		= "& g_charge_buga &" "
		strSql = strSql &", g_charge_combine	= "& g_charge_combine &" "
		strSql = strSql &"	where g_charge_idx	= "& g_charge_idx
		Set objRs=objCnn.Execute(strSql)
	End if

	i=i+1
	objRs1.movenext
	
  loop

  Alert_url "기간내 접수된 고객의 정산이 일괄 처리 되었습니다. ("&i&"건) \n\n["& FormatNumber(runtimer, 3)&" sec] ","policy_list.asp?page="&page&"&s_group_code="&s_group_code
  %>  