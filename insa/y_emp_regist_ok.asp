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
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)

  if ad_i_y_emp="N" then
	Alert_url session_m_name &" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if 
  
  m_idx				= WORD_CHANGE(request("m_idx"),20)
  m_id				= WORD_CHANGE(Request("m_id"),20)
  page				= WORD_CHANGE(request("page"),20)
  m_name			= WORD_CHANGE(request("m_name"),20)
  m_dealer_code		= WORD_CHANGE(request("m_dealer_code"),20)
  m_passwd			= WORD_CHANGE(request("m_passwd"),20)


  m_jumin1			= WORD_CHANGE(request("m_jumin1"),20)
  m_jumin2			= WORD_CHANGE(request("m_jumin2"),20)
  m_zipcode1		= WORD_CHANGE(request("m_zipcode1"),20)
  m_zipcode2		= WORD_CHANGE(request("m_zipcode2"),20)
  m_address			= WORD_CHANGE(request("m_address"),200)
  m_email			= WORD_CHANGE(request("m_email"),50)
  m_login_ip		= WORD_CHANGE(request("m_login_ip"),40)
  m_tel1			= WORD_CHANGE(request("m_tel1"),50)
  m_tel2			= WORD_CHANGE(request("m_tel2"),50)
  m_bigo			= WORD_CHANGE(request("m_bigo"),0)
  m_duty			= WORD_CHANGE(request("m_duty"),20)
  m_position		= WORD_CHANGE(request("m_position"),20)
  m_bank_cd			= WORD_CHANGE(request("m_bank_cd"),20)
  m_bank_no			= WORD_CHANGE(request("m_bank_no"),20)
  m_bank_name		= WORD_CHANGE(request("m_bank_name"),20)
  m_status			= WORD_CHANGE(request("m_status"),20)
  m_pay_type		= WORD_CHANGE(request("m_pay_type"),20)
  m_in_date			= date_null_chk(request("m_in_date"))
  m_out_date		= date_null_chk(request("m_out_date"))
  

  If m_dealer_code="" Or m_id="" Or m_name="" Or m_passwd=""  Or m_position="" Or m_bank_cd="" Or m_duty="" Then 
	Alert_back "�߸��� �����Դϴ�."
	Response.end
  End If

  '���� ����� �߰�
  strSql = " select m_dealer_code, m_dealer_admin from emp_list where  m_id='"&session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs("m_dealer_code")
  	
  if m_idx<>"" then  
	  strSql = " select * from emp_list where m_idx="&m_idx
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
		Alert_back "�߸��� �����Դϴ�."
		Response.End
	  Else
		m_dealer_code1	= objRs("m_dealer_code")

		If m_dealer_code1<>m_dealer_code Then
			Alert_back "�߸��� �����Դϴ�."
			Response.end
		End if
	  End if

	  strSql = " update emp_list set "
	  strSql = strSql & "  m_name = '"& m_name &"'"  
	  strSql = strSql & ", m_passwd = '"& m_passwd &"'"
	  strSql = strSql & ", m_dealer_code = '"& m_dealer_code &"'"
	  strSql = strSql & ", m_jumin1 = '"& m_jumin1 &"'"
	  strSql = strSql & ", m_jumin2 = '"& m_jumin2 &"'"
	  strSql = strSql & ", m_login_ip = '"& m_login_ip &"'"
	  strSql = strSql & ", m_tel1 = '"& m_tel1 &"'"
	  strSql = strSql & ", m_tel2 = '"& m_tel2 &"'"
	  strSql = strSql & ", m_bigo = '"& m_bigo &"'"
	  strSql = strSql & ", m_duty = '"& m_duty &"'"
	  strSql = strSql & ", m_email = '"& m_email &"'"
	  strSql = strSql & ", m_bank_cd =  "& m_bank_cd &" "
	  strSql = strSql & ", m_bank_no = '"& m_bank_no &"'"
	  strSql = strSql & ", m_bank_name = '"& m_bank_name &"'"
	  strSql = strSql & ", m_position = '"& m_position &"'"
	  strSql = strSql & ", m_status = '"& m_status &"'"
	  strSql = strSql & ", m_zipcode1 = '"& m_zipcode1 &"'"
	  strSql = strSql & ", m_zipcode2 = '"& m_zipcode2 &"'"
	  strSql = strSql & ", m_address = '"& m_address &"'"	  
	  If m_in_date="null" then
		strSql = strSql & ", m_in_date=  "& m_in_date &"  "
	  else
		strSql = strSql & ", m_in_date= '"& m_in_date &"' "
	  End If		
	  If m_out_date="null" then
		strSql = strSql & ", m_out_date=  "& m_out_date &"  "
	  else
		strSql = strSql & ", m_out_date= '"& m_out_date &"' "
	  End If
	  strSql = strSql & ", m_pay_type = '"& m_pay_type &"'"
	  strSql = strSql & "  where m_idx="&m_idx&" "
	  'response.write strSql
	  set objRs=objCnn.Execute(strSql)

	  Alert_url "��������� ���� �Ǿ����ϴ�. ","y_emp_list.asp?page="&page
  Else      
	  strSql =" select m_id from emp_list where m_id='"&m_id&"'"
	  set objRs=objCnn.Execute(strSql)
	  
	  if objRs.eof or objRs.bof then
	  Else
		Alert_back " ���̵� �̹� ���� �մϴ�. \n\n �ٽ� �Է��� �ּ���! "
		response.end
	  end if  		
	  
	  strSql = "Select ISNULL(MAX(m_idx)+1,1) from emp_list "
	  set objRs=objCnn.Execute(strSql)
	  m_idx	= objRs(0)

	  strSql = "INSERT INTO emp_list (m_idx, o_code, m_id, m_passwd, m_name, m_dealer_code, m_jumin1,m_jumin2, m_login_ip,"
	  strSql = strSql & "m_duty, m_position, m_tel1, m_tel2, m_bigo,m_status, "
	  strSql = strSql & "m_email,m_zipcode1, m_zipcode2, m_address, m_bank_cd, m_bank_no, m_bank_name, "
	  strSql = strSql & " m_pay_type, m_in_date, m_out_date,m_last_passwd) VALUES "
	  strSql = strSql & "( " & m_idx & "  "
	  strSql = strSql & ",'" & o_code & "' "
	  strSql = strSql & ",'" & m_id & "' "
	  strSql = strSql & ",'" & m_passwd & "' "
	  strSql = strSql & ",'" & m_name & "' "
	  strSql = strSql & ",'" & m_dealer_code & "' "
	  strSql = strSql & ",'" & m_jumin1 & "' "
	  strSql = strSql & ",'" & m_jumin2 & "' "
	  strSql = strSql & ",'" & m_login_ip & "' "
	  strSql = strSql & ",'" & m_duty & "'"
	  strSql = strSql & ",'" & m_position & "'"
	  strSql = strSql & ",'" & m_tel1 & "'"
	  strSql = strSql & ",'" & m_tel2 & "'"
	  strSql = strSql & ",'" & m_bigo & "'"
	  strSql = strSql & ",'" & m_status & "'"
	  strSql = strSql & ",'" & m_email & "'"
	  strSql = strSql & ",'" & m_zipcode1 & "'"
	  strSql = strSql & ",'" & m_zipcode2 & "'"
	  strSql = strSql & ",'" & m_address & "'"
	  strSql = strSql & ",'" & m_bank_cd & "'"
	  strSql = strSql & ",'" & m_bank_no & "'"
	  strSql = strSql & ",'" & m_bank_name & "'"
	  strSql = strSql & ",'" & m_pay_type & "'"
	  If m_in_date="null" then
		strSql = strSql & ",  "& m_in_date &"  "	
	  else
		strSql = strSql & ", '"& m_in_date &"' "	
	  End If
	  If m_out_date="null" then
		strSql = strSql & ",  "& m_out_date &"  "	
	  else
		strSql = strSql & ", '"& m_out_date &"' "	
	  End If
		strSql = strSql & ", getdate() "	
	  
	  strSql = strSql & " )"
	  'response.write stRsql
	  set objRs=objCnn.Execute(strSql) 

	  ' ��� ���� ���� ���
	  strSql = "Select ISNULL(MAX(board_idx)+1,1) from emp_admin "
	  set objRs=objCnn.Execute(strSql)
	  board_idx	= objRs(0)
	
	
	  strSql = " insert into emp_admin ("
	  strSql = strSql & "  board_idx, o_code, m_id, ad_b_p_custom,ad_g_p_gamang, ad_k_p_result,"

	  If m_dealer_code=o_code Then
		strSql = strSql & " ad_e_notice1, ad_e_data1 "
	  Else
		strSql = strSql & " ad_e_notice2, ad_e_data2 "	  
	  End if
	  strSql = strSql & "  ) values("
	  strSql = strSql & "  "& board_idx &" "
	  strSql = strSql & ",'"& o_code &"','"& m_id &"','W', 'W', "
	  strSql = strSql & " 'R','R','R' "
	  strSql = strSql & " )"
	  set objRs=objCnn.Execute(strSql) 

	  Alert_url " ����� ��ϵǾ����ϴ�.","y_emp_list.asp?page="&page
  end if 
  %>