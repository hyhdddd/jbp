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
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%

  gaetong_idx		= WORD_CHANGE(Request("gaetong_idx"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  gaetong_order		= WORD_CHANGE(Request("gaetong_order"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(gaetong_order),0) from code_gaetong where gaetong_order>"&gaetong_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select gaetong_idx from code_gaetong where gaetong_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		gaetong_idx1	= objRs2(0)

		if gaetong_idx1="0" or gaetong_idx1="" then
  		else
  			strSql = "update code_gaetong set gaetong_order="&gaetong_order&" where gaetong_idx="&gaetong_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_gaetong set gaetong_order="&sorting1&" where gaetong_idx="&gaetong_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(gaetong_order),0) from code_gaetong where gaetong_order<"&gaetong_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select gaetong_idx from code_gaetong where  gaetong_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		gaetong_idx1	= objRs2(0)

  		if gaetong_idx1="0" or gaetong_idx1="" then  		
  		else
	  		strSql = "update code_gaetong set gaetong_order="&gaetong_order&" where gaetong_idx="&gaetong_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_gaetong set gaetong_order="&sorting1&" where gaetong_idx="&gaetong_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "gaetong_list.asp?page="&page
  %>

