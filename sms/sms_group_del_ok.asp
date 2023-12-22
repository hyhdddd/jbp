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
 
  if ad_b_a_custom="A" Then
  else
	Alert_back session_m_name &" 님은 개통정보 코드 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  group_idx		= WORD_CHANGE(Request("group_idx"),10)

  strSql = " select * from SMS_GROUP_EMP where group_idx='"&group_idx&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql ="delete sms_group where group_idx='"&group_idx&"'"
	Set objRs=objCnn.Execute(strSql)

	Alert_url " 코드를 삭제했습니다.","sms_group_list.asp"
  Else
  	Alert_back " 삭제하고자 하는 코드에 소속된 사원이 존재합니다. \n\n 소속을 모두 지우신후 코드를 삭제해 주시기 바랍니다."
	Response.end
  End if  
  %>