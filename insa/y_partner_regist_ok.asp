   <%
  '====================================='
  ' ������Ʈ : SENQ PROJECT
  ' ��    �� : HTTP://OSS.SENQ.CO.KR
  ' �������� : 2007/08/15 ~2008/08/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <%
  m_id					= WORD_CHANGE(Request("m_id"),20)
  m_name				= WORD_CHANGE(request("m_name"),40)
  m_passwd				= WORD_CHANGE(request("m_passwd"),40)
  m_jumin1				= WORD_CHANGE(request("m_jumin1"),20)
  m_jumin2				= WORD_CHANGE(request("m_jumin2"),20)
  m_zipcode1			= WORD_CHANGE(request("m_zipcode1"),20)
  m_zipcode2			= WORD_CHANGE(request("m_zipcode2"),20)
  m_address				= WORD_CHANGE(request("m_address"),200)
  m_email				= WORD_CHANGE(request("m_email"),70)
  m_tel1				= WORD_CHANGE(request("m_tel1"),30)
  m_tel2				= WORD_CHANGE(request("m_tel2"),30)
  m_bigo				= WORD_CHANGE(request("m_bigo"),0)
  dealer_name			= WORD_CHANGE(request("dealer_name"),40)
  dealer_com_yn			= WORD_CHANGE(Request("dealer_com_yn"),20)
  dealer_com_no			= WORD_CHANGE(Request("dealer_com_no"),40)
  dealer_bank_name		= WORD_CHANGE(Request("dealer_bank_name"),40)		' ���� ������
  dealer_bank_cd		= WORD_CHANGE(Request("dealer_bank_cd"),20)			' ���� �ڵ�
  dealer_bank_no		= WORD_CHANGE(Request("dealer_bank_no"),20)			' ���� ���¹�ȣ
  dealer_zipcode1		= WORD_CHANGE(Request("dealer_zipcode1"),20)		' ȸ�� �����ȣ1
  dealer_zipcode2		= WORD_CHANGE(Request("dealer_zipcode2"),20)		' ȸ�� �����ȣ2
  dealer_address		= WORD_CHANGE(Request("dealer_address"),200)			' ȸ�� �ּ�
  dealer_tel1			= WORD_CHANGE(Request("dealer_tel1"),30)
  dealer_tel2			= WORD_CHANGE(Request("dealer_tel2"),30)

  If m_name="" Or m_id="" Or m_passwd="" Or dealer_name=""  Then
	Alert_back "�߸��� �����Դϴ�."
  End If
  
  
  strSql =" select m_id from emp_list where m_id='"&m_id&"'"
  set objRs=objCnn.Execute(strSql)
	  
  if objRs.eof or objRs.bof then
  Else
	Alert_back " ���̵� �̹� ���� �մϴ�. \n\n �ٽ� �Է��� �ּ���! "
	response.end
  end if  
	  
  strSql = "Select ISNULL(MAX(board_idx)+1,1) from dealer_partner_info "
  set objRs=objCnn.Execute(strSql)
  board_idx	= objRs(0)

  strSql = "INSERT INTO dealer_partner_info (board_idx, o_code, m_id, m_passwd, m_name, "
  strSql = strSql & " m_zipcode1, m_zipcode2, m_address, m_tel1, m_tel2,m_email, m_bigo, "
  strSql = strSql & " dealer_name, dealer_com_yn, dealer_com_no, "
  strSql = strSql & " dealer_zipcode1, dealer_zipcode2, dealer_address, dealer_tel1, dealer_tel2, d_writeday) VALUES "
  strSql = strSql & "( " & board_idx & "  "
  strSql = strSql & ",'" & o_code & "' "
  strSql = strSql & ",'" & m_id & "' "
  strSql = strSql & ",'" & m_passwd & "' "
  strSql = strSql & ",'" & m_name & "' "
  strSql = strSql & ",'" & m_zipcode1 & "'"
  strSql = strSql & ",'" & m_zipcode2 & "'"
  strSql = strSql & ",'" & m_address & "'"  
  strSql = strSql & ",'" & m_tel1 & "'"
  strSql = strSql & ",'" & m_tel2 & "'"
  strSql = strSql & ",'" & m_email & "'"
  strSql = strSql & ",'" & m_bigo & "'"
  strSql = strSql & ",'" & dealer_name & "'"
  strSql = strSql & ",'" & dealer_com_yn & "'"
  strSql = strSql & ",'" & dealer_com_no & "'"
  strSql = strSql & ",'" & dealer_zipcode1 & "'"
  strSql = strSql & ",'" & dealer_zipcode2 & "'"
  strSql = strSql & ",'" & dealer_address & "'"
  strSql = strSql & ",'" & dealer_tel1 & "'"
  strSql = strSql & ",'" & dealer_tel2 & "'"
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql)

  Alert " ��Ʈ�� ��û�� �Ϸ�Ǿ����ϴ�. \n\n �����ڰ� Ȯ�� �� �����ð��ȿ� �����帮���� �ϰڽ��ϴ�. \n\n �����մϴ�."
  win_close()
  %>