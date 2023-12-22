 <%
  '====================================='
  ' 프로젝트 : SENQ OPEN MARKET
  ' 목    적 : OPEN MARKET 형태의 쇼핑몰
  ' 개발일자 : 2008/07/01 ~2008/12/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com (네이트온)
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"  
  %>  
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <%

  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  document_order	= WORD_CHANGE(Request("document_order"),20)
  document_idx		= WORD_CHANGE(Request("document_idx"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(document_order),0) from code_document where article_idx="&article_idx&" "
	strSql = strSql & " and document_order>"&document_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select document_idx from code_document where document_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		document_idx1	= objRs2(0)

		if document_idx1="0" or document_idx1="" then
  		else
  			strSql = "update code_document set document_order="&document_order&" where document_idx="&document_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_document set document_order="&sorting1&" where document_idx="&document_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(document_order),0) from code_document where article_idx="&article_idx&" "
	strSql = strSql & " and  document_order<"&document_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select document_idx from code_document where  document_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		document_idx1	= objRs2(0)

  		if document_idx1="0" or document_idx1="" then  		
  		else
	  		strSql = "update code_document set document_order="&document_order&" where document_idx="&document_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_document set document_order="&sorting1&" where document_idx="&document_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "document_order.asp?page="&page&"&article_idx="&article_idx
  %>

