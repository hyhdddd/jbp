  <%  
  session_m_id		= session("m_id")

  Login_chk(Session_m_id)

  strSql = " select * from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  o_com_name	= objRs("o_com_name")
  o_zipcode1	= objRs("o_zipcode1")
  o_zipcode2	= objRs("o_zipcode2")
  o_address		= objRs("o_address")
  o_office_no1	= objRs("o_office_no1")
  o_office_no2	= objRs("o_office_no2")
  o_office_no3	= objRs("o_office_no3")
  o_tel1		= objRs("o_tel1")
  o_tel2		= objRs("o_tel2")
  o_tel3		= objRs("o_tel3")
  o_logo		= objRs("o_logo")
  o_fax1		= objRs("o_fax1")
  o_fax2		= objRs("o_fax2")
  o_fax3		= objRs("o_fax3")
  o_marking		= money_chk(objRs("o_marking"))

  If IsNull(o_logo)=True Or o_logo="" Then
	logo_img= o_com_name
  Else
	logo_img="<img src='/file_data/"& o_code &"/"& o_logo &"' height=40 align='absmiddle' border=0>"
  End If

  objRs.close

  strSql = " select * from emp_admin where  m_id='"&Session_m_id&"'"
  set objRs=objCnn.Execute(strSql)
    
  if objRs.bof or objRs.eof Then
	'Customer Menu
	ad_b_p_custom			= "N"										'고객관리 - 개인
	ad_b_y_custom			= "N"										'고객관리 - 협력점
	ad_b_a_custom			= "N"										'고객관리 - 전체
	ad_b_g_custom			= "N"										'고객관리 - 상부점
	ad_b_m_custom			= "N"										'고객관리 - 담당별

	'엑셀권한
	ad_b_p_excel			= "N"										'고객관리 - 엑셀_개인
	ad_b_y_excel			= "N"										'고객관리 - 엑셀_협력점
	ad_b_a_excel			= "N"										'고객관리 - 엑셀_전체
	ad_b_g_excel			= "N"										'고객관리 - 엑셀_상부점
	ad_b_m_excel			= "N"										'고객관리 - 엑셀_담당별

	'가망고객관리
	ad_g_p_gamang			= "N"										'가망고객관리 - 나의 가망고객
	ad_g_y_gamang			= "N"										'가망고객관리 - 전체 가망고객
	ad_g_a_gamang			= "N"										'가망고객관리 - 전체 가망고객

	'insa Menu
	ad_i_a_emp				= "N"										'인사관리 - 전체 사원관리
	ad_i_y_emp				= "N"										'인사관리 - 거래처 사원관리
	ad_i_a_company			= "N"										'인사관리 - 거래처 정보등록


	'실적관리 
	ad_k_p_result			= "N"										'실적관리 - 나의 실적 관리
	ad_k_y_result			= "N"										'실적관리 - 거래처 실적 관리
	ad_k_a_result			= "N"										'실적관리 - 전체 실적 관리

	'정산관리 메뉴
	ad_r_p_exact			= "N"										'정산관리 - 개인별
	ad_r_y_exact			= "N"										'정산관리 - 거래처 정산관리
	ad_r_a_exact			= "N"										'정산관리 - 전체 정산관리
	ad_r_g_exact			= "N"										'정산관리 - 인계 정산관리


	'고객센터 메뉴
	ad_e_notice1			= "N"										'고객센터 - 사내 공지사항
	ad_e_notice2			= "N"										'고객센터 - 거래처 공지사항
	ad_e_data1				= "N"										'고객센터 - 사내 자료실
	ad_e_data2				= "N"										'고객센터 - 거래처 자료실

	'부가서비스 메뉴
  	ad_c_sms				= "N"										'부가서비스 - SMS
  	ad_c_code				= "N"										'부가서비스 - 코드관리
  	ad_c_popup				= "N"										'부가서비스 - 팝업관리
  	ad_c_black				= "N"										'부가서비스 - 블랙리스트
  	ad_c_fee				= "N"										'부가서비스 - 요금표
	ad_a_marking			= "N"

	ad_p_gift				= "N"
	ad_a_gift				= "N"

  Else
	'Customer Menu
	ad_b_p_custom			= CheckAdmin(objRs("ad_b_p_custom"))		'고객관리 - 개인
	ad_b_y_custom			= CheckAdmin(objRs("ad_b_y_custom"))		'고객관리 - 협력점
	ad_b_a_custom			= CheckAdmin(objRs("ad_b_a_custom"))		'고객관리 - 전체
	ad_b_g_custom			= CheckAdmin(objRs("ad_b_g_custom"))		'고객관리 - 상부점
	ad_b_m_custom			= CheckAdmin(objRs("ad_b_m_custom"))		'고객관리 - 담당별

	ad_b_p_excel			= CheckAdmin(objRs("ad_b_p_excel"))			'고객관리 - 엑셀_개인
	ad_b_y_excel			= CheckAdmin(objRs("ad_b_y_excel"))			'고객관리 - 엑셀_협력점
	ad_b_a_excel			= CheckAdmin(objRs("ad_b_a_excel"))			'고객관리 - 엑셀_전체
	ad_b_g_excel			= CheckAdmin(objRs("ad_b_g_excel"))			'고객관리 - 엑셀_상부점
	ad_b_m_excel			= CheckAdmin(objRs("ad_b_m_excel"))			'고객관리 - 엑셀_담당별

	'가망고객관리
	ad_g_p_gamang			= CheckAdmin(objRs("ad_g_p_gamang"))		'가망고객관리 - 나의 가망고객
	ad_g_y_gamang			= CheckAdmin(objRs("ad_g_y_gamang"))		'가망고객관리 - 전체 가망고객
	ad_g_a_gamang			= CheckAdmin(objRs("ad_g_a_gamang"))		'가망고객관리 - 전체 가망고객

	'insa Menu
	ad_i_a_emp				= CheckAdmin(objRs("ad_i_a_emp"))			'인사관리 - 전체 사원관리
	ad_i_y_emp				= CheckAdmin(objRs("ad_i_y_emp"))			'인사관리 - 거래처 사원관리
	ad_i_a_company			= CheckAdmin(objRs("ad_i_a_company"))		'인사관리 - 거래처 정보등록


	'실적관리 
	ad_k_p_result			= CheckAdmin(objRs("ad_k_p_result"))		'실적관리 - 나의 실적 관리
	ad_k_y_result			= CheckAdmin(objRs("ad_k_y_result"))		'실적관리 - 거래처 실적 관리
	ad_k_a_result			= CheckAdmin(objRs("ad_k_a_result"))		'실적관리 - 전체 실적 관리

	'정산관리 메뉴
	ad_r_p_exact			= CheckAdmin(objRs("ad_r_p_exact"))			'정산관리 - 개인별
	ad_r_y_exact			= CheckAdmin(objRs("ad_r_y_exact"))			'정산관리 - 거래처 정산관리
	ad_r_a_exact			= CheckAdmin(objRs("ad_r_a_exact"))			'정산관리 - 전체 정산관리
	ad_r_g_exact			= CheckAdmin(objRs("ad_r_g_exact"))			'정산관리 - 인계 정산관리


	'고객센터 메뉴
	ad_e_notice1			= CheckAdmin(objRs("ad_e_notice1"))			'고객센터 - 사내 공지사항
	ad_e_notice2			= CheckAdmin(objRs("ad_e_notice2"))			'고객센터 - 거래처 공지사항
	ad_e_data1				= CheckAdmin(objRs("ad_e_data1"))			'고객센터 - 사내 자료실
	ad_e_data2				= CheckAdmin(objRs("ad_e_data2"))			'고객센터 - 거래처 자료실

	'부가서비스 메뉴
  	ad_c_sms				= CheckAdmin(objRs("ad_c_sms"))				'부가서비스 - SMS
  	ad_c_code				= CheckAdmin(objRs("ad_c_code"))			'부가서비스 - 코드관리
  	ad_c_popup				= CheckAdmin(objRs("ad_c_popup"))			'부가서비스 - 팝업관리
  	ad_c_black				= CheckAdmin(objRs("ad_c_black"))			'부가서비스 - 블랙리스트
  	ad_c_fee				= CheckAdmin(objRs("ad_c_fee"))				'부가서비스 - 요금표
	ad_a_marking			= CheckAdmin(objRs("ad_a_marking"))	

	ad_p_gift				= CheckAdmin(objRs("ad_p_gift"))	
	ad_a_gift				= CheckAdmin(objRs("ad_a_gift"))	

  End if


  strSql = "select * from event_homepage order by board_idx asc"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	home_name	= ""
	home_url	= ""
	cms_url		= ""
  Else
	home_name	= objRs("home_name")
	home_url	= objRs("home_url")
	cms_url		= objRs("cms_url")
  End If

  strSql = " select m_step, m_name, m_last_passwd, m_dealer_code from emp_list where m_id='"&Session_m_id&"'"  
  set objRs=objCnn.Execute(strSql)
  
  session_m_step	= objRs("m_step")
  session_m_name	= objRs("m_name")
  m_last_passwd		= objRs("m_last_passwd")
  t_dealer_code		= objRs("m_dealer_code")

  
  '비밀번호 변경기록 30일 이후나 처음이면 변경요청....
  If o_code<>"C0001" Then 
	  url_chk = Request.ServerVariables("URL")

	  If InStr(url_chk,"passwd_regist")>0 Then	  
	  else
		  If m_last_passwd="" Or IsNull(m_last_passwd)=True Then
			Alert_url " 처음접속 하시거나, 보안 유지를 위해 3달에 한번은 비밀번호를 변경하셔야 사용하실 수 있습니다. ","/information/passwd_regist.asp"
		  Else
			  difference_cnt = dateDiff("d",m_last_passwd, now)

			  If difference_cnt>=180 Then
				Alert_url " 처음접속 하시거나, 보안 유지를 위해 6달에 한번은 비밀번호를 변경하셔야 사용하실 수 있습니다. ","/information/passwd_regist.asp"
			  End if
		  End if
	  End If
  End if  
  objRs.close
%>    