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

  sms_cnt			= WORD_CHANGE(request("sms_cnt"),20)				'�� �Ϲ� ����
  s_m_id			= WORD_CHANGE(request("s_m_id"),20)			'�� ��� ����
  s_o_code			= WORD_CHANGE(request("s_o_code"),20)			'�� ��ǰ ����

  strSql = "Select ISNULL(MAX(s_board_idx)+1,1) from SMS_PAYMENT "
  set objRs=objCnn_e.Execute(strSql)
  s_board_idx	= objRs(0)
    
  strSql = " INSERT INTO SMS_PAYMENT( s_board_idx, s_sms_cnt, s_m_id, s_o_code, s_writeday)"
  strSql = strSql & " values ("
  strSql = strSql & "  " & s_board_idx & " "
  strSql = strSql & ", " & sms_cnt & " "
  strSql = strSql & ",'" & s_m_id & "' " 
  strSql = strSql & ",'" & s_o_code & "' "
  strSql = strSql & ",getdate())"
  set objRs=objCnn_e.Execute(strSql)
  Alert_url "  SMS ������ ��û�� �Ϸ� �Ǿ����ϴ�. \n\n (����) 132-055-917955  ������:�־ȱ�(���ͼ���Ʈ)�� ���� �������� ������ �Ա��� �ֽñ� �ٶ��ϴ�.","a_sms_pay.asp"


  %>