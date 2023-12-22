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

  group_idx				= WORD_CHANGE(request("group_idx"),20)
  group_name			= WORD_CHANGE(request("group_name"),20)
  
  if group_idx<>"" then  
	strSql = " update sms_group set "
	strSql = strSql & " group_name = '"& group_name &"'"
	strSql = strSql & " where group_idx='"&group_idx&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "코드가 수정 되었습니다. ","sms_group_list.asp"
	Response.end
  else    
	strSql = "Select ISNULL(MAX(group_idx)+1,1) from sms_group "
	set objRs=objCnn.Execute(strSql)
	group_idx		= objRs(0)

	strSql = "INSERT INTO sms_group (group_idx, o_code, group_name,group_writeday) VALUES "
	strSql = strSql & " ("& group_idx &",'"& o_code &"','"& group_name &"',getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "코드가 등록되었습니다.","mail_group_list.asp"
  %>