  <%
  '====================================='
  ' 프로젝트 : SENQ OPEN MARKET
  ' 목    적 : OPEN MARKET 형태의 쇼핑몰
  ' 개발일자 : 2008/07/01 ~2008/12/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com (네이트온)
  ' 문    의 : 011-9619-8280
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


  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 폴더 생성 
  DIR_O_CODE="/file_data/"&tname
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If

  '센터 코드 - 고객정보 - 날짜 폴더 생성
  DIR_O_CODE1 ="/file_data/"&tname&"/"&CSTR(yea)&cstr(mon)     	' 폴더 생성 경로  
  DIR_O_CODE2 = Server.MapPath(DIR_O_CODE1)

  IF fso.FolderExists(DIR_O_CODE2)=false then
	  fso.createfolder(DIR_O_CODE2)
  end if   

  '---------------------- 화일 업로드 처리부분 시작 ----------------------'
  message = ""
  '파일 업로드 처리
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
						Message = "이미지화일 GIF , JPG , png 만 업로드 가능합니다."
						file_chk ="X"
					else
						file_chk ="O"
					End If
				elseIf LCase(filetype)="flash" then
					If strExt<>"swf" Then
						message = "플래쉬 (swf) 파일만 업로드 가능합니다."
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

				message =  "파일 업로드를 완료 했습니다."
				End If
			Else
				message = file_block_check
			End if
   		else
			message =  "화일 용량이 10M을 초과할수 없습니다."
		end if   
  Else
	message =  "파일을 선택해 주세요!"
  end if
  '---------------------- 화일 업로드 처리부분 시작 ----------------------' 
  set UploadForm=Nothing


	
	'----------파일 업로드시 확장자 체크 ----------
	Function fnc_strExt_block_up(strExt)			
	
		strExt = Lcase(strExt)
		chk="X"
		select case strExt
			'이미지 파일
			Case "gif","jpeg","bmp","tif","tiff","jpg","png","psd","au","ogg"
				chk="O"
			'압축 파일
			Case "zip","a01","a02","a03"
				chk="O"
			'문서 파일
			Case "doc","hwp","xls","xlsx","ppt","csv","txt","doc","pdf","pptx"
				chk="O"
			'녹취 파일
			Case "wav","avi"
				chk="O"
			'플레쉬 파일
			Case "swf"
				chk="O"
		end select	
		
		If chk="O" Then
			fnc_strExt_block_up = "OK"
		Else
			fnc_strExt_block_up = "파일명의 확장자를 확인해 주세요! \n\n (이미지 파일 : gif , jpg , bmp , tif , tiff , png , psd , au , ogg) \n\n (압축 파일 : zip ,a01 , a02 , a03 ) \n\n (문서파일 : doc , hwp , xls , xlsx , ppt , csv , txt , doc , pdf ) \n\n (녹취 파일 : wav , avi ) \n\n (플레쉬 파일 : swf ) \n\n 위에 언급한 파일만 업로드 할 수 있습니다. \n\n 업로드에 필요한 확장자가 있으시면 1644-5499(엔터소프트)로 연락 주세요!"
		End If
	End Function 
	

  %>
  <script type="text/javascript">
    // 가장 중요한 부분인것 같군요
    // ckeditor의 순번과 유효한 파일 경로만 넘기면 자동으로 이미지나 플래쉬 속성 변경 탭으로 이동합니다.
    window.parent.CKEDITOR.tools.callFunction(<%=funcNum %>, '<%=fileUrl %>', '<%=message%>');
    //history.go(-1);
  </script>

