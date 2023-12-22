 <%
  '====================================='
  ' 프로젝트 : SENQ PROJECT
  ' 목    적 : HTTP://OSS.SENQ.CO.KR
  ' 개발일자 : 2007/08/15 ~2008/08/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)
 
  if ad_i_a_company="N" then
	Alert_url session_m_name &" 님은 거래처등록 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end If

  
  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  dealer_idx			= WORD_CHANGE(UploadForm("dealer_idx"),10)
  page					= WORD_CHANGE(UploadForm("page"),20)
  
  dealer_name			= WORD_CHANGE(UploadForm("dealer_name"),50)
  dealer_com_yn			= WORD_CHANGE(UploadForm("dealer_com_yn"),20)
  dealer_com_no			= WORD_CHANGE(UploadForm("dealer_com_no"),30)  
  dealer_bank_name		= WORD_CHANGE(UploadForm("dealer_bank_name"),30)		' 은행 예금주
  dealer_bank_cd		= WORD_CHANGE(UploadForm("dealer_bank_cd"),20)			' 은행 코드
  dealer_bank_no		= WORD_CHANGE(UploadForm("dealer_bank_no"),40)			' 은행 계좌번호
  dealer_zipcode1		= WORD_CHANGE(UploadForm("dealer_zipcode1"),20)		' 회사 우편번호1
  dealer_address		= WORD_CHANGE(UploadForm("dealer_address"),200)			' 회사 주소
  dealer_com_jumin		= WORD_CHANGE(UploadForm("dealer_com_jumin"),20)
  dealer_email			= WORD_CHANGE(UploadForm("dealer_email"),70)
  dealer_tel1			= WORD_CHANGE(UploadForm("dealer_tel1"),20)
  dealer_tel2			= WORD_CHANGE(UploadForm("dealer_tel2"),20)
  dealer_insu			= WORD_CHANGE(UploadForm("dealer_insu"),20)				'인수 / 인계
  dealer_ingea			= WORD_CHANGE(UploadForm("dealer_ingea"),20)			'인수 / 인계
  dealer_service1		= WORD_CHANGE(UploadForm("dealer_service1"),40)
  dealer_service2		= WORD_CHANGE(UploadForm("dealer_service2"),40)
  dealer_group_code		= WORD_CHANGE(UploadForm("dealer_group_code"),20)		'딜러 정산그룹
  dealer_view			= WORD_CHANGE(UploadForm("dealer_view"),20)
  dealer_bigo			= WORD_CHANGE(UploadForm("dealer_bigo"),0)
  dealer_ingea_url		= WORD_CHANGE(UploadForm("dealer_ingea_url"),40)
  dealer_ingea_id		= WORD_CHANGE(Trim(UploadForm("dealer_ingea_id")),20)
  dealer_ingea_passwd	= WORD_CHANGE(Trim(UploadForm("dealer_ingea_passwd")),20)

  If dealer_name=""  Then
    Alert_back "잘못된 접근입니다."
	Response.end
  End If

  If dealer_insu="" Or IsNull(dealer_insu) Then
	dealer_insu="N"
  End if

  If dealer_ingea="" Or IsNull(dealer_ingea) Then
	dealer_ingea="N"
  End if



   
  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 거래처 정보 폴더 생성
  DIR_O_CODE="/file_data/"&o_code&"/partner_info"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If


  '파일 업로드 처리
  dealer_file1			= UploadForm("dealer_file1")


  If dealer_idx<>"" then
	  strSql = "Select * from dealer_info where dealer_idx="&dealer_idx
	  Set objRs=objCnn.Execute(strSql)

	  dealer_file11		= objRs("dealer_file1")
	  dealer_file22		= objRs("dealer_file2")
  Else
	  dealer_file11		= ""
	  dealer_file22		= ""
  End If

 
   if Len(dealer_file1)>0 then  

		If dealer_file11<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/partner_info/"&dealer_file11
			DEL_DIR1 = Server.MapPath(DEL_DIR1) 
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if 
		End If 

    	att_file=UploadForm("dealer_file1").filepath 
    	filesize1=UploadForm("dealer_file1").FileLen 
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
 			UploadForm("dealer_file1").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end If
   
   dealer_file2=UploadForm("dealer_file2")
   if Len(dealer_file2)>0 then  

		If dealer_file2<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/partner_info/"&dealer_file22
			DEL_DIR1 = Server.MapPath(DEL_DIR1) 
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if 
		End If 

    	att_file=UploadForm("dealer_file2").filepath 
    	filesize2=UploadForm("dealer_file2").FileLen  
    	if filesize2<(1024*1000*10) then       	
    		filename2	= mid(att_file, InstrRev(att_file,"\")+1)  
    		strname		= Mid(filename2, 1, InstrRev(filename2,".")-1)
			strExt		= Mid(filename2,InstrRev(filename2,".")+1)
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

       		filename2		= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
 			UploadForm("dealer_file2").SaveAs strfilename 
	   	else
			Alert_back "화일 용량이 10M을 초과할수 없습니다."
		end if   	
   end if
 
  if dealer_idx<>"" then  
	strSql = " update dealer_info set "
	strSql = strSql & "  dealer_name = '"& dealer_name &"'"
	strSql = strSql & ", dealer_com_yn	= '" &dealer_com_yn &"'"
	strSql = strSql & ", dealer_com_no = '"& dealer_com_no &"'"
	strSql = strSql & ", dealer_bank_name = '"& dealer_bank_name &"'"
	strSql = strSql & ", dealer_bank_cd = "& dealer_bank_cd &" "
	strSql = strSql & ", dealer_bank_no = '"& dealer_bank_no &"'"
	strSql = strSql & ", dealer_zipcode1 = '"& dealer_zipcode1 &"'"
	strSql = strSql & ", dealer_address = '"& dealer_address &"'"
	strSql = strSql & ", dealer_com_jumin = '"& dealer_com_jumin &"'"
	strSql = strSql & ", dealer_email = '"& dealer_email &"'"
	strSql = strSql & ", dealer_tel1 = '"& dealer_tel1 &"'"
	strSql = strSql & ", dealer_tel2 = '"& dealer_tel2 &"'"
	
	IF len(trim(filename1))>1 THEN
	strSql = strSql & ", dealer_file1		= '"& filename1 &"'"
	End if
	IF len(trim(filename2))>1 THEN
	strSql = strSql & ", dealer_file1		= '"& filename2 &"'"
	End If

	strSql = strSql & ", dealer_insu = '"& dealer_insu &"'"
	strSql = strSql & ", dealer_ingea = '"& dealer_ingea &"'"
	strSql = strSql & ", dealer_service1 = '"& dealer_service1 &"'"
	strSql = strSql & ", dealer_service2 = '"& dealer_service2 &"'"
	strSql = strSql & ", dealer_group_code = '"& dealer_group_code &"'"	
	strSql = strSql & ", dealer_view = '"& dealer_view &"'"	
	strSql = strSql & ", dealer_bigo = '"& dealer_bigo &"'"	
	strSql = strSql & ", dealer_ingea_url = '"& dealer_ingea_url &"'"	
	strSql = strSql & ", dealer_ingea_id = '"& dealer_ingea_id &"'"	
	strSql = strSql & ", dealer_ingea_passwd = '"& dealer_ingea_passwd &"'"	
	strSql = strSql & "		where dealer_idx = "& dealer_idx &" "

	set objRs=objCnn.Execute(strSql)
	Alert_url "거래처 코드가 수정 되었습니다. ","a_company_list.asp?page="&page
  else    

	strSql = "Select ISNULL(MAX(dealer_idx)+1,1) from dealer_info "
	set objRs=objCnn.Execute(strSql)
	dealer_idx	= objRs(0)

	If Len(dealer_idx)=1 Then
		dealer_code="D000"&dealer_idx
	ElseIf Len(dealer_idx)=2 Then
		dealer_code="D00"&dealer_idx
	ElseIf Len(dealer_idx)=3 Then
		dealer_code="D0"&dealer_idx
	ElseIf Len(dealer_idx)=4 Then
		dealer_code="D"&dealer_idx
	End If

	strSql = " select dealer_code from dealer_info where dealer_code='"&dealer_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "거래처 코드 중복입니다.. \n\n 다시 입력해 주세요! "
		response.End
	End if

  strSql = "INSERT INTO dealer_info (dealer_idx, o_code, dealer_code, dealer_name, dealer_com_yn, "
  strSql = strSql & " dealer_com_no,dealer_insu,dealer_ingea, dealer_service1, dealer_service2, "
  strSql = stRsql & " dealer_bank_name, dealer_bank_cd, dealer_bank_no, "
  strSql = strSql & " dealer_zipcode1, dealer_address, dealer_com_jumin, "
  strSql = strSql & " dealer_email, dealer_tel1, dealer_tel2, dealer_file1, dealer_file2, "
  strSql = strSql & " dealer_group_code, dealer_view, dealer_bigo, "
  strSql = strSql & " dealer_ingea_url, dealer_ingea_id, dealer_ingea_passwd, dealer_writeday) VALUES "
  strSql = strSql & "("&dealer_idx&",'" & o_code & "','" & dealer_code & "'"
  strSql = strSql & ",'" & dealer_name & "'"
  strSql = strSql & ",'" & dealer_com_yn & "'"
  strSql = strSql & ",'" & dealer_com_no & "'"
  strSql = strSql & ",'" & dealer_insu & "'"
  strSql = strSql & ",'" & dealer_ingea & "'"
  strSql = strSql & ",'" & dealer_service1 & "'"
  strSql = strSql & ",'" & dealer_service2 & "'"
  strSql = strSql & ",'" & dealer_bank_name & "'"
  strSql = strSql & ", " & dealer_bank_cd & " "
  strSql = strSql & ",'" & dealer_bank_no & "'"
  strSql = strSql & ",'" & dealer_zipcode1 & "'"
  strSql = strSql & ",'" & dealer_address & "'"
  strSql = strSql & ",'" & dealer_com_jumin & "'"
  strSql = strSql & ",'" & dealer_email & "'"
  strSql = strSql & ",'" & dealer_tel1 & "'"
  strSql = strSql & ",'" & dealer_tel2 & "'"
  strSql = strSql & ",'" & filename1 & "'"
  strSql = strSql & ",'" & filename2 & "'"
  strSql = strSql & ",'" & dealer_group_code & "'"
  strSql = strSql & ",'" & dealer_view & "'"
  strSql = strSql & ",'" & dealer_bigo & "'"
  strSql = strSql & ",'" & dealer_ingea_url & "'"
  strSql = strSql & ",'" & dealer_ingea_id & "'"
  strSql = strSql & ",'" & dealer_ingea_passwd & "'"
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql) 
  end if     

  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing

  Alert_url "유통 코드가 등록되었습니다.","a_company_list.asp?page="&page 
  %>