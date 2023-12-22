  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"  
  %>  
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <%

  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  promise_order		= WORD_CHANGE(Request("promise_order"),20)
  promise_idx		= WORD_CHANGE(Request("promise_idx"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(promise_order),0) from code_promise where article_idx="&article_idx&" "
	strSql = strSql & " and promise_order>"&promise_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select promise_idx from code_promise where promise_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		promise_idx1	= objRs2(0)

		if promise_idx1="0" or promise_idx1="" then
  		else
  			strSql = "update code_promise set promise_order="&promise_order&" where promise_idx="&promise_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_promise set promise_order="&sorting1&" where promise_idx="&promise_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(promise_order),0) from code_promise where  article_idx="&article_idx&" "
	strSql = strSql & " and promise_order<"&promise_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select promise_idx from code_promise where  promise_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		promise_idx1	= objRs2(0)

  		if promise_idx1="0" or promise_idx1="" then  		
  		else
	  		strSql = "update code_promise set promise_order="&promise_order&" where promise_idx="&promise_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_promise set promise_order="&sorting1&" where promise_idx="&promise_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "promise_order.asp?page="&page&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&article_idx
  %>

