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

  if ad_b_g_custom="N" then
	Alert_URL session_m_name &" ���� ����ǰ ���������� �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/main.asp"
	Response.end
  End If
  
  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE


  page					= WORD_CHANGE(UploadForm("page"),20)									'������
  nowblock				= WORD_CHANGE(UploadForm("nowblock"),20)								'��
  s_link_txt			= WORD_CHANGE(UploadForm("s_link_txt"),0)								'�˻���
  g_goods_idx			= WORD_CHANGE(UploadForm("g_goods_idx"),20)								'�� ��ǰ ����
  g_service_no			= WORD_CHANGE(UploadForm("g_service_no"),40)							'���Լ��񽺹�ȣ
  g_date_gaetong		= WORD_CHANGE(date_null_chk(UploadForm("g_date_gaetong")),20)			'������
  g_code_gaetong_idx	= WORD_CHANGE(UploadForm("g_code_gaetong_idx"),20)						'�� ��ǰ �������

  '�����ڵ� �α� ����
  strSql = "select g_code_gaetong_idx from customer_goods where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  g_code_gaetong_old		= objRs(0)

  If g_code_gaetong_idx<>g_code_gaetong_old Then
	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&session_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)
  End If

  strSql = " update customer_goods set "
  strSql = strSql & "  g_o_code			= '"&o_code &"'"  
  strSql = strSql & ", g_service_no		= '"& g_service_no &"'"		
  strSql = strSql & ", g_code_gaetong_idx = '"& g_code_gaetong_idx &"' "	

  If g_date_gaetong="null" then
	strSql = strSql & ", g_date_gaetong= "& g_date_gaetong &" "		
  Else
	strSql = strSql & ", g_date_gaetong= '"& g_date_gaetong &"' "		
  End If		
	
  strSql = strSql & "  where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  objCnn.Close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  set FSO=Nothing
  
  Alert_url " �� ��ǰ�� ��ϵǾ����ϴ�.","g_custom_goods_list.asp?g_goods_idx="&g_goods_idx&"&page="&page&"&nowblock="&nowblock&"&"&s_link_txt
  %>