   <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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
	Alert_URL session_m_name &" ���� ����ǰ ���������� �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/default.asp"
	Response.end
  End If
  
  set FSO				= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  page					= WORD_CHANGE(UploadForm("page"),20)									'������
  nowblock				= WORD_CHANGE(UploadForm("nowblock"),20)								'��
  s_link_txt			= WORD_CHANGE(UploadForm("s_link_txt"),0)								'�˻���

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

  g_goods_idx			= WORD_CHANGE(UploadForm("g_goods_idx")	,20)							'�� ��ǰ ����
  g_custom_idx 			= WORD_CHANGE(UploadForm("g_custom_idx"),20)							'�� ����
  g_yuchi_m_id			= WORD_CHANGE(UploadForm("g_yuchi_m_id"),20)							'��ġ�� ���̵�
  g_jupsu_m_id			= WORD_CHANGE(UploadForm("g_jupsu_m_id"),20)							'������ ���̵�
  g_article_idx1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'�� ��ǰ ȸ���
  g_article_idx2		= WORD_CHANGE(UploadForm("g_article_idx2"),20)							'�� ��ǰ ��ǰ��
  g_set					= WORD_CHANGE(UploadForm("g_set"),20)									'��Ʈ����

  If g_article_idx1="0" Or g_article_idx2="0" Then
	Alert_back " ��ǰ ������ �߸��ƽ��ϴ�. \n\n �ٽ� �Է��� �ּ���!"
  End If

  g_option_idx			= WORD_CHANGE(UploadForm("g_option_idx"),20)							'�� ��ǰ �ɼ�
  g_code_promise1		= WORD_CHANGE(UploadForm("g_code_promise1"),20)							'�� ��ǰ ����
  g_code_course_idx		= WORD_CHANGE(UploadForm("g_code_course_idx"),20)						'�� ��ǰ �������
  g_date_yuchi			= WORD_CHANGE(date_null_chk(UploadForm("g_date_yuchi")),20)				'�� ��ǰ ������

  g_date_yuchi_hour		= WORD_CHANGE(UploadForm("g_date_yuchi_hour"),20)
  g_date_yuchi_minute	= WORD_CHANGE(UploadForm("g_date_yuchi_minute"),20)

  If g_date_yuchi="null" Then
	g_date_yuchi		= getdate()
  else
	g_date_yuchi		= g_date_yuchi & " " & g_date_yuchi_hour &":"&g_date_yuchi_minute &":00"
  End if

  g_code_sale			= WORD_CHANGE(UploadForm("g_code_sale"),20)								'�� ��ǰ ������ �ڵ�

  g_zipcode1			= WORD_CHANGE(UploadForm("g_zipcode1"),20)								'�� ��ǰ �����ȣ1
  g_zipcode2			= WORD_CHANGE(UploadForm("g_zipcode2"),20)								'�� ��ǰ �����ȣ2
  g_address				= WORD_CHANGE(UploadForm("g_address"),200)								'�� ��ǰ �ּ�
  g_bank_cd				= WORD_CHANGE(UploadForm("g_bank_cd"),20)								'�����
  g_bank_no				= WORD_CHANGE(UploadForm("g_bank_no"),40)								'���¹�ȣ
  g_bank_name			= WORD_CHANGE(UploadForm("g_bank_name"),40)								'������
  g_sp_name				= WORD_CHANGE(UploadForm("g_sp_name"),40)								'����ǰ ���� - �̸� 
  g_sp_price			= WORD_CHANGE(money_chk(UploadForm("g_sp_price")),20)					'����ǰ ���� - �ݾ�
  g_sp_date_start		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start")),20)			'����ǰ ���� - ���޿�����
  g_sp_date_end			= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_end")),20)			'����ǰ ���� - ���޿Ϸ���
  g_service_no			= WORD_CHANGE(UploadForm("g_service_no"),40)							'���Լ��񽺹�ȣ
  g_bank_name			= WORD_CHANGE(UploadForm("g_bank_name"),40)								'������
  g_bigo				= WORD_CHANGE(UploadForm("g_bigo"),0)									' �� ��ǰ ���

  g_bank_jumin1			= WORD_CHANGE(UploadForm("g_bank_jumin1"),20)							'��ü���� �ֹι�ȣ(����� �ٸ����)
  g_bank_jumin2			= WORD_CHANGE(UploadForm("g_bank_jumin2"),20)							'��ü���� �ֹι�ȣ(����� �ٸ����)

  g_give_type			= WORD_CHANGE(UploadForm("g_give_type"),20)								'��������
  g_give_chk			= WORD_CHANGE(UploadForm("g_give_chk"),20)								'��������
  g_card_cd				= WORD_CHANGE(UploadForm("g_card_cd"),20)								'ī���
  g_card_no				= WORD_CHANGE(UploadForm("g_card_no"),40)								'ī���ȣ
  g_card_gigan			= WORD_CHANGE(UploadForm("g_card_gigan"),20)							'ī�� ��ȿ�Ⱓ 
  g_card_gigan1			= WORD_CHANGE(UploadForm("g_card_gigan1"),20)							'ī�� ��ȿ�Ⱓ  
  g_card_name			= WORD_CHANGE(UploadForm("g_card_name"),40)								'ī�� ��ȿ�Ⱓ  
  g_card_jumin1			= WORD_CHANGE(UploadForm("g_card_jumin1"),20)							'ī�� ��ȿ�Ⱓ  
  g_card_jumin2			= WORD_CHANGE(UploadForm("g_card_jumin2"),20)							'ī�� ��ȿ�Ⱓ  

  g_sp_give_type		= WORD_CHANGE(UploadForm("g_sp_give_type"),20)							'����ǰ ������ ����

  g_date_gaetong_hope	= WORD_CHANGE(date_null_chk(UploadForm("g_date_gaetong_hope")),20)		'���������
  g_trans_out_dealer	= WORD_CHANGE(UploadForm("g_trans_out_dealer"),20)						'�ΰ�ŷ�ó

  g_date_gaetong		= WORD_CHANGE(date_null_chk(UploadForm("g_date_gaetong")),20)			'������
  g_code_gaetong_idx	= WORD_CHANGE(UploadForm("g_code_gaetong_idx"),20)						'�� ��ǰ �������
  g_date_gaetong_hope_time	=  WORD_CHANGE(UploadForm("g_date_gaetong_hope_time"),20)			'��������� �ð�

 '����ǰ ��������
  g_sp_bank_code		= WORD_CHANGE(UploadForm("g_sp_bank_code"),20)							'����ǰ���� �����ڵ�
  g_sp_bank_acount		= WORD_CHANGE(UploadForm("g_sp_bank_acount"),40)						'����ǰ���� �������
  g_sp_bank_name		= WORD_CHANGE(UploadForm("g_sp_bank_name"),40)							'����ǰ���� ���࿹����
  g_sp_bank_memo		= WORD_CHANGE(UploadForm("g_sp_bank_memo"),100)							'����ǰ���� ����޸�

  g_code_service1		= WORD_CHANGE(UploadForm("g_code_service1"),40)							'�ΰ�����
  g_cancel_date			= WORD_CHANGE(date_null_chk(UploadForm("g_cancel_date")),20)			'�ؾ�����
  g_article_cnt			= WORD_CHANGE(money_chk(UploadForm("g_article_cnt")),20)				'ȸ����

  g_sum_money_chk		= WORD_CHANGE(UploadForm("g_sum_money_chk"),20)							'�ջ�û��(A/B)
  g_sum_money_txt		= WORD_CHANGE(UploadForm("g_sum_money_txt"),100)							'�ջ�û�� �ؽ�Ʈ
  g_code_area			= WORD_CHANGE(money_chk(UploadForm("g_code_area")),20)					'����

  g_code_document		= WORD_CHANGE(replace(UploadForm("g_code_document")," ",""),0)			'�̺񼭷�

  g_move_tel1			= WORD_CHANGE(UploadForm("g_move_tel1"),20)
  g_move_name			= WORD_CHANGE(UploadForm("g_move_name"),40)
  g_move_jumin1			= WORD_CHANGE(UploadForm("g_move_jumin1"),20)
  g_move_jumin2			= WORD_CHANGE(UploadForm("g_move_jumin2"),20)
  g_move_date			= WORD_CHANGE(UploadForm("g_move_date"),20)
  g_move_tel2			= WORD_CHANGE(UploadForm("g_move_tel2"),20)
  g_move_company		= WORD_CHANGE(UploadForm("g_move_company"),20)
  g_move_memo			= WORD_CHANGE(UploadForm("g_move_memo"),100)

  '�������ǰ
  g_sp_name_top			= WORD_CHANGE(UploadForm("g_sp_name_top"),40)
  g_sp_price_top		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top")),20)	
  g_code_combine		= WORD_CHANGE(money_chk(UploadForm("g_code_combine")),20)

  strSql = " select m_dealer_code from emp_list where m_id='"&g_yuchi_m_id&"'"
  'Response.write strSql
  Set objRs=objCnn.Execute(strSql)

  g_trans_in_dealer = objRs(0)								' �μ� ����� �ڵ� ���

  sp_code				= Create_code() 

  yea = year(date)
  mon = month(date)
  if Cint(mon) < 10 then  	mon = "0" & mon  end if
  
  '��Ÿ �ڵ� ���� ����
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '���� �ڵ� - ������ ���� ���� 
  DIR_O_CODE="/file_data/"&o_code&"/customer"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '���� �ڵ� - ������ - ��¥ ���� ����
  DIR_O_CODE="/file_data/"& o_code &"/customer/"&CSTR(yea)&cstr(mon)     	' ���� ���� ���  
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
 
  '���� ���ε� ó��
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
			Alert_back "ȭ�� �뷮�� 20M�� �ʰ��Ҽ� �����ϴ�."
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
			Alert_back "ȭ�� �뷮�� 20M�� �ʰ��Ҽ� �����ϴ�."
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
			Alert_back "ȭ�� �뷮�� 20M�� �ʰ��Ҽ� �����ϴ�."
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
			Alert_back "ȭ�� �뷮�� 20M�� �ʰ��Ҽ� �����ϴ�."
		end if   	
  end if


  '==================ȭ�� ���ε� ó���κ� �� ==================='  
  
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

	'���� �� ���� ����
	strSql = " select g_goods_ref, g_date_yuchi from customer_goods where g_goods_idx="&g_goods_idx
	Set objRs=objCnn.Execute(strSql)
	
	g_goods_ref			= objRs("g_goods_ref")
	g_date_yuchi_db		= objRs("g_date_yuchi")

	
	'����ŷ ����
	o_marking				= CInt(o_marking)
	g_date_yuchi_day		= dateDiff("d",g_date_yuchi_db, now)
	
	If g_date_yuchi_day>=(o_marking) And CInt(o_marking)<>0 Then 
		Alert_back "��ŷ�� ���� ������ �� �����ϴ�."
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
	
	'��ü ī������
	strSql = strSql & ", g_give_type = '"& g_give_type &"'"
	strSql = strSql & ", g_give_chk = '"& g_give_chk &"'"
	strSql = strSql & ", g_card_cd = "& g_card_cd &" "
	strSql = strSql & ", g_card_no = '"& g_card_no &"'"
	strSql = strSql & ", g_card_gigan = '"& g_card_gigan &"'"
	strSql = strSql & ", g_card_gigan1 = '"& g_card_gigan1 &"'"
	strSql = strSql & ", g_card_name = '"& g_card_name &"'"
	strSql = strSql & ", g_card_jumin1 = '"& g_card_jumin1 &"'"
	strSql = strSql & ", g_card_jumin2 = '"& g_card_jumin2 &"'"

	'��ü ��������
	strSql = strSql & ", g_bank_cd 		= '"& g_bank_cd &"'" 
	strSql = strSql & ", g_bank_no 		= '"& g_bank_no &"'" 
	strSql = strSql & ", g_bank_name	= '"& g_bank_name &"'" 
	strSql = strSql & ", g_bank_jumin1 = '"& g_bank_jumin1 &"'"
	strSql = strSql & ", g_bank_jumin2 = '"& g_bank_jumin2 &"'"
	
	'����ǰ ���� ����
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
 
 		'�����ڵ� �α� ����
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
	g_g_option_idx				= g_option_idx						'�ɼǸ�
	g_g_trans_out_dealer		= g_trans_out_dealer				'�ΰ�ó �ڵ�
	g_g_code_promise			= g_code_promise1					'����
	g_g_sp_give_type			= g_sp_give_type					'����ǰ ����ó	(C:�ΰ�ó����)
	g_g_sp_price				= g_sp_price						'����ǰ �ݾ�
	g_g_code_sale				= g_code_sale						'�������ڵ�
	g_g_set						= g_set								'��Ʈ����
	g_g_article_cnt				= g_article_cnt						'ȸ����1
    g_g_sp_price_top			= g_sp_price_top					'�������ǰ
  %>  
  <!--#include virtual="/customer/a_charge_set_doc.asp"-->
  <%
  objCnn.Close
  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  set FSO=Nothing

  
  Alert_url " �� ��ǰ�� ��ϵǾ����ϴ�.","a_custom_goods_list.asp?g_goods_idx="&g_goods_idx&"&page="&page&"&nowblock="&nowblock&"&"&s_link_txt
  %>