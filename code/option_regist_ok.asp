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
  
  option_idx		= WORD_CHANGE(Request("option_idx"),20)
  option_name		= WORD_CHANGE(Request("option_name"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  option_view		= WORD_CHANGE(Request("option_view"),20)
  option_set		= WORD_CHANGE(Request("option_set"),20)

  If option_idx<>"" Then
	strSql = " update code_article_option set "
	strSql = strSql & " option_name = '"& option_name &"',option_view='"&option_view&"',"
	strSql = strSql & " option_set='"&option_set&"' where option_idx='"&option_idx&"'"
	Set objRs=objCnn.Execute(strSql)
    Alert_url "코드가 수정 되었습니다. ","option_list.asp?article_idx="&article_idx&"&option_idx="&option_idx
  Else
    strSql = "Select ISNULL(MAX(option_idx)+1,1) from code_article_option "
	set objRs=objCnn.Execute(strSql)
	option_idx	= objRs(0)

	strSql = "INSERT INTO code_article_option (option_idx, article_idx, option_name,option_view, option_order, "
	strSql = strSql & " option_set) VALUES "
	strSql = strSql & "("&option_idx&","& article_idx &",'" & option_name & "',"
	strSql = strSql & " '" & option_view&"', "&option_idx&", '" & option_set&"')"
	Set objRs=objCnn.Execute(strSql)
	Alert_url " 코드가 등록되었습니다.","option_list.asp?article_idx="&article_idx&"&option_idx="&option_idx
  End If
  
  
  %>