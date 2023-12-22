   <%
  '====================================='
  ' 프로젝트 : SENQ PROJECT
  ' 목    적 : HTTP://OSS.SENQ.CO.KR
  ' 개발일자 : 2007/08/15 ~2008/08/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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

  if ad_i_a_emp="N" then
	Alert_url session_m_name &" 님은 사원관리 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end if 

  search_key		= WORD_CHANGE(request("search_key"),20)
  search_txt		= WORD_CHANGE(request("search_txt"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  m_idx				= WORD_CHANGE(request("m_idx"),20)
  m_id				= WORD_CHANGE(Request("m_id"),20)
  page				= WORD_CHANGE(request("page"),20)
  m_name			= WORD_CHANGE(request("m_name"),40)
  m_dealer_code		= WORD_CHANGE(request("m_dealer_code"),20)
  m_passwd			= WORD_CHANGE(request("m_passwd"),20)


  m_jumin1			= WORD_CHANGE(request("m_jumin1"),20)
  m_jumin2			= WORD_CHANGE(request("m_jumin2"),20)
  m_zipcode1		= WORD_CHANGE(request("m_zipcode1"),20)
  m_zipcode2		= WORD_CHANGE(request("m_zipcode2"),20)
  m_address			= WORD_CHANGE(request("m_address"),200)
  m_email			= WORD_CHANGE(request("m_email"),70)
  m_login_ip		= WORD_CHANGE(request("m_login_ip"),30)
  m_tel1			= WORD_CHANGE(request("m_tel1"),20)
  m_tel2			= WORD_CHANGE(request("m_tel2"),20)
  m_bigo			= WORD_CHANGE(request("m_bigo"),0)
  m_duty			= WORD_CHANGE(request("m_duty"),20)
  m_position		= WORD_CHANGE(request("m_position"),20)
  m_bank_cd			= WORD_CHANGE(request("m_bank_cd"),20)
  m_bank_no			= WORD_CHANGE(request("m_bank_no"),40)
  m_bank_name		= WORD_CHANGE(request("m_bank_name"),40)
  m_status			= WORD_CHANGE(request("m_status"),20)
  m_pay_type		= WORD_CHANGE(request("m_pay_type"),20)
  m_family_no		= WORD_CHANGE(Request("m_family_no"),20)
  m_in_date			= WORD_CHANGE(date_null_chk(request("m_in_date")),20)
  m_out_date		= WORD_CHANGE(date_null_chk(request("m_out_date")),20)
  all_decision		= WORD_CHANGE(request("all_decision"),20)
  duty_decision		= WORD_CHANGE(request("duty_decision"),20)
  m_dealer_admin	= WORD_CHANGE(Request("m_dealer_admin"),20)

  If m_dealer_admin	= "" Then
	m_dealer_admin	= "X"
  End if

  '보안 취약점 추가
  If m_dealer_code="" Or m_id="" Or m_name="" Or m_passwd=""  Or m_position="" Or m_bank_cd="" Or m_duty="" Or m_status="" Then 
	Alert_back "잘못된 접근입니다."
	Response.end
  End If
  
  if m_idx<>"" then  

	  strSql = " select * from emp_list where m_idx="&m_idx&" "
	  Set objRs=objCnn.Execute(strSql)

	  m_id			= objRs("m_id")
	  o_dealer_code	= objRs("m_dealer_code")
	  
	  '거래처 소속이 바뀌면 실적도 따라가게 합니다.

	  If o_dealer_code<>m_dealer_code Then
		  strSql = " update customer_goods set g_trans_in_dealer='"&m_dealer_code&"' where g_yuchi_m_id='"&m_id&"'"
		  Set objRs=objCnn.Execute(strSql)
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
	  strSql = strSql & ", m_dealer_admin = '"& m_dealer_admin &"'"
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
	  strSql = strSql & ", m_family_no = "& m_family_no &" "
	  strSql = strSql & ", all_decision = '"& all_decision &"'"
	  strSql = strSql & ", duty_decision = '"& duty_decision &"'"
	  strSql = strSql & "  where m_idx="&m_idx&" "
	  'response.write strSql
	  set objRs=objCnn.Execute(strSql)

	  Alert_url "사원정보가 수정 되었습니다. ","a_emp_list.asp?page="&page&"&search_key="&search_key&"&search_txt="&search_txt&"&s_dealer_code="&s_dealer_code
  Else      
	  strSql =" select m_id from emp_list where m_id='"&m_id&"'"
	  set objRs=objCnn.Execute(strSql)
	  
	  if objRs.eof or objRs.bof then
	  Else
		Alert_back " 아이디가 이미 존재 합니다. \n\n 다시 입력해 주세요! "
		response.end
	  end if  
			  
	  strSql = "Select ISNULL(MAX(m_idx)+1,1) from emp_list "
	  set objRs=objCnn.Execute(strSql)
	  m_idx	= objRs(0)

	  strSql = "INSERT INTO emp_list (m_idx, o_code, m_id, m_passwd, m_name, m_dealer_code, m_jumin1,m_jumin2, m_login_ip,"
	  strSql = strSql & "m_duty, m_position, m_tel1, m_tel2, m_bigo,m_status, "
	  strSql = strSql & "m_email,m_zipcode1, m_zipcode2, m_address, m_bank_cd, m_bank_no, m_bank_name, "
	  strSql = strSql & " m_pay_type, m_family_no, m_in_date, m_out_date,m_step,m_dealer_admin,m_last_passwd) VALUES "
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
	  strSql = strSql & ", " & m_family_no & " "
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
	  strSql = strSql & ",'S','"& m_dealer_admin &"',getdate())"
	  'response.write stRsql&"<br>"
	  set objRs=objCnn.Execute(strSql) 

	  ' 사원 기초 권한 등록
	  strSql = "Select ISNULL(MAX(board_idx)+1,1) from emp_admin "
	  set objRs=objCnn.Execute(strSql)
	  board_idx	= objRs(0)
	
	  strSql = " insert into emp_admin ("
	  strSql = strSql & "  board_idx, o_code, m_id, ad_g_p_gamang, ad_k_p_result, "

	  If m_dealer_code=o_code Then
		strSql = strSql & " ad_e_notice1, ad_e_data1, "
	  Else
		strSql = strSql & " ad_e_notice2, ad_e_data2, "
		If m_dealer_admin="O" Then 
			strSql = strSql & " ad_g_y_gamang, ad_i_y_emp, ad_r_p_exact, ad_r_y_exact, ad_b_y_custom, ad_k_y_result,"			
		End if
	  End If

	  strSql = strSql & " ad_b_p_custom "
	  strSql = strSql & " ) values("
	  strSql = strSql & " "& board_idx &",'"& o_code &"','"& m_id &"', 'E','R',"

	  If m_dealer_code=o_code Then
	  strSql = strSql & " 'R','R',"
	  Else
	  strSql = strSql & " 'R','R',"
		If m_dealer_admin="O" Then 
			strSql = strSql & " 'E', 'A', 'N', 'R', 'W', 'R', "
		End if
	  End If

	  strSql = strSql & " 'W'"
	  strSql = strSql & " )"
	  'Response.write strSql &"<br>"
	  set objRs=objCnn.Execute(strSql) 

	  Alert_url " 사원이 등록되었습니다. \n\n 등록된 사원은 메뉴 사용권한 을 설정해야 합니다.\n\n 마스터 권한이을 가지고 계신분만 설정할 수 있습니다.","a_emp_list.asp?page="&page&"&search_key="&search_key&"&search_txt="&search_txt&"&s_dealer_code="&s_dealer_code
  end if 
  %>