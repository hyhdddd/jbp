  <%
  '====================================='
  ' 프로젝트 : SENQ OPEN MARKET
  ' 목    적 : OPEN MARKET 형태의 쇼핑몰
  ' 개발일자 : 2008/07/01 ~2008/12/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com (네이트온)
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%  
  set UploadForm=Server.CreateObject("SiteGalaxyUpload.Form")
  set FSO=Server.CreateObject("Scripting.FileSystemObject")
  
  Login_chk(Session_m_id)

  tname		= "txt_file"



  sp_code=Create_code()
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
      	
  '---------------------- 화일 업로드 처리부분 시작 ----------------------'
 
  '파일 업로드 처리
  g_file1=UploadForm("g_file1")
  if Len(g_file1)>0 then  
    	att_file=UploadForm("g_file1").filepath 
    	filesize1=UploadForm("g_file1").size  
    	if filesize1<10000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

			fnc_strExt_block(strExt)

			If strExt<>"txt" And strExt<>"csv" Then
				Alert_back "TXT , scv파일 만 업로드 가능합니다."
				Response.end
			End if
			strfilename = DIR_O_CODE &"/"& sp_code & "_1." & strExt 
			filename1=sp_code&"_1."&strExt
			UploadForm("g_file1").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
  end if
  '---------------------- 화일 업로드 처리부분 시작 ----------------------' 
  objCnn.Close
  Set objCnn = Nothing
  Set objRs = Nothing
  set UploadForm=Nothing
  Set FSO = Nothing
  
  filename		= "/file_data/"& o_code &"/"&tname&"/"&CSTR(yea)&cstr(mon)&"/"&filename1

  Win_link "/customer/a_custom_gaetong_batch03.asp?filename="&filename
  %>