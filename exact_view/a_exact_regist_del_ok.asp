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
 
  set FSO=Server.CreateObject("Scripting.FileSystemObject")

  e_exact_idx		= WORD_CHANGE(request("e_exact_idx"),20)
  page				= Request("page")

  strSql = "select e_fname1,e_fname2_excel from exact_list where e_exact_idx = "&e_exact_idx
  set objRs = objCnn.execute(strSql)

  e_fname1		= objRs("e_fname1")
  e_fname2		= objRs("e_fname2_excel")

  If e_fname1<>"" Then
	DEL_DIR1="/file_data/"&o_code &"/exact/"&e_fname1
	DEL_DIR1 = Server.MapPath(DEL_DIR1) 
	if fso.FileExists(DEL_DIR1) then 
		fileo=fso.DeleteFile(DEL_DIR1) 
	end if 
  End If 

  If e_fname2<>"" Then
	DEL_DIR1="/file_data/"&o_code &"/exact/"&e_fname2
	DEL_DIR1 = Server.MapPath(DEL_DIR1) 
	if fso.FileExists(DEL_DIR1) then 
		fileo=fso.DeleteFile(DEL_DIR1) 
	end if 
  End If 
		
  strsql = "delete exact_list where e_exact_idx = "&e_exact_idx	
  Set objRs=objCnn.Execute(strSql) 	
    
  Alert_url "글이 삭제 되었습니다.","a_exact_list.asp?page="&page
  %>