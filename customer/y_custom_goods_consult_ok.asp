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

  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  page					= WORD_CHANGE(UploadForm("page"),20)						'������
  nowblock				= WORD_CHANGE(UploadForm("nowblock"),20)					'��
  s_link_txt			= WORD_CHANGE(UploadForm("s_link_txt"),0)
  g_goods_idx			= WORD_CHANGE(UploadForm("g_goods_idx"),20)					'�� ��ǰ ����

  consult_bigo			= WORD_CHANGE(UploadForm("consult_bigo"),0)					'���
  consult_type			= WORD_CHANGE(UploadForm("consult_type"),20)				'D:���޸� / E:����� / A:ȸ�ſ�û / B:ȸ�Ŵ亯 / C:ȸ�ſϷ�
  consult_date			= WORD_CHANGE(UploadForm("consult_date"),20)
  consult_date_hour		= WORD_CHANGE(UploadForm("consult_date_hour"),20)  
  consult_date_minute	= WORD_CHANGE(UploadForm("consult_date_minute"),20)  
  consult_date_view		= WORD_CHANGE(UploadForm("consult_date_view"),20)  

  if consult_date="" Then
	consult_date=""
  else
  	consult_date1 = consult_date_hour&":"&consult_date_minute
  	consult_date  = consult_date &" "&consult_date1
  end if  

  If consult_date_view="Y" Then
  Else
	consult_date_view="N"
  End If

  
  strSql = "select ISNULL(MAX(consult_idx)+1,1) from customer_goods_consult"
  Set objRs=objCnn.Execute(strSql)

  consult_idx=objRs(0) 

  strSql = "INSERT INTO customer_goods_consult(consult_idx, o_code, consult_m_id, g_goods_idx,"	
  strSql = strSql & "consult_type, consult_bigo, consult_date_view, "

  If consult_date<>"" then
	strSql = strSql & " consult_date,  "
  End If

  strSql = strSql & " consult_writeday) VALUES " 
  strSql = strSql & "("
  strSql = strSql & "  "& consult_idx &"  "
  strSql = strSql & ", '"& o_code &"'"
  strSql = strSql & ", '"& session_m_id &"'"
  strSql = strSql & ", "& g_goods_idx &" "
  strSql = strSql & ", '"& consult_type &"'"  		
  strSql = strSql & ", '"& consult_bigo &"'"
  strSql = strSql & ", '"& consult_date_view &"'"

  If consult_date<>"" then
	strSql = strSql & " ,'"& consult_date&"'"
  End If
  
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql)  


  '���̷�
  If consult_type="A" Then			'���޸�
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	  set objRs=objCnn.Execute(strSql)
  elseIf consult_type="B" Then		'ȸ�ſ�û
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & ", receipt_order_p	= 1"
	  strSql = strSql & ", receipt_order_a	= null"
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	  set objRs=objCnn.Execute(strSql)
  ElseIf consult_type="C" then		'ȸ�Ŵ亯
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & ", receipt_order_p	= null"
	  strSql = strSql & ", receipt_order_a	= 1"
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	  set objRs=objCnn.Execute(strSql)
  elseIf consult_type="D" Then		'ȸ�ſϷ�
	  strSql = " update customer_goods set "
	  strSql = strSql & " g_receipt_type='"&consult_type&"' "
	  strSql = strSql & ", receipt_order_a	= null"
	  strSql = strSql & ", receipt_order_p	= null"
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "  
	  set objRs=objCnn.Execute(strSql)
  ElseIf consult_type="E" Then		'��û����(����)
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	  set objRs=objCnn.Execute(strSql)
  ElseIf consult_type="F" Then		'ó������(����)
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "
	  set objRs=objCnn.Execute(strSql)
  ElseIf consult_type="G" Then		'�����޸�
  ElseIf consult_type="H" Then		'�ΰ�޸�
  elseIf consult_type="I" Then		'��ο�û
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & ", receipt_order_a	= 2"
	  strSql = strSql & ", receipt_order_p	= null"
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "  
	  set objRs=objCnn.Execute(strSql)
  elseIf consult_type="J" Then		'��δ亯
	  strSql = " update customer_goods set "
	  strSql = strSql & "  g_receipt_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_type	= '"&consult_type&"' "
	  strSql = strSql & ", g_consult_bigo	= '"&consult_bigo&"' "
	  strSql = strSql & ", receipt_order_a	= null"
	  strSql = strSql & ", receipt_order_p	= null"
	  strSql = strSql & "	where g_goods_idx	= "&g_goods_idx&" "  
	  set objRs=objCnn.Execute(strSql)
  End If
  
  objCnn.Close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  
  Alert_url " �� ��ǰ�� ��ϵǾ����ϴ�.","y_custom_goods_regist.asp?g_goods_idx="&g_goods_idx&"&page="&page&"&nowblock="&nowblock&"&s_link_txt="&Server.URLEncode(s_link_txt)
  %>