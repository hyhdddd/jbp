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

  policy_idx		= WORD_CHANGE(UploadForm("policy_idx"),10)
  policy_title		= WORD_CHANGE(UploadForm("policy_title"),50)
  policy_passwd		= WORD_CHANGE(UploadForm("policy_passwd"),20)


  yea = year(date)
  mon = month(date)
  if Cint(mon) < 10 then  	mon = "0" & mon  end If
  
  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 게시판 폴더 생성
  DIR_O_CODE="/file_data/"&o_code&"/policy"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 - 날짜 폴더 생성
  DIR_O_CODE="/file_data/"& o_code &"/policy/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)

  IF fso.FolderExists(DIR_O_CODE)=false then
	  fso.createfolder(DIR_O_CODE)
  end if   


  '파일 업로드 처리
  board_fname1=UploadForm("policy_file1")
   if Len(board_fname1)>0 then  
    	att_file=UploadForm("policy_file1").filepath 
    	filesize1=UploadForm("policy_file1").FileLen 
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
 			UploadForm("policy_file1").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end if
 
  IF len(trim(filename1))>1 THEN
    FILENAME1=CSTR(yea)+cstr(mon)+"/"+filename1
  end if   
  

  strSql = " update policy_list set policy_passwd='"&policy_passwd&"', policy_title='"&policy_title&"' "

  if len(trim(filename1))>1 then
	strSql = strSql & ", policy_file1 = '"& filename1 &"'"
  end If
	  
  strSql = strSql & " where policy_idx="&policy_idx
  Set objRs=objCnn.Execute(strSql)

    
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  
  Alert_url "정책표를 수정 했습니다.","/policy/a_policy_list.asp"
  %>