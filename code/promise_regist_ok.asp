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
  Login_chk(Session_m_id)

  promise_idx		= WORD_CHANGE(request("promise_idx"),20)
  promise_name		= WORD_CHANGE(request("promise_name"),20)
  promise_view		= WORD_CHANGE(request("promise_view"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  promise_policy	= WORD_CHANGE(Request("promise_policy"),20)
  
  article_step1		= WORD_CHANGE(Request("article_step1"),20)
  article_step2		= WORD_CHANGE(Request("article_step2"),20)
  If promise_policy="Y" Then
	strSql = " update code_promise set promise_policy='N' where article_idx="&article_idx&" "
	set objRs=objCnn.Execute(strSql)
  End if

  if promise_idx<>"" then  
	strSql = " update code_promise set "
	strSql = strSql & " promise_name = '"& promise_name &"', "
	strSql = strSql & " promise_view = '"& promise_view &"', "
	strSql = strSql & " article_idx = "& article_idx &", "
	strSql = strSql & " promise_policy = '"& promise_policy &"' "
	strSql = strSql & " where promise_idx='"&promise_idx&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "코드가 수정 되었습니다. ","promise_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
	Response.end
  else    
	strSql = "Select ISNULL(MAX(promise_idx)+1,1) from code_promise "
	set objRs=objCnn.Execute(strSql)
	promise_idx		= objRs(0)

	strSql = "INSERT INTO code_promise (promise_idx, o_code, article_idx, promise_name,promise_view, promise_policy, promise_order,  promise_writeday) VALUES "
	strSql = strSql & " ("& promise_idx &",'"&session_o_code&"',"&article_idx&",'" & promise_name & "','"& promise_view &"','"& promise_policy &"',"& promise_idx &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "코드가 등록되었습니다.","promise_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
  %>