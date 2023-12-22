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
  service_order		= WORD_CHANGE(Request("service_order"),20)
  service_idx		= WORD_CHANGE(Request("service_idx"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(service_order),0) from code_service where article_idx="&article_idx&" "
	strSql = strSql & " and service_order>"&service_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select service_idx from code_service where service_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		service_idx1	= objRs2(0)

		if service_idx1="0" or service_idx1="" then
  		else
  			strSql = "update code_service set service_order="&service_order&" where service_idx="&service_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_service set service_order="&sorting1&" where service_idx="&service_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(service_order),0) from code_service where  article_idx="&article_idx&" "
	strSql = strSql & " and service_order<"&service_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select service_idx from code_service where  service_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		service_idx1	= objRs2(0)

  		if service_idx1="0" or service_idx1="" then  		
  		else
	  		strSql = "update code_service set service_order="&service_order&" where service_idx="&service_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_service set service_order="&sorting1&" where service_idx="&service_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "service_order.asp?page="&page&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&article_idx
  %>

