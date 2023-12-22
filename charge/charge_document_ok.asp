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
  article_idx		= WORD_CHANGE(Request("article_idx"),20)

  strSql =  " select document_idx from code_document where document_view='Y' "
  strSql = strSql & " and article_idx="&article_idx&" "
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  
  Else
	Do Until objRs.eof
		document_idx		= objRs("document_idx")

		document_charge		= "document_"&document_idx
		document_charge		= request(document_charge)

		If document_charge="" Or IsNull(document_charge)=True Then
				document_charge=0
		End if


		strSql = "select * from charge_document where policy_idx="&policy_idx&" "
		strSql = strSql & " and article_idx="&article_idx&" and document_idx="&document_idx&" "
		Set objRs2=objCnn.Execute(strSql)

		If objRs2.eof Or objRs2.bof Then
			strSql ="insert into charge_document (policy_idx, article_idx, document_idx, document_charge) "
			strSql = strSql & " values("&policy_idx&","&article_idx&","& document_idx&","&document_charge&") "					
			Set objRs3=objCnn.Execute(strSql)
		Else
			strSql = " update charge_document Set document_charge="&document_charge&" "
			strSql = strSql & " where policy_idx="&policy_idx&"  and article_idx="&article_idx&" "
			strSql = strSql & "		and document_idx="& document_idx&" "
			Set objRs3=objCnn.Execute(strSql)
		End if

		objRs.movenext
    loop
  End if

  Alert_url "설정이 저장되었습니다.","charge_document.asp?policy_idx="&policy_idx&"&s_article_idx1="&article_idx
  %>