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
	ad_b_p_custom			= "N"										'������ - ����
	ad_b_y_custom			= "N"										'������ - ������
	ad_b_a_custom			= "N"										'������ - ��ü
	ad_b_g_custom			= "N"										'������ - �����
	ad_b_m_custom			= "N"										'������ - ��纰

	'��������
	ad_b_p_excel			= "N"										'������ - ����_����
	ad_b_y_excel			= "N"										'������ - ����_������
	ad_b_a_excel			= "N"										'������ - ����_��ü
	ad_b_g_excel			= "N"										'������ - ����_�����
	ad_b_m_excel			= "N"										'������ - ����_��纰

	'����������
	ad_g_p_gamang			= "N"										'���������� - ���� ������
	ad_g_y_gamang			= "N"										'���������� - ��ü ������
	ad_g_a_gamang			= "N"										'���������� - ��ü ������

	'insa Menu
	ad_i_a_emp				= "N"										'�λ���� - ��ü �������
	ad_i_y_emp				= "N"										'�λ���� - �ŷ�ó �������
	ad_i_a_company			= "N"										'�λ���� - �ŷ�ó �������


	'�������� 
	ad_k_p_result			= "N"										'�������� - ���� ���� ����
	ad_k_y_result			= "N"										'�������� - �ŷ�ó ���� ����
	ad_k_a_result			= "N"										'�������� - ��ü ���� ����

	'������� �޴�
	ad_r_p_exact			= "N"										'������� - ���κ�
	ad_r_y_exact			= "N"										'������� - �ŷ�ó �������
	ad_r_a_exact			= "N"										'������� - ��ü �������
	ad_r_g_exact			= "N"										'������� - �ΰ� �������


	'������ �޴�
	ad_e_notice1			= "N"										'������ - �系 ��������
	ad_e_notice2			= "N"										'������ - �ŷ�ó ��������
	ad_e_data1				= "N"										'������ - �系 �ڷ��
	ad_e_data2				= "N"										'������ - �ŷ�ó �ڷ��

	'�ΰ����� �޴�
  	ad_c_sms				= "N"										'�ΰ����� - SMS
  	ad_c_code				= "N"										'�ΰ����� - �ڵ����
  	ad_c_popup				= "N"										'�ΰ����� - �˾�����
  	ad_c_black				= "N"										'�ΰ����� - ������Ʈ
  	ad_c_fee				= "N"										'�ΰ����� - ���ǥ
	ad_a_marking			= "N"

	ad_p_gift				= "N"
	ad_a_gift				= "N"

  Else
	'Customer Menu
	ad_b_p_custom			= CheckAdmin(objRs("ad_b_p_custom"))		'������ - ����
	ad_b_y_custom			= CheckAdmin(objRs("ad_b_y_custom"))		'������ - ������
	ad_b_a_custom			= CheckAdmin(objRs("ad_b_a_custom"))		'������ - ��ü
	ad_b_g_custom			= CheckAdmin(objRs("ad_b_g_custom"))		'������ - �����
	ad_b_m_custom			= CheckAdmin(objRs("ad_b_m_custom"))		'������ - ��纰

	ad_b_p_excel			= CheckAdmin(objRs("ad_b_p_excel"))			'������ - ����_����
	ad_b_y_excel			= CheckAdmin(objRs("ad_b_y_excel"))			'������ - ����_������
	ad_b_a_excel			= CheckAdmin(objRs("ad_b_a_excel"))			'������ - ����_��ü
	ad_b_g_excel			= CheckAdmin(objRs("ad_b_g_excel"))			'������ - ����_�����
	ad_b_m_excel			= CheckAdmin(objRs("ad_b_m_excel"))			'������ - ����_��纰

	'����������
	ad_g_p_gamang			= CheckAdmin(objRs("ad_g_p_gamang"))		'���������� - ���� ������
	ad_g_y_gamang			= CheckAdmin(objRs("ad_g_y_gamang"))		'���������� - ��ü ������
	ad_g_a_gamang			= CheckAdmin(objRs("ad_g_a_gamang"))		'���������� - ��ü ������

	'insa Menu
	ad_i_a_emp				= CheckAdmin(objRs("ad_i_a_emp"))			'�λ���� - ��ü �������
	ad_i_y_emp				= CheckAdmin(objRs("ad_i_y_emp"))			'�λ���� - �ŷ�ó �������
	ad_i_a_company			= CheckAdmin(objRs("ad_i_a_company"))		'�λ���� - �ŷ�ó �������


	'�������� 
	ad_k_p_result			= CheckAdmin(objRs("ad_k_p_result"))		'�������� - ���� ���� ����
	ad_k_y_result			= CheckAdmin(objRs("ad_k_y_result"))		'�������� - �ŷ�ó ���� ����
	ad_k_a_result			= CheckAdmin(objRs("ad_k_a_result"))		'�������� - ��ü ���� ����

	'������� �޴�
	ad_r_p_exact			= CheckAdmin(objRs("ad_r_p_exact"))			'������� - ���κ�
	ad_r_y_exact			= CheckAdmin(objRs("ad_r_y_exact"))			'������� - �ŷ�ó �������
	ad_r_a_exact			= CheckAdmin(objRs("ad_r_a_exact"))			'������� - ��ü �������
	ad_r_g_exact			= CheckAdmin(objRs("ad_r_g_exact"))			'������� - �ΰ� �������


	'������ �޴�
	ad_e_notice1			= CheckAdmin(objRs("ad_e_notice1"))			'������ - �系 ��������
	ad_e_notice2			= CheckAdmin(objRs("ad_e_notice2"))			'������ - �ŷ�ó ��������
	ad_e_data1				= CheckAdmin(objRs("ad_e_data1"))			'������ - �系 �ڷ��
	ad_e_data2				= CheckAdmin(objRs("ad_e_data2"))			'������ - �ŷ�ó �ڷ��

	'�ΰ����� �޴�
  	ad_c_sms				= CheckAdmin(objRs("ad_c_sms"))				'�ΰ����� - SMS
  	ad_c_code				= CheckAdmin(objRs("ad_c_code"))			'�ΰ����� - �ڵ����
  	ad_c_popup				= CheckAdmin(objRs("ad_c_popup"))			'�ΰ����� - �˾�����
  	ad_c_black				= CheckAdmin(objRs("ad_c_black"))			'�ΰ����� - ������Ʈ
  	ad_c_fee				= CheckAdmin(objRs("ad_c_fee"))				'�ΰ����� - ���ǥ
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

  
  '��й�ȣ ������ 30�� ���ĳ� ó���̸� �����û....
  If o_code<>"C0001" Then 
	  url_chk = Request.ServerVariables("URL")

	  If InStr(url_chk,"passwd_regist")>0 Then	  
	  else
		  If m_last_passwd="" Or IsNull(m_last_passwd)=True Then
			Alert_url " ó������ �Ͻðų�, ���� ������ ���� 3�޿� �ѹ��� ��й�ȣ�� �����ϼž� ����Ͻ� �� �ֽ��ϴ�. ","/information/passwd_regist.asp"
		  Else
			  difference_cnt = dateDiff("d",m_last_passwd, now)

			  If difference_cnt>=180 Then
				Alert_url " ó������ �Ͻðų�, ���� ������ ���� 6�޿� �ѹ��� ��й�ȣ�� �����ϼž� ����Ͻ� �� �ֽ��ϴ�. ","/information/passwd_regist.asp"
			  End if
		  End if
	  End If
  End if  
  objRs.close
%>    