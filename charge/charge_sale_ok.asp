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
  article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)
  article_idx2		= WORD_CHANGE(Request("s_article_idx2"),20)

  strSql =  " select article_idx, option_idx from code_article_option "
  strSql = strSql & "		where option_view='Y' and article_idx="&article_idx2&" "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  
  Else
	Do Until objRs.eof
		article_idx		= objRs("article_idx")
		option_idx		= objRs("option_idx")

			strSql = " select sale_idx from code_sale where article_idx="&article_idx&" "
			strSql = strSql & " and sale_view='Y' order by sale_name asc "
			Set objRs1=objcnn.Execute(strSql)

			Do Until objRs1.eof
				sale_idx		= objRs1("sale_idx")

			
				Request_val1	= sale_idx&"_"&option_idx
				Request_val1	= request(Request_val1)

				Request_val2	= sale_idx&"_"&option_idx&"_dps"
				Request_val2	= request(Request_val2)

				Request_val3	= sale_idx&"_"&option_idx&"_tps"
				Request_val3	= request(Request_val3)

				If Request_val1="" Or IsNull(Request_val1)=True Then
					Request_val1=0
				End if

				If Request_val2="" Or IsNull(Request_val2)=True Then
					Request_val2=0
				End if

				If Request_val3="" Or IsNull(Request_val3)=True Then
					Request_val3=0
				End if


				strSql = "select * from charge_sale where policy_idx="&policy_idx&" "
				strSql = strSql & " and option_idx="&option_idx&" and sale_idx='"&sale_idx&"'"
				Set objRs2=objCnn.Execute(strSql)

				If objRs2.eof Or objRs2.bof Then
					strSql ="insert into charge_sale(o_code, policy_idx, option_idx, sale_idx, sale_charge,"
					strSql = strSql & " sale_charge_dps,sale_charge_tps) "
					strSql = strSql & " values('"&o_code&"',"&policy_idx&","&option_idx&","&sale_idx&" ,"
					strSql = strSql & " "&Request_val1&","&Request_val2&","&Request_val3&") "
					Set objRs3=objCnn.Execute(strSql)
				Else
					strSql = " update charge_sale Set "
					strSql = stRSql & "  sale_charge		= "&Request_val1&" "
					strSql = stRSql & ", sale_charge_dps	= "&Request_val2&" "
					strSql = stRSql & ", sale_charge_tps	= "&Request_val3&" "
					strSql = strSql & " where policy_idx="&policy_idx&" "
					strSql = strSql & "		and option_idx="&option_idx&" and sale_idx="&sale_idx&" "
					Set objRs3=objCnn.Execute(strSql)
				End if

			'Response.write stRsql&"<br><br><br>"
			'Response.end

			objRs1.movenext
		loop
		objRs.movenext
	loop
  End if


  Alert_url "설정이 저장되었습니다.","charge_sale.asp?policy_idx="&policy_idx&"&s_article_idx1="&article_idx1&"&s_article_idx2="&article_idx2
  %>