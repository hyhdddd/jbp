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
	Alert_back session_m_name &" 님은 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If

  article_idx			= WORD_CHANGE(Request("article_idx"),20)
  If article_idx="" Then
	Alert_back " 접근이 잘못되었습니다."
	Response.end
  End If
  
  strSql = " select * from code_article where article_idx="&article_idx
  Set objRs=objCnn.Execute(strSql)

  article_step1	= objRs("article_step1")
  article_step2	= objRs("article_step2")

  strSql = " select * from code_article_option where article_idx="&article_idx
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
	Alert_back " 상품 옵션이 존재합니다. \n\n 옵션을 먼저 지우신후 상품을 지워주시기 바랍니다."
	Response.end
  End if
  
  If article_step2>0 Then
    strSql = "select * from customer_goods where g_article_idx2="&article_idx&" " 
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = "delete code_article where article_idx="&article_idx
		Set objRs=objCnn.Execute(strSql)
	Else
		alert_back " 이 상품을 사용하는 고객이 존재 합니다. \n\n 고객상품을 모두 삭제후 삭제하실 수 있습니다."
		Response.end
	End if
  Else
	'회사삭제 일 경우 상품 검색
    strSql = "select * from customer_goods where g_article_idx1="&article_step1&" " 
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then

	Else
		alert_back " 이 상품을 사용하는 고객이 존재 합니다. \n\n 고객상품을 모두 삭제후 삭제하실 수 있습니다."
		Response.end
	End If
	
	strSql = " select * from code_article where article_step1="&article_idx&" and article_step2>0"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = "delete code_article where article_idx="&article_idx
		Set objRs=objCnn.Execute(strSql)
	Else
		Alert_back " 하위 상품이 존재합니다. \n\n 상품을 먼저 지우신후 상품을 지워주시기 바랍니다."
		Response.end		
	End if
  End If

  Alert_url "상품이 삭제 되었습니다. ","article_list.asp"
  Response.End		
  
  %>