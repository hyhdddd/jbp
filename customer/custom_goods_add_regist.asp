  <%
  g_goods_idx_new	= WORD_CHANGE(Request("g_goods_idx_new"),20)

  If g_goods_idx_new<>"" Then
    	strSql = "select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_option_idx, A.g_set, A.g_code_gaetong_idx, "
	strSql = strSql & " A.g_zipcode1, A.g_zipcode2, A.g_address, A.g_date_yuchi, A.g_service_no, A.g_article_cnt,  "
	strSql = strsql & " A.g_bank_cd , A.g_bank_no, A.g_bank_name, A.g_cancel_date, A.g_writeday, "
	strSql = strSql & " A.g_sp_bank_code, A.g_sp_bank_acount, A.g_sp_bank_name, A.g_sp_bank_memo, A.g_code_service,  "
	strSql = strSql & " A.g_file1, A.g_file2, A.g_file3, A.g_file4, A.g_receipt_type, A.c_auth_chk, A.g_trans_in_dealer,  "
	strSql = strSql & " A.g_code_course_idx, A.g_sp_date_start, A.g_sp_name, A.g_sp_price, A.g_goods_ref, "
	strSql = strSql & " A.g_code_promise, A.g_yuchi_m_id, A.g_jupsu_m_id, A.g_trans_out_dealer, A.g_give_chk, "
	strSql = strSql & " A.g_sp_give_type, A.g_bank_jumin1, A.g_bank_jumin2, A.g_give_type, A.g_date_gaetong, "
	strSql = strSql & " A.g_card_cd, A.g_card_no , A.g_card_gigan, A.g_card_gigan1, A.g_card_name, A.g_card_jumin1, A.g_card_jumin2, "
	strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, A.g_code_area, A.g_code_document, "
	strSql = strSql & " A.g_date_gaetong_hope, A.g_date_gaetong_hope_time, A.g_sp_name_top, A.g_sp_price_top, "

	strSql = strSql & " A.g_move_tel1, A.g_move_name, A.g_move_jumin1, A.g_move_jumin2, A.g_move_date, "
	strSql = strSql & " A.g_move_tel2, A.g_move_company, A.g_move_memo,"

	strSql = strSql & " A.c_type, A.c_jumin1, A.c_jumin2, A.c_tel2, A.c_office_no, A.c_office_name, A.c_zipcode1, A.c_zipcode2, "
	strSql = strSql & " A.c_address, A.c_tel1, A.c_email, A.c_jumin_date, A.g_sp_date_end, "
	strSql = strSql & " A.c_name as c_name , A.g_bigo , A.g_code_sale "
	strSql = strSql & "		from customer_goods A where A.g_goods_idx="&g_goods_idx_new 	
  	set objRs=objCnn.Execute(strSql)
  		
  	if objRs.eof or objRs.bof then  	
  	Else
		g_option_idx		= objRs("g_option_idx")
		g_set				= objRs("g_set")				'��Ʈ����
		g_zipcode1			= objRs("g_zipcode1")
		g_zipcode2			= objRs("g_zipcode2")
		g_address			= objRs("g_address")
		g_date_yuchi		= objRs("g_date_yuchi")			'��ġ��
		m_dealer_code		= objRs("g_trans_in_dealer")

		g_date_yuchi_hour	= Hour(g_date_yuchi)
		g_date_yuchi_minute	= minute(g_date_yuchi)

		g_bank_cd			= objRs("g_bank_cd")
		g_bank_no			= objRs("g_bank_no")
		g_bank_name			= objRs("g_bank_name")
		c_name				= objRs("c_name")

		g_code_course_idx	= objRs("g_code_course_idx")	'�������
		g_code_promise		= objRs("g_code_promise")
		g_bigo				= objRs("g_bigo")
		g_code_sale			= objRs("g_code_sale")
		g_yuchi_m_id		= objRs("g_yuchi_m_id")			'��ġ��
		g_jupsu_m_id		= objRs("g_jupsu_m_id")			'������

		g_bank_jumin1		= objRs("g_bank_jumin1")		'��ü���� �ֹι�ȣ(����� �ٸ����)
		g_bank_jumin2		= objRs("g_bank_jumin2")		'��ü���� �ֹι�ȣ(����� �ٸ����)

		g_give_type			= objRs("g_give_type")			'��������
		g_give_chk			= objRs("g_give_chk")			'�������� - ����
		g_card_cd			= objRs("g_card_cd")			'ī���
		g_card_no			= objRs("g_card_no")			'ī���ȣ
		g_card_gigan		= objRs("g_card_gigan")			'ī�� ��ȿ�Ⱓ
		g_card_gigan1		= objRs("g_card_gigan1")		'ī�� ��ȿ�Ⱓ
		g_card_name			= objRs("g_card_name")			'ī�� ��ȿ�Ⱓ
		g_card_jumin1		= objRs("g_card_jumin1")		'ī�� ��ȿ�Ⱓ
		g_card_jumin2		= objRs("g_card_jumin2")		'ī�� ��ȿ�Ⱓ

		g_date_gaetong_hope	= objRs("g_date_gaetong_hope")	'���������
		g_date_gaetong_hope_time = objRs("g_date_gaetong_hope_time")
		g_service_no		= objRs("g_service_no")			'���Լ��񽺹�ȣ

		g_date_gaetong		= objRs("g_date_gaetong")		'������
		g_code_gaetong_idx	= objRs("g_code_gaetong_idx")	'�������

		'������
		c_type				= objRs("c_type")
		c_jumin1			= objRs("c_jumin1")
		c_jumin2			= objRs("c_jumin2")
		c_tel2				= objRs("c_tel2")
		c_office_no			= objRs("c_office_no")
		c_office_name		= objRs("c_office_name")

		c_zipcode1			= objRs("c_zipcode1")
		c_zipcode2			= objRs("c_zipcode2")
		c_address			= objRs("c_address")
		c_tel1				= objRs("c_tel1")
		c_email				= objRs("c_email")
		c_auth_chk			= objRs("c_auth_chk")
		c_jumin_date		= objRs("c_jumin_date")

		g_receipt_type		= objRs("g_receipt_type")							'ȸ�ſ�û

		'����ǰ ��������
		g_sp_bank_code		= objRs("g_sp_bank_code")							'����ǰ ���� �����ڵ�
		g_sp_bank_acount	= objRs("g_sp_bank_acount")							'����ǰ ���� �������
		g_sp_bank_name		= objRs("g_sp_bank_name")							'����ǰ ���� ���࿹����
		g_sp_bank_memo		= objRs("g_sp_bank_memo")							'����ǰ ���� ����޸�

		'g_code_service		= objRs("g_code_service")							'�ΰ�����
		'g_cancel_date		= objRs("g_cancel_date")							'�ؾ�����
		'g_article_cnt		= objRs("g_article_cnt")							'ȸ����

		g_sum_money_chk		= objRs("g_sum_money_chk")							'�ջ�û������
		g_sum_money_txt		= objRs("g_sum_money_txt")							'�ջ�û������

		'g_move_tel1			= objRs("g_move_tel1")								'��ȣ�̵� �׸�
		'g_move_name			= objRs("g_move_name")
		'g_move_jumin1		= objRs("g_move_jumin1")
		'g_move_jumin2		= objRs("g_move_jumin2")
		'g_move_date			= objRs("g_move_date")
		'g_move_tel2			= objRs("g_move_tel2")
		'g_move_company		= objRs("g_move_company")
		'g_move_memo			= objRs("g_move_memo")
	End if
  End if
  %>