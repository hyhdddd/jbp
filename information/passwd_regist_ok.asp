 <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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
  
    '��й�ȣ �α� ��� ��ȸ
    strSql = " select board_idx from emp_passwd_log where m_id='"&session_m_id&"' and m_passwd='"&passwd2&"'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.bof Or objRs.eof Then
	else
		'Alert_url "������ �̹� ����ϼ̴� ��й�ȣ �Դϴ�. \n\n ���ο� ��й�ȣ�� �ٲپ� �ֽñ� �ٶ��ϴ�.","/information/passwd_regist.asp"
		'Response.end
	End if

	'��й�ȣ ����
  	strSql = " update emp_list set "
  	strSql = strSql & " m_passwd = '"& passwd2 &"',m_last_passwd=getdate() where m_id='"& session_m_id &"'"
  	set objRs=objCnn.Execute(strSql)

	
	'��й�ȣ ������ �α� ���
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
	
	Alert_url "�����й�ȣ�� ���� �Ǿ����ϴ�. ","/default.asp"
  else
	Alert_back "������ ��й�ȣ�� ���� �ʽ��ϴ�. \n\n �ٽ� Ȯ���Ͻð� �ٲ��ּ���!"
  end if
  %>
