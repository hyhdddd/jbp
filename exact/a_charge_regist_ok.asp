  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	 

  page					= WORD_CHANGE(Request("page"),20)										'������
  nowblock				= WORD_CHANGE(Request("nowblock"),20)									'��
  s_link_txt			= WORD_CHANGE(Request("s_link_txt"),0)									'�˻���

  g_charge_idx			= WORD_CHANGE(Request("g_charge_idx"),20)
  g_goods_idx			= WORD_CHANGE(Request("g_goods_idx"),20)
  g_charge_promise		= WORD_CHANGE(money_chk(Request("g_charge_promise")),20)				'����ݾ�
  g_charge_sp_top		= WORD_CHANGE(money_chk(Request("g_charge_sp_top")),20)					'�������ǰ
  g_charge_sp			= WORD_CHANGE(money_chk(Request("g_charge_sp")),20)						'����ǰ
  g_charge_sale			= WORD_CHANGE(money_chk(Request("g_charge_sale")),20)					'������
  g_charge_document		= WORD_CHANGE(money_chk(Request("g_charge_document")),20)				'�̺񼭷�
  g_charge_gita			= WORD_CHANGE(money_chk(Request("g_charge_gita")),20)					'��Ÿ
  g_charge_bundle		= WORD_CHANGE(money_chk(Request("g_charge_bundle")),20)	
  g_charge_buga			= WORD_CHANGE(money_chk(Request("g_charge_buga")),20)		
  g_charge_combine		= WORD_CHANGE(money_chk(Request("g_charge_combine")),20)		

  g_charge_date1		= WORD_CHANGE(date_null_chk(Request("g_charge_date1")),20)				'���� ������
  g_charge_date2		= WORD_CHANGE(date_null_chk(Request("g_charge_date2")),20)				'���� �Ϸ���
  g_charge_bigo			= WORD_CHANGE(Request("g_charge_bigo"),0)								'���� ���
  g_charge_type			= WORD_CHANGE(Request("g_charge_type"),20)
  g_charge_bigo_doc		= WORD_CHANGE(Request("g_charge_bigo_doc"),200)							'���� ���

  if g_charge_idx="" then	
	strSql = " INSERT INTO customer_goods_charge (g_charge_type,o_code, g_goods_idx, g_charge_promise, "
	strSql = strSql &" g_charge_sp_top, g_charge_sp, g_charge_sale, g_charge_document, g_charge_gita, g_charge_bundle, g_charge_buga, g_charge_combine, "
	strSql = strSql &" g_charge_date1, g_charge_date2, g_charge_bigo, g_charge_bigo_doc, g_charge_writeday) values ("
	strSql = strSql &"  '"& g_charge_type &"' "
	strSql = strSql &", '"& o_code &"' "
	strSql = strSql &",  "& g_goods_idx &" "
	strSql = strSql &",  "& g_charge_promise &"  "
	strSql = strSql &",  "& g_charge_sp_top &"  "
	strSql = strSql &",  "& g_charge_sp &"  "
	strSql = strSql &",  "& g_charge_sale &"  "
	strSql = strSql &",  "& g_charge_document &"  "
	strSql = strSql &",  "& g_charge_gita &"  "
	strSql = strSql &",  "& g_charge_bundle &"  "
	strSql = strSql &",  "& g_charge_buga &"  "
	strSql = strSql &",  "& g_charge_combine &"  "

	If g_charge_date1="null" then
	strSql = strSql &",  "& g_charge_date1 &"  "	
	else
	strSql = strSql &", '"& g_charge_date1 &"' "	
	End If

	If g_charge_date2="null" then
	strSql = strSql &",  "& g_charge_date2 &"  "	
	else
	strSql = strSql &", '"& g_charge_date2 &"' "	
	End If

	strSql = strSql &", '"& g_charge_bigo &"' "
	strSql = strSql &", '"& g_charge_bigo_doc &"' "
	strSql = strSql &", Getdate()) "	

	Set objRs=objCnn.Execute(strSql)

  Else
	strSql = " update customer_goods_charge set "
	strSql = strSql &"  g_charge_promise		= "& g_charge_promise &" "  
	strSql = strSql &", g_charge_sp_top			= "& g_charge_sp_top &" "  
	strSql = strSql &", g_charge_sp				= "& g_charge_sp &" "  
	strSql = strSql &", g_charge_sale			= "& g_charge_sale &" "  
	strSql = strSql &", g_charge_gita			= "& g_charge_gita &" "  
	strSql = strSql &", g_charge_bundle			= "& g_charge_bundle &" "  
	strSql = strSql &", g_charge_buga			= "& g_charge_buga &" "  
	strSql = strSql &", g_charge_combine		= "& g_charge_combine &"  "

	If g_charge_date1="null" then
	strSql = strSql &", g_charge_date1			=  "& g_charge_date1 &"  "
	else
	strSql = strSql &", g_charge_date1			= '"& g_charge_date1 &"' "
	End If

	If g_charge_date2="null" then
	strSql = strSql &", g_charge_date2			=  "& g_charge_date2 &" "		
	Else
	strSql = strSql &", g_charge_date2			= '"& g_charge_date2 &"' "		
	End If

	strSql = strSql &", g_charge_bigo			= '"& g_charge_bigo &"' "
	strSql = strSql &", g_charge_type			= '"& g_charge_type &"' "
	
	'�߰������� ���
	If g_charge_type<>"G" Then
	strSql = strSql &", g_charge_document		=  "& g_charge_document &" "
	strSql = strSql &", g_charge_bigo_doc		= '"& g_charge_bigo_doc &"' "
	End If
	
	strSql = strSql &"  where g_charge_idx		=  "&g_charge_idx
	Set objRs=objCnn.Execute(strSql)
  End If

  Alert_url "������ ���/���� �Ǿ����ϴ�.","a_charge_list.asp?g_goods_idx="&g_goods_idx
  DBClose()
  %>