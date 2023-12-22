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
  
  article_name			= WORD_CHANGE(Request("article_name"),20)
  article_step1			= WORD_CHANGE(Request("article_step1"),20)
  article_step2			= WORD_CHANGE(Request("article_step2"),20)
  article_view			= WORD_CHANGE(Request("article_view"),20)

  If article_step1<>"" Then
	If article_step2="0" Then
		'대분류 수정
		strSql = " update code_article set "
		strSql = strSql & " article_name = '"& article_name &"' "
		strSql = strSql & ", article_view='"&article_view&"'"
		strSql = strSql & " where article_step1='"&article_step1&"' and article_step2=0 "
		Set objRs=objCnn.Execute(strSql)
	    Alert_url "코드가 수정 되었습니다. ","article_list.asp"  
		Response.end
	End If
	
	If article_step2="" Then		
		'중분류 등록
		strSql = " Select ISNULL(MAX(article_step2)+1,1) from code_article "
		strSql = strSql & " where article_step1="&article_step1&" "
		Set objRs=objCnn.Execute(strSql)
		
		w_step2 = objRs(0)

  		strSql = "Select ISNULL(MAX(article_idx)+1,1) from code_article "
		set objRs=objCnn.Execute(strSql)
		article_idx	= objRs(0)

		strSql = "INSERT INTO code_article (article_idx, article_name, article_step1, article_step2, "
		strSql = strSql & " article_order, article_view "
		strSql = strSql & " ) VALUES "
		strSql = strSql & "("&article_idx&",'"& article_name &"', "&article_step1&","&w_step2&","&article_idx&",'"&article_view&"')"
		Set objRs=objCnn.Execute(strSql)
		Alert_url " 코드가 등록되었습니다.","article_list.asp"
	End If

	If article_step2<>"0" And article_step2<>"" Then
		'중분류 수정
		strSql = " update code_article set "
		strSql = strSql & " article_name = '"& article_name &"', "
		strSql = strSql & " article_view = '"& article_view &"' "
		strSql = strsql & "		where article_step1="&article_step1&" and article_step2="&article_step2&" "
		Set objRs=objCnn.Execute(strSql)
	    Alert_url "코드가 수정 되었습니다. ","article_list.asp"  
		Response.end
	End If
  Else
  	strSql = "Select ISNULL(MAX(article_idx)+1,1) from code_article "
	set objRs=objCnn.Execute(strSql)
	article_idx	= objRs(0)

	strSql = "INSERT INTO code_article (article_idx, article_name,article_step1, "
	strSql = strSql & " article_step2, article_order, article_view) VALUES "
	strSql = strSql & "("&article_idx&",'"& article_name &"',"&article_idx&",0,"&article_idx&",'"&article_view&"')"
	'response.write strSql
	Set objRs=objCnn.Execute(strSql)

	Alert_url " 코드가 등록되었습니다.","article_list.asp"
  End If
  
  %>