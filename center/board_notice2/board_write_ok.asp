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

  set FSO		= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  tname 			= WORD_CHANGE(UploadForm("tname"),20)
  board_name		= WORD_CHANGE(UploadForm("board_name"),20)
  board_title		= WORD_CHANGE(UploadForm("board_title"),50)
  board_idx			= WORD_CHANGE(UploadForm("board_idx"),20)
  session_m_id		= WORD_CHANGE(UploadForm("session_m_id"),20)
  board_notice_yn	= WORD_CHANGE(UploadForm("board_notice_yn"),20)
  board_contents	= WORD_CHANGE(UploadForm("board_contents"),"E")

  If board_notice_yn="Y" Then
  Else
	board_notice_yn="N"
  End If
  

  sp_code		= Create_code() 

  yea = year(date)
  mon = month(date)
  if Cint(mon) < 10 then  	mon = "0" & mon  end if
  
  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If
  '센터 코드 - 게시판 폴더 생성
  DIR_O_CODE="/file_data/"&o_code&"/"&tname
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 - 날짜 폴더 생성
  DIR_O_CODE="/file_data/"& o_code &"/"&tname&"/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)

  IF fso.FolderExists(DIR_O_CODE)=false then
	  fso.createfolder(DIR_O_CODE)
  end if   


  If board_idx<>"" then
	  strSql = "Select * from "&tname&" where board_idx="&board_idx
	  Set objRs=objCnn.Execute(strSql)

	  board_fname11		= objRs("board_fname1")
  Else
	  board_fname11		= ""
  End if
 
  '파일 업로드 처리
  board_fname1=UploadForm("board_fname1")
   if Len(board_fname1)>0 then  

		If board_fname11<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/"&tname&"/"&board_fname11
			DEL_DIR1 = Server.MapPath(DEL_DIR1) 
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if 
		End If 

    	att_file=UploadForm("board_fname1").filepath 
    	filesize1=UploadForm("board_fname1").FileLen  
    	if filesize1<(1024*1000*10) then       	
    		filename	= mid(att_file, InstrRev(att_file,"\")+1)  
    		strname		= Mid(filename, 1, InstrRev(filename,".")-1)
			strExt		= Mid(filename,InstrRev(filename,".")+1)
    		strExt		= Lcase(strExt)
			strname		= file_StrDelete(strname)		'파일명중 특수문자 삭제

			fnc_strExt_block(strExt)

			bExist=True 
	   		strfilename = strname & "." & strExt 
   			cntFile	    = 0 

   			do while bExist 
      			if (FSO.FileExists(DIR_O_CODE&"/"&strfilename)) then
       				cntfile = cntfile+1
       				strfilename= strname&"_"&cntfile&"."&strExt  
      			else 
       				bExist=false
     			end if
	   		loop

       		filename1		= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
 			UploadForm("board_fname1").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end if
 
  IF len(trim(filename1))>1 THEN
    FILENAME1=CSTR(yea)+cstr(mon)+"/"+filename1
  end if   

  If board_idx<>"" Then	 
	  strSql = " update "&tname&" set "
	  strSql = strSql & " board_name = '"& board_name &"'"
	  strSql = strSql & ", board_title = '"& board_title &"'"
	  strSql = strSql & ", board_contents = '"& board_contents &"'"
	  strSql = strSql & ", board_notice_yn = '"& board_notice_yn &"'"
	  
	  if len(trim(filename1))>1 then
		strSql = strSql & ", board_fname1 = '"& filename1 &"'"
	  end If

	  strSql = strSql & " where board_idx="&board_idx
	  set objRs=objCnn.Execute(strSql)
  Else 
	  strSql = "Select ISNULL(MAX(board_idx)+1,1) from "& tname 
	  set objRs=objCnn.Execute(strSql)
	  board_idx	= objRs(0)
	  
	  strSql = " INSERT INTO "& tname &"(board_idx, o_code, board_notice_yn, board_m_id, board_name, board_title, "
	  strSql = strSql & " board_contents, "
	  strSql = strSql & " board_readnum, board_writeday,board_fname1)"
	  strSql = strSql & " values ("
	  strSql = strSql & "  " & board_idx & " "
	  strSql = strSql & ",'" & o_code & "' "
	  strSql = strSql & ",'" & board_notice_yn & "' "
	  strSql = strSql & ",'" & session_m_id & "' " 
	  strSql = strSql & ",'" & board_name & "' "
	  strSql = strSql & ",'" & board_title & "' "
	  strSql = strSql & ",'" & board_contents & "' "
	  strSql = strSql & ", 0 "
	  strSql = strSql & ",getdate() "
	  strSql = strSql & ",'" & filename1 & "')"
	  set objRs=objCnn.Execute(strSql)
  End if

  objCnn.Close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  set FSO=Nothing

  Alert_url " 글이 저장 되었습니다. ","board_list.asp?tname="&tname  

  %>
