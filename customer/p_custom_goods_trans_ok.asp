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
  <%
  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE


  g_yuchi_m_id			= WORD_CHANGE(UploadForm("g_yuchi_m_id"),20)							'유치자 아이디
  g_jupsu_m_id			= WORD_CHANGE(UploadForm("g_jupsu_m_id"),20)							'접수자 아이디

  goods_cnt				= WORD_CHANGE(UploadForm("goods_cnt"),20)
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
  c_email				= WORD_CHANGE(UploadForm("c_email"),70)									'이메일
  c_auth_chk			= WORD_CHANGE(UploadForm("c_auth_chk"),20)								'발급일자
  c_jumin_date			= WORD_CHANGE(UploadForm("c_jumin_date"),20)							'발급일자
  c_bank_cd				= WORD_CHANGE(UploadForm("c_bank_cd"),20)								'은행명
  c_bank_no				= WORD_CHANGE(UploadForm("c_bank_no"),40)								'계좌번호
  c_bank_name			= WORD_CHANGE(UploadForm("c_bank_name"),40)								'예금주

  c_bank_jumin1			= WORD_CHANGE(UploadForm("c_bank_jumin1"),20)							'이체정보 주민번호(고객명과 다를경우)
  c_bank_jumin2			= WORD_CHANGE(UploadForm("c_bank_jumin2"),20)							'이체정보 주민번호(고객명과 다를경우)

  g_give_type			= WORD_CHANGE(UploadForm("g_give_type"),20)								'납부정보
  g_give_chk			= WORD_CHANGE(UploadForm("g_give_chk"),20)								'납부 관계
  c_card_cd				= WORD_CHANGE(UploadForm("c_card_cd"),20)								'카드사

  g_card_no				= WORD_CHANGE(UploadForm("g_card_no"),20)								'카드번호
  g_card_gigan			= WORD_CHANGE(UploadForm("g_card_gigan"),20)							'카드 유효기간
  g_card_gigan1			= WORD_CHANGE(UploadForm("g_card_gigan1"),20)							'카드 유효기간
  g_card_name			= WORD_CHANGE(UploadForm("g_card_name"),40)								'카드주
  g_card_jumin1			= WORD_CHANGE(UploadForm("g_card_jumin1"),20)							'카드주 주민번호
  g_card_jumin2			= WORD_CHANGE(UploadForm("g_card_jumin2"),20)							'카드주 주민번호

  g_code_course_idx		= WORD_CHANGE(UploadForm("g_code_course_idx"),20)						'고객 상품 접수경로
  

  g_article_idx1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'고객 상품 회사명
  g_article_idx1_1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'고객 상품 회사명
  g_article_idx1_2		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'고객 상품 회사명
  g_article_idx2		= WORD_CHANGE(UploadForm("g_article_idx2"),20)							'고객 상품 상품명
  g_set					= WORD_CHANGE(UploadForm("g_set"),20)									'셋트유형

  If goods_cnt="1" Then	g_set="A" End if
  If goods_cnt="2" Then	g_set="B" End if
  If goods_cnt="3" Then	g_set="C" End If
  
  If g_article_idx1="0" Or g_article_idx2="0" Then
	Alert_back " 상품 정보가 잘못됐습니다. \n\n 다시 입력해 주세요!"
  End If

  g_option_idx			= WORD_CHANGE(UploadForm("g_option_idx"),20)							'고객 상품 옵션
  g_code_sale			= WORD_CHANGE(UploadForm("g_code_sale"),20)							'고객 상품 할인탭 코드
  g_sp_name				= WORD_CHANGE(UploadForm("g_sp_name"),40)								'사은품 정보 - 이름 
  g_sp_price			= WORD_CHANGE(money_chk(UploadForm("g_sp_price")),20)					'사은품 정보 - 금액
  g_sp_date_start		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start")),20)			'사은품 정보 - 지급예정일
  g_sp_give_type		= WORD_CHANGE(UploadForm("g_sp_give_type"),20)							'사은품 정보 - 지급처선택

  g_sp_name1			= WORD_CHANGE(UploadForm("g_sp_name1"),40)								'사은품 정보 - 이름 
  g_sp_price1			= WORD_CHANGE(money_chk(UploadForm("g_sp_price1")),20)					'사은품 정보 - 금액
  g_sp_date_start1		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start1")),20)			'사은품 정보 - 지급예정일
  g_sp_give_type1		= WORD_CHANGE(UploadForm("g_sp_give_type1"),20)							'사은품 정보 - 지급처선택

  g_sp_name2			= WORD_CHANGE(UploadForm("g_sp_name2"),40)								'사은품 정보 - 이름 
  g_sp_price2			= WORD_CHANGE(money_chk(UploadForm("g_sp_price2")),20)					'사은품 정보 - 금액
  g_sp_date_start2		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start2")),20)			'사은품 정보 - 지급예정일
  g_sp_give_type2		= WORD_CHANGE(UploadForm("g_sp_give_type2"),20)							'사은품 정보 - 지급처선택
  g_bigo				= WORD_CHANGE(UploadForm("g_bigo"),0)									' 고객 상품 비고
 
  g_article_idx2_1		= WORD_CHANGE(UploadForm("g_article_idx2_1"),20)						'고객 상품 상품명
  g_option_idx_1		= WORD_CHANGE(UploadForm("g_option_idx_1"),20)							'고객 상품 옵션
  g_code_sale1			= WORD_CHANGE(UploadForm("g_code_sale1"),20)							'고객 상품 할인탭 코드

  g_article_idx2_2		= WORD_CHANGE(UploadForm("g_article_idx2_2"),20)						'고객 상품 상품명
  g_option_idx_2		= WORD_CHANGE(UploadForm("g_option_idx_2"),20)							'고객 상품 옵션
  g_code_sale2			= WORD_CHANGE(UploadForm("g_code_sale2"),20)							'고객 상품 할인탭 코드

  '사은품 계좌등록
  g_sp_bank_code		= WORD_CHANGE(UploadForm("g_sp_bank_code"),20)							'사은품지급 은행코드
  g_sp_bank_acount		= WORD_CHANGE(UploadForm("g_sp_bank_acount"),40)						'사은품지급 은행계좌
  g_sp_bank_name		= WORD_CHANGE(UploadForm("g_sp_bank_name"),40)							'사은품지급 은행예금주
  g_sp_bank_memo		= WORD_CHANGE(UploadForm("g_sp_bank_memo"),100)							'사은품지급 은행메모
  g_sp_bank_jumin1		= WORD_CHANGE(UploadForm("g_sp_bank_jumin1"),20)						'사은품지급 은행메모
  g_sp_bank_jumin2		= WORD_CHANGE(UploadForm("g_sp_bank_jumin2"),20)						'사은품지급 은행메모

  '부가서비스
  g_code_service1		= WORD_CHANGE(UploadForm("g_code_service1"),20)							'부가서비스1
  g_code_service2		= WORD_CHANGE(UploadForm("g_code_service2"),20)							'부가서비스1
  g_code_service3		= WORD_CHANGE(UploadForm("g_code_service3"),20)							'부가서비스1

  '약정
  g_code_promise1		= WORD_CHANGE(UploadForm("g_code_promise1"),20)						
  g_code_promise2		= WORD_CHANGE(UploadForm("g_code_promise2"),20)						
  g_code_promise3		= WORD_CHANGE(UploadForm("g_code_promise3"),20)						


  g_article_cnt1		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt1")),20)				'회선수1
  g_article_cnt2		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt2")),20)				'회선수2
  g_article_cnt3		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt3")),20)				'회선수3

  g_sum_money_chk		= WORD_CHANGE(UploadForm("g_sum_money_chk"),20)							'합산청구(A/B)
  g_sum_money_txt		= WORD_CHANGE(UploadForm("g_sum_money_txt"),100)							'합산청구 텍스트

  g_code_area			= WORD_CHANGE(money_chk(UploadForm("g_code_area")),20)					'지역

  g_move_tel1			= WORD_CHANGE(UploadForm("g_move_tel1"),20)
  g_move_name			= WORD_CHANGE(UploadForm("g_move_name"),40)
  g_move_jumin1			= WORD_CHANGE(UploadForm("g_move_jumin1"),20)
  g_move_jumin2			= WORD_CHANGE(UploadForm("g_move_jumin2"),20)
  g_move_date			= WORD_CHANGE(UploadForm("g_move_date"),20)
  g_move_tel2			= WORD_CHANGE(UploadForm("g_move_tel2"),20)
  g_move_company		= WORD_CHANGE(UploadForm("g_move_company"),20)
  g_move_memo			= WORD_CHANGE(UploadForm("g_move_memo"),100)

  '본사사은품
  g_sp_name_top1		= WORD_CHANGE(UploadForm("g_sp_name_top1"),40)							'본사 사은품 - 이름 
  g_sp_price_top1		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top1")),20)				'본사 사은품 - 금액

  g_sp_name_top2		= WORD_CHANGE(UploadForm("g_sp_name_top2"),40)							'본사 사은품 - 이름 
  g_sp_price_top2		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top2")),20)				'본사 사은품 - 금액

  g_sp_name_top3		= WORD_CHANGE(UploadForm("g_sp_name_top3"),40)							'본사 사은품 - 이름 
  g_sp_price_top3		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top3")),20)				'본사 사은품 - 금액


  goods_settop1_chk		= WORD_CHANGE(UploadForm("goods_settop1_chk"),40)
  goods_settop2_chk		= WORD_CHANGE(UploadForm("goods_settop2_chk"),40)

  g_article_idx2_4		= WORD_CHANGE(UploadForm("g_article_idx2_4"),20)						'고객 상품 상품명
  g_option_idx_4		= WORD_CHANGE(UploadForm("g_option_idx_4"),20)							'고객 상품 옵션
  g_code_sale4			= WORD_CHANGE(UploadForm("g_code_sale4"),20)							'고객 상품 할인탭 코드
  g_code_promise4		= WORD_CHANGE(UploadForm("g_code_promise4"),20)		
  g_code_service4		= WORD_CHANGE(UploadForm("g_code_service4"),20)							'부가서비스1
  g_article_cnt4		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt4")),20)				'회선수3
  g_sp_name4			= WORD_CHANGE(UploadForm("g_sp_name4"),40)		
  g_sp_price4			= WORD_CHANGE(money_chk(UploadForm("g_sp_price4")),20)					'본사 사은품 - 금액
  g_sp_date_start4		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start4")),20)			'사은품 정보 - 지급예정일
  g_sp_give_type4		= WORD_CHANGE(UploadForm("g_sp_give_type4"),20)							'사은품 정보 - 지급처선택
  g_sp_name_top4		= WORD_CHANGE(UploadForm("g_sp_name_top4"),40)	
  g_sp_price_top4		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top4")),20)				

  g_article_idx2_5		= WORD_CHANGE(UploadForm("g_article_idx2_5"),20)						'고객 상품 상품명
  g_option_idx_5		= WORD_CHANGE(UploadForm("g_option_idx_5"),20)							'고객 상품 옵션
  g_code_sale5			= WORD_CHANGE(UploadForm("g_code_sale5"),20)							'고객 상품 할인탭 코드
  g_code_promise5		= WORD_CHANGE(UploadForm("g_code_promise5"),20)		
  g_code_service5		= WORD_CHANGE(UploadForm("g_code_service5"),20)							'부가서비스1
  g_article_cnt5		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt5")),20)				'회선수3
  g_sp_name5			= WORD_CHANGE(UploadForm("g_sp_name5"),40)		
  g_sp_price5			= WORD_CHANGE(money_chk(UploadForm("g_sp_price5")),20)					'본사 사은품 - 금액
  g_sp_date_start5		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start5")),20)			'사은품 정보 - 지급예정일
  g_sp_give_type5		= WORD_CHANGE(UploadForm("g_sp_give_type5"),20)							'사은품 정보 - 지급처선택
  g_sp_name_top5		= WORD_CHANGE(UploadForm("g_sp_name_top5"),40)	
  g_sp_price_top5		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top5")),20)				


  g_code_combine1		= WORD_CHANGE(money_chk(UploadForm("g_code_combine1")),40)		
  g_code_combine2		= 0		
  g_code_combine3		= 0	
  g_code_combine4		= 0		
  g_code_combine5		= 0


  '블랙리스트 체크

  strSql = " select * from customer_goods_black where black_jumin1='"&c_jumin1&"' and black_jumin2='"&c_jumin2&"'"
  Set objRs=objCnn.execute(strSql)

  If objRs.eof Or objRs.bof Then
	black_type	= ""
  Else
	black_type	= objRs("black_type")

	If black_type="C" Then
		Alert " 입력하신 고객은 블랙리스트의 불량고객으로 등록되어 있으므로 청약을 받지 않는 고객입니다."
		win_close()
	End if
  End If

  '초기 개통상태 자동 입력 
  strSql = "select * from code_gaetong where gaetong_default='Y'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	g_code_gaetong_idx = ""
  Else
	g_code_gaetong_idx = objRs("gaetong_code")
  End if

  strSql = " select m_dealer_code from emp_list where  m_id='"&g_yuchi_m_id&"'"
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

			filename4	= strfilename
			strfilename	= DIR_O_CODE &"/"& strfilename
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
	If g_file11<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file44
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME4=CSTR(yea)+cstr(mon)+"/"+filename4
  end if 

    strSql = "set nocount on SET ANSI_WARNINGS off "
	strSql = strSql & " INSERT INTO customer_goods (g_o_code, c_name, c_type, c_jumin1,c_jumin2, c_office_no,"
	strSql = strSql & " c_office_name, c_zipcode1, c_zipcode2, c_address, c_tel1, c_tel2, c_tel2_com, c_tel3, c_email, c_jumin_date, "
	strSql = strSql & " g_yuchi_m_id, g_jupsu_m_id, g_article_idx1, g_set, c_auth_chk, "
	strSql = strSql & " g_article_idx2, g_option_idx, g_code_promise, g_code_course_idx, g_date_yuchi, "
	strSql = strSql & " g_code_sale, g_zipcode1, g_zipcode2, g_address, g_bank_cd, "
	strSql = strSql & " g_bank_no, g_bank_name, g_sp_name, g_sp_price, g_sp_name_top, g_sp_price_top, g_sp_date_start, "
	strSql = strSql & " g_bigo,g_trans_in_dealer, "
	strSql = strSql & " g_bank_jumin1, "
	strSql = strSql & " g_bank_jumin2, g_give_type, g_give_chk, "
	strSql = strSql & " g_card_cd, g_card_no, g_card_gigan, g_card_gigan1, g_card_name, g_card_jumin1, g_card_jumin2, "
	strSql = strSql & " g_sp_give_type,g_file1, g_file2, g_file3, g_file4,   "
	strSql = strSql & " g_sp_bank_code, g_sp_bank_acount, g_sp_bank_name, g_sp_bank_memo, g_sp_bank_jumin1, g_sp_bank_jumin2, g_code_gaetong_idx, "
	strSql = strSql & " g_code_service, g_article_cnt, g_sum_money_chk, g_sum_money_txt, g_code_area, "
	strSql = strSql & " g_move_tel1,g_move_name,g_move_jumin1,g_move_jumin2,g_move_date,g_move_tel2,g_move_company,g_move_memo, g_code_combine, "
	strSql = strSql & " g_writeday ) values "
	strSql = strSql & " ('"& o_code &"' "
	strSql = strSql & ", '"& c_name &"'"
	strSql = strSql & ", '"& c_type &"'"
	strSql = strSql & ", '"& c_jumin1 &"'"
	strSql = strSql & ", '"& c_jumin2 &"'"
	strSql = strSql & ", '"& c_office_no &"'"
	strSql = strSql & ", '"& c_office_name &"'"
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_tel1 &"'"
	strSql = strSql & ", '"& c_tel2 &"'"
	strSql = strSql & ", '"& c_tel2_com &"'"
	strSql = strSql & ", '"& c_tel3 &"'"
	strSql = strSql & ", '"& c_email &"'"
	strSql = strSql & ", '"& c_jumin_date &"'"
	strSql = strSql & ", '"& g_yuchi_m_id &"' "
	strSql = strSql & ", '"& g_jupsu_m_id &"' "
	strSql = strSql & ",  "& g_article_idx1 &" "
	strSql = strSql & ", '"& g_set &"'"
	strSql = strSql & ", '"& c_auth_chk &"'"
	strSql = strSql & ",  "& g_article_idx2 &""
	strSql = strSql & ",  "& g_option_idx &" "
	strSql = strSql & ",  "& g_code_promise1 &" "
	strSql = strSql & ", '"& g_code_course_idx &"' "
	strSql = strSql & ", getdate() "	
	strSql = strSql & ",  "& g_code_sale &"  "
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_bank_cd &"'"
	strSql = strSql & ", '"& c_bank_no &"'"
	strSql = strSql & ", '"& c_bank_name &"'"
	strSql = strSql & ", '"& g_sp_name &"'"
	strSql = strSql & ", "& g_sp_price &" "


	strSql = strSql & ", '"& g_sp_name_top1 &"'"
	strSql = strSql & ", "& g_sp_price_top1 &" "
			
	If g_sp_date_start="null" then
	strSql = strSql & ",  "& g_sp_date_start &"  "	
	Else
	strSql = strSql & ",  '"& g_sp_date_start &"'  "	
	End If

	strSql = strSql & ", '"& g_bigo &"'"
	strSql = strSql & ", '"& g_trans_in_dealer &"'"

	strSql = strSql & ", '"& c_bank_jumin1 &"'"
	strSql = strSql & ", '"& c_bank_jumin2 &"'"
	strSql = strSql & ", '"& g_give_type &"'"
	strSql = strSql & ", '"& g_give_chk &"'"
	strSql = strSql & ",  "& c_card_cd &" "
	strSql = strSql & ", '"& g_card_no &"'"
	strSql = strSql & ", '"& g_card_gigan &"'"
	strSql = strSql & ", '"& g_card_gigan1 &"'"
	strSql = strSql & ", '"& g_card_name &"'"
	strSql = strSql & ", '"& g_card_jumin1 &"'"
	strSql = strSql & ", '"& g_card_jumin2 &"'"
	strSql = strSql & ", '"& g_sp_give_type &"'"		
	strSql = strSql & ", '"& FILENAME1 &"'"
	strSql = strSql & ", '"& FILENAME2 &"'"
	strSql = strSql & ", '"& FILENAME3 &"'"
	strSql = strSql & ", '"& FILENAME4 &"'"
	strSql = strSql & ",  "& g_sp_bank_code &" "
	strSql = strSql & ", '"& g_sp_bank_acount &"'"
	strSql = strSql & ", '"& g_sp_bank_name &"'"
	strSql = strSql & ", '"& g_sp_bank_memo &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin2 &"'"

	strSql = strSql & ", '"& g_code_gaetong_idx &"'"
	strSql = strSql & ", '"& g_code_service1 &"'"
	strSql = strSql & ",  "& g_article_cnt1 &" "
	strSql = strSql & ", '"& g_sum_money_chk &"'"
	strSql = strSql & ", '"& g_sum_money_txt &"'"
	strSql = strSql & ",  "& g_code_area &" "

	strSql = strSql & ", '"& g_move_tel1 &"'"
	strSql = strSql & ", '"& g_move_name &"'"
	strSql = strSql & ", '"& g_move_jumin1 &"'"
	strSql = strSql & ", '"& g_move_jumin2 &"'"
	strSql = strSql & ", '"& g_move_date &"'"
	strSql = strSql & ", '"& g_move_tel2 &"'"
	strSql = strSql & ", '"& g_move_company &"'"
	strSql = strSql & ", '"& g_move_memo &"'"
	strSql = strSql & ",  "& g_code_combine1 &" "
	strSql = strSql & ", Getdate());SELECT @@IDENTITY "	
	'response.write strSql
    Set objRs=objCnn.Execute(strSql)

	g_goods_idx = objRs(0)
	g_goods_ref = g_goods_idx


	strSql = "update customer_goods set g_goods_ref="&g_goods_idx&" where g_goods_idx="&g_goods_idx
	Set objRs=objcnn.Execute(strSql)
	

	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&g_yuchi_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

  '------------------ 자동정산 로직 ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'딜러코드
	c_g_article_idx2		= g_article_idx2		'상품
	c_g_option_idx			= g_option_idx			'상품옵션
	c_g_code_promise_idx	= g_code_promise1		'상품약정
	c_g_sp_give_type		= g_sp_give_type		'사은품 유치자 지급
	c_g_code_sale			= g_code_sale			'할인탭
	c_g_sp_price			= g_sp_price			'사은품
	c_g_article_cnt			= g_article_cnt1		'회선수1
	c_g_sp_price_top		= g_sp_price_top1		'본사사은품

  %>
	<!--#include virtual="/customer/a_charge_set.asp"--> 
  <%

	If goods_cnt="2" Or goods_cnt="3" Then
    strSql = "set nocount on SET ANSI_WARNINGS off "		
	strSql = strSql & " INSERT INTO customer_goods (g_goods_ref,g_o_code,c_name, c_type, c_jumin1,c_jumin2, c_office_no, "
	strSql = strSql & " c_office_name, c_zipcode1, c_zipcode2, c_address, c_tel1, c_tel2, c_tel2_com, c_tel3, c_email, c_jumin_date, "
	strSql = strSql & " g_yuchi_m_id, g_jupsu_m_id, g_article_idx1, g_set, c_auth_chk, "
	strSql = strSql & " g_article_idx2, g_option_idx, g_code_promise, g_code_course_idx, g_date_yuchi, "
	strSql = strSql & " g_code_sale, g_zipcode1, g_zipcode2, g_address, g_bank_cd, "
	strSql = strSql & " g_bank_no, g_bank_name, "
	strSql = strSql & " g_bigo, g_trans_in_dealer, g_bank_jumin1, "
	strSql = strSql & " g_sp_name, g_sp_price, g_sp_name_top, g_sp_price_top, g_sp_date_start, g_sp_give_type, "
	strSql = strSql & " g_bank_jumin2, g_give_type, g_give_chk, "
	strSql = strSql & " g_card_cd, g_card_no, g_card_gigan, g_card_gigan1, g_card_name, g_card_jumin1, g_card_jumin2, "
	strSql = strSql & " g_sp_bank_code, g_sp_bank_acount, g_sp_bank_name, g_sp_bank_memo, g_sp_bank_jumin1, g_sp_bank_jumin2, g_code_gaetong_idx, "
	strSql = strSql & " g_code_service, g_article_cnt, g_sum_money_chk, g_sum_money_txt, g_code_area, "

	strSql = strSql & " g_move_tel1,g_move_name,g_move_jumin1,g_move_jumin2,g_move_date,g_move_tel2,g_move_company,g_move_memo, g_code_combine, "
	
	strSql = strSql & " g_writeday ) values "
	strSql = strSql & " ( "& g_goods_ref &" "
	strSql = strSql & ", '"& o_code &"' "
	strSql = strSql & ", '"& c_name &"'"
	strSql = strSql & ", '"& c_type &"'"
	strSql = strSql & ", '"& c_jumin1 &"'"
	strSql = strSql & ", '"& c_jumin2 &"'"
	strSql = strSql & ", '"& c_office_no &"'"
	strSql = strSql & ", '"& c_office_name &"'"
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_tel1 &"'"
	strSql = strSql & ", '"& c_tel2 &"'"
	strSql = strSql & ", '"& c_tel2_com &"'"
	strSql = strSql & ", '"& c_tel3 &"'"
	strSql = strSql & ", '"& c_email &"'"
	strSql = strSql & ", '"& c_jumin_date &"'"
	strSql = strSql & ", '"& g_yuchi_m_id &"' "
	strSql = strSql & ", '"& g_jupsu_m_id &"' "
	strSql = strSql & ",  "& g_article_idx1_1 &" "
	strSql = strSql & ", '"& g_set &"'"
	strSql = strSql & ", '"& c_auth_chk &"'"
	strSql = strSql & ",  "& g_article_idx2_1 &""
	strSql = strSql & ",  "& g_option_idx_1 &" "
	strSql = strSql & ",  "& g_code_promise2 &" "
	strSql = strSql & ", '"& g_code_course_idx &"' "
	strSql = strSql & ", getdate() "	
	strSql = strSql & ",  "& g_code_sale1 &" "
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_bank_cd &"'"
	strSql = strSql & ", '"& c_bank_no &"'"
	strSql = strSql & ", '"& c_bank_name &"'"
	strSql = strSql & ", '"& g_bigo &"'"
	strSql = strSql & ", '"& g_trans_in_dealer &"'"
	strSql = strSql & ", '"& c_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_name1 &"'"
	strSql = strSql & ",  "& g_sp_price1 &" "

	strSql = strSql & ", '"& g_sp_name_top2 &"'"
	strSql = strSql & ", "& g_sp_price_top2 &" "
				
	If g_sp_date_start1="null" then
	strSql = strSql & ",  "& g_sp_date_start1 &"  "	
	Else
	strSql = strSql & ",  '"& g_sp_date_start1 &"'  "	
	End If

	strSql = strSql & ", '"& g_sp_give_type1 &"' "	

	strSql = strSql & ", '"& c_bank_jumin2 &"'"
	strSql = strSql & ", '"& g_give_type &"'"
	strSql = strSql & ", '"& g_give_chk &"'"

	strSql = strSql & ",  "& c_card_cd &" "
	strSql = strSql & ", '"& g_card_no &"'"
	strSql = strSql & ", '"& g_card_gigan &"'"
	strSql = strSql & ", '"& g_card_gigan1 &"'"
	strSql = strSql & ", '"& g_card_name &"'"
	strSql = strSql & ", '"& g_card_jumin1 &"'"
	strSql = strSql & ", '"& g_card_jumin2 &"'"
	strSql = strSql & ",  "& g_sp_bank_code &" "
	strSql = strSql & ", '"& g_sp_bank_acount &"'"
	strSql = strSql & ", '"& g_sp_bank_name &"'"
	strSql = strSql & ", '"& g_sp_bank_memo &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin2 &"'"

	strSql = strSql & ", '"& g_code_gaetong_idx &"'"
	strSql = strSql & ", '"& g_code_service2 &"'"
	strSql = strSql & ",  "& g_article_cnt2 &" "
	strSql = strSql & ", '"& g_sum_money_chk &"'"
	strSql = strSql & ", '"& g_sum_money_txt &"'"
	strSql = strSql & ",  "& g_code_area &" "

	strSql = strSql & ", '"& g_move_tel1 &"'"
	strSql = strSql & ", '"& g_move_name &"'"
	strSql = strSql & ", '"& g_move_jumin1 &"'"
	strSql = strSql & ", '"& g_move_jumin2 &"'"
	strSql = strSql & ", '"& g_move_date &"'"
	strSql = strSql & ", '"& g_move_tel2 &"'"
	strSql = strSql & ", '"& g_move_company &"'"
	strSql = strSql & ", '"& g_move_memo &"'"
	strSql = strSql & ",  "& g_code_combine2 &" "

	strSql = strSql & ", Getdate());SELECT @@IDENTITY "	
    Set objRs=objCnn.Execute(strSql)
   
	g_goods_idx = objRs(0)

 	'개통상태 이력 추가

	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&g_yuchi_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

  '------------------ 자동정산 로직 ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'딜러코드
	c_g_article_idx2		= g_article_idx2_1		'상품
	c_g_option_idx			= g_option_idx_1		'상품옵션
	c_g_code_promise_idx	= g_code_promise2		'상품약정
	c_g_sp_give_type		= g_sp_give_type1		'사은품 유치자 지급
	c_g_code_sale			= g_code_sale1			'할인탭
	c_g_sp_price			= g_sp_price1
	c_g_article_cnt			= g_article_cnt2		'회선수2
	c_g_sp_price_top		= g_sp_price_top2		'본사사은품

  %>
	<!--#include virtual="/customer/a_charge_set.asp"--> 
  <%
	End if
  
	If goods_cnt="3" Then
    strSql = "set nocount on SET ANSI_WARNINGS off "
	strSql = strSql & " INSERT INTO customer_goods (g_goods_ref, g_o_code, c_name, c_type, c_jumin1,c_jumin2, c_office_no, "
	strSql = strSql & " c_office_name, c_zipcode1, c_zipcode2, c_address, c_tel1, c_tel2, c_tel2_com, c_tel3, c_email, c_jumin_date, "
	strSql = strSql & " g_yuchi_m_id, g_jupsu_m_id, g_article_idx1, g_set, c_auth_chk, "
	strSql = strSql & " g_article_idx2, g_option_idx, g_code_promise, g_code_course_idx, g_date_yuchi, "
	strSql = strSql & " g_code_sale, g_zipcode1, g_zipcode2, g_address, g_bank_cd, "
	strSql = strSql & " g_bank_no, g_bank_name, "
	strSql = strSql & " g_bigo,g_trans_in_dealer, g_bank_jumin1, "
	strSql = strSql & " g_sp_name, g_sp_price, g_sp_name_top, g_sp_price_top, g_sp_date_start,  g_sp_give_type, "
	strSql = strSql & " g_bank_jumin2, g_give_type, g_give_chk, "
	strSql = strSql & " g_card_cd, g_card_no, g_card_gigan, g_card_gigan1, g_card_name, g_card_jumin1, g_card_jumin2, "
	strSql = strSql & " g_sp_bank_code, g_sp_bank_acount, g_sp_bank_name, g_sp_bank_memo, g_sp_bank_jumin1, g_sp_bank_jumin2, g_code_gaetong_idx, "
	strSql = strSql & " g_code_service, g_article_cnt, g_sum_money_chk, g_sum_money_txt, g_code_area, "

	strSql = strSql & " g_move_tel1,g_move_name,g_move_jumin1,g_move_jumin2,g_move_date,g_move_tel2,g_move_company,g_move_memo, g_code_combine, "
	
	strSql = strSql & " g_writeday ) values "
	strSql = strSql & " ( "& g_goods_ref &" "
	strSql = strSql & ", '"& o_code &"' "
	strSql = strSql & ", '"& c_name &"'"
	strSql = strSql & ", '"& c_type &"'"
	strSql = strSql & ", '"& c_jumin1 &"'"
	strSql = strSql & ", '"& c_jumin2 &"'"
	strSql = strSql & ", '"& c_office_no &"'"
	strSql = strSql & ", '"& c_office_name &"'"
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_tel1 &"'"
	strSql = strSql & ", '"& c_tel2 &"'"
	strSql = strSql & ", '"& c_tel2_com &"'"
	strSql = strSql & ", '"& c_tel3 &"'"
	strSql = strSql & ", '"& c_email &"'"
	strSql = strSql & ", '"& c_jumin_date &"'"
	strSql = strSql & ", '"& g_yuchi_m_id &"' "
	strSql = strSql & ", '"& g_jupsu_m_id &"' "
	strSql = strSql & ",  "& g_article_idx1_2 &" "
	strSql = strSql & ", '"& g_set &"'"
	strSql = strSql & ", '"& c_auth_chk &"'"
	strSql = strSql & ",  "& g_article_idx2_2 &""
	strSql = strSql & ",  "& g_option_idx_2 &" "
	strSql = strSql & ",  "& g_code_promise3 &" "
	strSql = strSql & ", '"& g_code_course_idx &"' "
	strSql = strSql & ", getdate() "	
	strSql = strSql & ",  "& g_code_sale2 &" "
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_bank_cd &"'"
	strSql = strSql & ", '"& c_bank_no &"'"
	strSql = strSql & ", '"& c_bank_name &"'"
	strSql = strSql & ", '"& g_bigo &"'"
	strSql = strSql & ", '"& g_trans_in_dealer &"'"
	strSql = strSql & ", '"& c_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_name2 &"'"
	strSql = strSql & ",  "& g_sp_price2 &" "
	
	strSql = strSql & ", '"& g_sp_name_top3 &"'"
	strSql = strSql & ", "& g_sp_price_top3 &" "
		
	If g_sp_date_start2="null" then
	strSql = strSql & ",  "& g_sp_date_start2 &"  "	
	Else
	strSql = strSql & ",  '"& g_sp_date_start2 &"'  "	
	End If

	strSql = strSql & ", '"& g_sp_give_type2 &"'"	
	strSql = strSql & ", '"& c_bank_jumin2 &"'"
	strSql = strSql & ", '"& g_give_type &"'"
	strSql = strSql & ", '"& g_give_chk &"'"
	strSql = strSql & ",  "& c_card_cd &" "
	strSql = strSql & ", '"& g_card_no &"'"
	strSql = strSql & ", '"& g_card_gigan &"'"
	strSql = strSql & ", '"& g_card_gigan1 &"'"
	strSql = strSql & ", '"& g_card_name &"'"
	strSql = strSql & ", '"& g_card_jumin1 &"'"
	strSql = strSql & ", '"& g_card_jumin2 &"'"
	strSql = strSql & ",  "& g_sp_bank_code &" "
	strSql = strSql & ", '"& g_sp_bank_acount &"'"
	strSql = strSql & ", '"& g_sp_bank_name &"'"
	strSql = strSql & ", '"& g_sp_bank_memo &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin2 &"'"

	strSql = strSql & ", '"& g_code_gaetong_idx &"'"
	strSql = strSql & ", '"& g_code_service3 &"'"
	strSql = strSql & ",  "& g_article_cnt3 &" "
	strSql = strSql & ", '"& g_sum_money_chk &"'"
	strSql = strSql & ", '"& g_sum_money_txt &"'"
	strSql = strSql & ",  "& g_code_area &" "

	strSql = strSql & ", '"& g_move_tel1 &"'"
	strSql = strSql & ", '"& g_move_name &"'"
	strSql = strSql & ", '"& g_move_jumin1 &"'"
	strSql = strSql & ", '"& g_move_jumin2 &"'"
	strSql = strSql & ", '"& g_move_date &"'"
	strSql = strSql & ", '"& g_move_tel2 &"'"
	strSql = strSql & ", '"& g_move_company &"'"
	strSql = strSql & ", '"& g_move_memo &"'"
	strSql = strSql & ",  "& g_code_combine3 &" "

	strSql = strSql & ", Getdate());SELECT @@IDENTITY "	
    Set objRs=objCnn.Execute(strSql)

	g_goods_idx = objRs(0)

 	'개통상태 이력 추가

	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&g_yuchi_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

  '------------------ 자동정산 로직 ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'딜러코드
	c_g_article_idx2		= g_article_idx2_2		'상품
	c_g_option_idx			= g_option_idx_2		'상품옵션
	c_g_code_promise_idx	= g_code_promise3		'상품약정
	c_g_sp_give_type		= g_sp_give_type2		'사은품 유치자 지급
	c_g_code_sale			= g_code_sale2			'할인탭
	c_g_sp_price			= g_sp_price2			'사은품
	c_g_article_cnt			= g_article_cnt3		'회선수3
	c_g_sp_price_top		= g_sp_price_top3		'본사사은품

  %>
	<!--#include virtual="/customer/a_charge_set.asp"--> 
  <%
  End If
  

  If goods_settop1_chk="A" Then

    strSql = "set nocount on SET ANSI_WARNINGS off "
	strSql = strSql & " INSERT INTO customer_goods (g_goods_ref, g_o_code, c_name, c_type, c_jumin1,c_jumin2, c_office_no, "
	strSql = strSql & " c_office_name, c_zipcode1, c_zipcode2, c_address, c_tel1, c_tel2, c_tel2_com, c_tel3, c_email, c_jumin_date, "
	strSql = strSql & " g_yuchi_m_id, g_jupsu_m_id, g_article_idx1, g_set, c_auth_chk, "
	strSql = strSql & " g_article_idx2, g_option_idx, g_code_promise, g_code_course_idx, g_date_yuchi, "
	strSql = strSql & " g_code_sale, g_zipcode1, g_zipcode2, g_address, g_bank_cd, "
	strSql = strSql & " g_bank_no, g_bank_name, "
	strSql = strSql & " g_bigo,g_trans_in_dealer, g_bank_jumin1, "
	strSql = strSql & " g_sp_name, g_sp_price, g_sp_name_top, g_sp_price_top, g_sp_date_start,  g_sp_give_type, "
	strSql = strSql & " g_bank_jumin2, g_give_type,  g_give_chk, "
	strSql = strSql & " g_card_cd, g_card_no, g_card_gigan, g_card_gigan1, g_card_name, g_card_jumin1, g_card_jumin2,  "
	strSql = strSql & " g_sp_bank_code, g_sp_bank_acount, g_sp_bank_name, g_sp_bank_memo,  g_sp_bank_jumin1, g_sp_bank_jumin2, g_code_gaetong_idx, "
	strSql = strSql & " g_code_service, g_article_cnt, g_sum_money_chk, g_sum_money_txt, g_code_area, "
	strSql = strSql & " g_move_tel1,g_move_name,g_move_jumin1,g_move_jumin2,g_move_date,g_move_tel2,g_move_company,g_move_memo, goods_settop1_chk, g_code_combine, "
	strSql = strSql & " g_writeday ) values "
	strSql = strSql & " ( "& g_goods_ref &" "
	strSql = strSql & ", '"& session_o_code &"' "
	strSql = strSql & ", '"& c_name &"'"
	strSql = strSql & ", '"& c_type &"'"
	strSql = strSql & ", '"& c_jumin1 &"'"
	strSql = strSql & ", '"& c_jumin2 &"'"
	strSql = strSql & ", '"& c_office_no &"'"
	strSql = strSql & ", '"& c_office_name &"'"
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_tel1 &"'"
	strSql = strSql & ", '"& c_tel2 &"'"
	strSql = strSql & ", '"& c_tel2_com &"'"
	strSql = strSql & ", '"& c_tel3 &"'"
	strSql = strSql & ", '"& c_email &"'"
	strSql = strSql & ", '"& c_jumin_date &"'"
	strSql = strSql & ", '"& g_yuchi_m_id &"' "
	strSql = strSql & ", '"& g_jupsu_m_id &"' "
	strSql = strSql & ",  "& g_article_idx1 &" "
	strSql = strSql & ", '"& g_set &"'"
	strSql = strSql & ", '"& c_auth_chk &"'"
	strSql = strSql & ",  "& g_article_idx2_4 &""
	strSql = strSql & ",  "& g_option_idx_4 &" "
	strSql = strSql & ",  "& g_code_promise4 &" "
	strSql = strSql & ", '"& g_code_course_idx &"' "
	strSql = strSql & ", getdate() "	
	strSql = strSql & ",  "& g_code_sale4 &" "
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_bank_cd &"'"
	strSql = strSql & ", '"& c_bank_no &"'"
	strSql = strSql & ", '"& c_bank_name &"'"
	strSql = strSql & ", '"& g_bigo &"'"
	strSql = strSql & ", '"& g_trans_in_dealer &"'"
	strSql = strSql & ", '"& c_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_name4 &"'"
	strSql = strSql & ",  "& g_sp_price4 &" "

	strSql = strSql & ", '"& g_sp_name_top4 &"'"
	strSql = strSql & ", "& g_sp_price_top4 &" "
			
	If g_sp_date_start4="null" then
	strSql = strSql & ",  "& g_sp_date_start4 &"  "	
	Else
	strSql = strSql & ",  '"& g_sp_date_start4 &"'  "	
	End If

	strSql = strSql & ", '"& g_sp_give_type4 &"'"	

	strSql = strSql & ", '"& c_bank_jumin2 &"'"
	strSql = strSql & ", '"& g_give_type &"'"
	strSql = strSql & ", '"& g_give_chk &"'"
	strSql = strSql & ",  "& c_card_cd &" "
	strSql = strSql & ", '"& g_card_no &"'"
	strSql = strSql & ", '"& g_card_gigan &"'"
	strSql = strSql & ", '"& g_card_gigan1 &"'"
	strSql = strSql & ", '"& g_card_name &"'"
	strSql = strSql & ", '"& g_card_jumin1 &"'"
	strSql = strSql & ", '"& g_card_jumin2 &"'"
	strSql = strSql & ",  "& g_sp_bank_code &" "
	strSql = strSql & ", '"& g_sp_bank_acount &"'"
	strSql = strSql & ", '"& g_sp_bank_name &"'"
	strSql = strSql & ", '"& g_sp_bank_memo &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin2 &"'"

	strSql = strSql & ", '"& g_code_gaetong_idx &"'"
	strSql = strSql & ", '"& g_code_service4 &"'"
	strSql = strSql & ",  "& g_article_cnt4&" "
	strSql = strSql & ", '"& g_sum_money_chk &"'"
	strSql = strSql & ", '"& g_sum_money_txt &"'"
	strSql = strSql & ",  "& g_code_area &" "
	strSql = strSql & ", '"& g_move_tel1 &"'"
	strSql = strSql & ", '"& g_move_name &"'"
	strSql = strSql & ", '"& g_move_jumin1 &"'"
	strSql = strSql & ", '"& g_move_jumin2 &"'"
	strSql = strSql & ", '"& g_move_date &"'"
	strSql = strSql & ", '"& g_move_tel2 &"'"
	strSql = strSql & ", '"& g_move_company &"'"
	strSql = strSql & ", '"& g_move_memo &"'"
	strSql = strSql & ", 'O'"
	strSql = strSql & ",  "& g_code_combine4 &" "

	strSql = strSql & ", Getdate());SELECT @@IDENTITY "	
    Set objRs=objCnn.Execute(strSql)
  
	g_goods_idx = objRs(0)
  
	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&session_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

   '------------------ 자동정산 로직 ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'딜러코드
	c_g_article_idx2		= g_article_idx2_4		'상품
	c_g_option_idx			= g_option_idx_4		'상품옵션
	c_g_code_promise_idx	= g_code_promise4		'상품약정
	c_g_sp_give_type		= g_sp_give_type4		'사은품 유치자 지급
	c_g_code_sale			= g_code_sale4			'할인탭
	c_g_sp_price			= g_sp_price4			'사은품
	c_g_article_cnt			= g_article_cnt4		'회선수1
	c_g_sp_price_top		= g_sp_price_top4		'본사사은품

  %>
  <!--#include virtual="/customer/a_charge_set.asp"--> 
  <%
  End If
  
  If goods_settop2_chk="A" Then


    strSql = "set nocount on SET ANSI_WARNINGS off "
	strSql = strSql & " INSERT INTO customer_goods (g_goods_ref, g_o_code, c_name, c_type, c_jumin1,c_jumin2, c_office_no, "
	strSql = strSql & " c_office_name, c_zipcode1, c_zipcode2, c_address, c_tel1, c_tel2, c_tel2_com, c_tel3, c_email, c_jumin_date, "
	strSql = strSql & " g_yuchi_m_id, g_jupsu_m_id, g_article_idx1, g_set, c_auth_chk, "
	strSql = strSql & " g_article_idx2, g_option_idx, g_code_promise, g_code_course_idx, g_date_yuchi, "
	strSql = strSql & " g_code_sale, g_zipcode1, g_zipcode2, g_address, g_bank_cd, "
	strSql = strSql & " g_bank_no, g_bank_name, "
	strSql = strSql & " g_bigo,g_trans_in_dealer, g_bank_jumin1, "
	strSql = strSql & " g_sp_name, g_sp_price, g_sp_name_top, g_sp_price_top, g_sp_date_start,  g_sp_give_type, "
	strSql = strSql & " g_bank_jumin2, g_give_type,  g_give_chk, "
	strSql = strSql & " g_card_cd, g_card_no, g_card_gigan, g_card_gigan1, g_card_name, g_card_jumin1, g_card_jumin2,  "
	strSql = strSql & " g_sp_bank_code, g_sp_bank_acount, g_sp_bank_name, g_sp_bank_memo,  g_sp_bank_jumin1, g_sp_bank_jumin2, g_code_gaetong_idx, "
	strSql = strSql & " g_code_service, g_article_cnt, g_sum_money_chk, g_sum_money_txt, g_code_area, "
	strSql = strSql & " g_move_tel1,g_move_name,g_move_jumin1,g_move_jumin2,g_move_date,g_move_tel2,g_move_company,g_move_memo, goods_settop2_chk, g_code_combine, "
	strSql = strSql & " g_writeday ) values "
	strSql = strSql & " ( "& g_goods_ref &" "
	strSql = strSql & ", '"& session_o_code &"' "
	strSql = strSql & ", '"& c_name &"'"
	strSql = strSql & ", '"& c_type &"'"
	strSql = strSql & ", '"& c_jumin1 &"'"
	strSql = strSql & ", '"& c_jumin2 &"'"
	strSql = strSql & ", '"& c_office_no &"'"
	strSql = strSql & ", '"& c_office_name &"'"
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_tel1 &"'"
	strSql = strSql & ", '"& c_tel2 &"'"
	strSql = strSql & ", '"& c_tel2_com &"'"
	strSql = strSql & ", '"& c_tel3 &"'"
	strSql = strSql & ", '"& c_email &"'"
	strSql = strSql & ", '"& c_jumin_date &"'"
	strSql = strSql & ", '"& g_yuchi_m_id &"' "
	strSql = strSql & ", '"& g_jupsu_m_id &"' "
	strSql = strSql & ",  "& g_article_idx1 &" "
	strSql = strSql & ", '"& g_set &"'"
	strSql = strSql & ", '"& c_auth_chk &"'"
	strSql = strSql & ",  "& g_article_idx2_5 &""
	strSql = strSql & ",  "& g_option_idx_5 &" "
	strSql = strSql & ",  "& g_code_promise5 &" "
	strSql = strSql & ", '"& g_code_course_idx &"' "
	strSql = strSql & ", getdate() "	
	strSql = strSql & ",  "& g_code_sale5 &" "
	strSql = strSql & ", '"& c_zipcode1 &"'"
	strSql = strSql & ", '"& c_zipcode2 &"'"
	strSql = strSql & ", '"& c_address &"'"
	strSql = strSql & ", '"& c_bank_cd &"'"
	strSql = strSql & ", '"& c_bank_no &"'"
	strSql = strSql & ", '"& c_bank_name &"'"
	strSql = strSql & ", '"& g_bigo &"'"
	strSql = strSql & ", '"& g_trans_in_dealer &"'"
	strSql = strSql & ", '"& c_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_name4 &"'"
	strSql = strSql & ",  "& g_sp_price4 &" "

	strSql = strSql & ", '"& g_sp_name_top5 &"'"
	strSql = strSql & ", "& g_sp_price_top5 &" "
			
	If g_sp_date_start5="null" then
	strSql = strSql & ",  "& g_sp_date_start5 &"  "	
	Else
	strSql = strSql & ",  '"& g_sp_date_start5 &"'  "	
	End If

	strSql = strSql & ", '"& g_sp_give_type5 &"'"	

	strSql = strSql & ", '"& c_bank_jumin2 &"'"
	strSql = strSql & ", '"& g_give_type &"'"
	strSql = strSql & ", '"& g_give_chk &"'"
	strSql = strSql & ",  "& c_card_cd &" "
	strSql = strSql & ", '"& g_card_no &"'"
	strSql = strSql & ", '"& g_card_gigan &"'"
	strSql = strSql & ", '"& g_card_gigan1 &"'"
	strSql = strSql & ", '"& g_card_name &"'"
	strSql = strSql & ", '"& g_card_jumin1 &"'"
	strSql = strSql & ", '"& g_card_jumin2 &"'"
	strSql = strSql & ",  "& g_sp_bank_code &" "
	strSql = strSql & ", '"& g_sp_bank_acount &"'"
	strSql = strSql & ", '"& g_sp_bank_name &"'"
	strSql = strSql & ", '"& g_sp_bank_memo &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin1 &"'"
	strSql = strSql & ", '"& g_sp_bank_jumin2 &"'"

	strSql = strSql & ", '"& g_code_gaetong_idx &"'"
	strSql = strSql & ", '"& g_code_service5 &"'"
	strSql = strSql & ",  "& g_article_cnt5&" "
	strSql = strSql & ", '"& g_sum_money_chk &"'"
	strSql = strSql & ", '"& g_sum_money_txt &"'"
	strSql = strSql & ",  "& g_code_area &" "
	strSql = strSql & ", '"& g_move_tel1 &"'"
	strSql = strSql & ", '"& g_move_name &"'"
	strSql = strSql & ", '"& g_move_jumin1 &"'"
	strSql = strSql & ", '"& g_move_jumin2 &"'"
	strSql = strSql & ", '"& g_move_date &"'"
	strSql = strSql & ", '"& g_move_tel2 &"'"
	strSql = strSql & ", '"& g_move_company &"'"
	strSql = strSql & ", '"& g_move_memo &"'"
	strSql = strSql & ", 'O'"
	strSql = strSql & ",  "& g_code_combine5 &" "

	strSql = strSql & ", Getdate());SELECT @@IDENTITY "	
    Set objRs=objCnn.Execute(strSql)
  
	g_goods_idx = objRs(0)
  
	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&session_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

   '------------------ 자동정산 로직 ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'딜러코드
	c_g_article_idx2		= g_article_idx2_5		'상품
	c_g_option_idx			= g_option_idx_5		'상품옵션
	c_g_code_promise_idx	= g_code_promise5		'상품약정
	c_g_sp_give_type		= g_sp_give_type5		'사은품 유치자 지급
	c_g_code_sale			= g_code_sale5			'할인탭
	c_g_sp_price			= g_sp_price5			'사은품
	c_g_article_cnt			= g_article_cnt5		'회선수1
	c_g_sp_price_top		= g_sp_price_top5		'본사사은품

  %>
  <!--#include virtual="/customer/a_charge_set.asp"--> 
  <%
  End If
    
  If black_type="A" Then
	  Alert " 입력하신 고객은 블랙리스트 고객으로 주의 고객 입니다. 참고해 주세요!\n\n 고객 상품이 되었습니다."
  ElseIf black_type="B" then
	  Alert " 입력하신 고객은 블랙리스트 고객으로 경고 고객 입니다. 참고해 주세요!\n\n 고객 상품이 등록되었습니다."
  else
	  Alert " 고객 상품이 등록되었습니다."
  End If
  win_close()
  %>