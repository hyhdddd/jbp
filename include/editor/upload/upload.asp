  <%
  '====================================='
  ' ������Ʈ : SENQ OPEN MARKET
  ' ��    �� : OPEN MARKET ������ ���θ�
  ' �������� : 2008/07/01 ~2008/12/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com (����Ʈ��)
  ' ��    �� : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <%  
  tname				= WORD_CHANGE(request("tname"),30)
  funcNum			= WORD_CHANGE(request("CKEditorFuncNum"),20)
  filetype			= WORD_CHANGE(request("type"),10)


  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  sp_code=Create_code()
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
  DIR_O_CODE="/file_data/"&tname
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '���� �ڵ� - ������ - ��¥ ���� ����
  DIR_O_CODE1 ="/file_data/"&tname&"/"&CSTR(yea)&cstr(mon)     	' ���� ���� ���  
  DIR_O_CODE2 = Server.MapPath(DIR_O_CODE1)

  IF fso.FolderExists(DIR_O_CODE2)=false then
	  fso.createfolder(DIR_O_CODE2)
  end if   

  '---------------------- ȭ�� ���ε� ó���κ� ���� ----------------------'
  message = ""
  '���� ���ε� ó��
  g_file1=UploadForm("upload")
  if Len(g_file1)>0 then  
    	att_file=UploadForm("upload").filepath 
    	filesize1=UploadForm("upload").FileLen  
    	if filesize1<10000000 then   
   			filename=mid(att_file, InstrRev(att_file,"\")+1)  
    		strname=Mid(filename, 1, InstrRev(filename,".")-1)
			strname	 = file_StrDelete(strname)
			strExt=Mid(filename,InstrRev(filename,".")+1)
    		strExt=Lcase(strExt)

			file_block_check = fnc_strExt_block_up(strExt)

			If file_block_check="OK" then
				
				If LCase(filetype)="images" then
					If strExt<>"gif" And strExt<>"jpg" And strExt<>"jpeg" And strExt<>"png" Then
						Message = "�̹���ȭ�� GIF , JPG , png �� ���ε� �����մϴ�."
						file_chk ="X"
					else
						file_chk ="O"
					End If
				elseIf LCase(filetype)="flash" then
					If strExt<>"swf" Then
						message = "�÷��� (swf) ���ϸ� ���ε� �����մϴ�."
						file_chk ="X"
					Else
						file_chk ="O"
					End If
				elseIf LCase(filetype)="files" Then
						file_chk = "O"			
				End If

				If file_chk="O" then
				strfilename = DIR_O_CODE2 &"/"& sp_code & "_1." & strExt 
				filename1=sp_code&"_1."&strExt
				UploadForm("upload").SaveAs strfilename  

				fileUrl= DIR_O_CODE1&"/"&filename1

				message =  "���� ���ε带 �Ϸ� �߽��ϴ�."
				End If
			Else
				message = file_block_check
			End if
   		else
			message =  "ȭ�� �뷮�� 10M�� �ʰ��Ҽ� �����ϴ�."
		end if   
  Else
	message =  "������ ������ �ּ���!"
  end if
  '---------------------- ȭ�� ���ε� ó���κ� ���� ----------------------' 
  set UploadForm=Nothing


	
	'----------���� ���ε�� Ȯ���� üũ ----------
	Function fnc_strExt_block_up(strExt)			
	
		strExt = Lcase(strExt)
		chk="X"
		select case strExt
			'�̹��� ����
			Case "gif","jpeg","bmp","tif","tiff","jpg","png","psd","au","ogg"
				chk="O"
			'���� ����
			Case "zip","a01","a02","a03"
				chk="O"
			'���� ����
			Case "doc","hwp","xls","xlsx","ppt","csv","txt","doc","pdf","pptx"
				chk="O"
			'���� ����
			Case "wav","avi"
				chk="O"
			'�÷��� ����
			Case "swf"
				chk="O"
		end select	
		
		If chk="O" Then
			fnc_strExt_block_up = "OK"
		Else
			fnc_strExt_block_up = "���ϸ��� Ȯ���ڸ� Ȯ���� �ּ���! \n\n (�̹��� ���� : gif , jpg , bmp , tif , tiff , png , psd , au , ogg) \n\n (���� ���� : zip ,a01 , a02 , a03 ) \n\n (�������� : doc , hwp , xls , xlsx , ppt , csv , txt , doc , pdf ) \n\n (���� ���� : wav , avi ) \n\n (�÷��� ���� : swf ) \n\n ���� ����� ���ϸ� ���ε� �� �� �ֽ��ϴ�. \n\n ���ε忡 �ʿ��� Ȯ���ڰ� �����ø� 1644-5499(���ͼ���Ʈ)�� ���� �ּ���!"
		End If
	End Function 
	

  %>
  <script type="text/javascript">
    // ���� �߿��� �κ��ΰ� ������
    // ckeditor�� ������ ��ȿ�� ���� ��θ� �ѱ�� �ڵ����� �̹����� �÷��� �Ӽ� ���� ������ �̵��մϴ�.
    window.parent.CKEDITOR.tools.callFunction(<%=funcNum %>, '<%=fileUrl %>', '<%=message%>');
    //history.go(-1);
  </script>

