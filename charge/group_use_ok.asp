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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  group_code		= WORD_CHANGE(Request("group_code"),20)

  group_use_chk		= "group_use_"&group_code
  group_use_chk		= WORD_CHANGE(Request(group_use_chk),20)

  strSql = "update code_group set group_use='"&group_use_chk&"' where group_code='"&group_code&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url "적용되었습니다.","group_list.asp"
  %>