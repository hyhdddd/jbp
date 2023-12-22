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
  gift_idx			= WORD_CHANGE(request("gift_idx"),0)
  gift_status		= WORD_CHANGE(request("gift_status"),20)

  strSql = " update board_gift set gift_status='"& gift_status &"' where gift_idx in ("& gift_idx &") "
  Set objRs=objCnn.Execute(strSql)

  Alert " 선택 고객정보가 일괄 처리 되었습니다."
  win_reload_modal()
  win_close_modal()
  %>

