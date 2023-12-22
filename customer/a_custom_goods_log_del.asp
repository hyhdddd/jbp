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

  if session_m_step="M" Then
  else
 	Alert_URL session_m_name &" 님은 삭제권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
	Response.end
  end if	 

  board_idx				= WORD_CHANGE(request("board_idx"),20)
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)

  
  strSql = " delete customer_gaetong_log where board_idx="&board_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 이력글이 삭제 되었습니다.","a_custom_goods_regist.asp?g_goods_idx="&g_goods_idx
  %>