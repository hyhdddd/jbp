  <%
    area_idx		= g_code_area

 	strSql = "select dealer_group_code from dealer_info where dealer_code='"&c_g_trans_in_dealer&"'"
	Set objRs=objCnn.Execute(strSql)

	dealer_group_code = objRs("dealer_group_code")

	If dealer_group_code="" Or IsNull(dealer_group_code)=True Then
		Alert_back "수수료 기초자료(딜러점 그룹설정)가 셋팅되지 않아 접수를 받을 수 없습니다.\n\n 관리자에 문의하세요!"
	End If
	
	'정책 가져오기 
	strSql = "select top 1 policy_idx from charge_policy where group_code='"&dealer_group_code&"' "
	strSql = strSql & " and policy_date<=getdate() "
	strSql = strSql & "		order by policy_date desc "
    Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		policy_idx	= 0
	Else
		policy_idx	= objRs("policy_idx")
	End If
	
	'약정 불러오기
	strSql = "select promise_charge from charge_promise where option_idx="& c_g_option_idx & ""
	strSql = strSql & " and promise_idx="& c_g_code_promise_idx &""
	strSql = strSql & " and policy_idx="& policy_idx & ""
	strSql = strSql & " and area_idx="& area_idx &" "
	Set objRs=objCnn.Execute(strSql)
	
	If objRs.eof Or objRs.bof Then
		g_promise_charge=0
	Else
		g_promise_charge	= money_chk(objRs("promise_charge"))

		'회선수 계산
		If g_promise_charge="0" Or g_promise_charge=0 Or IsNull(g_promise_charge)=True Then
			g_promise_charge	= 0
		else
			g_promise_charge	= CDbl(g_promise_charge * c_g_article_cnt)
		End if
	End If

	'사은품 불러오기(유치자지급)
	If c_g_sp_give_type="A" Or c_g_sp_give_type="E" Then
		g_charge_sp		= 0
	Else
		g_charge_sp		= c_g_sp_price
	End If
	
	'본사사은품
	g_charge_sp_top		= c_g_sp_price_top
	
	'할인탭 불러오기
	strSql = " select sale_charge,sale_charge_dps, sale_charge_tps from charge_sale where option_idx="& c_g_option_idx &" "
	strSql = strSql & " and sale_idx="& c_g_code_sale &" "
	strSql = strSql & " and policy_idx="& policy_idx & " "
	Set objRs=objCnn.Execute(strSql)
	
	If objRs.eof Or objRs.bof Then
		g_charge_sale		= 0
		g_charge_sale_dps	= 0
		g_charge_sale_tps	= 0
	Else
		g_charge_sale		= objRs("sale_charge")
		g_charge_sale_dps	= objRs("sale_charge_dps")
		g_charge_sale_tps	= objRs("sale_charge_tps")

	End If

	If goods_cnt="2" Then
		g_charge_sale		= money_chk(g_charge_sale_dps)
	ElseIf goods_cnt="3" Then
		g_charge_sale		= money_chk(g_charge_sale_tps)	
	Else
		g_charge_sale		= money_chk(g_charge_sale)
	End If
	
	'할인탭 회선수 계산 
	If g_charge_sale="0" Or g_charge_sale=0 Or IsNull(g_charge_sale)=True Then
		g_charge_sale = 0
	Else
		g_charge_sale = CDbl(g_charge_sale * c_g_article_cnt)
	End if
	
	'번들수수료 불러오기
	strSql = " select bundle_dps_charge,bundle_tps_charge from charge_bundle where article_idx="& c_g_option_idx &" "
	strSql = strSql & " and policy_idx="& policy_idx &" "
	Set objRs=objCnn.Execute(strSql)
		
	If objRs.eof Or objRs.bof Then
		bundle_dps_charge	= 0
		bundle_tps_charge	= 0
	Else
		bundle_dps_charge	= money_chk(objRs("bundle_dps_charge"))
		bundle_tps_charge	= money_chk(objRs("bundle_tps_charge"))
	End If

	If goods_cnt="2" Then
		g_charge_bundle		= bundle_dps_charge
	ElseIf goods_cnt="3" Then
		g_charge_bundle		= bundle_tps_charge	
	Else
		g_charge_bundle		= "0"
	End If	

	'정산입력	
	strSql =" insert into customer_goods_charge(g_goods_idx, o_code, g_charge_type, "
	strSql = strSql & " g_charge_promise, g_charge_sp_top, g_charge_sp, g_charge_sale, g_charge_document, "
	strSql = strSql & " g_charge_gita, g_charge_bundle, g_charge_writeday) "
	strSql = strSql & " values ("&g_goods_idx&", '"&o_code&"', 'G', "&g_promise_charge&","
	strSql = strSql & " "&g_charge_sp_top&","&g_charge_sp&", "&g_charge_sale&", 0, 0, "&g_charge_bundle&", getdate())"
	'Response.write strsQl&"<br><br>"
	Set objRs=objCnn.Execute(strSql)
  %>