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
  if ad_c_code="N" then
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  sale_order		= WORD_CHANGE(Request("sale_order"),20)
  sale_idx			= WORD_CHANGE(Request("sale_idx"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  
  if chk="D" then
  	strSql = " select ISNULL(min(sale_order),0) from code_sale where article_idx="&article_idx&" "
	strSql = strSql & " and sale_order>"&sale_order  	
  	set objRs=objCnn.Execute(strSql)
  	
  	sorting1=objRs(0)
  	
  	if sorting1="0" or sorting1="" then
  	
  	else
  		strSql="select sale_idx from code_sale where sale_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		sale_idx1	= objRs2(0)

		if sale_idx1="0" or sale_idx1="" then
  		else
  			strSql = "update code_sale set sale_order="&sale_order&" where sale_idx="&sale_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_sale set sale_order="&sorting1&" where sale_idx="&sale_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end If
	
  Else
  
  	strSql = " select isnull(max(sale_order),0) from code_sale where  article_idx="&article_idx&" "
	strSql = strSql & " and sale_order<"&sale_order
  	set objRs=objCnn.Execute(strSql)

	sorting1	= objRs(0)  
		
  	if sorting1="0" or sorting1="" then
  	
  	else

  		strSql="select sale_idx from code_sale where  sale_order="&sorting1
  		set objRs2=objCnn.Execute(strSql)
  		
  		sale_idx1	= objRs2(0)

  		if sale_idx1="0" or sale_idx1="" then  		
  		else
	  		strSql = "update code_sale set sale_order="&sale_order&" where sale_idx="&sale_idx1
  			set objRs3=objCnn.Execute(strSql)
  		
  			strSql = "update code_sale set sale_order="&sorting1&" where sale_idx="&sale_idx
  			set objRs3=objCnn.Execute(strSql)
  		end if
  	end if
  end if

  Win_link "sale_order.asp?page="&page&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&article_idx
  %>

