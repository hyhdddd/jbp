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
	Alert_url session_name&" 님은 거래처등록 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  end If
  
  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  partner_idx			= WORD_CHANGE(UploadForm("partner_idx"),20)
  dealer_code			= WORD_CHANGE(UploadForm("dealer_code"),20)
  page					= WORD_CHANGE(UploadForm("page"),20)

  If UCase(o_code)=UCase(dealer_code) Then
	Alert_back " 업체코드와 거래처 코드는 서로 달라야 합니다. \n\n 코드를 바꾸어 주세요"
	Response.end
  End If
  
  dealer_name			= WORD_CHANGE(UploadForm("dealer_name"),50)
  dealer_com_yn			= WORD_CHANGE(UploadForm("dealer_com_yn"),20)
  dealer_com_no			= WORD_CHANGE(UploadForm("dealer_com_no"),30)  
  dealer_service1		= WORD_CHANGE(UploadForm("dealer_service1"),40)
  dealer_service2		= WORD_CHANGE(UploadForm("dealer_service2"),40)
  dealer_bank_name		= WORD_CHANGE(UploadForm("dealer_bank_name"),20)		' 은행 예금주
  dealer_bank_cd		= WORD_CHANGE(UploadForm("dealer_bank_cd"),20)			' 은행 코드
  dealer_bank_no		= WORD_CHANGE(UploadForm("dealer_bank_no"),50)			' 은행 계좌번호
  dealer_zipcode1		= WORD_CHANGE(UploadForm("dealer_zipcode1"),20)			' 회사 우편번호1
  dealer_zipcode2		= WORD_CHANGE(UploadForm("dealer_zipcode2"),20)			' 회사 우편번호2
  dealer_address		= WORD_CHANGE(UploadForm("dealer_address"),200)			' 회사 주소
  dealer_com_jumin		= WORD_CHANGE(UploadForm("dealer_com_jumin"),20)
  dealer_email			= WORD_CHANGE(UploadForm("dealer_email"),30)
  dealer_tel1			= WORD_CHANGE(UploadForm("dealer_tel1"),20)
  dealer_tel2			= WORD_CHANGE(UploadForm("dealer_tel2"),20) 
  dealer_insu			= WORD_CHANGE(UploadForm("dealer_insu"),20)				'인수 / 인계
  dealer_ingea			= WORD_CHANGE(UploadForm("dealer_ingea"),20)				'인수 / 인계
  dealer_group_code		= WORD_CHANGE(UploadForm("dealer_group_code"),20)		'딜러 정산그룹

  If dealer_insu="" Or IsNull(dealer_insu) Then
	dealer_insu="N"
  End if

  If dealer_ingea="" Or IsNull(dealer_ingea) Then
	dealer_ingea="N"
  End if

  m_idx					= WORD_CHANGE(UploadForm("m_idx"),20)
  m_id					= WORD_CHANGE(UploadForm("m_id"),20)
  page					= WORD_CHANGE(UploadForm("page"),20)
  m_name				= WORD_CHANGE(UploadForm("m_name"),20)
  m_passwd				= WORD_CHANGE(UploadForm("m_passwd"),20)

  m_id_chk			= checkSpecialChar(m_id)
  pass_chk			= checkSpecialChar(m_passwd)

  If m_id_chk="X" Then
	Alert_back "아이디에 특수문자를 사용하시면 안됩니다."
	Response.end
  End if

  If pass_chk="X" Then
	Alert_back "패스워드에 특수문자를 사용하시면 안됩니다."
	Response.end
  End If
  
  m_jumin1				= WORD_CHANGE(UploadForm("m_jumin1"),20)
  m_jumin2				= WORD_CHANGE(UploadForm("m_jumin2"),20)
  m_zipcode1			= WORD_CHANGE(UploadForm("m_zipcode1"),20)
  m_zipcode2			= WORD_CHANGE(UploadForm("m_zipcode2"),20)
  m_address				= WORD_CHANGE(UploadForm("m_address"),200)
  m_email				= WORD_CHANGE(UploadForm("m_email"),70)
  m_login_ip			= WORD_CHANGE(UploadForm("m_login_ip"),30)
  m_tel1				= WORD_CHANGE(UploadForm("m_tel1"),20)
  m_tel2				= WORD_CHANGE(UploadForm("m_tel2"),20)
  m_bigo				= WORD_CHANGE(UploadForm("m_bigo"),0)
  m_duty				= WORD_CHANGE(UploadForm("m_duty"),20)
  m_position			= WORD_CHANGE(UploadForm("m_position"),20)
  m_bank_cd				= WORD_CHANGE(UploadForm("m_bank_cd"),20)
  m_bank_no				= WORD_CHANGE(UploadForm("m_bank_no"),40)
  m_bank_name			= WORD_CHANGE(UploadForm("m_bank_name"),40)
  m_status				= WORD_CHANGE(UploadForm("m_status"),20)
  m_pay_type			= WORD_CHANGE(UploadForm("m_pay_type"),20)
  m_family_no			= WORD_CHANGE(UploadForm("m_family_no"),20)
  m_in_date				= WORD_CHANGE(date_null_chk(UploadForm("m_in_date")),20)
  m_out_date			= WORD_CHANGE(date_null_chk(UploadForm("m_out_date")),20)
  all_decision			= WORD_CHANGE(UploadForm("all_decision"),20)
  duty_decision			= WORD_CHANGE(UploadForm("duty_decision"),20)
  m_dealer_admin		= WORD_CHANGE(UploadForm("m_dealer_admin"),20)

  If m_dealer_admin	= "" Then
	m_dealer_admin	= "X"
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

 
   if Len(dealer_file1)>0 then  

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
  End If
  
  strSql =" select m_id from emp_list where m_id='"&m_id&"'"
  set objRs=objCnn.Execute(strSql)
  
  if objRs.eof or objRs.bof then
  Else
	Alert_back " 아이디가 이미 존재 합니다. \n\n 다시 입력해 주세요! "
	response.end
  end if    

  strSql = "INSERT INTO dealer_info (dealer_idx, o_code, dealer_code, dealer_name, dealer_com_yn, "
  strSql = strSql & " dealer_com_no,dealer_insu,dealer_ingea, dealer_service1, dealer_service2, "
  strSql = strSql & " dealer_bank_name, dealer_bank_cd, dealer_bank_no, "
  strSql = strSql & " dealer_zipcode1, dealer_zipcode2, dealer_address, dealer_com_jumin, "
  strSql = strSql & " dealer_email, dealer_tel1, dealer_tel2, dealer_file1, dealer_file2, "
  strSql = strSql & " dealer_group_code, dealer_view, dealer_writeday) VALUES "
  strSql = strSql & "("&dealer_idx&",'" & o_code & "','" & dealer_code & "'"
  strSql = strSql & ",'" & dealer_name & "'"
  strSql = strSql & ",'" & dealer_com_yn & "'"
  strSql = strSql & ",'" & dealer_com_no & "'"
  strSql = strSql & ",'" & dealer_insu & "'"
  strSql = strSql & ",'" & dealer_ingea & "'"
  strSql = strSql & ",'" & dealer_service1 & "'"
  strSql = strSql & ",'" & dealer_service2 & "'"
  strSql = strSql & ",'" & dealer_bank_name & "'"
  strSql = strSql & ",'" & dealer_bank_cd & "'"
  strSql = strSql & ",'" & dealer_bank_no & "'"
  strSql = strSql & ",'" & dealer_zipcode1 & "'"
  strSql = strSql & ",'" & dealer_zipcode2 & "'"
  strSql = strSql & ",'" & dealer_address & "'"
  strSql = strSql & ",'" & dealer_com_jumin & "'"
  strSql = strSql & ",'" & dealer_email & "'"
  strSql = strSql & ",'" & dealer_tel1 & "'"
  strSql = strSql & ",'" & dealer_tel2 & "'"
  strSql = strSql & ",'" & filename1 & "'"
  strSql = strSql & ",'" & filename2 & "'"
  strSql = strSql & ",'" & dealer_group_code & "'"
  strSql = strSql & ",'Y'" 
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql) 
 
  strSql = "Select ISNULL(MAX(m_idx)+1,1) from emp_list "
  set objRs=objCnn.Execute(strSql)
  m_idx	= objRs(0)

  strSql = "INSERT INTO emp_list (m_idx, o_code, m_id, m_passwd, m_name, m_dealer_code, m_jumin1,m_jumin2, m_login_ip,"
  strSql = strSql & "m_duty, m_position, m_tel1, m_tel2,m_bigo, m_status, "
  strSql = strSql & "m_email,m_zipcode1, m_zipcode2, m_address, m_bank_cd, m_bank_no, m_bank_name, "
  strSql = strSql & " m_pay_type, m_family_no, m_in_date, m_out_date,m_step,m_dealer_admin, m_last_passwd) VALUES "
  strSql = strSql & "( " & m_idx & "  "
  strSql = strSql & ",'" & o_code & "' "
  strSql = strSql & ",'" & m_id & "' "
  strSql = strSql & ",'" & m_passwd & "' "
  strSql = strSql & ",'" & m_name & "' "
  strSql = strSql & ",'" & dealer_code & "' "
  strSql = strSql & ",'" & m_jumin1 & "' "
  strSql = strSql & ",'" & m_jumin2 & "' "
  strSql = strSql & ",'" & m_login_ip & "' "
  strSql = strSql & ",'" & m_duty & "'"
  strSql = strSql & ",'" & m_position & "'"
  strSql = strSql & ",'" & m_tel1 & "'"
  strSql = strSql & ",'" & m_tel2 & "'"
  strSql = strSql & ",'" & m_bigo & "'"
  strSql = strSql & ",'" & m_status & "'"
  strSql = strSql & ",'" & m_email & "'"
  strSql = strSql & ",'" & m_zipcode1 & "'"
  strSql = strSql & ",'" & m_zipcode2 & "'"
  strSql = strSql & ",'" & m_address & "'"
  strSql = strSql & ",'" & m_bank_cd & "'"
  strSql = strSql & ",'" & m_bank_no & "'"
  strSql = strSql & ",'" & m_bank_name & "'"
  strSql = strSql & ",'" & m_pay_type & "'"
  strSql = strSql & ", " & m_family_no & " "
  If m_in_date="null" then
	strSql = strSql & ",  "& m_in_date &"  "	
  else
	strSql = strSql & ", '"& m_in_date &"' "	
  End If
  If m_out_date="null" then
	strSql = strSql & ",  "& m_out_date &"  "	
  else
	strSql = strSql & ", '"& m_out_date &"' "	
  End If
  strSql = strSql & ",'S','"& m_dealer_admin &"',getdate())"
  'response.write stRsql&"<br>"
  set objRs=objCnn.Execute(strSql) 

  ' 사원 기초 권한 등록
  strSql = "Select ISNULL(MAX(board_idx)+1,1) from emp_admin "
  set objRs=objCnn.Execute(strSql)
  board_idx	= objRs(0)

  strSql = " insert into emp_admin ("
  strSql = strSql & "  board_idx, o_code, m_id, ad_g_p_gamang, ad_k_p_result, "

	strSql = strSql & " ad_e_notice2, ad_e_data2, "
	If m_dealer_admin="O" Then 
		strSql = strSql & " ad_g_y_gamang, ad_i_y_emp, ad_r_p_exact, ad_r_y_exact, ad_b_y_custom, ad_k_y_result,"			
	End if

  strSql = strSql & " ad_b_p_custom "
  strSql = strSql & " ) values("
  strSql = strSql & " "& board_idx &",'"& o_code &"','"& m_id &"', 'E', 'R',"

  strSql = strSql & " 'R','R',"
	If m_dealer_admin="O" Then 
		strSql = strSql & " 'E', 'A', 'N', 'R', 'W', 'R', "
	End if

  strSql = strSql & " 'W'"
  strSql = strSql & " )"
  'Response.write strSql &"<br>"
  set objRs=objCnn.Execute(strSql) 

  strSql = "delete dealer_partner_info where board_idx="&partner_idx
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 사원이 등록되었습니다. \n\n 등록된 사원은 메뉴 사용권한 을 설정해야 합니다.\n\n 마스터 권한이을 가지고 계신분만 설정할 수 있습니다.","y_partner_list.asp?page="&page&" "

  
  %>