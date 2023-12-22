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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)

  set FSO=Server.CreateObject("Scripting.FileSystemObject")

  if ad_b_a_custom="A" Then
  else
 	Alert_URL session_m_name&" 님은 삭제권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
	Response.end
  end if	 

  g_goods_idx			= WORD_CHANGE(request("g_goods_idx"),20)
  file_chk				= WORD_CHANGE(request("file_chk"),20)
  
  strSql = " select * from customer_goods where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  g_file1 = objRs("g_file1")
  g_file2 = objRs("g_file2")
  g_file3 = objRs("g_file3")
  g_file4 = objRs("g_file4")
  
  If file_chk="g_file1" Then
	DEL_DIR1="/file_data/"&o_code &"/customer/"&g_file1
  ElseIf file_chk="g_file2" Then
	DEL_DIR1="/file_data/"&o_code &"/customer/"&g_file2
  ElseIf file_chk="g_file3" Then
	DEL_DIR1="/file_data/"&o_code &"/customer/"&g_file3
  ElseIf file_chk="g_file4" Then
	DEL_DIR1="/file_data/"&o_code &"/customer/"&g_file4
  End if

  DEL_DIR1 = Server.MapPath(DEL_DIR1)
 
  if fso.FileExists(DEL_DIR1) then 
	fileo=fso.DeleteFile(DEL_DIR1) 
  end if 

  strSql = " update customer_goods set "&file_chk&"='' where g_goods_idx="&g_goods_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 첨부파일을 삭제 되었습니다.","a_custom_goods_regist.asp?g_goods_idx="&g_goods_idx
  %>