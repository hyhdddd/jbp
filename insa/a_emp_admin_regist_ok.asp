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

  If session_m_step="M" Then
  Else
	Alert_url session_m_name &" ���� ������� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  End If 

  m_id				= WORD_CHANGE(Request("m_id"),20)
  m_name			= WORD_CHANGE(Request("m_name"),20)

  If m_id="" Then
	Alert_back " ������ �߸��Ǿ����ϴ�."
	Response.End
  End if

 '������
  ad_b_p_custom		= CheckAdmin(Request("ad_b_p_custom"))		'������ - ����
  ad_b_y_custom		= CheckAdmin(Request("ad_b_y_custom"))		'������ - ������
  ad_b_a_custom		= CheckAdmin(Request("ad_b_a_custom"))		'������ - ��ü
  ad_b_g_custom		= CheckAdmin(Request("ad_b_g_custom"))		'������ - �����
  ad_b_m_custom		= CheckAdmin(Request("ad_b_m_custom"))		'������ - ��纰

  '�������Ѽ���
  ad_b_p_excel		= CheckAdmin(Request("ad_b_p_excel"))		'������ - ����_����
  ad_b_y_excel		= CheckAdmin(Request("ad_b_y_excel"))		'������ - ����_������
  ad_b_a_excel		= CheckAdmin(Request("ad_b_a_excel"))		'������ - ����_��ü
  ad_b_g_excel		= CheckAdmin(Request("ad_b_g_excel"))		'������ - ����_�����
  ad_b_m_excel		= CheckAdmin(Request("ad_b_m_excel"))		'������ - ����_��纰

  '����������
  ad_g_p_gamang		= CheckAdmin(Request("ad_g_p_gamang"))		'������ - ���� ������
  ad_g_y_gamang		= CheckAdmin(Request("ad_g_y_gamang"))		'������ - ������ ������
  ad_g_a_gamang		= CheckAdmin(Request("ad_g_a_gamang"))		'������ - ��ü ������

  'insa Menu
  ad_i_a_emp		= CheckAdmin(Request("ad_i_a_emp"))			'�λ���� - ��ü �������
  ad_i_y_emp		= CheckAdmin(Request("ad_i_y_emp"))			'�λ���� - �ŷ�ó �������
  ad_i_a_company	= CheckAdmin(Request("ad_i_a_company"))		'�λ���� - �ŷ�ó �������

  '�������� 
  ad_k_p_result		= CheckAdmin(Request("ad_k_p_result"))		'�������� - ���� ���� ����
  ad_k_y_result		= CheckAdmin(Request("ad_k_y_result"))		'�������� - �ŷ�ó ���� ����
  ad_k_a_result		= CheckAdmin(Request("ad_k_a_result"))		'�������� - ��ü ���� ����


  '������� �޴�
  ad_r_p_exact		= CheckAdmin(Request("ad_r_p_exact"))		'������� - ���� �������
  ad_r_y_exact		= CheckAdmin(Request("ad_r_y_exact"))		'������� - �ŷ�ó �������
  ad_r_a_exact		= CheckAdmin(Request("ad_r_a_exact"))		'������� - ��ü �������
  ad_r_g_exact		= CheckAdmin(Request("ad_r_g_exact"))		'������� - ��ü �������

  '������ �޴�
  ad_e_notice1		= CheckAdmin(Request("ad_e_notice1"))		'������ - �系 ��������
  ad_e_notice2		= CheckAdmin(Request("ad_e_notice2"))		'������ - �ŷ�ó ��������
  ad_e_data1		= CheckAdmin(Request("ad_e_data1"))			'������ - �系 �ڷ��
  ad_e_data2		= CheckAdmin(Request("ad_e_data2"))			'������ - �ŷ�ó �ڷ��


  '�ΰ����� ����
  ad_c_sms			= CheckAdmin(Request("ad_c_sms"))			'�ΰ����� - sms
  ad_c_code			= CheckAdmin(Request("ad_c_code"))			'�ΰ����� - �ڵ� ����
  ad_c_popup		= CheckAdmin(Request("ad_c_popup"))			'�ΰ����� - popup ����
  ad_c_black		= CheckAdmin(Request("ad_c_black"))			'�ΰ����� - ������Ʈ
  ad_c_fee			= CheckAdmin(Request("ad_c_fee"))			'������Ʈ - ���ǥ ����
  ad_a_marking		= CheckAdmin(Request("ad_a_marking"))	
  
  ad_p_gift			= CheckAdmin(Request("ad_p_gift"))	
  ad_a_gift			= CheckAdmin(Request("ad_a_gift"))	

  strsql = " select * from emp_admin where  m_id='"&m_id&"'"
  set objRs=objCnn.execute(strSql)
  
	
  if objRs.eof or objRs.bof then 
    strSql = "select ISNULL(MAX(board_idx)+1,1) AS SEQ from emp_admin"
	Set objRs=objCnn.Execute(strSql)

	board_idx=objRs(0)
	
  	strSql = " insert into emp_admin ("
  	strSql = strSql & "  board_idx "
	strSql = strSql & ", o_code"
	strSql = strSql & ", m_id"
	strSql = strSql & ", ad_b_p_custom"
	strSql = strSql & ", ad_b_y_custom"
	strSql = strSql & ", ad_b_a_custom"
	strSql = strSql & ", ad_b_g_custom"
	strSql = strSql & ", ad_b_m_custom"

	strSql = strSql & ", ad_b_p_excel"
	strSql = strSql & ", ad_b_y_excel"
	strSql = strSql & ", ad_b_a_excel"
	strSql = strSql & ", ad_b_g_excel"
	strSql = strSql & ", ad_b_m_excel"

	strSql = strSql & ", ad_g_p_gamang"
	strSql = strSql & ", ad_g_y_gamang"
	strSql = strSql & ", ad_g_a_gamang"
	strSql = strSql & ", ad_i_a_emp"
	strSql = strSql & ", ad_i_y_emp"
	strSql = strSql & ", ad_i_a_company"
	strSql = strSql & ", ad_k_p_result"
	strSql = strSql & ", ad_k_y_result"
	strSql = strSql & ", ad_k_a_result"
	strSql = strSql & ", ad_r_p_exact"
	strSql = strSql & ", ad_r_y_exact"
	strSql = strSql & ", ad_r_a_exact"
	strSql = strSql & ", ad_r_g_exact"
	strSql = strSql & ", ad_e_notice1"
	strSql = strSql & ", ad_e_notice2"
	strSql = strSql & ", ad_e_data1"
	strSql = strSql & ", ad_e_data2"
	strSql = strSql & ", ad_c_sms"
	strSql = strSql & ", ad_c_code"
	strSql = strSql & ", ad_c_popup"
	strSql = strSql & ", ad_c_black"
	strSql = strSql & ", ad_c_fee"
	strSql = strSql & ", ad_a_marking"	

	strSql = strSql & ", ad_p_gift"	
	strSql = strSql & ", ad_a_gift"	


  	strSql = strSql & "  ) "
  	strSql = strSql & "  values("
  	strSql = strSql & "  "& board_idx &" "
  	strSql = strSql & ",'"& o_code &"'"
  	strSql = strSql & ",'"& m_id &"'"
  	strSql = strSql & ",'"& ad_b_p_custom &"'"
  	strSql = strSql & ",'"& ad_b_y_custom &"'"
  	strSql = strSql & ",'"& ad_b_a_custom &"'"
  	strSql = strSql & ",'"& ad_b_g_custom &"'"
  	strSql = strSql & ",'"& ad_b_m_custom &"'"

  	strSql = strSql & ",'"& ad_b_p_excel &"'"
  	strSql = strSql & ",'"& ad_b_y_excel &"'"
  	strSql = strSql & ",'"& ad_b_a_excel &"'"
  	strSql = strSql & ",'"& ad_b_g_excel &"'"
  	strSql = strSql & ",'"& ad_b_m_excel &"'"

  	strSql = strSql & ",'"& ad_g_p_gamang &"'"
  	strSql = strSql & ",'"& ad_g_y_gamang &"'"
  	strSql = strSql & ",'"& ad_g_a_gamang &"'"
  	strSql = strSql & ",'"& ad_i_a_emp &"'"
  	strSql = strSql & ",'"& ad_i_y_emp &"'"
  	strSql = strSql & ",'"& ad_i_a_company &"'"
  	strSql = strSql & ",'"& ad_k_p_result &"'"
  	strSql = strSql & ",'"& ad_k_y_result &"'"
  	strSql = strSql & ",'"& ad_k_a_result &"'"
  	strSql = strSql & ",'"& ad_r_p_exact &"'"
  	strSql = strSql & ",'"& ad_r_y_exact &"'"
  	strSql = strSql & ",'"& ad_r_a_exact &"'"
  	strSql = strSql & ",'"& ad_r_g_exact &"'"
  	strSql = strSql & ",'"& ad_e_notice1 &"'"
  	strSql = strSql & ",'"& ad_e_notice2 &"'"
  	strSql = strSql & ",'"& ad_e_data1 &"'"
  	strSql = strSql & ",'"& ad_e_data2 &"'"
  	strSql = strSql & ",'"& ad_c_sms &"'"
  	strSql = strSql & ",'"& ad_c_code &"'"
  	strSql = strSql & ",'"& ad_c_popup &"'"
  	strSql = strSql & ",'"& ad_c_black &"'"
  	strSql = strSql & ",'"& ad_c_fee &"'"
  	strSql = strSql & ",'"& ad_a_marking &"'"

  	strSql = strSql & ",'"& ad_p_gift &"'"
  	strSql = strSql & ",'"& ad_a_gift &"'"
	
  	strSql = strSql & " )"
  else
  	strSql = " update emp_admin set "
  	strSql = strSql & "  ad_b_p_custom			= '"& ad_b_p_custom &"' "   
  	strSql = strSql & ", ad_b_y_custom			= '"& ad_b_y_custom &"' "  
  	strSql = strSql & ", ad_b_a_custom			= '"& ad_b_a_custom &"' "  
  	strSql = strSql & ", ad_b_g_custom			= '"& ad_b_g_custom &"' "  
  	strSql = strSql & ", ad_b_m_custom			= '"& ad_b_m_custom &"' "  

	strSql = strSql & ", ad_b_p_excel			= '"& ad_b_p_excel &"' "  
	strSql = strSql & ", ad_b_y_excel			= '"& ad_b_y_excel &"' "  
	strSql = strSql & ", ad_b_a_excel			= '"& ad_b_a_excel &"' "  
	strSql = strSql & ", ad_b_g_excel			= '"& ad_b_g_excel &"' "  
	strSql = strSql & ", ad_b_m_excel			= '"& ad_b_m_excel &"' "  

  	strSql = strSql & ", ad_g_p_gamang			= '"& ad_g_p_gamang &"' "  
  	strSql = strSql & ", ad_g_y_gamang			= '"& ad_g_y_gamang &"' "  
  	strSql = strSql & ", ad_g_a_gamang			= '"& ad_g_a_gamang &"' "  
  	strSql = strSql & ", ad_i_a_emp				= '"& ad_i_a_emp &"' "  
  	strSql = strSql & ", ad_i_y_emp				= '"& ad_i_y_emp &"' "  
  	strSql = strSql & ", ad_i_a_company			= '"& ad_i_a_company &"' " 
  	strSql = strSql & ", ad_k_p_result			= '"& ad_k_p_result &"' "  
  	strSql = strSql & ", ad_k_y_result			= '"& ad_k_y_result &"' "  
  	strSql = strSql & ", ad_k_a_result			= '"& ad_k_a_result &"' "  
  	strSql = strSql & ", ad_r_p_exact			= '"& ad_r_p_exact &"' "  
  	strSql = strSql & ", ad_r_y_exact			= '"& ad_r_y_exact &"' "  
  	strSql = strSql & ", ad_r_a_exact			= '"& ad_r_a_exact &"' "  
  	strSql = strSql & ", ad_r_g_exact			= '"& ad_r_g_exact &"' "  
  	strSql = strSql & ", ad_e_notice1			= '"& ad_e_notice1 &"' "  
  	strSql = strSql & ", ad_e_notice2			= '"& ad_e_notice2 &"' "  
  	strSql = strSql & ", ad_e_data1				= '"& ad_e_data1 &"' "  
  	strSql = strSql & ", ad_e_data2				= '"& ad_e_data2 &"' "  
  	strSql = strSql & ", ad_c_sms				= '"& ad_c_sms &"' "  
  	strSql = strSql & ", ad_c_code				= '"& ad_c_code &"' "  
  	strSql = strSql & ", ad_c_popup				= '"& ad_c_popup &"' "  
  	strSql = strSql & ", ad_c_black				= '"& ad_c_black &"' "  
  	strSql = strSql & ", ad_c_fee				= '"& ad_c_fee &"' "  
  	strSql = strSql & ", ad_a_marking			= '"& ad_a_marking &"' "  	

  	strSql = strSql & ", ad_p_gift				= '"& ad_p_gift &"' "  	
  	strSql = strSql & ", ad_a_gift				= '"& ad_a_gift &"' "  	
	
  	strSql = strSql & "  where m_id				= '"& m_id &"'"  
  end If
  'Response.write strSql
  set objRs=objCnn.Execute(strSql)  
  Alert_url " ��� ���� ������ ���/���� �Ǿ����ϴ�.","a_emp_admin_regist.asp?m_id="&m_id&"&m_name="&m_name
  %>

  %>