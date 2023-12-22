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
	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  option_idx			= WORD_CHANGE(request("option_idx"),20)
  article_idx			= WORD_CHANGE(Request("article_idx"),20)


  if ad_c_code="A" Then
  else
	Alert_back session_m_name&" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If

  if option_idx<>"" then  
	strSql = " select * from code_article_option where option_idx="&option_idx
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
	
	Else
		article_idx = objRs("article_idx")			'중분류
	End If
	strSql = " select * from code_article where article_idx="&article_idx
	Set objRs=objCnn.Execute(stRSql)

	If objRs.eof Or objRs.bof Then
	
	Else
		article_step1 = objRs("article_step1")		'대분류
		article_step2 = objRs("article_step2")

	    strSql = "select * from customer_goods where g_article_idx1="&article_step1&" and g_article_idx2="&article_idx&" "
		strSql = strSql & " and g_option_idx="&option_idx&" " 
		Set objRs=objCnn.Execute(strSql)

		If objRs.eof Or objRs.bof Then
		
		Else
			alert_back " 이 상품을 사용하는 고객이 존재 합니다. \n\n 고객상품을 모두 삭제후 삭제하실 수 있습니다."
			Response.end
		End if

	End If

	strSql = " delete code_article_option where option_idx="&option_idx
	set objRs=objCnn.Execute(strSql)

	Alert_url "상품 옵션이 삭제 되었습니다. ","option_list.asp?article_idx="&article_idx
	Response.End
  End if
  %>