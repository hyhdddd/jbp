  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
  '====================================='

  Set objCnn = Server.CreateObject("ADODB.Connection") 
  Set objRs   = Server.CreateObject("ADODB.Recordset") 
  strConnect = "Provider=SQLOLEDB;User ID=jb12345;Password=hyh5017574;"
  strConnect = strConnect & "Data Source=sql19-103.cafe24.com;Initial Catalog=jb12345;"
  objCnn.Open strConnect 

  o_code			= "C1299"
  session_o_code	= o_code


  https_chk			= Request.ServerVariables("https")

  If https_chk="off" Then
	win_link "https://jb7.kr"
  End if

  '�������� �ʴ� ���� �׽�Ʈ
  c_m_id		= WORD_CHANGE(Request.Cookies("m_id1"),20)
  c_m_id		= Replace(c_m_id," ","")

  session_m_id	= session("m_id")

  If session_m_id="" Or IsNull(session_m_id)=True Then
	If c_m_id<>"" Then
		session("m_id")=c_m_id
	End if
  End if
  %>

 