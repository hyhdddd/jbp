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
  	
  passwd1		= WORD_CHANGE(request("passwd1"),20)
  passwd2		= left(request("passwd2"),20)
  passwd3		= left(request("passwd3"),20)

  strSql = "select * from emp_list where m_id='"& session_m_id &"'"
  set objRs=objCnn.Execute(strSql)
  db_passwd=objRs("m_passwd")
  
  if db_passwd=passwd1 Then
  
    '비밀번호 로그 기록 조회
    strSql = " select board_idx from emp_passwd_log where m_id='"&session_m_id&"' and m_passwd='"&passwd2&"'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.bof Or objRs.eof Then
	else
		'Alert_url "이전에 이미 사용하셨던 비밀번호 입니다. \n\n 새로운 비밀번호로 바꾸어 주시기 바랍니다.","/information/passwd_regist.asp"
		'Response.end
	End if

	'비밀번호 수정
  	strSql = " update emp_list set "
  	strSql = strSql & " m_passwd = '"& passwd2 &"',m_last_passwd=getdate() where m_id='"& session_m_id &"'"
  	set objRs=objCnn.Execute(strSql)

	
	'비밀번호 수정후 로그 기록
	strSql = "Select ISNULL(MAX(board_idx)+1,1) from emp_passwd_log "
	set objRs=objCnn.Execute(strSql)
	board_idx	= objRs(0)

	strSql = " INSERT INTO emp_passwd_log (board_idx, m_id, m_passwd, m_writeday)"
	strSql = strSql & " values ("
	strSql = strSql & "  " & board_idx & " "
	strSql = strSql & ",'" & Session_m_id & "' "
	strSql = strSql & ",'" & passwd2 & "' " 
	strSql = strSql & ",getdate() )"
	set objRs=objCnn.Execute(strSql)
	
	Alert_url "사원비밀번호가 수정 되었습니다. ","/default.asp"
  else
	Alert_back "기존의 비밀번호가 맞지 않습니다. \n\n 다시 확인하시고 바꿔주세요!"
  end if
  %>
