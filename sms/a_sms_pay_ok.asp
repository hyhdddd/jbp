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

  sms_cnt			= WORD_CHANGE(request("sms_cnt"),20)				'고객 일반 정보
  s_m_id			= WORD_CHANGE(request("s_m_id"),20)			'고객 상담 정보
  s_o_code			= WORD_CHANGE(request("s_o_code"),20)			'고객 상품 정보

  strSql = "Select ISNULL(MAX(s_board_idx)+1,1) from SMS_PAYMENT "
  set objRs=objCnn_e.Execute(strSql)
  s_board_idx	= objRs(0)
    
  strSql = " INSERT INTO SMS_PAYMENT( s_board_idx, s_sms_cnt, s_m_id, s_o_code, s_writeday)"
  strSql = strSql & " values ("
  strSql = strSql & "  " & s_board_idx & " "
  strSql = strSql & ", " & sms_cnt & " "
  strSql = strSql & ",'" & s_m_id & "' " 
  strSql = strSql & ",'" & s_o_code & "' "
  strSql = strSql & ",getdate())"
  set objRs=objCnn_e.Execute(strSql)
  Alert_url "  SMS 충전이 신청이 완료 되었습니다. \n\n (신협) 132-055-917955  예금주:최안규(엔터소프트)를 적어 놓으신후 무통장 입금해 주시기 바랍니다.","a_sms_pay.asp"


  %>