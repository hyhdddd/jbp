   <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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

  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  p_idx 			= WORD_CHANGE(UploadForm("p_idx"),20)
  p_title			= WORD_CHANGE(UploadForm("p_title"),50)
  p_contents		= WORD_CHANGE(UploadForm("board_contents"),"E")
  p_width 			= WORD_CHANGE(money_chk(UploadForm("p_width")),20)
  p_height 			= WORD_CHANGE(money_chk(UploadForm("p_height")),20)
  p_view 			= WORD_CHANGE(UploadForm("p_view"),20)
  p_top 			= WORD_CHANGE(money_chk(UploadForm("p_top")),20)
  p_left 			= WORD_CHANGE(money_chk(UploadForm("p_left")),20)

  If p_idx<>"" Then	 
	  strSql = " update popup set "
	  strSql = strSql & "  p_title = '"& p_title &"'"
	  strSql = strSql & ", p_contents = '"& p_contents &"'"
	  strSql = strSql & ", p_view = '"& p_view &"'"
	  strSql = strSql & ", p_height = "& p_height &" "
	  strSql = strSql & ", p_width = "& p_width &" "
	  strSql = strSql & ", p_top = "& p_top &" "
	  strSql = strSql & ", p_left = "& p_left &" "
	  strSql = strSql & " where p_idx="&p_idx
	  'Response.write strsql
	  set objRs=objCnn.Execute(strSql)
	  Alert_url " 글이 수정 되었습니다. ","popup_list.asp"
  Else 
	  strSql = "Select ISNULL(MAX(p_idx)+1,1) from popup"
	  set objRs=objCnn.Execute(strSql)
	  p_idx	= objRs(0)
	  
	  strSql = " INSERT INTO popup (p_idx, p_o_code, p_m_id, p_title, p_contents, p_width, p_height, p_top, p_left, p_view, "
	  strSql = strSql & " p_writeday)"
	  strSql = strSql & " values ("
	  strSql = strSql & "  " & p_idx & " "
	  strSql = strSql & ",'" & o_code & "' "
	  strSql = strSql & ",'" & session_m_id & "' "
	  strSql = strSql & ",'" & p_title & "' "
	  strSql = strSql & ",'" & p_contents & "' "
	  strSql = strSql & ", " & p_width & " "
	  strSql = strSql & ", " & p_height & " "
	  strSql = strSql & ", " & p_top & " "
	  strSql = strSql & ", " & p_left & " "
	  strSql = strSql & ",'" & p_view & "' "
	  strSql = strSql & ",getdate())"
	  'Response.write strSql
	  set objRs=objCnn.Execute(strSql)
	Alert_url " 글이 등록 되었습니다. ","popup_list.asp"
  End if

  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  
  %>
