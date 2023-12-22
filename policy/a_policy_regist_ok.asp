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
  charge_idx		= WORD_CHANGE(UploadForm("charge_idx"),10)
  group_code		= WORD_CHANGE(UploadForm("group_code"),0)
  policy_title		= WORD_CHANGE(UploadForm("policy_title"),50)
  policy_date		= WORD_CHANGE(UploadForm("policy_date"),20)
  policy_passwd		= WORD_CHANGE(UploadForm("policy_passwd"),20)
  dealer_code		= WORD_CHANGE(UploadForm("dealer_code"),0)

  article_idx		= replace(UploadForm("article_idx[]")," ","")
  arrStrCut1		= split(article_idx,",")
  articleMaxArr		= ubound(arrStrCut1)

  If Len(dealer_code)<>0 then
	  dealer_code=left(dealer_code,len(dealer_code)-1)
  Else
		Alert_back " 받는 사람을 선택하세요"
		response.end
  End If

  arrStrCut			= split(dealer_code,"_")
  maxArr			= ubound(arrStrCut )

  If policy_idx="" Then
	strSql = " SELECT ISNULL(MAX(policy_idx)+1,1) from policy_list "
	Set objRs1=objCnn.Execute(strSql)
	policy_idx	= objRs1(0)
	regist_chk="new"
  Else
	'정책상품 목록 삭제후 다시 셋팅
	strSql = "delete policy_list_article where policy_idx="&policy_idx
	Set objRs=objCnn.Execute(strSql)
  End if

  Dim Arr_area_name(10)
  Dim Arr_area_idx(10)
  Dim Arr_area_charge(10)

  	html_txt	=  "<style type='text/css'>	"&chr(13) & chr(10)
	html_txt	= html_txt & "td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	"&chr(13) & chr(10)
	html_txt	= html_txt & ".st_td {border-bottom: 1px solid #C7C7C7; border-right: 1px solid #C7C7C7} "&Chr(13)&Chr(10)
	html_txt	= html_txt & ".st_td1 {border-bottom: 1px solid #C7C7C7; border-right: 1px solid #C7C7C7border-left: 1px solid #C7C7C7} "&Chr(13)&Chr(10)
	html_txt	= html_txt & "</style>	"&chr(13) & chr(10)

  For k=0 To articleMaxArr
	policy_bigo		= WORD_CHANGE(UploadForm("board_contents"&arrStrCut1(k)),"E")


	strSql = " select * from code_article where article_view='Y' and article_idx="& arrStrCut1(k) &" "
	strSql = strSql & " order by article_order asc "
	Set objRs=objCnn.Execute(strSql)

	Do Until objRs.eof
		article_idx			= objRs("article_idx")
		article_name		= objRs("article_name")
		article_step1		= objRs("article_step1")
		chk					= "O"
		article_name_old	= article_name
		

		'정책 표시 지역 가지고 오기.
		strSql = " select count(area_idx) from code_area "
		strSql = strSql & " where article_idx="&article_step1&" and area_policy='Y' "
		Set objRs0=objCnn.Execute(strSql)

		area_cnt	= objRs0(0)
		col_cnt		= area_cnt+3

		If area_cnt=0 Then		
		else
			strSql = "select * from code_area "
			strSql = strSql & " where article_idx="&article_step1&" and area_policy='Y' "
			strSql = strSql & "		order by area_order asc"
			Set objRs0=objCnn.Execute(strSql)

			For i=1 To area_cnt
				Arr_area_name(i) = objRs0("area_name")		
				Arr_area_idx(i)  = objRs0("area_idx")	
				objRs0.movenext
			Next
			
			strSql = " select * from  code_article where  article_view='Y' and article_step2>0 "
			strSql = strSql & " and article_step1="&article_step1&" order by article_order asc"
			Set objRs2=objCnn.Execute(strSql)

			Do Until objRs2.eof
				article_idx			= objRs2("article_idx")
				article_name		= objRs2("article_name")


				strSql = " select promise_idx,promise_name from code_promise where article_idx="&article_idx&" "
				strSql = strSql & " and promise_policy='Y'"
				Set objRs3=objCnn.Execute(strSql)
				
				If objRs3.eof Or objRs3.bof Then
				Else
					If chk="O" Then
					  html_txt	= html_txt & "<br><br><table align=center width=98% cellspacing='0' cellpadding='0' border=0 style='border-bottom:1px solid #e6e6e6;'>"&chr(13)&chr(10)
					  html_txt	= html_txt & "<tr height='30'>"&chr(13) & chr(10)
					  html_txt	= html_txt & "	<td colspan='"&col_cnt&"'>&nbsp;<span style='font-size:16px;color:red'><b>"& article_name_old & "</b></span></td>"&chr(13) & chr(10)
					  html_txt	= html_txt & "</tr>"&chr(13) & chr(10)

					  html_txt	= html_txt & "<tr height='30'>"&chr(13) & chr(10)
					  html_txt	= html_txt & "	<td align='center' style='background:#FAAC58'>&nbsp;<b>상품명</b></td>"&chr(13) & chr(10)
					  html_txt	= html_txt & "	<td align='center' style='background:#FAAC58'>&nbsp;<b>옵션명</b></td>"&chr(13) & chr(10)
					
					  For j=1 To area_cnt
					    html_txt	= html_txt & "	<td align='center' style='background:#FAAC58'>&nbsp;<b>"&Arr_area_name(j)&"</b></td>"&chr(13) & chr(10)
					  Next
					  html_txt	= html_txt & "	<td align='center' style='background:#FAAC58'>&nbsp;<b>기준 약정</b></td>"&chr(13) & chr(10)

					  html_txt	= html_txt & "</tr>"&chr(13) & chr(10)
					End If

					
					html_txt	= html_txt & "<tr height='30'>"&chr(13) & chr(10)
					html_txt	= html_txt & "	<td colspan='"&col_cnt&"' class='st_td1'>&nbsp;"& article_name & "</td>"&chr(13) & chr(10)
					html_txt	= html_txt & "</tr>"&chr(13) & chr(10)

			
					promise_idx		= objRs3("promise_idx")
					promise_name	= objRs3("promise_name")
					
					strSql = " select option_idx, option_name from code_article_option where option_view='Y' "
					strSql = strsql & " and article_idx="&article_idx&" order by option_order asc "
					Set objRs4=objCnn.Execute(strSql)
				
					Do Until objRs4.eof
						option_idx	= objRs4("option_idx")
						option_name = objRs4("option_name")
						
						For j=1 To area_cnt
						  strSql = "select * from charge_promise where policy_idx="&charge_idx&" and option_idx="&option_idx&" "
						  strSql = strSql & " and promise_idx="&promise_idx&" and area_idx="&Arr_area_idx(j)&" "
						  'Response.write strSql
						  Set objRs5=objCnn.Execute(strSql)
						
						  If objRs5.eof Or objRs5.bof Then
							  Arr_area_charge(j)		= "0 원 "
						  Else
							  Arr_area_charge(j)		= money_change(objRs5("promise_charge"))& "원"
						  End If
						Next

						html_txt	= html_txt & "<tr height='30'>"&chr(13) & chr(10)
						html_txt	= html_txt & "	<td width='150' class='st_td1'>&nbsp;</td>"&chr(13) & chr(10)
						html_txt	= html_txt & "	<td class='st_td'>&nbsp;"& option_name & "</td>"&chr(13) & chr(10)

						For j=1 To area_cnt
							html_txt	= html_txt & "	<td class='st_td'>&nbsp;"& Arr_area_charge(j) &"</td>"&chr(13)&chr(10)
						Next
						html_txt	= html_txt & "	<td class='st_td'>&nbsp;"& promise_name & " </td>"&chr(13)&chr(10)
						html_txt	= html_txt & "</tr>"&chr(13) & chr(10)

						objRs4.movenext
					Loop
				End If

				objRs2.movenext
				chk="X"
			Loop

			
			html_txt	= html_txt & "<tr height='100' valign='top'>"&chr(13) & chr(10)
			html_txt	= html_txt & "	<td class='st_td' style='padding:7px 0px 4px 0px;font-size:12px;' bgcolor='white' colspan='"&col_cnt&"'>&nbsp;"& policy_bigo &"</td>"&chr(13) & chr(10)
			html_txt	= html_txt & "</tr>"&chr(13) & chr(10)

			html_txt	= html_txt & "</table><br><Br>"
			html_txt	= Replace(html_txt, "'", "")

		End If
		
		objRs.movenext

  
		html_txt	= Replace(html_txt, "'", "")

		'상품등록
		strSql = " SELECT ISNULL(MAX(board_idx)+1,1) from policy_list_article "
		Set objRs6=objCnn.Execute(strSql)

		board_idx = objRs6(0)

		strSql = "insert into policy_list_article(board_idx, policy_idx, article_idx, policy_bigo, policy_txt) "
		strSql = strSql & " values("&board_idx&", "&policy_idx&","& arrStrCut1(k) &",'"&policy_bigo&"','"&html_txt&"') "
		Set objRs2=objCnn.Execute(strSql)

		html_txt	= " "

	Loop
  Next

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

  '정책표 등록/수정 처리
  If regist_chk="new" Then
	strSql = "insert into policy_list(policy_idx, charge_idx, policy_title, policy_date, "
	strSql = strSql & " policy_passwd, policy_file1, group_code, policy_writeday) "
	strSql = strSql & " values("&policy_idx&", "&charge_idx&",'"& policy_title &"', '"& policy_date & "',"
	strSql = strSql & " '"& policy_passwd &"','"&filename1&"','"&group_code&"', getdate()) "
	'Response.write strSql
	Set objRs2=objCnn.Execute(strSql)
  Else  
	strSql = " update policy_list set "
	strSql = strSql & "  policy_title	= '"& policy_title &"' "
	strSql = strSql & ", policy_date	= '"& policy_date &"' "
	strSql = strSql & ", policy_passwd	= '"& policy_passwd &"' "

	If filename1<>"" Then 
	strSql = strSql & ", policy_file1	= '"&filename1&"' "
	End If
	
	strSql = strSql & " where policy_idx= "&policy_idx&" "
	'Response.write strSql
	Set objRs=objCnn.Execute(strSql)
  End if


  '딜러정보 삭제후 등록
  strSql = " delete policy_list_dealer where policy_idx="&policy_idx
  Set objRs=objCnn.Execute(strSql)

  For i=0 To maxArr
	
	strSql = " SELECT ISNULL(MAX(board_idx)+1,1) from policy_list_dealer "
	Set objRs1=objCnn.Execute(strSql)

	board_idx = objRs1(0)


	strSql = "insert into policy_list_dealer(board_idx, policy_idx, dealer_code) "
	strSql = strSql & " values("&board_idx&", "&policy_idx&",'"& arrStrCut(i) &"') "
	'Response.write strSql
	Set objRs2=objCnn.Execute(strSql)
  Next 

  
  Alert_url "정책표를 발송했습니다.","/policy/a_policy_list.asp"
  %>