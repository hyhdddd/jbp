<%
	'-----------------ALERT ǥ�� ------------------------------------
	sub Alert(txtmsg)
		txtmsg = replace(txtmsg, "'", "`")
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "alert('" & txtmsg & "');"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
	end sub

	'-----------------ALERT ǥ�� �� �ڷ� �̵�------------------------
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

	'-----------------ALERT ǥ�� �� Ư�� URL �� �̵�-----------------
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

	'-----------------ALERT ǥ�þ��� Ư�� URL �� �̵�
	sub Win_link(txturl)
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "location.replace ('" & txturl & "');"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'----------------- â �ݱ� ----------------------------------
	sub win_close()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.close();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub


	'----------------- â �ݱ� ----------------------------------
	sub win_close_modal()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.parent.remove_modal();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	end sub

	'----------------- ���â ���ΰ�ħ ----------------------------------
	Sub win_reload_modal()
		response.write "<script type='text/javascript'>"&Chr(13)
		response.write "<!--"&Chr(13)
		response.write "window.parent.document.location.reload();"&Chr(13)
		response.write "-->"&Chr(13)
		response.write "</script>"&Chr(13)
		response.end
	End Sub


	'----------------- ������ Ư�� URL ����-----------------------
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
	
	'----------------- �۾��� Ư������ ��ȯ -----------------------
	Function CheckWord(CheckValue)	
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "''")
		CheckValue	= Replace(CheckValue, """", "&#34;")

		CheckWord = CheckValue
  	End Function  	 


	'------------------------ DB ��ü�ݱ�-------------------------
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


   	'----------------- õ���� �ĸ� ��� --------------
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

	'----------------- �ݾ� ���� ��ȯ �Լ�(Null üũ) --------------
  	Function money_chk(expression)
		if expression="" or isnull(expression)=true then
			returnValue = 0
		Else
			returnValue	= expression
		end if
		money_chk = returnValue
  	End Function 


	'----------------- �ݾ� ���� ��ȯ �Լ�(Null üũ) --------------
 	Function date_null_chk(expression)
		if expression="" or isnull(expression)=true then
  			expression="null"
		End If
		
		date_null_chk=expression
  	End Function	

	'----------------- ���� Query String �� ���� ------------------- 		
	Function Current_Qs_Check()
		path_info = Request.ServerVariables("URL")
		qs	  = Request.ServerVariables("QUERY_STRING")
		path_info = path_info&"?"&qs
		Current_Qs_Check = path_info		
	End Function		
	
	'----------------- ȸ�� �α��� üũ ---------------------------- 		
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

	'----------------- ������ �α��� üũ ---------------------------- 		
	sub Admin_Login_chk(admin_id) 
  		if admin_id="" or isnull(admin_id)=true then
  			win_link "/admin/admin_login.asp?QS_URL="&Current_Qs_Check()
  			response.end
  		end if	
  	end Sub

  	'----------------- ��¥�� �̿��� ������ ���� ---------------------  			
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
  	

	'------------------- Ư�� ���� ���� �Լ� -----------------------
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

	'------------------- Board �ڷ��� ����Ȯ���� �� ������ ǥ��-----
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

	'----------���� ���ε�� Ȯ���� üũ ----------
	Function fnc_strExt_block(strExt)	
		
		strExt = Lcase(strExt)
		chk="X"
		select case strExt
			'�̹��� ����
			Case "gif","jpeg","bmp","tif","tiff","jpg","png","psd","au","ogg"
				chk="O"
			'���� ����
			Case "zip","alz","a01","a02","a03","egg"
				chk="O"
			'���� ����
			Case "doc","hwp","xls","xlsx","ppt","pptx","csv","txt","doc","pdf","docx"
				chk="O"
			'���� ����
			Case "wav","avi","mp3","mpeg","mpg","3gp"
				chk="O"
			'�÷��� ����
			Case "swf"
				chk="O"
		end select	
		
		If chk="O" Then
		Else
			Alert_back "���ϸ��� Ȯ���ڸ� Ȯ���� �ּ���! \n\n (�̹��� ���� : gif , jpg , bmp , tif , tiff , png , psd , au , ogg) \n\n (���� ���� : zip ,alz ,a01 , a02 , a03 ) \n\n (�������� : doc , hwp , xls , xlsx , ppt , csv , txt , doc , pdf ) \n\n (���� ���� : wav , avi , mp3 ) \n\n (�÷��� ���� : swf , fla ) \n\n ���� ����� ���ϸ� ���ε� �� �� �ֽ��ϴ�. \n\n ���ε忡 �ȿ��� Ȯ���ڰ� �����ø� 1644-5499(���ͼ���Ʈ)�� ���� �ּ���!"
			Response.end
		End If
	End Function 
	
	'------------------- Ư�� ���� üũ -----------------------
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

	'------------------- ������ ���� üũ -----------------------
	Function CheckAdmin(CheckValue)	
		if CheckValue="" or  isnull(CheckValue)=true then
			CheckAdmin = "N"
		else
			CheckAdmin = CheckValue	
		end if
	End Function  	  

	'------------------- ��� ���� -----------------------
	Function fnc_deli_status(strExt)
		select case strExt
			Case "A"
				Ext_img="�Աݴ��"
			Case "B"
				Ext_img="�Ա�Ȯ��"
			Case "C"
				Ext_img="��ۿ�û"
			Case "D"
				Ext_img="�����"
			Case "E"
				Ext_img="<span class='red'>��ۿϷ�</span>"
			Case "F"
				Ext_img="ȯ��ó��"
		end select	

		fnc_deli_status=Ext_img
	End Function	

	'------------------- ��Ʈ ��ǰ -----------------------
	Function fnc_g_set(strExt)
		select case strExt
			Case "A"
				g_set_txt="�ܵ�"
			Case "B"
				g_set_txt="DPS"
			Case "C"
				g_set_txt="TPS"
		end select	

		fnc_g_set=g_set_txt
	End Function	

	'����ǰ ���� ���� ���
	Function fnc_g_sp_give_type(g_sp_give_type,chk)
		If chk="A" then
			If g_sp_give_type="A" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>��ġ������</span>"
			ElseIf g_sp_give_type="B" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>���� ����</span>"
			ElseIf g_sp_give_type="C" Then
				g_sp_give_type_txt = "<span style='color:#0B6138;' style='font-size:11px;'>����(���)</span>"
			ElseIf g_sp_give_type="D" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>��������</span>"
			ElseIf g_sp_give_type="E" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>����ǰ����</span>"
			ElseIf g_sp_give_type="F" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>�����ǰ��+����</span>"
			ElseIf g_sp_give_type="G" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>������</span>"
			ElseIf g_sp_give_type="" Then
				g_sp_give_type_txt = " "
			End If
		ElseIf chk="P" Or chk="Y" Then
			If g_sp_give_type="A" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>��ġ������</span>"
			ElseIf g_sp_give_type="B" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>��������</span>"
			ElseIf g_sp_give_type="C" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>��������</span>"
			ElseIf g_sp_give_type="D" Then
				g_sp_give_type_txt = "<span class='red' style='font-size:11px;'>��������</span>"
			ElseIf g_sp_give_type="E" Then
				g_sp_give_type_txt = "<span class='blue' style='font-size:11px;'>����ǰ����</span>"
			ElseIf g_sp_give_type="F" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>�����ǰ��+����</span>"
			ElseIf g_sp_give_type="G" Then
				g_sp_give_type_txt = "<span class='green' style='font-size:11px;'>������</span>"
			ElseIf g_sp_give_type="" Then
				g_sp_give_type_txt = " "
			End If
		End if
		fnc_g_sp_give_type=g_sp_give_type_txt
	End Function


	'��Ʈ�� ���� ��ǰ ǥ�ÿ���
	Function fnc_option_set(option_set)
		If option_set="A" Then
			option_set_txt = "<span class='blue'>�ܵ�</span>"
		ElseIf option_set="B" Then
			option_set_txt = "<span class='red'>����</span>"
		ElseIf option_set="C" Then
			option_set_txt = "����"
		Else
			option_set_txt = ""
		End If
		fnc_option_set=option_set_txt
	End Function

	'�޸�/ȸ��/��� ���� TXT
	Function fnc_consult_txt(txt)
		If txt="A" Then
			fnc_consult_txt = "���޸�"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="B" Then
			fnc_consult_txt = "ȸ�ſ�û"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="C" Then
			fnc_consult_txt = "ȸ�Ŵ亯"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="D" then
			fnc_consult_txt = "ȸ�ſϷ�"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="E" then
			fnc_consult_txt = "��û����"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="F" then
			fnc_consult_txt = "ó������"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="G" then
			fnc_consult_txt = "�����޸�"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="H" then
			fnc_consult_txt = "��θ޸�"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="I" then
			fnc_consult_txt = "��ο�û"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="J" then
			fnc_consult_txt = "��δ亯"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		ElseIf txt="K" then
			fnc_consult_txt = "VOC�߻�"
			fnc_consult_txt = "<img src='/images/button/consult_icon_"&txt&".gif' align='absmiddle'>&nbsp;"
		Else
			fnc_consult_txt = ""
		End If	
	End Function


	'�޸�/ȸ��/��� ���� TXT
	Function fnc_consult_txt11(txt)
		If txt="A" Then
			fnc_consult_txt11 = "���޸�"
		ElseIf txt="B" Then
			fnc_consult_txt11 = "ȸ�ſ�û"
		ElseIf txt="C" Then
			fnc_consult_txt11 = "ȸ�Ŵ亯"
		ElseIf txt="D" then
			fnc_consult_txt11 = "ȸ�ſϷ�"
		ElseIf txt="E" then
			fnc_consult_txt11 = "�����"
		ElseIf txt="F" then
			fnc_consult_txt11 = "���ó��"
		ElseIf txt="G" then
			fnc_consult_txt11 = "�����޸�"
		ElseIf txt="H" then
			fnc_consult_txt11 = "��θ޸�"
		ElseIf txt="I" then
			fnc_consult_txt11 = "��ο�û"
		ElseIf txt="J" then
			fnc_consult_txt11 = "��δ亯"
		Else
			fnc_consult_txt11 = ""
		End If		
	End Function


	'�޸�/ȸ��/��� ���� TXT
	Function fnc_consult_list(txt)
		If txt="A" Then
			fnc_consult_list = "���޸�"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="B" Then
			fnc_consult_list = "ȸ�ſ�û"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="C" Then
			fnc_consult_list = "ȸ�Ŵ亯"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="D" then
			fnc_consult_list = "ȸ�ſϷ�"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="E" then
			fnc_consult_list = "��û����"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="F" then
			fnc_consult_list = "ó������"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="G" then
			fnc_consult_list = "�����޸�"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="H" then
			fnc_consult_list = "��θ޸�"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="I" then
			fnc_consult_list = "��ο�û"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="J" then
			fnc_consult_list = "��δ亯"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		ElseIf txt="K" then
			fnc_consult_list = "VOC �߻�"
			fnc_consult_list = "<img src='/images/button/consult_icon_"&txt&"_list.gif' align='absmiddle'>&nbsp;"
		Else
			fnc_consult_list = ""
		End If	
	End Function

	Function black_type_txt(txt)
		If txt="A" Then
			black_type_txt = "����"
		ElseIf txt="B" Then
			black_type_txt = "���"
		ElseIf txt="C" Then
			black_type_txt = "�ҷ�"
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
			fnc_give_chk = "����"
		ElseIf txt="B" Then
			fnc_give_chk = "�����"
		ElseIf txt="C" Then
			fnc_give_chk = "����"
		Else
			fnc_give_chk="����"
		End if
	End Function

	'���� ����
	Function fnc_charge_type(txt)
		If txt="G" Then
			fnc_charge_type = "�Ϲ�"
		ElseIf txt="A" Then
			fnc_charge_type = "<span class='red'>�߰�</span>"
		ElseIf txt="B" Then
			fnc_charge_type = "<span class='red'>ȯ��</span>"
		ElseIf txt="C" Then
			fnc_charge_type = "<span class='red'>VOC</span>"
		Else
			fnc_charge_type=""
		End if
	End Function

	'----------SQL ������ �� ���� ��ȯ----------
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

