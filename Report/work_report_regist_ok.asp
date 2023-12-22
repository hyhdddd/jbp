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

  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE


  w_work_date		= WORD_CHANGE(UploadForm("w_work_date"),20)
  w_board_idx	 	= WORD_CHANGE(UploadForm("w_board_idx"),10)
  w_work_today		= WORD_CHANGE(UploadForm("w_work_today"),20)
  w_work_tomorrow	= UploadForm("w_work_tomorrow")
  w_work_request	= UploadForm("w_work_request")
  w_work_date		= UploadForm("w_work_date")  
  w_work_today		= CheckWord(w_work_today) 
  w_work_tomorrow	= CheckWord(w_work_tomorrow)  
  w_work_UploadForm	= CheckWord(w_work_UploadForm)
 
 
  yea = year(date)
  mon = month(date)
  if Cint(mon) < 10 then  	mon = "0" & mon  end If
  
  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If
  '센터 코드 - 업무일지 폴더 생성
  DIR_O_CODE="/file_data/"&o_code&"/emp_work_report"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 업무일지 - 날짜 폴더 생성
  DIR_O_CODE="/file_data/"& o_code &"/emp_work_report/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)

  IF fso.FolderExists(DIR_O_CODE)=false then
	  fso.createfolder(DIR_O_CODE)
  end if   
 
 
  If w_board_idx<>"" then
	  strSql = "Select w_board_fname1 from emp_work_report where w_board_idx="&w_board_idx
	  Set objRs=objCnn.Execute(strSql)

	  w_board_fname11		= objRs("w_board_fname1")
  Else
	  w_board_fname11		= ""
  End If
  
  '파일 업로드 처리
  w_board_fname1=UploadForm("w_board_fname1")
   if Len(w_board_fname1)>0 then  

		If w_board_fname11<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/emp_work_report/"&w_board_fname11
			DEL_DIR1 = Server.MapPath(DEL_DIR1) 
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if 
		End If 

    	att_file=UploadForm("w_board_fname1").filepath 
    	filesize1=UploadForm("w_board_fname1").FileLen
    	if filesize1<(1024*1000*10) then       	
    		filename1	= mid(att_file, InstrRev(att_file,"\")+1)  
    		strname		= Mid(filename1, 1, InstrRev(filename1,".")-1)
			strExt		= Mid(filename1,InstrRev(filename1,".")+1)
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

       		w_board_fname1	= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
 			UploadForm("w_board_fname1").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end if
 
  IF len(trim(w_board_fname1))>1 THEN
    w_board_fname1=CSTR(yea)+cstr(mon)+"/"+w_board_fname1
  end if   


  if w_board_idx="" Then
	strSql = "Select ISNULL(MAX(w_board_idx)+1,1) from emp_work_report "
	set objRs=objCnn.Execute(strSql)
	w_board_idx	= objRs(0)

  	strSql = " INSERT INTO emp_work_report (w_board_idx, w_o_code, w_m_id, w_work_date,w_work_today, w_work_tomorrow, "
	strSql = strSql & " w_work_request, w_board_fname1, w_writeday, w_decision1_yn, w_decision2_yn, w_decision3_yn)"  
	strSql = strSql & " values ("  
	strSql = strSql & "  " & w_board_idx & " "  
	strSql = strSql & ",'" & o_code & "' "  
	strSql = strSql & ",'" & session_m_id & "' "  
	strSql = strSql & ", '" & w_work_date & "' "   
	strSql = strSql & ",'" & w_work_today & "'"   
	strSql = strSql & ",'" & w_work_tomorrow & "'"
	strSql = strSql & ",'" & w_work_request & "'" 
	strSql = strSql & ",'" & w_board_fname1 & "'" 
	strSql = strSql & ",getdate(),'N','N','N')"  
	'Response.write strSql
	set objRs=objCnn.Execute(strSql)
  else        
	If w_board_fname1<>"" Then
		strsql_txt = " w_board_fname1 ='"&w_board_fname1&"',"
	End if


 	strSql = " update emp_work_report set " 
	strSql = strSql & " w_work_date			= '"& w_work_date & "'," 
	strSql = strSql & " w_work_today		= '"& w_work_today & "'," 
	strSql = strSql & " w_work_tomorrow		= '" & w_work_tomorrow & "'," 
	strSql = strSql & " w_work_request		= '"& w_work_request & "', " 
	strSql = strSql & strsql_txt
  	strSql = strSql & " w_writeday			= getdate() " 
	strSql = strSql &  " where w_board_idx	= "& w_board_idx
	'Response.write strSql
	set objRs=objCnn.Execute(strSql)
  end If
   
  objCnn.close
  Set objRs = Nothing
  Set objCnn = Nothing
  Set UploadForm = Nothing
  Set FSO = Nothing

  Alert_url " 업무일지가 저장 되었습니다.","work_report_list.asp?page="& page

  %>
