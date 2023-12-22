<%
	'-----------------ALERT 표시 ------------------------------------
	sub Alert(txtmsg)
		txtmsg = replace(txtmsg, "'", "`")
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "alert('" & txtmsg & "');"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
	end sub

	'-----------------ALERT 표시 후 뒤로 이동------------------------
	sub Alert_back(txtmsg)
		txtmsg = replace(txtmsg, "'", "`")
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "alert('" & txtmsg & "');"&Chr(13)
		response.write "history.back ();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'-----------------ALERT 표시 후 특정 URL 로 이동-----------------
	sub Alert_url(txtmsg, txturl)
		txtmsg = replace(txtmsg, "'", "`")
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "alert('" & txtmsg & "');"&Chr(13)
		response.write "location.replace ('" & txturl & "');"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'-----------------ALERT 표시없이 특정 URL 로 이동
	sub Win_link(txturl)
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "location.replace ('" & txturl & "');"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'----------------- 창 닫기 ----------------------------------
	sub win_close()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.close();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub


	'----------------- 창 닫기 ----------------------------------
	sub win_close_modal()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.parent.remove_modal();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'----------------- 모달창 새로고침 ----------------------------------
	Sub win_reload_modal()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.parent.document.location.reload();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	End Sub


	'----------------- 질문후 특정 URL 연결-----------------------
	sub Confirm_url(txtmsg, txturl,txturl1)
		response.write "<script type='text/javascript'>"& Chr(13)
		response.write "<!--"&Chr(13)
		response.write "if(confirm('" & txtmsg & "')==1)"& Chr(13)
		response.write "{"& Chr(13)
		response.write "	location.replace ('" & txturl & "');"& Chr(13)
		response.write "}"& Chr(13)
		response.write "else"& Chr(13)
		response.write "{"& Chr(13)
		response.write "	location.replace ('" & txturl1 & "');"& Chr(13)
		response.write "}"& Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"& Chr(13)
	end sub	
	
	'----------------- 글쓰기 특수문자 변환 -----------------------
	Function CheckWord(CheckValue)	
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "''")
		CheckValue	= Replace(CheckValue, """", "&#34;")

		CheckWord = CheckValue
  	End Function  	 


	'------------------------ DB 객체닫기-------------------------
	Sub DbClose()

		If objRs.state = 1 Then
			objRs.Close
		End If
				
		If isobject(objCnn) Then
		  objCnn.Close
		End If

		Set objRs = Nothing
		Set objCnn = Nothing
		Set FSO = Nothing
		set UploadForm = Nothing  
	
   	End Sub


   	'----------------- 천단위 컴마 찍기 --------------
  	Function money_change(expression)
		if expression="" or expression="0" or isnull(expression)=true then
  			returnValue=0
		else
  			if expression>0 then
  				returnValue=mid(Formatcurrency(expression),2)
	  		else  		
	  			returnValue="-"&mid(Formatcurrency(expression),3)
	  		end if	
  		end if  

		money_change = returnValue
  	End Function

	'----------------- 금액 관련 변환 함수(Null 체크) --------------
  	Function money_chk(expression)
		if expression="" or isnull(expression)=true then
			returnValue = 0
		Else
			returnValue	= expression
		end if
		money_chk = returnValue
  	End Function 


	'----------------- 금액 관련 변환 함수(Null 체크) --------------
 	Function date_null_chk(expression)
		if expression="" or isnull(expression)=true then
  			expression="null"
		End If
		
		date_null_chk=expression
  	End Function	

	'----------------- 현재 Query String 값 리턴 ------------------- 		
	Function Current_Qs_Check()
		path_info = Request.ServerVariables("URL")
		qs	  = Request.ServerVariables("QUERY_STRING")
		path_info = path_info&"?"&qs
		Current_Qs_Check = path_info		
	End Function		
	
	'----------------- 회원 로그인 체크 ---------------------------- 		
	sub Login_chk(m_id) 
		URL_NAME	= UCase(Request.ServerVariables("SERVER_NAME"))
		If Left(URL_NAME,4)="WWW." Then
			URL_NAME = Mid(URL_NAME,5)
		End If
		
		URL_NAME	= LCase(Mid(URL_NAME,1,Instr(URL_NAME,".")-1))

  		if m_id="" or isnull(m_id)=true then
  			win_link "/include/asp/login_jb7.asp?QS_URL="&Current_Qs_Check()
  			response.end
  		end if	
  	end Sub

	'----------------- 관리자 로그인 체크 ---------------------------- 		
	sub Admin_Login_chk(admin_id) 
  		if admin_id="" or isnull(admin_id)=true then
  			win_link "/admin/admin_login.asp?QS_URL="&Current_Qs_Check()
  			response.end
  		end if	
  	end Sub

  	'----------------- 날짜를 이용한 고유값 생성 ---------------------  			
  	Function Create_code()  	
  	  	yea = year(date)
  		mon = month(date)
  		dayy = day(date)
  		hr = hour(time)
  		min = minute(time)
  		sec = second(time)

  		if Cint(mon) < 10 then	mon = "0" & mon		end if
  		if Cint(dayy) < 10 then	dayy = "0" & dayy	end if 
  		if Cint(hr)  < 10 then	hr = "0" & hr  		end if
  		if Cint(min) < 10 then	min = "0" & min		end if
  		if Cint(sec) < 10 then	sec = "0" & sec		end if
  		ymd = yea & mon & dayy
  		tim = hr & min & sec
  		Create_code = mid(ymd,3)&tim   
    End Function    	
  	

	'------------------- 특정 문자 삭제 함수 -----------------------
	Function file_StrDelete(strmessage)
			StrDelete=Replace(strmessage,".","")
			StrDelete=Replace(StrDelete,"&","")
			StrDelete=Replace(StrDelete,"%","")
			StrDelete=Replace(StrDelete," ","")
			StrDelete=Replace(StrDelete,",","")
			StrDelete=Replace(StrDelete,"?","")
			StrDelete=Replace(StrDelete,"@","")
			StrDelete=Replace(StrDelete,"$","")
			StrDelete=Replace(StrDelete,"!","")
			StrDelete=Replace(StrDelete,"^","")
			StrDelete=Replace(StrDelete,"*","")
			StrDelete=Replace(StrDelete,"+","")
			StrDelete=Replace(StrDelete,";","")
			StrDelete=Replace(StrDelete,"#","")
			StrDelete=Replace(StrDelete,"=","_")
			StrDelete=Replace(StrDelete,"'","")
			file_StrDelete=StrDelete
	End Function

	'------------------- Board 자료형 파일확장자 별 아이콘 표시-----
	Function file_strExt_chk(strExt)
		select case strExt
			Case "GIF"
				Ext_img="gif.gif"
			Case "PDF"
				Ext_img="PDF.gif"
			Case "AVI"
				Ext_img="avi.gif"
			Case "BMP"
				Ext_img="bmp.gif"
			Case "DOC"
				Ext_img="doc.gif"
			Case "EXE"
				Ext_img="exe.gif"
			Case "HTML"
				Ext_img="html.jpg"
			Case "HWP"
				Ext_img="hwp.gif"
			Case "JPG"
				Ext_img="jpg.gif"
			Case "MDB"
				Ext_img="mdb.gif"
			Case "MID"
				Ext_img="mid.gif"
			Case "TIF"
				Ext_img="tif.gif"
			Case "TXT"
				Ext_img="txt.gif"
			Case "XLS"
				Ext_img="xls.gif"
			Case "XLSX"
				Ext_img="xls.gif"
			Case "ZIP"
				Ext_img="zip.gif"
			Case Else
				Ext_img="non.gif"
		end select	
		file_strExt_chk="/images/file_icon/"&Ext_img
	End Function	

	'----------파일 업로드시 확장자 체크 ----------
	Function fnc_strExt_block(strExt)	
		
		strExt = Lcase(strExt)
		chk="X"
		select case strExt
			'이미지 파일
			Case "gif","jpeg","bmp","tif","tiff","jpg","png","psd","au","ogg"
				chk="O"
			'압축 파일
			Case "zip","alz","a01","a02","a03","egg"
				chk="O"
			'문서 파일
			Case "doc","hwp","xls","xlsx","ppt","pptx","csv","txt","doc","pdf","docx"
				chk="O"
			'녹취 파일
			Case "wav","avi","mp3","mpeg","mpg","3gp"
				chk="O"
			'플레쉬 파일
			Case "swf"
				chk="O"
		end select	
		
		If chk="O" Then
		Else
			Alert_back "파일명의 확장자를 확인해 주세요! \n\n (이미지 파일 : gif , jpg , bmp , tif , tiff , png , psd , au , ogg) \n\n (압축 파일 : zip ,alz ,a01 , a02 , a03 ) \n\n (문서파일 : doc , hwp , xls , xlsx , ppt , csv , txt , doc , pdf ) \n\n (녹취 파일 : wav , avi , mp3 ) \n\n (플레쉬 파일 : swf , fla ) \n\n 위에 언급한 파일만 업로드 할 수 있습니다. \n\n 업로드에 팔요한 확장자가 있으시면 1644-5499(엔터소프트)로 연락 주세요!"
			Response.end
		End If
	End Function 
	
	'------------------- 특수 문자 체크 -----------------------
	Function checkSpecialChar(expression)
		checkSpecialChar="O"
		strSpecial = "`~!@#$%^&*()_+|\;\\/:=-<>.'\ "
		For i=1 to Len(expression) 
			For j=1 to Len(strSpecial)
				if mid(expression,i,1)=mid(strSpecial,j,1) then
					checkSpecialChar="X"
				end if	
			next		
		Next
	End Function	

	'------------------- 관리자 권한 체크 -----------------------
	Function CheckAdmin(CheckValue)	
		if CheckValue="" or  isnull(CheckValue)=true then
			CheckAdmin = "N"
		else
			CheckAdmin = CheckValue	
		end if
	End Function  	  

	'------------------- 배송 상태 -----------------------
	Function fnc_deli_status(strExt)
		select case strExt
			Case "A"
				Ext_img="입금대기"
			Case "B"
				Ext_img="입금확인"
			Case "C"
				Ext_img="배송요청"
			Case "D"
				Ext_img="배송중"
			Case "E"
				Ext_img="<span class='red'>배송완료</span>"
			Case "F"
				Ext_img="환불처리"
		end select	

		fnc_deli_status=Ext_img
	End Function	

	'------------------- 셋트 상품 -----------------------
	Function fnc_g_set(strExt)
		select case strExt
			Case "A"
				g_set_txt="단독"
			Case "B"
				g_set_txt="DPS"
			Case "C"
				g_set_txt="TPS"
		end select	

		fnc_g_set=g_set_txt
	End Function	

	'사은품 지급 형태 출력
	Function fnc_g_sp_give_type(g_sp_give_type,chk)
		If chk="A" then
			If g_sp_give_type="A" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>유치자지급</span>"
			ElseIf g_sp_give_type="B" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>센터 지급</span>"
			ElseIf g_sp_give_type="C" Then
				g_sp_give_type_txt = "<span style='color:#0B6138;' style='font-size:11px;'>센터(상부)</span>"
			ElseIf g_sp_give_type="D" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>본사지급</span>"
			ElseIf g_sp_give_type="E" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>사은품없음</span>"
			ElseIf g_sp_give_type="F" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>본사상품권+현금</span>"
			ElseIf g_sp_give_type="G" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>선지급</span>"
			ElseIf g_sp_give_type="" Then
				g_sp_give_type_txt = " "
			End If
		ElseIf chk="P" Or chk="Y" Then
			If g_sp_give_type="A" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>유치자지급</span>"
			ElseIf g_sp_give_type="B" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>센터지급</span>"
			ElseIf g_sp_give_type="C" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>센터지급</span>"
			ElseIf g_sp_give_type="D" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>본사지급</span>"
			ElseIf g_sp_give_type="E" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>사은품없음</span>"
			ElseIf g_sp_give_type="F" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>본사상품권+현금</span>"
			ElseIf g_sp_give_type="G" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>선지급</span>"
			ElseIf g_sp_give_type="" Then
				g_sp_give_type_txt = " "
			End If
		End if
		fnc_g_sp_give_type=g_sp_give_type_txt
	End Function


	'셋트에 따른 상품 표시여부
	Function fnc_option_set(option_set)
		If option_set="A" Then
			option_set_txt = "<span class='blue'>단독</span>"
		ElseIf option_set="B" Then
			option_set_txt = "<span class='red'>번들</span>"
		ElseIf option_set="C" Then
			option_set_txt = "통합"
		Else
			option_set_txt = ""
		End If
		fnc_option_set=option_set_txt
	End Function

	'메모/회신/상담 구분 TXT
	Function fnc_consult_txt(txt)
		If txt="A" Then
			fnc_consult_txt = "고객메모"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="B" Then
			fnc_consult_txt = "회신요청"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="C" Then
			fnc_consult_txt = "회신답변"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="D" then
			fnc_consult_txt = "회신완료"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="E" then
			fnc_consult_txt = "요청내용"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="F" then
			fnc_consult_txt = "처리내용"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="G" then
			fnc_consult_txt = "관리메모"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="H" then
			fnc_consult_txt = "상부메모"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="I" then
			fnc_consult_txt = "상부요청"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="J" then
			fnc_consult_txt = "상부답변"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="K" then
			fnc_consult_txt = "VOC발생"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		Else
			fnc_consult_txt = ""
		End If	
	End Function


	'메모/회신/상담 구분 TXT
	Function fnc_consult_txt11(txt)
		If txt="A" Then
			fnc_consult_txt11 = "고객메모"
		ElseIf txt="B" Then
			fnc_consult_txt11 = "회신요청"
		ElseIf txt="C" Then
			fnc_consult_txt11 = "회신답변"
		ElseIf txt="D" then
			fnc_consult_txt11 = "회신완료"
		ElseIf txt="E" then
			fnc_consult_txt11 = "고객상담"
		ElseIf txt="F" then
			fnc_consult_txt11 = "상담처리"
		ElseIf txt="G" then
			fnc_consult_txt11 = "관리메모"
		ElseIf txt="H" then
			fnc_consult_txt11 = "상부메모"
		ElseIf txt="I" then
			fnc_consult_txt11 = "상부요청"
		ElseIf txt="J" then
			fnc_consult_txt11 = "상부답변"
		Else
			fnc_consult_txt11 = ""
		End If		
	End Function


	'메모/회신/상담 구분 TXT
	Function fnc_consult_list(txt)
		If txt="A" Then
			fnc_consult_list = "고객메모"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="B" Then
			fnc_consult_list = "회신요청"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="C" Then
			fnc_consult_list = "회신답변"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="D" then
			fnc_consult_list = "회신완료"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="E" then
			fnc_consult_list = "요청내용"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="F" then
			fnc_consult_list = "처리내용"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="G" then
			fnc_consult_list = "관리메모"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="H" then
			fnc_consult_list = "상부메모"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="I" then
			fnc_consult_list = "상부요청"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="J" then
			fnc_consult_list = "상부답변"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="K" then
			fnc_consult_list = "VOC 발생"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		Else
			fnc_consult_list = ""
		End If	
	End Function

	Function black_type_txt(txt)
		If txt="A" Then
			black_type_txt = "주의"
		ElseIf txt="B" Then
			black_type_txt = "경고"
		ElseIf txt="C" Then
			black_type_txt = "불량"
		Else
			black_type_txt=""
		End if
	End Function

	Function fnc_date_change(txt)		
		If txt="" Or IsNull(txt) Then
			fnc_date_change	= ""
		else
			hr				= hour(txt)
			min				= minute(txt)
			sec				= second(txt)

			if Cint(hr)  < 10 then	hr = "0" & hr  		end if
			if Cint(min) < 10 then	min = "0" & min		end if
			if Cint(sec) < 10 then	sec = "0" & sec		end If
			
			fnc_date_change	= Left(txt,10)& " "& hr & ":" & min
		End if
	End Function 


	Function fnc_give_chk(txt)
		If txt="A" Then
			fnc_give_chk = "본인"
		ElseIf txt="B" Then
			fnc_give_chk = "배우자"
		ElseIf txt="C" Then
			fnc_give_chk = "가족"
		Else
			fnc_give_chk="본인"
		End if
	End Function

	'정산 종류
	Function fnc_charge_type(txt)
		If txt="G" Then
			fnc_charge_type = "일반"
		ElseIf txt="A" Then
			fnc_charge_type = "<span class='red'>추가</span>"
		ElseIf txt="B" Then
			fnc_charge_type = "<span class='red'>환수</span>"
		ElseIf txt="C" Then
			fnc_charge_type = "<span class='red'>VOC</span>"
		Else
			fnc_charge_type=""
		End if
	End Function

	'----------SQL 인젝션 방어를 위한 변환----------
	Function WORD_CHANGE(chk_txt,limitLength)
	
		If limitLength<>"E" Then
			chk_txt = replace(chk_txt, ";" , "&#59;")		';
			chk_txt = replace(chk_txt, """" , "&#34;")		';
			chk_txt = replace(chk_txt,"<","&lt;")
			chk_txt = replace(chk_txt,">","&gt;")
		
			If limitLength<>0 then
				chk_txt = Left(chk_txt,limitLength)
			End if
		End if
		
		'chk_txt = replace(chk_txt, "+" , "&#43;")		';
		chk_txt = replace(chk_txt, "'" , "&#39;")			
		chk_txt = replace(chk_txt, "--" , "&#45;&#45;")	'--
		chk_txt = replace(chk_txt, "%27" , "")			
		chk_txt = replace(chk_txt, "%3B" , "")			';
		chk_txt = replace(chk_txt, "%3b" , "")			';
		chk_txt = replace(chk_txt, "%22" , "")			'"		
		chk_txt = replace(chk_txt, "%2B" , "")			'+
		chk_txt = replace(chk_txt, "%2b" , "")			'+
		chk_txt = replace(chk_txt, "@@" , "")			'space
		chk_txt = replace(chk_txt, "(94)" , "")			'space
		chk_txt = replace(chk_txt, "(85)" , "")			'space
		chk_txt = replace(chk_txt, "(124)" , "")		'space
		chk_txt = replace(chk_txt, "**/)" , "")			'space
		chk_txt = replace(chk_txt, "/**)" , "")			'space

		WORD_CHANGE = chk_txt
	End Function
%>	

