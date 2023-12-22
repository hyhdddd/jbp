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

  service_idx			= WORD_CHANGE(request("service_idx"),20)
  service_name			= WORD_CHANGE(request("service_name"),20)
  service_view			= WORD_CHANGE(request("service_view"),20)
  article_idx			= WORD_CHANGE(Request("article_idx"),20)
  
  article_step1		= WORD_CHANGE(Request("article_step1"),20)
  article_step2		= WORD_CHANGE(Request("article_step2"),20)

  if service_idx<>"" then  
	strSql = " update code_service set "
	strSql = strSql & " service_name = '"& service_name &"', "
	strSql = strSql & " service_view = '"& service_view &"', "
	strSql = strSql & " article_idx = "& article_idx &" "
	strSql = strSql & " where service_idx='"&service_idx&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "코드가 수정 되었습니다. ","service_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
	Response.end
  else      
	strSql = "Select ISNULL(MAX(service_idx)+1,1) from code_service "
	set objRs=objCnn.Execute(strSql)
	service_idx		= objRs(0)

	strSql = "INSERT INTO code_service (service_idx, article_idx, o_code, service_name,service_view, service_order, service_writeday) VALUES "
	strSql = strSql & " ("& service_idx &","& article_idx &",'"& o_code &"','"& service_name &"','"& service_view &"',"& service_idx &", getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "코드가 등록되었습니다.","service_list.asp?article_idx="&article_idx&"&article_step1="&article_step1&"&article_step2="&article_step2
  %>