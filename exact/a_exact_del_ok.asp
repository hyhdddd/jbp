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
  <%
  If session_m_step<>"M" Then
	Alert_back session_m_name&" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���! "
	Response.end
  End If 


  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm		= Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  g_goods_idx		= WORD_CHANGE(UploadForm("g_goods_idx"),10)
  page				= WORD_CHANGE(UploadForm("page"),20)
  nowblock			= WORD_CHANGE(UploadForm("nowblock"),20)
  s_link_txt		= WORD_CHANGE(UploadForm("s_link_txt"),0)

  ip_addr			= Request.ServerVariables("REMOTE_HOST")

  If InStr(g_goods_idx,"=")>0 Or InStr(g_goods_idx," ")>0 Or InStr(UCase(g_goods_idx),"OR")>0 Then
	Alert_back "�߸��� ���� �Դϴ�."
	Response.end
  End if  


  strSql = " delete customer_goods where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  strSql = " delete customer_goods_consult where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  strSql = " delete customer_goods_charge where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  strSql = " delete customer_goods_charge_g where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  strSql = " delete customer_gaetong_log where  g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " ����ǰ������ �����Ǿ����ϴ�.","a_exact_list.asp?page="&page&"&nowblock="&nowblock&"&"&s_link_txt
  %>