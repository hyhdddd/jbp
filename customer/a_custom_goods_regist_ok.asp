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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_b_a_custom="N" then
	Alert_URL session_m_name &" 님은 고객상품 관리권한이 없습니다. 관리자에게 문의하시기 바랍니다.","/default.asp"
	Response.end
  End If
  
  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  page					= WORD_CHANGE(UploadForm("page"),20)									'페이지
  nowblock				= WORD_CHANGE(UploadForm("nowblock"),20)								'블럭
  s_link_txt			= WORD_CHANGE(UploadForm("s_link_txt"),0)								'검색어

  c_name				= WORD_CHANGE(UploadForm("c_name"),40)
  c_jumin1				= WORD_CHANGE(UploadForm("c_jumin1"),20)
  c_jumin2				= WORD_CHANGE(UploadForm("c_jumin2"),20)
  c_type				= WORD_CHANGE(UploadForm("c_type"),20)
  c_office_no			= WORD_CHANGE(UploadForm("c_office_no"),40)
  c_office_name			= WORD_CHANGE(UploadForm("c_office_name"),40)
  c_zipcode1			= WORD_CHANGE(UploadForm("c_zipcode1"),20)
  c_zipcode2			= WORD_CHANGE(UploadForm("c_zipcode2"),20)
  c_address				= WORD_CHANGE(UploadForm("c_address"),200)
  c_tel1				= WORD_CHANGE(UploadForm("c_tel1"),20)
  c_tel2				= WORD_CHANGE(UploadForm("c_tel2"),20) 
  c_tel2_com			= WORD_CHANGE(UploadForm("c_tel2_com"),20) 
  c_email				= WORD_CHANGE(UploadForm("c_email"),70)		
  c_auth_chk			= WORD_CHANGE(UploadForm("c_auth_chk"),20)	
  c_jumin_date			= WORD_CHANGE(UploadForm("c_jumin_date"),50)	

  g_goods_idx			= WORD_CHANGE(UploadForm("g_goods_idx")	,20)							'고객 상품 정보
  g_custom_idx 			= WORD_CHANGE(UploadForm("g_custom_idx"),20)							'고객 정보
  g_yuchi_m_id			= WORD_CHANGE(UploadForm("g_yuchi_m_id"),20)							'유치자 아이디
  g_jupsu_m_id			= WORD_CHANGE(UploadForm("g_jupsu_m_id"),20)							'접수자 아이디
  g_article_idx1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'고객 상품 회사명
  g_article_idx2		= WORD_CHANGE(UploadForm("g_article_idx2"),20)							'고객 상품 상품명
  g_set					= WORD_CHANGE(UploadForm("g_set"),20)									'셋트유형

  If g_article_idx1="0" Or g_article_idx2="0" Then
	Alert_back " 상품 정보가 잘못됐습니다. \n\n 다시 입력해 주세요!"
  End If

  g_option_idx			= WORD_CHANGE(UploadForm("g_option_idx"),20)							'고객 상품 옵션
  g_code_promise1		= WORD_CHANGE(UploadForm("g_code_promise1"),20)							'고객 상품 약정
  g_code_course_idx		= WORD_CHANGE(UploadForm("g_code_course_idx"),20)						'고객 상품 접수경로
  g_date_yuchi			= WORD_CHANGE(date_null_chk(UploadForm("g_date_yuchi")),20)				'고객 상품 접수일

  g_date_yuchi_hour		= WORD_CHANGE(UploadForm("g_date_yuchi_hour"),20)
  g_date_yuchi_minute	= WORD_CHANGE(UploadForm("g_date_yuchi_minute"),20)

  If g_date_yuchi="null" Then
	g_date_yuchi		= getdate()
  else
	g_date_yuchi		= g_date_yuchi & " " & g_date_yuchi_hour &":"&g_date_yuchi_minute &":00"
  End if

  g_code_sale			= WORD_CHANGE(UploadForm("g_code_sale"),20)								'고객 상품 할인탭 코드

  g_zipcode1			= WORD_CHANGE(UploadForm("g_zipcode1"),20)								'고객 상품 우편번호1
  g_zipcode2			= WORD_CHANGE(UploadForm("g_zipcode2"),20)								'고객 상품 우편번호2
  g_address				= WORD_CHANGE(UploadForm("g_address"),200)								'고객 상품 주소
  g_bank_cd				= WORD_CHANGE(UploadForm("g_bank_cd"),20)								'은행명
  g_bank_no				= WORD_CHANGE(UploadForm("g_bank_no"),40)								'계좌번호
  g_bank_name			= WORD_CHANGE(UploadForm("g_bank_name"),40)								'예금주
  g_sp_name				= WORD_CHANGE(UploadForm("g_sp_name"),40)								'사은품 정보 - 이름 
  g_sp_price			= WORD_CHANGE(money_chk(UploadForm("g_sp_price")),20)					'사은품 정보 - 금액
  g_sp_date_start		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start")),20)			'사은품 정보 - 지급예정일
  g_sp_date_end			= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_end")),20)			'사은품 정보 - 지급완료일
  g_service_no			= WORD_CHANGE(UploadForm("g_service_no"),40)							'가입서비스번호
  g_bank_name			= WORD_CHANGE(UploadForm("g_bank_name"),40)								'예금주
  g_bigo				= WORD_CHANGE(UploadForm("g_bigo"),0)									' 고객 상품 비고

  g_bank_jumin1			= WORD_CHANGE(UploadForm("g_bank_jumin1"),20)							'이체정보 주민번호(고객명과 다를경우)
  g_bank_jumin2			= WORD_CHANGE(UploadForm("g_bank_jumin2"),20)							'이체정보 주민번호(고객명과 다를경우)

  g_give_type			= WORD_CHANGE(UploadForm("g_give_type"),20)								'납부정보
  g_give_chk			= WORD_CHANGE(UploadForm("g_give_chk"),20)								'납부정보
  g_card_cd				= WORD_CHANGE(UploadForm("g_card_cd"),20)								'카드사
  g_card_no				= WORD_CHANGE(UploadForm("g_card_no"),40)								'카드번호
  g_card_gigan			= WORD_CHANGE(UploadForm("g_card_gigan"),20)							'카드 유효기간 
  g_card_gigan1			= WORD_CHANGE(UploadForm("g_card_gigan1"),20)							'카드 유효기간  
  g_card_name			= WORD_CHANGE(UploadForm("g_card_name"),40)								'카드 유효기간  
  g_card_jumin1			= WORD_CHANGE(UploadForm("g_card_jumin1"),20)							'카드 유효기간  
  g_card_jumin2			= WORD_CHANGE(UploadForm("g_card_jumin2"),20)							'카드 유효기간  

  g_sp_give_type		= WORD_CHANGE(UploadForm("g_sp_give_type"),20)							'사은품 지급자 선택

  g_date_gaetong_hope	= WORD_CHANGE(date_null_chk(UploadForm("g_date_gaetong_hope")),20)		'개통희망일
  g_trans_out_dealer	= WORD_CHANGE(UploadForm("g_trans_out_dealer"),20)						'인계거래처

  g_date_gaetong		= WORD_CHANGE(date_null_chk(UploadForm("g_date_gaetong")),20)			'개통일
  g_code_gaetong_idx	= WORD_CHANGE(UploadForm("g_code_gaetong_idx"),20)						'고객 상품 개통상태
  g_date_gaetong_hope_time	=  WORD_CHANGE(UploadForm("g_date_gaetong_hope_time"),20)			'개통희망일 시간

 '사은품 계좌정보
  g_sp_bank_code		= WORD_CHANGE(UploadForm("g_sp_bank_code"),20)							'사은품지급 은행코드
  g_sp_bank_acount		= WORD_CHANGE(UploadForm("g_sp_bank_acount"),40)						'사은품지급 은행계좌
  g_sp_bank_name		= WORD_CHANGE(UploadForm("g_sp_bank_name"),40)							'사은품지급 은행예금주
  g_sp_bank_memo		= WORD_CHANGE(UploadForm("g_sp_bank_memo"),100)							'사은품지급 은행메모

  g_code_service1		= WORD_CHANGE(UploadForm("g_code_service1"),40)							'부가서비스
  g_cancel_date			= WORD_CHANGE(date_null_chk(UploadForm("g_cancel_date")),20)			'해약일자
  g_article_cnt			= WORD_CHANGE(money_chk(UploadForm("g_article_cnt")),20)				'회선수

  g_sum_money_chk		= WORD_CHANGE(UploadForm("g_sum_money_chk"),20)							'합산청구(A/B)
  g_sum_money_txt		= WORD_CHANGE(UploadForm("g_sum_money_txt"),100)							'합산청구 텍스트
  g_code_area			= WORD_CHANGE(money_chk(UploadForm("g_code_area")),20)					'지역

  g_code_document		= WORD_CHANGE(replace(UploadForm("g_code_document")," ",""),0)			'미비서류

  g_move_tel1			= WORD_CHANGE(UploadForm("g_move_tel1"),20)
  g_move_name			= WORD_CHANGE(UploadForm("g_move_name"),40)
  g_move_jumin1			= WORD_CHANGE(UploadForm("g_move_jumin1"),20)
  g_move_jumin2			= WORD_CHANGE(UploadForm("g_move_jumin2"),20)
  g_move_date			= WORD_CHANGE(UploadForm("g_move_date"),20)
  g_move_tel2			= WORD_CHANGE(UploadForm("g_move_tel2"),20)
  g_move_company		= WORD_CHANGE(UploadForm("g_move_company"),20)
  g_move_memo			= WORD_CHANGE(UploadForm("g_move_memo"),100)

  '본사사은품
  g_sp_name_top			= WORD_CHANGE(UploadForm("g_sp_name_top"),40)
  g_sp_price_top		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top")),20)	
  g_code_combine		= WORD_CHANGE(money_chk(UploadForm("g_code_combine")),20)

  strSql = " select m_dealer_code from emp_list where m_id='"&g_yuchi_m_id&"'"
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  g_trans_in_dealer = objRs(0)								' 인수 유통망 자동 출력

  sp_code				= Create_code() 

  yea = year(date)
  mon = month(date)
  if Cint(mon) < 10 then  	mon = "0" & mon  end if
  
  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 폴더 생성 
  DIR_O_CODE="/file_data/"&o_code&"/customer"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 - 날짜 폴더 생성
  DIR_O_CODE="/file_data/"& o_code &"/customer/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)

  IF fso.FolderExists(DIR_O_CODE)=false then
	  fso.createfolder(DIR_O_CODE)
  end if   


  If g_goods_idx<>"" then
	  strSql = "Select * from customer_goods where g_goods_idx="&g_goods_idx
	  Set objRs=objCnn.Execute(strSql)

	  g_file11		= objRs("g_file1")
	  g_file22		= objRs("g_file2")
	  g_file33		= objRs("g_file3")
	  g_file44		= objRs("g_file4")
  End if
 
  '파일 업로드 처리
  g_file1=UploadForm("g_file1")
  if Len(g_file1)>0 then  
    	att_file=UploadForm("g_file1").filepath 
    	filesize1=UploadForm("g_file1").FileLen  
    	if filesize1<20000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

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
	   		Loop

			filename1	= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
			UploadForm("g_file1").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 20M을 초과할수 없습니다."
		end if   	
  end if

  g_file2=UploadForm("g_file2")
  if Len(g_file2)>0 then  
    	att_file=UploadForm("g_file2").filepath 
    	filesize1=UploadForm("g_file2").FileLen  
    	if filesize1<20000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

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
	   		Loop

			filename2	= strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
			UploadForm("g_file2").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 20M을 초과할수 없습니다."
		end if   	
  end if

  g_file3=UploadForm("g_file3")
  if Len(g_file3)>0 then  
    	att_file=UploadForm("g_file3").filepath 
    	filesize1=UploadForm("g_file3").FileLen  
    	if filesize1<20000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

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
	   		Loop

			filename3	= strfilename			
			strfilename		= DIR_O_CODE &"/"& strfilename
			UploadForm("g_file3").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 20M을 초과할수 없습니다."
		end if   	
  end if

  g_file4=UploadForm("g_file4")
  if Len(g_file4)>0 then  
    	att_file=UploadForm("g_file4").filepath 
    	filesize1=UploadForm("g_file4").FileLen  
    	if filesize1<20000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

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
	   		Loop


			filename4=strfilename
			strfilename		= DIR_O_CODE &"/"& strfilename
			UploadForm("g_file4").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 20M을 초과할수 없습니다."
		end if   	
  end if


  '==================화일 업로드 처리부분 끝 ==================='  
  
  IF len(trim(filename1))>1 Then
	If g_file11<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file11
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME1=CSTR(yea)+cstr(mon)+"/"+filename1
  end if 

  IF len(trim(filename2))>1 Then
	If g_file22<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file22
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME2=CSTR(yea)+cstr(mon)+"/"+filename2
  end if 
  IF len(trim(filename3))>1 Then
	If g_file33<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file33
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME3=CSTR(yea)+cstr(mon)+"/"+filename3
  end if 
  IF len(trim(filename4))>1 Then
	If g_file44<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file44
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME4=CSTR(yea)+cstr(mon)+"/"+filename4
  end if 

	'같은 고객 정보 수정
	strSql = " select g_goods_ref, g_date_yuchi from customer_goods where g_goods_idx="&g_goods_idx
	Set objRs=objCnn.Execute(strSql)
	
	g_goods_ref			= objRs("g_goods_ref")
	g_date_yuchi_db		= objRs("g_date_yuchi")

	
	'고객마킹 로직
	o_marking				= CInt(o_marking)
	g_date_yuchi_day		= dateDiff("d",g_date_yuchi_db, now)
	
	If g_date_yuchi_day>=(o_marking) And CInt(o_marking)<>0 Then 
		Alert_back "마킹된 고객은 수정할 수 없습니다."
		Response.end
	End If

	strSql = " update customer_goods set "
	strSql = strSql & "  c_name			= '"&c_name &"'"  
	strSql = strSql & ", c_type			= '"&c_type &"'"  
	strSql = strSql & ", c_jumin1		= '"& c_jumin1 &"'"
	strSql = strSql & ", c_jumin2		= '"& c_jumin2 &"'"
	strSql = strSql & ", c_office_no	= '"& c_office_no &"'"
	strSql = strSql & ", c_office_name	= '"& c_office_name &"'"
	strSql = strSql & ", c_zipcode1		= '"& c_zipcode1 &"'"
	strSql = strSql & ", c_zipcode2		= '"& c_zipcode2 &"'"
	strSql = strSql & ", c_address		= '"& c_address &"'"
	strSql = strSql & ", c_tel1			= '"& c_tel1 &"'"
	strSql = strSql & ", c_tel2			= '"& c_tel2 &"'"
	strSql = strSql & ", c_tel2_com		= '"& c_tel2_com &"'"

	

	strSql = strSql & ", c_email		= '"& c_email &"'"
	strSql = strSql & ", c_auth_chk		= '"& c_auth_chk &"'"
	strSql = strSql & ", c_jumin_date	= '"& c_jumin_date &"'"
	
	'이체 카드정보
	strSql = strSql & ", g_give_type = '"& g_give_type &"'"
	strSql = strSql & ", g_give_chk = '"& g_give_chk &"'"
	strSql = strSql & ", g_card_cd = "& g_card_cd &" "
	strSql = strSql & ", g_card_no = '"& g_card_no &"'"
	strSql = strSql & ", g_card_gigan = '"& g_card_gigan &"'"
	strSql = strSql & ", g_card_gigan1 = '"& g_card_gigan1 &"'"
	strSql = strSql & ", g_card_name = '"& g_card_name &"'"
	strSql = strSql & ", g_card_jumin1 = '"& g_card_jumin1 &"'"
	strSql = strSql & ", g_card_jumin2 = '"& g_card_jumin2 &"'"

	'이체 은행정보
	strSql = strSql & ", g_bank_cd 		= '"& g_bank_cd &"'" 
	strSql = strSql & ", g_bank_no 		= '"& g_bank_no &"'" 
	strSql = strSql & ", g_bank_name	= '"& g_bank_name &"'" 
	strSql = strSql & ", g_bank_jumin1 = '"& g_bank_jumin1 &"'"
	strSql = strSql & ", g_bank_jumin2 = '"& g_bank_jumin2 &"'"
	
	'사은품 계좌 정보
	strSql = strSql & ", g_sp_bank_code =  "& g_sp_bank_code &" "
	strSql = strSql & ", g_sp_bank_acount = '"& g_sp_bank_acount &"'"
	strSql = strSql & ", g_sp_bank_name = '"& g_sp_bank_name &"'"
	strSql = strSql & ", g_sp_bank_memo = '"& g_sp_bank_memo &"'"

	strSql = strSql & ", g_sum_money_chk	= '"& g_sum_money_chk &"'" 
	strSql = strSql & ", g_sum_money_txt	= '"& g_sum_money_txt &"'" 
	strSql = strSql & ", g_code_area		=  "& g_code_area &" " 

	If g_date_yuchi="null" then
	strSql = strSql & ", g_date_yuchi	=  "& g_date_yuchi &"  "
	else
	strSql = strSql & ", g_date_yuchi	= '"& g_date_yuchi &"' "
	End If

	strSql = strSql & ", g_move_tel1		= '"& g_move_tel1 &"' "
	strSql = strSql & ", g_move_name		= '"& g_move_name &"' "
	strSql = strSql & ", g_move_jumin1		= '"& g_move_jumin1 &"' "
	strSql = strSql & ", g_move_jumin2		= '"& g_move_jumin2 &"' "
	strSql = strSql & ", g_move_date		= '"& g_move_date &"' "
	strSql = strSql & ", g_move_tel2		= '"& g_move_tel2 &"' "
	strSql = strSql & ", g_move_company		= '"& g_move_company &"' "
	strSql = strSql & ", g_move_memo		= '"& g_move_memo &"' "

	strSql = strSql & "  where g_goods_ref	= "&g_goods_ref
	'Response.write strSql
	Set objRs=objCnn.Execute(strSql)
 
 		'개통코드 로그 저장
		strSql = "select g_code_gaetong_idx from customer_goods where g_goods_idx="&g_goods_idx
		Set objRs=objCnn.Execute(strSql)

		g_code_gaetong_old		= objRs(0)

		If g_code_gaetong_idx<>g_code_gaetong_old Then
			strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
			strSql = strSql & "values ("&g_goods_idx&",'"&session_m_id&"','"&g_code_gaetong_idx&"',getdate())"
			Set objRs=objCnn.Execute(strSql)
		End If
		
	strSql = " update customer_goods set "
	strSql = strSql & "  c_name			= '"&c_name &"'"  
	strSql = strSql & ", c_type			= '"&c_type &"'"  
	strSql = strSql & ", c_jumin1		= '"& c_jumin1 &"'"
	strSql = strSql & ", c_jumin2		= '"& c_jumin2 &"'"
	strSql = strSql & ", c_office_no	= '"& c_office_no &"'"
	strSql = strSql & ", c_office_name	= '"& c_office_name &"'"
	strSql = strSql & ", c_zipcode1		= '"& c_zipcode1 &"'"
	strSql = strSql & ", c_zipcode2		= '"& c_zipcode2 &"'"
	strSql = strSql & ", c_address		= '"& c_address &"'"
	strSql = strSql & ", c_tel1			= '"& c_tel1 &"'"
	strSql = strSql & ", c_tel2			= '"& c_tel2 &"'"
	strSql = strSql & ", c_tel2_com		= '"& c_tel2_com &"'"
	
	strSql = strSql & ", c_tel3			= '"& c_tel3 &"'"
	strSql = strSql & ", c_email		= '"& c_email &"'"
	strSql = strSql & ", c_auth_chk		= '"& c_auth_chk &"'"
	strSql = strSql & ", c_jumin_date	= '"& c_jumin_date &"'"
	strSql = strSql & ", g_yuchi_m_id	= '"& g_yuchi_m_id &"'"
  	strSql = strSql & ", g_service_no	= '"& g_service_no &"'"		
	strSql = strSql & ", g_article_idx1 = "& g_article_idx1 &" "  
	strSql = strSql & ", g_article_idx2 = "& g_article_idx2 &" "
	strSql = strSql & ", g_set			= '"& g_set &"'" 
	strSql = strSql & ", g_option_idx	= "& g_option_idx &" "  
	strSql = strSql & ", g_zipcode1		= '"& g_zipcode1 &"'"
	strSql = strSql & ", g_zipcode2		= '"& g_zipcode2 &"'"
	strSql = strSql & ", g_address		= '"& g_address &"'"
	strSql = strSql & ", g_bank_cd 		= '"& g_bank_cd &"'" 
	strSql = strSql & ", g_bank_no 		= '"& g_bank_no &"'" 
	strSql = strSql & ", g_bank_name	= '"& g_bank_name &"'" 
	strSql = strSql & ", g_bigo			= '"& g_bigo &"'"
 	strSql = strSql & ", g_trans_out_dealer = '"& g_trans_out_dealer &"' "
 	strSql = strSql & ", g_trans_in_dealer = '"& g_trans_in_dealer &"' "
	IF len(trim(filename1))>1 THEN
	strSql = strSql & ", g_file1		= '"& FILENAME1 &"'"
	End if
	IF len(trim(filename2))>1 THEN
	strSql = strSql & ", g_file2		= '"& FILENAME2 &"'"
	End if
	IF len(trim(filename3))>1 THEN
	strSql = strSql & ", g_file3		= '"& FILENAME3 &"'"
	End if
	IF len(trim(filename4))>1 THEN
	strSql = strSql & ", g_file4		= '"& FILENAME4 &"'"
	End If

	If g_date_yuchi="null" then
	strSql = strSql & ", g_date_yuchi	=  "& g_date_yuchi &"  "
	else
	strSql = strSql & ", g_date_yuchi	= '"& g_date_yuchi &"' "
	End If
	
	strSql = strSql & ", g_code_course_idx= '"& g_code_course_idx &"' "			
	strSql = strSql & ", g_sp_name		=  '"& g_sp_name &"' "			
	strSql = strSql & ", g_sp_price		= "& g_sp_price &" "	

	If g_sp_date_end="null" then
	strSql = strSql & ", g_sp_date_end= "& g_sp_date_end &" "		
	Else
	strSql = strSql & ", g_sp_date_end= '"& g_sp_date_end &"' "		
	End If		

	If g_sp_date_start="null" then
	strSql = strSql & ", g_sp_date_start= "& g_sp_date_start &" "		
	Else
	strSql = strSql & ", g_sp_date_start= '"& g_sp_date_start &"' "		
	End If
	strSql = strSql & ", g_code_gaetong_idx = '"& g_code_gaetong_idx &"' "	

	If g_date_gaetong="null" then
	strSql = strSql & ", g_date_gaetong= "& g_date_gaetong &" "		
	Else
	strSql = strSql & ", g_date_gaetong= '"& g_date_gaetong &"' "		
	End If		

	strSql = strSql & ", g_code_promise = "& g_code_promise1 &" "	
	strSql = strSql & ", g_code_sale	 = "& g_code_sale &" "
	strSql = strSql & ", g_bank_jumin1 = '"& g_bank_jumin1 &"'"
	strSql = strSql & ", g_bank_jumin2 = '"& g_bank_jumin2 &"'"
	strSql = strSql & ", g_give_type = '"& g_give_type &"'"
	strSql = strSql & ", g_card_cd = "& g_card_cd &" "
	strSql = strSql & ", g_card_no = '"& g_card_no &"'"
	strSql = strSql & ", g_card_gigan = '"& g_card_gigan &"'"
	strSql = strSql & ", g_card_gigan1 = '"& g_card_gigan1 &"'"
	strSql = strSql & ", g_card_name = '"& g_card_name &"'"
	strSql = strSql & ", g_card_jumin1 = '"& g_card_jumin1 &"'"
	strSql = strSql & ", g_card_jumin2 = '"& g_card_jumin2 &"'"

	strSql = strSql & ", g_sp_give_type = '"& g_sp_give_type &"'"

	If g_date_gaetong_hope="null" then
	strSql = strSql & ", g_date_gaetong_hope = "& g_date_gaetong_hope &"  "	
	Else
	strSql = strSql & ", g_date_gaetong_hope = '"& g_date_gaetong_hope &"'  "	
	End If
	strSql = strSql & ", g_date_gaetong_hope_time = '"& g_date_gaetong_hope_time &"'"	

	strSql = strSql & ", g_sp_bank_code		=  "& g_sp_bank_code &" "
	strSql = strSql & ", g_sp_bank_acount	= '"& g_sp_bank_acount &"'"
	strSql = strSql & ", g_sp_bank_name		= '"& g_sp_bank_name &"'"
	strSql = strSql & ", g_sp_bank_memo		= '"& g_sp_bank_memo &"'"
	strSql = strSql & ", g_code_service		=  "& g_code_service1 &" "

	If g_cancel_date="null" then
	strSql = strSql & ", g_cancel_date		=  "& g_cancel_date &" "	
	Else
	strSql = strSql & ", g_cancel_date		= '"& g_cancel_date &"' "	
	End If
	strSql = strSql & ", g_article_cnt		=  "& g_article_cnt &" "
	strSql = strSql & ", g_code_document	= '"& g_code_document &"' "

	strSql = strSql & ", g_sp_name_top		= '"& g_sp_name_top &"' "			
	strSql = strSql & ", g_sp_price_top		=  "& g_sp_price_top &" "	
	strSql = strSql & ", g_code_combine		=  "& g_code_combine &" "	
	strSql = strSql & "  where g_goods_idx	=  "& g_goods_idx

  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)
  %>
  <%
    g_g_goods_idx				= g_goods_idx
	g_g_option_idx				= g_option_idx						'옵션명
	g_g_trans_out_dealer		= g_trans_out_dealer				'인계처 코드
	g_g_code_promise			= g_code_promise1					'약정
	g_g_sp_give_type			= g_sp_give_type					'사은품 지급처	(C:인계처지급)
	g_g_sp_price				= g_sp_price						'사은품 금액
	g_g_code_sale				= g_code_sale						'할인탭코드
	g_g_set						= g_set								'셋트유형
	g_g_article_cnt				= g_article_cnt						'회선수1
    g_g_sp_price_top			= g_sp_price_top					'본사사은품
  %>  
  <!--#include virtual="/customer/a_charge_set_doc.asp"-->
  <%
  objCnn.Close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  set FSO=Nothing

  
  Alert_url " 고객 상품이 등록되었습니다.","a_custom_goods_list.asp?g_goods_idx="&g_goods_idx&"&page="&page&"&nowblock="&nowblock&"&"&s_link_txt
  %>