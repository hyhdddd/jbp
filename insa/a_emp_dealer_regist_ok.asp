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

  if ad_i_a_emp="N" then
	Alert_url session_m_name &" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
	Response.end
  end If

  m_id					= WORD_CHANGE(Request("m_id"),20)
  m_dealer_code			= WORD_CHANGE(Request("m_dealer_code"),20)

  If m_id="" Or m_dealer_code="" Then
	Alert_back " 접근이 잘못되었습니다."
	Response.End
  End if

  strSql = "select ISNULL(MAX(m_idx)+1,1) AS SEQ from emp_list_dealer"
  Set objRs=objCnn.Execute(strSql)

  m_idx=objRs(0)

  strSql = " insert into emp_list_dealer ("
  strSql = strSql & "  m_idx "
  strSql = strSql & ", m_id"
  strSql = strSql & ", m_dealer_code"
  strSql = strSql & ", m_writeday"
  strSql = strSql & "  ) "
  strSql = strSql & "  values("
  strSql = strSql & "  "& m_idx &" "
  strSql = strSql & ",'"& m_id &"'"
  strSql = strSql & ",'"& m_dealer_code &"'"
  strSql = strSql & ",getdate()"
  strSql = strSql & " )"
  set objRs=objCnn.Execute(strSql)  

  Alert_url " 사원 권한 설정이 등록/수정 되었습니다.","a_emp_regist.asp?m_id="&m_id
  %>
