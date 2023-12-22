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
  article_order		= WORD_CHANGE(Request("article_order"),20)
  article_step1		= WORD_CHANGE(Request("article_step1"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(article_order),0) from code_article where article_step1="&article_step1&" "
	strSql = strSql & " and article_step2>0 and article_order>"&article_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select article_idx from code_article where article_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		article_idx1	= objRs2(0)

		if article_idx1="0" or article_idx1="" then
  		else
  			strSql = "update code_article set article_order="&article_order&" where article_idx="&article_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_article set article_order="&sorting1&" where article_idx="&article_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(article_order),0) from code_article where  article_step1="&article_step1&" "
	strSql = strSql & " and article_step2>0 and article_order<"&article_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select article_idx from code_article where  article_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		article_idx1	= objRs2(0)

  		if article_idx1="0" or article_idx1="" then  		
  		else
	  		strSql = "update code_article set article_order="&article_order&" where article_idx="&article_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_article set article_order="&sorting1&" where article_idx="&article_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "article_order1.asp?page="&page&"&article_idx="&article_step1
  %>

