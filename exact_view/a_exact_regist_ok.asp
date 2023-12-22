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

  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  page				= WORD_CHANGE(UploadForm("page"),20)
  e_title 			= WORD_CHANGE(UploadForm("e_title"),100)
  e_contents		= WORD_CHANGE(UploadForm("board_contents"),"E")
  session_m_id		= WORD_CHANGE(UploadForm("session_m_id"),20)
  e_exact_date1		= WORD_CHANGE(UploadForm("e_exact_date1"),20)
  e_exact_date2		= WORD_CHANGE(UploadForm("e_exact_date2"),20)
  e_exact_idx		= WORD_CHANGE(UploadForm("e_exact_idx"),20)
  e_charge_chk		= WORD_CHANGE(UploadForm("e_charge_chk"),20)
  e_dealer_code		= WORD_CHANGE(UploadForm("e_dealer_code"),20)
  tax_chk			= WORD_CHANGE(UploadForm("tax_chk"),20)
  s_date_start		= WORD_CHANGE(UploadForm("s_date_start"),20)
  s_date_end		= WORD_CHANGE(UploadForm("s_date_end"),20)
  date_chk			= WORD_CHANGE(UploadForm("date_chk"),20)
  exact_passwd		= WORD_CHANGE(UploadForm("exact_passwd"),20)

  s_dealer_code		= WORD_CHANGE(UploadForm("s_dealer_code"),20)
  s_gaetong_code	= WORD_CHANGE(UploadForm("s_gaetong_code"),20)
  s_dealer_code		= WORD_CHANGE(UploadForm("s_dealer_code"),20)
  s_charge_chk		= WORD_CHANGE(UploadForm("s_charge_chk"),20)

  tax_price_n		= WORD_CHANGE(money_chk(UploadForm("tax_price_n")),20)
  charge_promise	= WORD_CHANGE(money_chk(UploadForm("charge_promise")),20)
  charge_sp			= WORD_CHANGE(money_chk(UploadForm("charge_sp")),20)
  charge_sale		= WORD_CHANGE(money_chk(UploadForm("charge_sale")),20)
  charge_bundle		= WORD_CHANGE(money_chk(UploadForm("charge_bundle")),20)
  charge_gita		= WORD_CHANGE(money_chk(UploadForm("charge_gita")),20)

  charge_gita1		= WORD_CHANGE(money_chk(UploadForm("charge_gita1")),20)
  charge_gita1_bigo	= WORD_CHANGE(UploadForm("charge_gita1_bigo"),0)

  charge_gongje		= WORD_CHANGE(money_chk(UploadForm("charge_gongje")),20)
  charge_gongje_bigo= WORD_CHANGE(UploadForm("charge_gongje_bigo"),0)

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
  DIR_O_CODE="/file_data/"&o_code&"/exact"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 - 날짜 폴더 생성
  DIR_O_CODE="/file_data/"& o_code &"/exact/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)

  IF fso.FolderExists(DIR_O_CODE)=false then
	  fso.createfolder(DIR_O_CODE)
  end if   

  If e_exact_idx<>"" then
	  strSql = "Select * from exact_list where e_exact_idx="&e_exact_idx
	  Set objRs=objCnn.Execute(strSql)

	  board_fname11		= objRs("e_fname1")
  Else
	  board_fname11		= ""
  End if
 
  '파일 업로드 처리
  e_fname1=UploadForm("e_fname1")
   if Len(e_fname1)>0 then  

		If board_fname11<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/exact/"&board_fname11
			DEL_DIR1 = Server.MapPath(DEL_DIR1) 
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if 
		End If 

    	att_file=UploadForm("e_fname1").filepath 
    	filesize1=UploadForm("e_fname1").FileLen  
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

       		filename1		= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
 			UploadForm("e_fname1").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end if
 
  IF len(trim(filename1))>1 THEN
    FILENAME1=CSTR(yea)+cstr(mon)+"/"+filename1
  end if   



  If e_exact_idx<>"" Then	 
	  strSql = " update exact_list set "
	  strSql = strSql & "  e_title			= '"& e_title &"'"
	  strSql = strSql & ", e_contents		= '"& e_contents &"'"
	  strSql = strSql & ", e_exact_date1	= '"& e_exact_date1 &"'"
	  strSql = strSql & ", e_exact_date2	= '"& e_exact_date2 &"'"
	  strSql = strSql & ", e_charge_chk		= '"& e_charge_chk &"'"
	  strSql = strSql & ", exact_passwd		= '"& exact_passwd &"'"

	  strSql = strSql & ", charge_gita1		= "& charge_gita1 &" "
	  strSql = strSql & ", charge_gita1_bigo = '"& charge_gita1_bigo &"'"

	  strSql = strSql & ", charge_gongje	= "& charge_gongje &" "
	  strSql = strSql & ", charge_gongje_bigo = '"& charge_gongje_bigo &"'"

	  strSql = strSql & ", tax_chk			= '"& tax_chk &"'"
	  
	  if len(trim(filename1))>1 then
		strSql = strSql & ", e_fname1		= '"& filename1 &"'"
	  end if

	  strSql = strSql & " where e_exact_idx	=  "&e_exact_idx
	  set objRs=objCnn.Execute(strSql)
	  'Response.write strsql
  End if

  Alert_url "글이 저장 되었습니다.","a_exact_list.asp?s_dealer_code="&s_dealer_code&"&page="&page&"&s_charge_chk="&s_charge_chk
 
  %>
