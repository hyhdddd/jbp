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

  w_board_idx 	= WORD_CHANGE(Request("w_board_idx"),10)
  indication_chk= WORD_CHANGE(Request("indication_chk"),10)
  page			= WORD_CHANGE(Request("page"),10)

  if indication_chk="2" then
  	w_decision2_txt   = CheckWord(request("w_decision2_txt"))
	w_decision2_id		= Session_m_id
  elseif indication_chk="3" then
  	w_decision3_txt   = CheckWord(request("w_decision3_txt"))
	w_decision3_id		= Session_m_id
  end if	
  
 
  strSql = " update emp_work_report set  w_o_code='"&o_code&"'" 
  
  if indication_chk="2" then
  	 strSql = strSql & ", w_decision2_txt = '"& w_decision2_txt & "' "
  	 strSql = strSql & ", w_decision2_id = '"& w_decision2_id & "' "
  	 strSql = strSql & ", w_decision2_day = getdate() "
  	 
  elseif indication_chk="3" then
  	 strSql = strSql & ", w_decision3_txt = '"& w_decision3_txt & "' "
  	 strSql = strSql & ", w_decision3_id = '"& w_decision3_id & "' "
  	 strSql = strSql & ", w_decision3_day = getdate() "
  end if	  
  strSql = strSql & " where w_board_idx="& w_board_idx	 
  'Response.write strSql
  set objRs=objCnn.Execute(strSql)

  Alert_url " 업무일지가 수정되었습니다.","work_report_list.asp?page="+page

  objCnn.close
  Set objRs = Nothing
  Set objCnn = Nothing
  %>
