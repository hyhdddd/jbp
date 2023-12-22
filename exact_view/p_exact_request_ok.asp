  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->

  <%
  Login_chk(Session_m_id)
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  e_exact_idx 		= WORD_CHANGE(UploadForm("e_exact_idx"),20)
  e_request_txt		= WORD_CHANGE(UploadForm("e_request_txt"),0)
  e_charge_chk		= WORD_CHANGE(UploadForm("e_charge_chk"),20)

  strSql = " update exact_list set "
  strSql = strSql & "  e_charge_chk = '"&e_charge_chk&"'"
  strSql = strSql & ", e_request_txt = '"&e_request_txt&"'"
  strSql = strSql & ", e_charge_chk_date = getdate()"  
  strSql = strSql & " where e_exact_idx="&e_exact_idx
  set objRs=objCnn.Execute(strSql)

  Alert_url " 정산 요청 하였습니다. ","y_exact_list.asp"
  %>