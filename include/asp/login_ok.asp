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
  login_message = "�α��� ����...."
  
  If login_status="O" Then
	If o_step="A" Then
		'���� ��ü �ڵ� üũ
		login_status  = "X"
		login_message = "���� ���İ�� ���� ���� �׽�Ʈ �Ⱓ���� ��ü �Դϴ�."
    End If

	If o_step="C" Then 
		'���� ��ü �ڵ� üũ
		login_status  = "X"
		login_message = "���� �Ͻ����� ���� ��ü �ڵ� �Դϴ�."
	End If
  End If
 
  If login_status="O" Then
	  if trim(m_id)="" or trim(m_passwd)="" Then
	  '���̵�/��й�ȣ ��� ���� ��� üũ
		login_status  = "X"
		login_message = "���̵� �Ǵ� ��й�ȣ�� �Էµ��� �ʾҽ��ϴ�."
	  End If
  End If
  
  If login_status="O" Then
	strSql = "SELECT m_name, m_passwd, m_login_ip, m_status, m_step FROM emp_list where m_id='"&m_id&"'"
	Set objRs=objCnn.Execute(strSql)

	if objRs.eof or objRs.bof Then
		login_status  = "X"
		login_message = "��ϵǾ� �ִ� ���̵� �ƴմϴ�."
	Else
		m_name			= objRs("m_name")
		m_step			= objRs("m_step")
		m_login_ip		= objRs("m_login_ip") 
		m_status		= objRs("m_status") 
		m_passwd_db		= UCase(objRs("m_passwd"))

		If m_passwd_db<>m_passwd Then
			login_status  = "X"
			login_message = "�н����尡 ��ġ���� �ʽ��ϴ�."
		End If

		if m_login_ip="" or isnull(m_login_ip) then
		else
			if ip_addr<>m_login_ip Then
				login_status  = "X"
				login_message = "�α��� �Ͻ� ������ �α��� ���� IP �� �ٸ��ϴ�."
			End If
		End if	

		if m_status<>"O" Then
			login_status  = "X"
			login_message = "����� ó���Ǿ� �ִ� ���̵� �Դϴ�."
		End If
		
    end if
  end If
  
  '������ �α��� ����� ����ϴ�.
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
	Alert_back login_message & "\n\n �����ڿ� ������ �ֽñ� �ٶ��ϴ�."	
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
	
	'�������� �ʴ� ������ ���� ��Ű��
	Response.Cookies("m_id1").expires=date+1
	Response.Cookies("m_id1")=m_id

    Win_link "/main.asp"
	Response.end
  End if

  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>