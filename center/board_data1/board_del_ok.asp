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
 
  set FSO=Server.CreateObject("Scripting.FileSystemObject")

  tname			= WORD_CHANGE(request("tname"),20)
  board_idx		= WORD_CHANGE(request("board_idx"),20)

  strSql = "select board_m_id, board_name, board_fname1 from "& tname &" where board_idx = "&board_idx
  set objRs = objCnn.execute(strSql)

  board_fname1	= objRs("board_fname1")
  board_m_id	= objRs("board_m_id")
          

  DEL_DIR1="/file_data/"&o_code &"/"&tname&"/"&board_fname1
  DEL_DIR1 = Server.MapPath(DEL_DIR1)
 
  if fso.FileExists(DEL_DIR1) then 
	fileo=fso.DeleteFile(DEL_DIR1) 
  end if 
    	
  strsql = "delete "&tname&" where board_idx = "&board_idx	
  Set objRs=objCnn.Execute(strSql) 	
    
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  Set FSO = Nothing
  
  Alert_url "글이 삭제 되었습니다.","board_list.asp?tname="&tname
  %>