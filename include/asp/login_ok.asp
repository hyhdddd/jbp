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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  m_id			= WORD_CHANGE(UCase(Request("m_id")),20)
  m_passwd		= left(UCase(Request("m_passwd")),20)
  idchk			= WORD_CHANGE(UCase(Request("idchk")),20)
  pwchk			= WORD_CHANGE(UCase(Request("pwchk")),20)
  ip_addr		= Request.ServerVariables("REMOTE_HOST")

  strSql = " select * from company_info where o_code='"&o_code&"' "
  Set objRs=objCnn.Execute(strSql)

  If objRs.bof Or objRs.eof Then
	o_step			= "A"
  Else
	o_step			= objRs("o_step")
  End If
  
  login_status  = "O"
  login_message = "로그인 성공...."
  
  If login_status="O" Then
	If o_step="A" Then
		'승인 업체 코드 체크
		login_status  = "X"
		login_message = "아직 정식계약 되지 않은 테스트 기간중인 업체 입니다."
    End If

	If o_step="C" Then 
		'승인 업체 코드 체크
		login_status  = "X"
		login_message = "서비스 일시중지 중인 업체 코드 입니다."
	End If
  End If
 
  If login_status="O" Then
	  if trim(m_id)="" or trim(m_passwd)="" Then
	  '아이디/비밀번호 비어 있을 경우 체크
		login_status  = "X"
		login_message = "아이디 또는 비밀번호가 입력되지 않았습니다."
	  End If
  End If
  
  If login_status="O" Then
	strSql = "SELECT m_name, m_passwd, m_login_ip, m_status, m_step FROM emp_list where m_id='"&m_id&"'"
	Set objRs=objCnn.Execute(strSql)

	if objRs.eof or objRs.bof Then
		login_status  = "X"
		login_message = "등록되어 있는 아이디가 아닙니다."
	Else
		m_name			= objRs("m_name")
		m_step			= objRs("m_step")
		m_login_ip		= objRs("m_login_ip") 
		m_status		= objRs("m_status") 
		m_passwd_db		= UCase(objRs("m_passwd"))

		If m_passwd_db<>m_passwd Then
			login_status  = "X"
			login_message = "패스워드가 일치하지 않습니다."
		End If

		if m_login_ip="" or isnull(m_login_ip) then
		else
			if ip_addr<>m_login_ip Then
				login_status  = "X"
				login_message = "로그인 하신 계정은 로그인 지정 IP 와 다릅니다."
			End If
		End if	

		if m_status<>"O" Then
			login_status  = "X"
			login_message = "퇴사자 처리되어 있는 아이디 입니다."
		End If
		
    end if
  end If
  
  '무조건 로그인 기록을 남깁니다.
  strSql = "Select ISNULL(MAX(board_idx)+1,1) from emp_login_info "
  set objRs=objCnn.Execute(strSql)
  board_idx	= objRs(0)

  strSql = " INSERT INTO emp_login_info (board_idx, m_id, m_passwd, m_status, m_ipinfo, m_bigo, m_writeday)"
  strSql = strSql & " values ("
  strSql = strSql & "  " & board_idx & " "
  strSql = strSql & ",'" & m_id & "' "
  strSql = strSql & ",'" & m_passwd & "' " 
  strSql = strSql & ",'"& login_status &"' "
  strSql = strSql & ",'" & ip_addr & "' "
  strSql = strSql & ",'"& login_message &"' "
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql)  

  If login_status="X" Then
	Alert_back login_message & "\n\n 관리자에 문의해 주시기 바랍니다."	
	Response.end
  Else
  	session("m_id")		= m_id
	If idchk="Y" then
		Response.Cookies("userid").expires=date+365
		Response.Cookies("userid")("userid")=m_id
		Response.Cookies("userid")("idchk")="Y"
	else
  		Response.Cookies("userid").expires=date+365
		Response.Cookies("userid")("userid")=""
		Response.Cookies("userid")("idchk")=""
	End If
	
	'끊어지지 않는 세션을 위한 쿠키값
	Response.Cookies("m_id1").expires=date+1
	Response.Cookies("m_id1")=m_id

    Win_link "/main.asp"
	Response.end
  End if

  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>