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
  <%
  s_o_code			= WORD_CHANGE(Request("s_o_code"),20) 
  chk				= WORD_CHANGE(Request("chk"),20)
  s_sms_cnt			= WORD_CHANGE(Request("s_sms_cnt"),10)

  If chk="entersoft_admin" Then
    strSql = " update SMS_MESSAGE_CNT set s_message1=s_message1+"&s_sms_cnt&" where s_o_code='"&s_o_code&"'"
	Set objRs=objCnn.Execute(strSql)
  Else
	Alert_close "잘못된 접근 입니다."
  End If
  
  alert "충전이 완료되었습니다."
  win_close
  Response.End 

  %>