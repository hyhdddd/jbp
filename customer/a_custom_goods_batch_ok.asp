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
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%


  if ad_b_a_custom="N" And ad_b_m_custom="N" then
 	Alert session_m_name &" ���� �� ��ǰ ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	win_close()
  end if	  
  
  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),0)
  g_date_gaetong		= WORD_CHANGE(request("g_date_gaetong"),20)
  g_date_yuchi			= WORD_CHANGE(request("g_date_yuchi"),20)

  g_date_yuchi_hour		= WORD_CHANGE(request("g_date_yuchi_hour"),20)
  g_date_yuchi_minute	= WORD_CHANGE(request("g_date_yuchi_minute"),20)

  g_cancel_date			= WORD_CHANGE(Request("g_cancel_date"),20)

  If g_date_yuchi="" Or IsNull(g_date_yuchi)=True Then
  else
	  g_date_yuchi		= g_date_yuchi & " " & g_date_yuchi_hour &":"&g_date_yuchi_minute &":00"
  End If


  g_sp_date_start		= WORD_CHANGE(request("g_sp_date_start"),20)	
  g_sp_date_end			= WORD_CHANGE(request("g_sp_date_end"),20)
  g_trans_out_dealer	= WORD_CHANGE(request("g_trans_out_dealer"),20)		'�ΰ�ó
  g_sp_give_type1		= WORD_CHANGE(request("g_sp_give_type"),20)
  g_code_gaetong		= WORD_CHANGE(request("g_code_gaetong"),20)
  g_code_gaetong_idx	= WORD_CHANGE(request("g_code_gaetong"),20)
  g_service_no			= WORD_CHANGE(request("g_service_no"),20)
  date1_chk				= WORD_CHANGE(request("date1_chk"),20)
  date2_chk				= WORD_CHANGE(request("date2_chk"),20)
  date3_chk				= WORD_CHANGE(request("date3_chk"),20)
  date4_chk				= WORD_CHANGE(request("date4_chk"),20)

  g_goods_idx1			= split(g_goods_idx,",")

  for i=0 to ubound(g_goods_idx1)

	If g_code_gaetong="" Or IsNull(g_code_gaetong)=True Then
	Else
	
	'�����ڵ� �α� ����
	strSql = "select g_code_gaetong_idx from customer_goods where g_goods_idx="&Trim(g_goods_idx1(i))
	Set objRs=objCnn.Execute(strSql)

	g_code_gaetong_old		= objRs(0)

	If g_code_gaetong<>g_code_gaetong_old Then
		strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
		strSql = strSql & "values ("&Trim(g_goods_idx1(i))&",'"&session_m_id&"','"&g_code_gaetong&"',getdate())"
		Set objRs=objCnn.Execute(strSql)
	End If
	End if

	strSql = " update customer_goods set "

	If g_date_yuchi="" Or IsNull(g_date_yuchi)=True Then
	else
		strSql = strSql & " g_date_yuchi='"&g_date_yuchi&"',"
	End If


	If date1_chk="Y" Then
		strSql = strSql & " g_date_gaetong=null,"
	Else				
		If g_date_gaetong="" Or IsNull(g_date_gaetong)=True Then
		else
			strSql = strSql & " g_date_gaetong='"&g_date_gaetong&"',"
		End If
	End If

	If g_service_no="" Or IsNull(g_service_no)=True Then
	else
		strSql = strSql & " g_service_no='"&g_service_no&"',"
	End If


	If date2_chk="Y" Then
		strSql = strSql & " g_sp_date_start=null,"
	Else				
		If g_sp_date_start="" Or IsNull(g_sp_date_start)=True Then
		else
			strSql = strSql & " g_sp_date_start='"&g_sp_date_start&"',"
		End If
	End If


	If date3_chk="Y" Then
		strSql = strSql & " g_sp_date_end=null,"
	Else				
		If g_sp_date_end="" Or IsNull(g_sp_date_end)=True Then
		else
			strSql = strSql & " g_sp_date_end='"&g_sp_date_end&"',"
		End If
	End If


	If date4_chk="Y" Then
		strSql = strSql & " g_cancel_date=null,"
	Else				
		If g_cancel_date="" Or IsNull(g_cancel_date)=True Then
		else
			strSql = strSql & " g_cancel_date='"&g_cancel_date&"',"
		End If
	End If

	If g_trans_out_dealer="" Or IsNull(g_trans_out_dealer)=True Then
	else
		strSql = strSql & " g_trans_out_dealer='"&g_trans_out_dealer&"',"
	End if
	
	If g_sp_give_type1="" Or IsNull(g_sp_give_type1)=True Then
	else
		strSql = strSql & " g_sp_give_type='"&g_sp_give_type1&"',"
	End If
	
	If g_code_gaetong="" Or IsNull(g_code_gaetong)=True Then
	else
		strSql = strSql & " g_code_gaetong_idx='"&g_code_gaetong&"',"
	End If

	strSql = Left(strSql,Len(strSql)-1)

	strSql = strSql & " where g_goods_idx="&Trim(g_goods_idx1(i))
	Set objRs=objCnn.Execute(strSql)
	'Response.write strSql &"<br><br>"

	'�ΰ����� ó�� ����.
	g_goods_idx	= Trim(g_goods_idx1(i))

	strSql = "select * from customer_goods where g_goods_idx="&Trim(g_goods_idx1(i))
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
	Else
		g_goods_idx				= objRs("g_goods_idx")
		g_article_idx2			= objRs("g_article_idx2")			'��ǰ��
		g_option_idx			= objRs("g_option_idx")				'�ɼǸ�
		g_trans_out_dealer		= g_trans_out_dealer
		g_code_promise1			= objRs("g_code_promise")			'����
		g_sp_give_type			= objRs("g_sp_give_type")			'����ǰ ����ó	(C:�ΰ�ó����)
		g_sp_price				= money_chk(objRs("g_sp_price"))	'����ǰ �ݾ�
		g_sp_price_top			= money_chk(objRs("g_sp_price_top"))	'����ǰ �ݾ�
		g_code_sale				= objRs("g_code_sale")				'�������ڵ�
		g_set					= objRs("g_set")					'��Ʈ����
		g_article_cnt			= objRs("g_article_cnt")			'ȸ����
		g_code_area				= money_chk(objRs("g_code_area"))	'����

		If g_article_cnt="" Or IsNull(g_article_cnt)=True Or g_article_cnt="0" Then
			g_article_cnt=1
		End if
	%>
	<%
		'------------------ �ΰ� �ڵ����� ���� ----------------
		g_g_goods_idx			= g_goods_idx
		g_g_option_idx			= g_option_idx						'�ɼǸ�
		g_g_trans_out_dealer	= g_trans_out_dealer				'�ΰ�ó �ڵ�
		g_g_code_promise		= g_code_promise1					'����
		g_g_sp_give_type		= g_sp_give_type					'����ǰ ����ó	(C:�ΰ�ó����)
		g_g_sp_price			= g_sp_price						'����ǰ �ݾ�
		g_g_sp_price_top		= g_sp_price_top					'����ǰ �ݾ�
		g_g_code_sale			= g_code_sale						'�������ڵ�
		g_g_set					= g_set								'��Ʈ����
		g_g_article_cnt			= g_article_cnt						'ȸ����1
	%>

	<%
	End if

  Next

  Alert " ���� �������� �ϰ� ó�� �Ǿ����ϴ�."
  %>
  <script language="javascript">
  <!--
	opener.document.location.reload();
    parent.window.close();
	window.close();
  -->
  </script>
