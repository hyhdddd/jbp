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
  <%
  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE


  g_yuchi_m_id			= WORD_CHANGE(UploadForm("g_yuchi_m_id"),20)							'��ġ�� ���̵�
  g_jupsu_m_id			= WORD_CHANGE(UploadForm("g_jupsu_m_id"),20)							'������ ���̵�

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
  c_email				= WORD_CHANGE(UploadForm("c_email"),70)									'�̸���
  c_auth_chk			= WORD_CHANGE(UploadForm("c_auth_chk"),20)								'�߱�����
  c_jumin_date			= WORD_CHANGE(UploadForm("c_jumin_date"),20)							'�߱�����
  c_bank_cd				= WORD_CHANGE(UploadForm("c_bank_cd"),20)								'�����
  c_bank_no				= WORD_CHANGE(UploadForm("c_bank_no"),40)								'���¹�ȣ
  c_bank_name			= WORD_CHANGE(UploadForm("c_bank_name"),40)								'������

  c_bank_jumin1			= WORD_CHANGE(UploadForm("c_bank_jumin1"),20)							'��ü���� �ֹι�ȣ(����� �ٸ����)
  c_bank_jumin2			= WORD_CHANGE(UploadForm("c_bank_jumin2"),20)							'��ü���� �ֹι�ȣ(����� �ٸ����)

  g_give_type			= WORD_CHANGE(UploadForm("g_give_type"),20)								'��������
  g_give_chk			= WORD_CHANGE(UploadForm("g_give_chk"),20)								'���� ����
  c_card_cd				= WORD_CHANGE(UploadForm("c_card_cd"),20)								'ī���

  g_card_no				= WORD_CHANGE(UploadForm("g_card_no"),20)								'ī���ȣ
  g_card_gigan			= WORD_CHANGE(UploadForm("g_card_gigan"),20)							'ī�� ��ȿ�Ⱓ
  g_card_gigan1			= WORD_CHANGE(UploadForm("g_card_gigan1"),20)							'ī�� ��ȿ�Ⱓ
  g_card_name			= WORD_CHANGE(UploadForm("g_card_name"),40)								'ī����
  g_card_jumin1			= WORD_CHANGE(UploadForm("g_card_jumin1"),20)							'ī���� �ֹι�ȣ
  g_card_jumin2			= WORD_CHANGE(UploadForm("g_card_jumin2"),20)							'ī���� �ֹι�ȣ

  g_code_course_idx		= WORD_CHANGE(UploadForm("g_code_course_idx"),20)						'�� ��ǰ �������
  

  g_article_idx1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'�� ��ǰ ȸ���
  g_article_idx1_1		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'�� ��ǰ ȸ���
  g_article_idx1_2		= WORD_CHANGE(UploadForm("g_article_idx1"),20)							'�� ��ǰ ȸ���
  g_article_idx2		= WORD_CHANGE(UploadForm("g_article_idx2"),20)							'�� ��ǰ ��ǰ��
  g_set					= WORD_CHANGE(UploadForm("g_set"),20)									'��Ʈ����

  If goods_cnt="1" Then	g_set="A" End if
  If goods_cnt="2" Then	g_set="B" End if
  If goods_cnt="3" Then	g_set="C" End If
  
  If g_article_idx1="0" Or g_article_idx2="0" Then
	Alert_back " ��ǰ ������ �߸��ƽ��ϴ�. \n\n �ٽ� �Է��� �ּ���!"
  End If

  g_option_idx			= WORD_CHANGE(UploadForm("g_option_idx"),20)							'�� ��ǰ �ɼ�
  g_code_sale			= WORD_CHANGE(UploadForm("g_code_sale"),20)							'�� ��ǰ ������ �ڵ�
  g_sp_name				= WORD_CHANGE(UploadForm("g_sp_name"),40)								'����ǰ ���� - �̸� 
  g_sp_price			= WORD_CHANGE(money_chk(UploadForm("g_sp_price")),20)					'����ǰ ���� - �ݾ�
  g_sp_date_start		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start")),20)			'����ǰ ���� - ���޿�����
  g_sp_give_type		= WORD_CHANGE(UploadForm("g_sp_give_type"),20)							'����ǰ ���� - ����ó����

  g_sp_name1			= WORD_CHANGE(UploadForm("g_sp_name1"),40)								'����ǰ ���� - �̸� 
  g_sp_price1			= WORD_CHANGE(money_chk(UploadForm("g_sp_price1")),20)					'����ǰ ���� - �ݾ�
  g_sp_date_start1		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start1")),20)			'����ǰ ���� - ���޿�����
  g_sp_give_type1		= WORD_CHANGE(UploadForm("g_sp_give_type1"),20)							'����ǰ ���� - ����ó����

  g_sp_name2			= WORD_CHANGE(UploadForm("g_sp_name2"),40)								'����ǰ ���� - �̸� 
  g_sp_price2			= WORD_CHANGE(money_chk(UploadForm("g_sp_price2")),20)					'����ǰ ���� - �ݾ�
  g_sp_date_start2		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start2")),20)			'����ǰ ���� - ���޿�����
  g_sp_give_type2		= WORD_CHANGE(UploadForm("g_sp_give_type2"),20)							'����ǰ ���� - ����ó����
  g_bigo				= WORD_CHANGE(UploadForm("g_bigo"),0)									' �� ��ǰ ���
 
  g_article_idx2_1		= WORD_CHANGE(UploadForm("g_article_idx2_1"),20)						'�� ��ǰ ��ǰ��
  g_option_idx_1		= WORD_CHANGE(UploadForm("g_option_idx_1"),20)							'�� ��ǰ �ɼ�
  g_code_sale1			= WORD_CHANGE(UploadForm("g_code_sale1"),20)							'�� ��ǰ ������ �ڵ�

  g_article_idx2_2		= WORD_CHANGE(UploadForm("g_article_idx2_2"),20)						'�� ��ǰ ��ǰ��
  g_option_idx_2		= WORD_CHANGE(UploadForm("g_option_idx_2"),20)							'�� ��ǰ �ɼ�
  g_code_sale2			= WORD_CHANGE(UploadForm("g_code_sale2"),20)							'�� ��ǰ ������ �ڵ�

  '����ǰ ���µ��
  g_sp_bank_code		= WORD_CHANGE(UploadForm("g_sp_bank_code"),20)							'����ǰ���� �����ڵ�
  g_sp_bank_acount		= WORD_CHANGE(UploadForm("g_sp_bank_acount"),40)						'����ǰ���� �������
  g_sp_bank_name		= WORD_CHANGE(UploadForm("g_sp_bank_name"),40)							'����ǰ���� ���࿹����
  g_sp_bank_memo		= WORD_CHANGE(UploadForm("g_sp_bank_memo"),100)							'����ǰ���� ����޸�
  g_sp_bank_jumin1		= WORD_CHANGE(UploadForm("g_sp_bank_jumin1"),20)						'����ǰ���� ����޸�
  g_sp_bank_jumin2		= WORD_CHANGE(UploadForm("g_sp_bank_jumin2"),20)						'����ǰ���� ����޸�

  '�ΰ�����
  g_code_service1		= WORD_CHANGE(UploadForm("g_code_service1"),20)							'�ΰ�����1
  g_code_service2		= WORD_CHANGE(UploadForm("g_code_service2"),20)							'�ΰ�����1
  g_code_service3		= WORD_CHANGE(UploadForm("g_code_service3"),20)							'�ΰ�����1

  '����
  g_code_promise1		= WORD_CHANGE(UploadForm("g_code_promise1"),20)						
  g_code_promise2		= WORD_CHANGE(UploadForm("g_code_promise2"),20)						
  g_code_promise3		= WORD_CHANGE(UploadForm("g_code_promise3"),20)						


  g_article_cnt1		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt1")),20)				'ȸ����1
  g_article_cnt2		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt2")),20)				'ȸ����2
  g_article_cnt3		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt3")),20)				'ȸ����3

  g_sum_money_chk		= WORD_CHANGE(UploadForm("g_sum_money_chk"),20)							'�ջ�û��(A/B)
  g_sum_money_txt		= WORD_CHANGE(UploadForm("g_sum_money_txt"),100)							'�ջ�û�� �ؽ�Ʈ

  g_code_area			= WORD_CHANGE(money_chk(UploadForm("g_code_area")),20)					'����

  g_move_tel1			= WORD_CHANGE(UploadForm("g_move_tel1"),20)
  g_move_name			= WORD_CHANGE(UploadForm("g_move_name"),40)
  g_move_jumin1			= WORD_CHANGE(UploadForm("g_move_jumin1"),20)
  g_move_jumin2			= WORD_CHANGE(UploadForm("g_move_jumin2"),20)
  g_move_date			= WORD_CHANGE(UploadForm("g_move_date"),20)
  g_move_tel2			= WORD_CHANGE(UploadForm("g_move_tel2"),20)
  g_move_company		= WORD_CHANGE(UploadForm("g_move_company"),20)
  g_move_memo			= WORD_CHANGE(UploadForm("g_move_memo"),100)

  '�������ǰ
  g_sp_name_top1		= WORD_CHANGE(UploadForm("g_sp_name_top1"),40)							'���� ����ǰ - �̸� 
  g_sp_price_top1		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top1")),20)				'���� ����ǰ - �ݾ�

  g_sp_name_top2		= WORD_CHANGE(UploadForm("g_sp_name_top2"),40)							'���� ����ǰ - �̸� 
  g_sp_price_top2		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top2")),20)				'���� ����ǰ - �ݾ�

  g_sp_name_top3		= WORD_CHANGE(UploadForm("g_sp_name_top3"),40)							'���� ����ǰ - �̸� 
  g_sp_price_top3		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top3")),20)				'���� ����ǰ - �ݾ�


  goods_settop1_chk		= WORD_CHANGE(UploadForm("goods_settop1_chk"),40)
  goods_settop2_chk		= WORD_CHANGE(UploadForm("goods_settop2_chk"),40)

  g_article_idx2_4		= WORD_CHANGE(UploadForm("g_article_idx2_4"),20)						'�� ��ǰ ��ǰ��
  g_option_idx_4		= WORD_CHANGE(UploadForm("g_option_idx_4"),20)							'�� ��ǰ �ɼ�
  g_code_sale4			= WORD_CHANGE(UploadForm("g_code_sale4"),20)							'�� ��ǰ ������ �ڵ�
  g_code_promise4		= WORD_CHANGE(UploadForm("g_code_promise4"),20)		
  g_code_service4		= WORD_CHANGE(UploadForm("g_code_service4"),20)							'�ΰ�����1
  g_article_cnt4		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt4")),20)				'ȸ����3
  g_sp_name4			= WORD_CHANGE(UploadForm("g_sp_name4"),40)		
  g_sp_price4			= WORD_CHANGE(money_chk(UploadForm("g_sp_price4")),20)					'���� ����ǰ - �ݾ�
  g_sp_date_start4		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start4")),20)			'����ǰ ���� - ���޿�����
  g_sp_give_type4		= WORD_CHANGE(UploadForm("g_sp_give_type4"),20)							'����ǰ ���� - ����ó����
  g_sp_name_top4		= WORD_CHANGE(UploadForm("g_sp_name_top4"),40)	
  g_sp_price_top4		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top4")),20)				

  g_article_idx2_5		= WORD_CHANGE(UploadForm("g_article_idx2_5"),20)						'�� ��ǰ ��ǰ��
  g_option_idx_5		= WORD_CHANGE(UploadForm("g_option_idx_5"),20)							'�� ��ǰ �ɼ�
  g_code_sale5			= WORD_CHANGE(UploadForm("g_code_sale5"),20)							'�� ��ǰ ������ �ڵ�
  g_code_promise5		= WORD_CHANGE(UploadForm("g_code_promise5"),20)		
  g_code_service5		= WORD_CHANGE(UploadForm("g_code_service5"),20)							'�ΰ�����1
  g_article_cnt5		= WORD_CHANGE(money_chk(UploadForm("g_article_cnt5")),20)				'ȸ����3
  g_sp_name5			= WORD_CHANGE(UploadForm("g_sp_name5"),40)		
  g_sp_price5			= WORD_CHANGE(money_chk(UploadForm("g_sp_price5")),20)					'���� ����ǰ - �ݾ�
  g_sp_date_start5		= WORD_CHANGE(date_null_chk(UploadForm("g_sp_date_start5")),20)			'����ǰ ���� - ���޿�����
  g_sp_give_type5		= WORD_CHANGE(UploadForm("g_sp_give_type5"),20)							'����ǰ ���� - ����ó����
  g_sp_name_top5		= WORD_CHANGE(UploadForm("g_sp_name_top5"),40)	
  g_sp_price_top5		= WORD_CHANGE(money_chk(UploadForm("g_sp_price_top5")),20)				


  g_code_combine1		= WORD_CHANGE(money_chk(UploadForm("g_code_combine1")),40)		
  g_code_combine2		= 0		
  g_code_combine3		= 0	
  g_code_combine4		= 0		
  g_code_combine5		= 0


  '������Ʈ üũ

  strSql = " select * from customer_goods_black where black_jumin1='"&c_jumin1&"' and black_jumin2='"&c_jumin2&"'"
  Set objRs=objCnn.execute(strSql)

  If objRs.eof Or objRs.bof Then
	black_type	= ""
  Else
	black_type	= objRs("black_type")

	If black_type="C" Then
		Alert " �Է��Ͻ� ���� ������Ʈ�� �ҷ������� ��ϵǾ� �����Ƿ� û���� ���� �ʴ� ���Դϴ�."
		win_close()
	End if
  End If

  '�ʱ� ������� �ڵ� �Է� 
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

			filename4	= strfilename
			strfilename	= DIR_O_CODE &"/"& strfilename
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

  '------------------ �ڵ����� ���� ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'�����ڵ�
	c_g_article_idx2		= g_article_idx2		'��ǰ
	c_g_option_idx			= g_option_idx			'��ǰ�ɼ�
	c_g_code_promise_idx	= g_code_promise1		'��ǰ����
	c_g_sp_give_type		= g_sp_give_type		'����ǰ ��ġ�� ����
	c_g_code_sale			= g_code_sale			'������
	c_g_sp_price			= g_sp_price			'����ǰ
	c_g_article_cnt			= g_article_cnt1		'ȸ����1
	c_g_sp_price_top		= g_sp_price_top1		'�������ǰ

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

 	'������� �̷� �߰�

	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&g_yuchi_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

  '------------------ �ڵ����� ���� ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'�����ڵ�
	c_g_article_idx2		= g_article_idx2_1		'��ǰ
	c_g_option_idx			= g_option_idx_1		'��ǰ�ɼ�
	c_g_code_promise_idx	= g_code_promise2		'��ǰ����
	c_g_sp_give_type		= g_sp_give_type1		'����ǰ ��ġ�� ����
	c_g_code_sale			= g_code_sale1			'������
	c_g_sp_price			= g_sp_price1
	c_g_article_cnt			= g_article_cnt2		'ȸ����2
	c_g_sp_price_top		= g_sp_price_top2		'�������ǰ

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

 	'������� �̷� �߰�

	strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
	strSql = strSql & "values ("&g_goods_idx&",'"&g_yuchi_m_id&"','"&g_code_gaetong_idx&"',getdate())"
	Set objRs=objCnn.Execute(strSql)

  '------------------ �ڵ����� ���� ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'�����ڵ�
	c_g_article_idx2		= g_article_idx2_2		'��ǰ
	c_g_option_idx			= g_option_idx_2		'��ǰ�ɼ�
	c_g_code_promise_idx	= g_code_promise3		'��ǰ����
	c_g_sp_give_type		= g_sp_give_type2		'����ǰ ��ġ�� ����
	c_g_code_sale			= g_code_sale2			'������
	c_g_sp_price			= g_sp_price2			'����ǰ
	c_g_article_cnt			= g_article_cnt3		'ȸ����3
	c_g_sp_price_top		= g_sp_price_top3		'�������ǰ

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

   '------------------ �ڵ����� ���� ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'�����ڵ�
	c_g_article_idx2		= g_article_idx2_4		'��ǰ
	c_g_option_idx			= g_option_idx_4		'��ǰ�ɼ�
	c_g_code_promise_idx	= g_code_promise4		'��ǰ����
	c_g_sp_give_type		= g_sp_give_type4		'����ǰ ��ġ�� ����
	c_g_code_sale			= g_code_sale4			'������
	c_g_sp_price			= g_sp_price4			'����ǰ
	c_g_article_cnt			= g_article_cnt4		'ȸ����1
	c_g_sp_price_top		= g_sp_price_top4		'�������ǰ

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

   '------------------ �ڵ����� ���� ----------------
    c_g_trans_in_dealer		= g_trans_in_dealer		'�����ڵ�
	c_g_article_idx2		= g_article_idx2_5		'��ǰ
	c_g_option_idx			= g_option_idx_5		'��ǰ�ɼ�
	c_g_code_promise_idx	= g_code_promise5		'��ǰ����
	c_g_sp_give_type		= g_sp_give_type5		'����ǰ ��ġ�� ����
	c_g_code_sale			= g_code_sale5			'������
	c_g_sp_price			= g_sp_price5			'����ǰ
	c_g_article_cnt			= g_article_cnt5		'ȸ����1
	c_g_sp_price_top		= g_sp_price_top5		'�������ǰ

  %>
  <!--#include virtual="/customer/a_charge_set.asp"--> 
  <%
  End If
    
  If black_type="A" Then
	  Alert " �Է��Ͻ� ���� ������Ʈ ������ ���� �� �Դϴ�. ������ �ּ���!\n\n �� ��ǰ�� �Ǿ����ϴ�."
  ElseIf black_type="B" then
	  Alert " �Է��Ͻ� ���� ������Ʈ ������ ��� �� �Դϴ�. ������ �ּ���!\n\n �� ��ǰ�� ��ϵǾ����ϴ�."
  else
	  Alert " �� ��ǰ�� ��ϵǾ����ϴ�."
  End If
  win_close()
  %>