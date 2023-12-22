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
  s_article_idx1	= WORD_CHANGE(Request("article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("article_idx2"),20)
  area_idx			= WORD_CHANGE(request("area_idx"),20)

  strSql = " select * from code_promise where article_idx="&s_article_idx2
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  
  Else
	Do Until objRs.eof
		promise_idx	= objRs("promise_idx")

		strSql =" select * from code_article_option where option_view='Y' "
		strSql = strSql & " and article_idx="&s_article_idx2
		Set objRs1=objCnn.Execute(strSql)

		Do Until objRs1.eof 
			option_idx	= objRs1("option_idx")
				
			Request_val	= promise_idx&"_"&option_idx
			Request_val1 = request(Request_Val)

			If Request_val1="" Or IsNull(Request_val1)=True Then
				Request_val1=0
			End if
			
			strSql = "select * from charge_promise where policy_idx="&policy_idx&" "
			strSql = strSql & " and option_idx="&option_idx&" "
			strSql = strSql & "	and promise_idx= "&promise_idx&" "
			strSql = strSql & " and area_idx="& area_idx &" "
			'Response.write strSql
			Set objRs2=objCnn.Execute(strSql)

			If objRs2.eof Or objRs2.bof Then
				strSql ="insert into charge_promise(o_code, policy_idx, option_idx, promise_idx, area_idx, promise_charge) "
				strSql = strSql & " values('"&o_code&"', "&policy_idx&" ,"&option_idx&","&promise_idx&", "
				strSql = strSql & " "&area_idx&", "&Request_val1&") "					
				Set objRs3=objCnn.Execute(strSql)
			Else
				strSql = " update charge_promise Set promise_charge="&Request_val1&" "
				strSql = strSql & " where policy_idx="&policy_idx&" "
				strSql = strSql & "		and option_idx="&option_idx&" "
				strSql = strSql & "		and promise_idx="&promise_idx&" "
				strSql = strSql & "		and area_idx="& area_idx &" "
				Set objRs3=objCnn.Execute(strSql)
			End If
			
			'Response.write strSql &"<br><Br>"

			objRs1.movenext
		loop
		objRs.movenext
	loop
  End if

  Alert_url "설정이 저장되었습니다.","charge_promise.asp?policy_idx="&policy_idx&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&s_article_idx2&"&g_code_area="&area_idx
  %>