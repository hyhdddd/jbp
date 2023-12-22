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
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE


  subject 			= WORD_CHANGE(UploadForm("subject"),50)
  contents 			= WORD_CHANGE(UploadForm("board_contents"),"E")
  select_name_hid	= WORD_CHANGE(UploadForm("select_name_hid"),0)
  
  If Len(select_name_hid)<>0 then
	  select_name_hid=left(select_name_hid,len(select_name_hid)-1)
  Else
		Alert_back " 받는 사람을 선택하세요"
		response.end
  End if
  
  arrStrCut = split(select_name_hid,"_")
  maxArr    = ubound(arrStrCut )

  yea = year(date)
  mon = month(date)
    
  if len(mon)=1 then  
	mon="0"&mon 
  end if


  UP_FILE_DIR0="/file_data/"& o_code &"/MAIL"						' 폴더 생성 경로  
  UP_FILE_DIR = Server.MapPath(UP_FILE_DIR0) 
 
  IF fso.FolderExists(UP_FILE_DIR)=false then
	  fso.createfolder(UP_FILE_DIR)
  end if   

  UP_FILE_DIR0="/file_data/"& o_code &"/MAIL/"&CSTR(yea)&cstr(mon)		' 폴더 생성 경로  
  UP_FILE_DIR = Server.MapPath(UP_FILE_DIR0) 

 
  IF fso.FolderExists(UP_FILE_DIR)=false then
	  fso.createfolder(UP_FILE_DIR)
  end if   
  
      	
  '==================화일 업로드 처리부분 시작 ================='
  file1=UploadForm("file1")

   if Len(file1)>0 then  
    	att_file=UploadForm("file1").filepath 
    	filesize1=UploadForm("file1").FileLen  
    	if filesize1<5000000 then   
    	
    		filename1=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename1, 1, InstrRev(filename1,".")-1)
    		strExt=Mid(filename1,InstrRev(filename1,".")+1)
    		strExt=Lcase(strExt)

			fnc_strExt_block(strExt)

			strname		= file_StrDelete(strname)

			bExist=True 
	   		strfilename = strname & "." & strExt 
   			cntFile	    = 0 

   			do while bExist 
      			if (FSO.FileExists(UP_FILE_DIR&"/"&strfilename)) then
       				cntfile = cntfile+1
       				strfilename= strname&"_"&cntfile&"."&strExt  
      			else 
       				bExist=false
     			end if
	   		loop

       		db_filename1="/"&CSTR(yea)&cstr(mon)&"/"&strfilename
			strfilename=UP_FILE_DIR &"/"& strfilename

			UploadForm("file1").SaveAs strfilename    			

		Else
			Alert_back "화일 용량이 5M을 초과할수 없습니다."
		end if   	
   end if
  '==================화일 업로드 처리부분 끝 ==================='     
  
  strSql = "SELECT ISNULL(MAX(board_idx)+1,1) FROM mail_message"
  set objRs=objCnn.Execute(strSql)
  
  message_idx=objRs(0)     
    
  strSql = "INSERT INTO mail_message (board_idx, o_code, send_m_id, subject, contents, file1, message_del, writeday)  "
  strSql = strSql & "VALUES ( "  
  strSql = strSql & message_idx 	& " ,'"
  strSql = strSql & o_code 	& "','"
  strSql = strSql & session_m_id 	& "','"
  strSql = strSql & subject     & "','"
  strSql = strSql & contents    & "','"
  strSql = strSql & db_filename1& "','"
  strSql = strSql & "X',getdate())"
  'response.write strSql
  set objRs=objCnn.Execute(strSql)
  
  for i=0 to maxArr
   
   strSql = "SELECT ISNULL(MAX(board_idx)+1,1) FROM mail_list"
   set objRs=objCnn.Execute(strSql)
  
    mail_idx=objRs(0)     

  	to_name 		= arrStrCut(i)
  	receipt_status  = "X"
  	message_del		= "X"
  	
  	strSql = " INSERT INTO mail_list (board_idx, o_code, message_idx, to_m_id,receipt_status,"
  	strSql = strSql & " message_del) VALUES "
  	strSql = strSql & "( "  
  	strSql = strSql & mail_idx  	& " ,'"
  	strSql = strSql & o_code	  	& "','"
  	strSql = strSql & message_idx  	& "','"
  	strSql = strSql & to_name    	& "','"
  	strSql = strSql & receipt_status& "','"
  	strSql = strSql & message_del   & "')"
	'response.write strSql
	set objRs=objCnn.Execute(strSql)
	
  next

 
  objCnn.close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  
  Alert_url "메일을 정상적으로 발송하였습니다.","mail_to_list.asp"
  %>