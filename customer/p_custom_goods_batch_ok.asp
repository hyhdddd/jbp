 <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
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

  set FSO				= Server.CreateObject("Scripting.FileSystemObject")  
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  g_goods_idx			= WORD_CHANGE(UploadForm("g_goods_idx"),20)


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
	If g_file11<>"" then
		DIR_O_CODE="/file_data/"&o_code&"/customer/"&g_file44
		DIR_O_CODE = Server.MapPath(DIR_O_CODE)
			
		if fso.FileExists(DIR_O_CODE) then 
			fileo=fso.DeleteFile(DIR_O_CODE) 
		end if 
    End if
	FILENAME4=CSTR(yea)+cstr(mon)+"/"+filename4
  end if 
 

	strSql = " update customer_goods set g_o_code='"&o_code&"' "

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

	strSql = strSql & " where g_goods_idx="&g_goods_idx
	'Response.write strSql &"<br><br>"
	Set objRs=objCnn.Execute(strSql)

  Alert "�������� ���� �Ǿ����ϴ�."
  %>
  <script language="javascript">
  <!--
	//opener.document.location.reload();
    //parent.window.close();
	window.close();
  -->
  </script>
