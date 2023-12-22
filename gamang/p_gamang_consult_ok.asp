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

  page						= WORD_CHANGE(Request("page"),20)									'페이지
  nowblock					= WORD_CHANGE(Request("nowblock"),20)								'블럭
  s_link_txt				= WORD_CHANGE(Request("s_link_txt"),0)								'검색어
  c_m_gamang_idx			= WORD_CHANGE(Request("c_m_gamang_idx"),20)							'고객번호
  consult_bigo				= WORD_CHANGE(Request("consult_bigo"),0)			'비고
  consult_type				= WORD_CHANGE(Request("consult_type"),20)			'D:고객메모 / E:고객상담 / A:회신요청 / B:회신답변 / C:회신완료	
  consult_date				= WORD_CHANGE(Request("consult_date"),20)
  consult_date_hour			= WORD_CHANGE(Request("consult_date_hour"),20)  
  consult_date_minute		= WORD_CHANGE(Request("consult_date_minute"),20)  

  if consult_date="" Then
	consult_date=""
  else
  	consult_date1 = consult_date_hour&":"&consult_date_minute
  	consult_date  = consult_date &" "&consult_date1
  end if  

  
  strSql = "select ISNULL(MAX(consult_idx)+1,1) from customer_gamang_consult"
  Set objRs=objCnn.Execute(strSql)

  consult_idx=objRs(0) 

 strSql = "INSERT INTO customer_gamang_consult(consult_idx, o_code, consult_m_id, c_m_gamang_idx,"	
 strSql = strSql & "consult_type, consult_bigo, "

  If consult_date<>"" then
	strSql = strSql & " consult_date,  "
  End If

  strSql = strSql & " consult_writeday) VALUES " 
  strSql = strSql & "("
  strSql = strSql & "  "& consult_idx &"  "
  strSql = strSql & ", '"& o_code &"'"
  strSql = strSql & ", '"& session_m_id &"'"
  strSql = strSql & ", "& c_m_gamang_idx &" "
  strSql = strSql & ", '"& consult_type &"'"  		
  strSql = strSql & ", '"& consult_bigo &"'"

  If consult_date<>"" then
	strSql = strSql & " ,'"& consult_date&"'"
  End If
  
  strSql = strSql & ",getdate())"
  'Response.write strSql
  set objRs=objCnn.Execute(strSql)

 
  '고객이력
  strSql = " update customer_gamang set "
  strSql = strSql & "  c_m_consult_type	= '"&consult_type&"' "
  strSql = strSql & ", c_m_consult_bigo	= '"&consult_bigo&"' "
  strSql = strSql & "	where c_m_gamang_idx	= "&c_m_gamang_idx&" "
  set objRs=objCnn.Execute(strSql)

  
  objCnn.Close
  Set objRs =Nothing
  Set objCnn = Nothing
  
  Alert_url " 이력글이 등록되었습니다.","p_gamang_regist.asp?c_m_gamang_idx="&c_m_gamang_idx&"&page="&page&"&nowblock="&nowblock&"&s_link_txt="&Server.URLEncode(s_link_txt)
  %>

