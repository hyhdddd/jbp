  <%	
	g_charge_bigo_doc		= ""
	g_code_document1		= Split(g_code_document,",")

	'전체가입신청 미비서류 차감
	'정책 가져오기 

 	strSql = "select dealer_group_code from dealer_info where dealer_code='"&g_trans_in_dealer&"'"
	Set objRs=objCnn.Execute(strSql)

	dealer_group_code = objRs("dealer_group_code")

	If dealer_group_code="" Or IsNull(dealer_group_code)=True Then
		Alert_back "수수료 기초자료(딜러점 그룹설정)가 셋팅되지 않아 접수를 받을 수 없습니다.\n\n 관리자에 문의하세요!"
	End If
	
	'정책 가져오기 
	strSql = "select top 1 policy_idx from charge_policy where group_code='"&dealer_group_code&"' "
	strSql = strSql & " and policy_date<='"& fnc_date_change(g_date_yuchi) &"' " 
	strSql = strSql & "		order by policy_date desc "
    Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		policy_idx	= 0
	Else
		policy_idx	= objRs("policy_idx")
	End If

	
	If UBound(g_code_document1)<0 Then
		g_charge_document		= 0
	else
		strSql = "select sum(document_charge) from charge_document where policy_idx="& policy_idx &" "
		strSql = strSql & " and article_idx="& g_article_idx1 &" "
		strSql = strSql & " and document_idx in ("& g_code_document &") "
		'Response.write strSql &"<br>"
		Set objRs=objCnn.Execute(strSql)
		
		g_charge_document		= money_chk(objRs(0))

		strSql = "select document_name from code_document where document_idx in ("& g_code_document &") "
		Set objRs5=objCnn.Execute(strSql)

		If objRs5.eof Or objRs5.bof Then
			g_charge_bigo_doc = ""
		Else
			Do Until objRs5.eof
				document_name		= objRs5("document_name")
				g_charge_bigo_doc	= g_charge_bigo_doc + document_name & ", "

				objRs5.movenext
			Loop
			
			g_charge_bigo_doc		= Left(g_charge_bigo_doc,Len(g_charge_bigo_doc)-2)
		End if
	End if	
    
	'미비서류 정산입력 (일반정산에만 저장)
	strSql = " Update customer_goods_charge Set "
	strSql = strSql & " g_charge_document="& g_charge_document &", "
	strSql = strSql & " g_charge_bigo_doc='"& g_charge_bigo_doc & "' "
	strSql = strSql & " where g_goods_idx="& g_goods_idx & " and g_charge_type='G' "
	Set objRs=objCnn.Execute(strSql)



  %>