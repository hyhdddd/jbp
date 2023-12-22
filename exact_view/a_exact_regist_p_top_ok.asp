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
  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE
  
  e_title 			= WORD_CHANGE(UploadForm("e_title"),100)
  e_contents		= WORD_CHANGE(UploadForm("board_contents"),"E")

  e_exact_date1		= WORD_CHANGE(UploadForm("e_exact_date1"),20)  
  e_exact_date2		= WORD_CHANGE(UploadForm("e_exact_date2"),20)  
  e_exact_idx		= WORD_CHANGE(UploadForm("e_exact_idx"),20)
  e_charge_chk		= WORD_CHANGE(UploadForm("e_charge_chk"),20)
  e_dealer_code		= WORD_CHANGE(UploadForm("e_dealer_code"),20)
  tax_chk			= WORD_CHANGE(UploadForm("tax_chk"),20)
  s_date_start		= WORD_CHANGE(UploadForm("s_date_start"),20)
  s_date_end		= WORD_CHANGE(UploadForm("s_date_end"),20)
  date_chk			= WORD_CHANGE(UploadForm("date_chk"),20)
  s_dealer_code		= WORD_CHANGE(UploadForm("s_dealer_code"),20)
  s_gaetong_code	= WORD_CHANGE(UploadForm("s_gaetong_code"),20)
  exact_passwd		= WORD_CHANGE(UploadForm("exact_passwd"),40)
  g_yuchi_m_id		= WORD_CHANGE(UploadForm("g_yuchi_m_id"),20)
  e_exact_type		= WORD_CHANGE(UploadForm("e_exact_type"),20)

  tax_price_n		= WORD_CHANGE(money_chk(UploadForm("tax_price_n")),20)

  s_article_idx1	= WORD_CHANGE(money_chk(UploadForm("s_article_idx1")),20)
  s_article_idx2	= WORD_CHANGE(money_chk(UploadForm("s_article_idx2")),20)
  s_option_idx		= WORD_CHANGE(money_chk(UploadForm("s_option_idx")),20)

  If date_chk=""		Then	date_chk="0"			End If  

  charge_promise	= WORD_CHANGE(money_chk(UploadForm("charge_promise")),20)
  charge_sp_top		= WORD_CHANGE(money_chk(UploadForm("charge_sp_top")),20)
  charge_sp			= WORD_CHANGE(money_chk(UploadForm("charge_sp")),20)
  charge_sale		= WORD_CHANGE(money_chk(UploadForm("charge_sale")),20)
  charge_bundle		= WORD_CHANGE(money_chk(UploadForm("charge_bundle")),20)
  charge_buga		= WORD_CHANGE(money_chk(UploadForm("charge_buga")),20)
  charge_combine	= WORD_CHANGE(money_chk(UploadForm("charge_combine")),20)
  charge_document	= WORD_CHANGE(money_chk(UploadForm("charge_document")),20)
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

  '서버에 엑셀 파일 생성
  f_name		= "정산내역서(20"&Left(Create_code(),10)&")"	
  f_name_Ext	= "xls"
  strfilename	= f_name & "." & f_name_Ext 
  bExist=True 
  cntFile	    = 0

  do while bExist 
	if (FSO.FileExists(DIR_O_CODE&"/"&strfilename)) then
		cntfile			= cntfile+1
		strfilename		= f_name&"_"&cntfile&"."&f_name_Ext  
	else 
   		bExist=false
	end if
  Loop
 
  filename2=CSTR(yea)+cstr(mon)+"/"+strfilename

  f_name = DIR_O_CODE&"/"&strfilename

  set file=fso.CreateTextFile(f_name, true,true)

  file.WriteLine("<style type='text/css'>  ")
  file.WriteLine("<!--  ")
  file.WriteLine("A:link    {color:#000000;text-decoration:none;}  ")
  file.WriteLine("A:visited {color:#000000;text-decoration:none;}  ")
  file.WriteLine("A:active  {color:#000000;text-decoration:none;}  ")
  file.WriteLine("A:hover  {color:#8CC84B;text-decoration:none}  ")
  file.WriteLine(" ")
  file.WriteLine("body  ")
  file.WriteLine("{  ")
  file.WriteLine("scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff;  ")
  file.WriteLine("scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;  ")
  file.WriteLine("}  ")
  file.WriteLine("td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	")
  file.WriteLine("//-->  ")
  file.WriteLine("</style>  ")
  file.WriteLine("<body leftmargin=0 topmargin=0 bgcolor=#FFFFFF text=#000000>   ")

  file.WriteLine("<table width=100% cellspacing=1 cellpadding=0 border=1> ")
  file.WriteLine("<tr height='30'> ")
  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>정산종류</th>")
  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>고객명</th>")
  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>가입서비스</th>")
  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>상품명</th> ")
  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>상품옵션</th>")


  file.WriteLine("  <th bgcolor='gray' rowspan='2'>부가서비스</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>할인탭</th>")

  file.WriteLine("	<Th bgcolor='gray' rowspan='2'>셋트유형</th>")
  file.WriteLine("	<th bgcolor='gray' rowspan='2'>유치자</th>")
  file.WriteLine("	<th bgcolor='gray' rowspan='2'>접수일</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>개통일</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>상태</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>약정금액</th>")
  file.WriteLine("  <th bgcolor='gray' colspan='5'>차감내역</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>번들수수료</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>부가서비스</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>결합수수료</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>정산금액</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>정산예정일</th>")
  file.WriteLine("  <th bgcolor='gray' rowspan='2'>정산 비고</th>")

  file.WriteLine("</tr>  ")
  file.WriteLine("<tr height='30'>  ")
  file.WriteLine("  <th bgcolor='gray' width=70>본사사은품</th>")
  file.WriteLine("  <th bgcolor='gray' width=70>사은품</th>")
  file.WriteLine("  <th bgcolor='gray' width=70>할인탭</th>")
  file.WriteLine("  <th bgcolor='gray' width=70>미비서류</th>")
  file.WriteLine("  <th bgcolor='gray' width=70>기타</th>")
  file.WriteLine("</tr>  ")
	
 
  strSql = " Select H.g_charge_type, A.g_goods_idx as gg_idx, A.g_goods_idx, A.g_article_idx1, "
  strSql = strSql & " A.g_yuchi_m_id, A.g_date_yuchi, A.g_date_gaetong, A.g_service_no, M.dealer_name as dealer_name1,  "
  strSql = strSql & " A.g_writeday, G.dealer_name,  B.m_name as yuchi_name, A.g_article_cnt, "

  strSql = strSql & " H.g_charge_promise, H.g_charge_sp_top, H.g_charge_sp, H.g_charge_sale, H.g_charge_document, H.g_charge_gita, " 
  strSql = strSql & " H.g_charge_bundle, H.g_charge_buga, H.g_charge_combine, H.g_charge_bigo, H.g_charge_bigo_doc, H.g_charge_date1, H.g_charge_date1, H.g_charge_date2, " 

  strSql = strSql & " A.g_sp_name, A.g_sp_price, A.g_sp_give_type, A.g_sp_date_start, "
  strSql = strSql & " A.g_sp_date_end, C.article_name, D.article_name as article_name1,  "
  strSql = strSql & " E.gaetong_name, E.gaetong_color, A.c_name, O.service_name,  "
  strSql = strSql & " I.promise_name, J.sale_name , K.option_name, A.g_set "
  strSql = strSql & "		from customer_goods A full  "
  strSql = strSql & "			 join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx"
  strSql = strSql & " 		left join emp_list B ON A.g_yuchi_m_id=B.m_id "
  strSql = strSql & "		left join code_article C on A.g_article_idx1=C.article_idx "
  strSql = strSql & "		left join code_article D on A.g_article_idx2=D.article_idx "
  strSql = strSql & "		left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql = strSql & "		left join dealer_info G ON A.g_trans_in_dealer=G.dealer_code"
  strSql = strSql & "		left join code_promise I on A.g_code_promise=I.promise_idx"
  strSql = strSql & "		left join code_sale J on A.g_code_sale=J.sale_idx"
  strSql = strSql & "		left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql = strSql & "		left join dealer_info M ON A.g_trans_out_dealer=M.dealer_code"
  strSql = strSql & "		left join code_service O ON A.g_code_service=O.service_idx"
  strSql = strSql & "			where (A.g_yuchi_m_id='"& g_yuchi_m_id &"') "
				 
	'회사
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End if

	'상품
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'옵션
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If

	'개통
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'접수일
	If date_chk="1" Then
		strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
	End If

	'개통일
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'해약일
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'정산완료일
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If


	'정산예정일 + 미완료
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If		


  strSql = strSql & "						order by  A.g_date_yuchi Desc,g_goods_idx desc "
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  else
	
	i=1
	Do until objRs.EOF 
		g_goods_idx				= objRs("g_goods_idx")
		article_name			= objRs("article_name")
		article_name1			= objRs("article_name1")
		c_name					= objRs("c_name")								'고객명		
		g_charge_type_txt		= fnc_charge_type(objRs("g_charge_type"))
	
		gg_idx					= objRs("gg_idx")
		g_date_yuchi			= fnc_date_change(objRs("g_date_yuchi"))
		g_date_gaetong			= Left(objRs("g_date_gaetong"),10)
		g_writeday				= Left(objRs("g_writeday"),10)
		option_name				= objRs("option_name")
		dealer_name				= objRs("dealer_name")
		dealer_name1			= objRs("dealer_name1")								'인계처

		g_charge_promise		= money_chk(objRs("g_charge_promise"))
		g_charge_sp_top			= money_chk(objRs("g_charge_sp_top"))
		g_charge_sp				= money_chk(objRs("g_charge_sp"))
		g_charge_sale			= money_chk(objRs("g_charge_sale"))
		g_charge_document		= money_chk(objRs("g_charge_document"))
		g_charge_gita			= money_chk(objRs("g_charge_gita"))
		g_charge_bundle			= money_chk(objRs("g_charge_bundle"))
		g_charge_buga			= money_chk(objRs("g_charge_buga"))
		g_charge_combine		= money_chk(objRs("g_charge_combine"))
		g_charge_sum			= CDbl(g_charge_promise-cdbl(g_charge_sp_top+g_charge_sp+g_charge_sale+g_charge_document+g_charge_gita)+g_charge_bundle + g_charge_buga + g_charge_combine)

		g_charge_promise		= money_change(g_charge_promise)
		g_charge_sp_top			= money_change(g_charge_sp_top)
		g_charge_sp				= money_change(g_charge_sp)
		g_charge_sale			= money_change(g_charge_sale)
		g_charge_document		= money_change(g_charge_document)
		g_charge_gita			= money_change(g_charge_gita)
		g_charge_bundle			= money_change(g_charge_bundle)
		g_charge_buga			= money_change(g_charge_buga)
		g_charge_combine		= money_change(g_charge_combine)
		g_charge_sum			= money_change(g_charge_sum)

		tt_charge_promise		= CDbl(tt_charge_promise+g_charge_promise)
		tt_charge_sp_top		= CDbl(tt_charge_sp_top+g_charge_sp_top)
		tt_charge_sp			= CDbl(tt_charge_sp+g_charge_sp)
		tt_charge_sale			= CDbl(tt_charge_sale+g_charge_sale)
		tt_charge_document		= CDbl(tt_charge_document+g_charge_document)
		tt_charge_gita			= CDbl(tt_charge_gita+g_charge_gita)
		tt_charge_bundle		= CDbl(tt_charge_bundle+g_charge_bundle)
		tt_charge_buga			= CDbl(tt_charge_buga+g_charge_buga)
		tt_charge_combine		= CDbl(tt_charge_combine+g_charge_combine)
		tt_charge_sum			= CDbl(tt_charge_sum+g_charge_sum)


		g_charge_bigo			= objRs("g_charge_bigo")							'정산 비고
		g_charge_bigo_doc		= objRs("g_charge_bigo_doc")						'정산 비고(미비서류)
		g_charge_date1			= objRs("g_charge_date1")							'정산 예정일
		g_charge_date2			= objRs("g_charge_date2")							'정산 완료일

		gaetong_name			= objRs("gaetong_name")
		gaetong_color			= objRs("gaetong_color")
			
		g_sp_name				= objRs("g_sp_name")							'사은품 명
		g_sp_name_txt			= Left(g_sp_name,10)							'사은품 명
		g_sp_price				= money_change(objRs("g_sp_price"))				'사은품 금액
		g_sp_give_type			= objRs("g_sp_give_type")						'사은품 지급처
		
		g_sp_give_type_txt		= fnc_g_sp_give_type(g_sp_give_type,"Y")

		g_sp_date_start			= objRs("g_sp_date_start")						'사은품 예정
		g_sp_date_end			= objRs("g_sp_date_end")						'사은품 지급완료
		g_set					= fnc_g_set(objRs("g_set"))						'셋트유형

		promise_name			= objRs("promise_name")							'상품 약정
		sale_name				= objRs("sale_name")							'할인탭
		yuchi_name				= objRs("yuchi_name")							'유치자
		service_name			= objRs("service_name")							'부가서비스 
		g_service_no			= objRs("g_service_no")
		g_article_cnt			= objRs("g_article_cnt")						'회선수


		  file.WriteLine("<tr height='27'>")
		  file.WriteLine("  <td>"&g_charge_type_txt&" </td>")
		  file.WriteLine("  <td>" & c_name & "</td>")

		  file.WriteLine("  <td style='mso-number-format:\@'>"& g_service_no& "</td>   ")
		  file.WriteLine("  <td>" & article_name&"_"& article_name1 & "</td>")
		  file.WriteLine("  <td>" & option_name & "</td>")
		  file.WriteLine("  <td style='mso-number-format:\@'>"& service_name & "</td>")
		  file.WriteLine("  <td>" & sale_name & "</td>")

		  file.WriteLine("  <td>" & g_set & "</td>")
		  file.WriteLine("  <td>" & yuchi_name & "</td>")
		  file.WriteLine("  <td>" & g_date_yuchi & "</td>")
		  file.WriteLine("  <td>" & g_date_gaetong & "</td>")
		  file.WriteLine("  <td>" & gaetong_name & "</td>")
		  file.WriteLine("  <td>" & g_charge_promise & "</td>")
		  file.WriteLine("  <td>" & g_charge_sp_top & "</td>")
		  file.WriteLine("  <td>" & g_charge_sp & "</td>")
		  file.WriteLine("  <td>" & g_charge_sale & "</td>")
		  file.WriteLine("  <td>" & g_charge_document & "</td>")
		  file.WriteLine("  <td>" & g_charge_gita & "</td>")
		  file.WriteLine("  <td>" & g_charge_bundle & "</td>")
		  file.WriteLine("  <td>" & g_charge_buga & "</td>")
		  file.WriteLine("  <td>" & g_charge_combine & "</td>")
		  file.WriteLine("  <td>" & g_charge_sum & "</td>")
		  file.WriteLine("  <td>" & g_charge_date1 & "</td>")
		  file.WriteLine("  <td>" & g_charge_bigo & "</td>")
		  file.WriteLine("</tr>")

		i=i+1
		objRs.movenext
	Loop
	End If

		  file.WriteLine("<Tr height='30'>")

		  file.WriteLine("	<Td align='center' colspan='12' ><b>현재 화면 정산 합계</b> </td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_promise)& "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_sp_top) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_sp) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_sale) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_document) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_gita) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_bundle) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_buga) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_combine) & "</td>")
		  file.WriteLine("	<Td>"& money_change(tt_charge_sum) & "</td>")
		  file.WriteLine("	<Td colspan='12'>&nbsp;</td>")
		  file.WriteLine("</tr>")
		  file.WriteLine("</table>")
		  file.close



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
	  strSql = strSql & "  e_title = '"& e_title &"'"
	  strSql = strSql & ", e_contents = '"& e_contents &"'"
	  strSql = strSql & ", e_exact_date1 = '"& e_exact_date1 &"'"
	  strSql = strSql & ", e_exact_date2 = '"& e_exact_date2 &"'"
	  strSql = strSql & ", s_dealer_code = '"& s_dealer_code &"'"
	  strSql = strSql & ", e_charge_chk = '"& e_charge_chk &"'"

	  strSql = strSql & ", tax_chk = '"& tax_chk &"'"
	  
	  if len(trim(filename1))>1 then
		strSql = strSql & ", e_fname1 = '"& filename1 &"'"
	  end if

	  strSql = strSql & " where e_exact_idx="&e_exact_idx
	  set objRs=objCnn.Execute(strSql)
	  'Response.write strsql
	  Alert_url " 글이 수정 되었습니다. ","a_exact_list.asp?s_dealer_code="&s_dealer_code
  Else 
	  strSql = "Select ISNULL(MAX(e_exact_idx)+1,1) from exact_list "
	  set objRs=objCnn.Execute(strSql)
	  e_exact_idx	= objRs(0)
	  
	  strSql = " INSERT INTO exact_list (e_exact_idx, e_exact_type, e_o_code, e_m_id, e_title, e_contents, "
	  strSql = strSql & " e_writeday, e_exact_date1, e_exact_date2, s_dealer_code, e_charge_chk, s_gaetong_code, "
	  strSql = strSql & " date_chk, e_fname1, e_fname2_excel, tax_chk, tax_price_n, charge_gita1, charge_gita1_bigo, "
	  strSql = strSql & " charge_gongje, charge_gongje_bigo, charge_promise, charge_sp_top, charge_sp, charge_sale, "
	  strSql = strSql & " charge_document, charge_gita, charge_bundle, charge_buga, charge_combine, s_yuchi_m_id, exact_passwd)"
	  strSql = strSql & " values ("
	  strSql = strSql & "  " & e_exact_idx & " "
	  strSql = strSql & ",'" & e_exact_type & "' "
	  strSql = strSql & ",'" & o_code & "' "
	  strSql = strSql & ",'" & session_m_id & "' " 
	  strSql = strSql & ",'" & e_title & "' "
	  strSql = strSql & ",'" & e_contents & "' "
	  strSql = strSql & ",getdate()"  
	  strSql = strSql & ",'" & e_exact_date1 & "' "
	  strSql = strSql & ",'" & e_exact_date2 & "' "
	  strSql = strSql & ",'" & s_dealer_code & "' "
	  strSql = strSql & ",'A' "
	  strSql = strSql & ",'" & s_gaetong_code & "' "
	  strSql = strSql & ",'" & date_chk & "' "	  
	  strSql = strSql & ",'" & filename1 & "' "
	  strSql = strSql & ",'" & filename2 & "' "
	  strSql = strSql & ",'" & tax_chk & "' "
	  strSql = strSql & ", " & tax_price_n & "  "
	  strSql = strSql & ", " & charge_gita1 & "  "
	  strSql = strSql & ",'" & charge_gita1_bigo & "'  "
	  strSql = strSql & ", " & charge_gongje & "  "
	  strSql = strSql & ",'" & charge_gongje_bigo & "'  "
	  strSql = strSql & ", " & charge_promise & "  "
	  strSql = strSql & ", " & charge_sp_top & "  "
	  strSql = strSql & ", " & charge_sp & "  "
	  strSql = strSql & ", " & charge_sale & "  "
	  strSql = strSql & ", " & charge_document & "  "
	  strSql = strSql & ", " & charge_gita & "  "
	  strSql = strSql & ", " & charge_bundle & " "
	  strSql = strSql & ", " & charge_buga & " "
	  strSql = strSql & ", " & charge_combine & " "
	  strSql = strSql & ",'" & g_yuchi_m_id & "' "
	  strSql = strSql & ",'" & exact_passwd & "')"
	  
	  'Response.write strSql
	  
	  set objRs=objCnn.Execute(strSql)
	  'Response.end
	Alert " 정산서가 발송되었습니다. "
	Win_close()
  End if

  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  
  %>
