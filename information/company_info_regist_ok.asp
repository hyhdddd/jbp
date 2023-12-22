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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  If session_m_step<>"M" Then
	Alert_url session_m_name&" 님은 접근권한이 없습니다. 관리자에게 문의하세요! ","/main.asp"
  End If 

  set FSO			= Server.CreateObject("Scripting.FileSystemObject")
  'set UploadForm		= Server.CreateObject("SiteGalaxyUpload.Form")  
  Set uploadForm = Server.CreateObject("DEXT.FileUpload")
  DIR_O_CODE="/file_data"
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  UploadForm.DefaultPath = DIR_O_CODE

  o_com_name		= WORD_CHANGE(UploadForm("o_com_name"),30)				'회사 명
  o_office_no1		= WORD_CHANGE(UploadForm("o_office_no1"),20)			'회사 사업자 번호1
  o_office_no2		= WORD_CHANGE(UploadForm("o_office_no2"),20)			'회사 사업자 번호2
  o_office_no3		= WORD_CHANGE(UploadForm("o_office_no3"),20)			'회사 사업자 번호3
  o_name			= WORD_CHANGE(UploadForm("o_name"),40)					'회사 대표자명
  o_judi_no1		= WORD_CHANGE(UploadForm("o_judi_no1"),20)				'회사 법인등록번호1
  o_judi_no2		= WORD_CHANGE(UploadForm("o_judi_no2"),20)				'회사 법인등록번호2
  o_zipcode1		= WORD_CHANGE(UploadForm("o_zipcode1"),20)				'회사 우편번호1
  o_zipcode2		= WORD_CHANGE(UploadForm("o_zipcode2"),20)				'회사 우편번호2
  o_address			= WORD_CHANGE(UploadForm("o_address"),50)				'회사 주소
  o_type1			= WORD_CHANGE(UploadForm("o_type1"),20)					'회사 업태
  o_type2			= WORD_CHANGE(UploadForm("o_type2"),20)					'회사 종목
  o_tel1			= WORD_CHANGE(UploadForm("o_tel1"),20)					'대표 전화1
  o_tel2			= WORD_CHANGE(UploadForm("o_tel2"),20)					'대표 전화2
  o_tel3			= WORD_CHANGE(UploadForm("o_tel3"),20)					'대표 전화3
  o_fax1			= WORD_CHANGE(UploadForm("o_fax1"),20)					'대표 팩스1
  o_fax2			= WORD_CHANGE(UploadForm("o_fax2"),20)					'대표 팩스2
  o_fax3			= WORD_CHANGE(UploadForm("o_fax3"),20)					'대표 팩스3

  '센타 코드 폴더 생성
  DIR_O_CODE="/file_data/"&o_code
  DIR_O_CODE = Server.MapPath(DIR_O_CODE)
  
  IF fso.FolderExists(DIR_O_CODE)=false THEN
  	fso.createfolder(DIR_O_CODE)
  End If


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

			
			If strExt<>"gif" And strExt<>"jpg" Then
				Alert_back "이미지화일 GIF , JPG 만 업로드 가능합니다."
				Response.end
			End if

			strfilename = DIR_O_CODE &"/logo." & strExt 
			'Response.write strfilename
			'Response.end
			filename1="logo."&strExt
			UploadForm("g_file1").SaveAs strfilename  
   		else
			Alert_back "화일 용량이 20M을 초과할수 없습니다."
		end if   	
  end If
 
  strSql = " update company_info set "
  strSql = strSql & "  o_com_name		= '"& o_com_name &"' "  
  strSql = strSql & ", o_office_no1		= '"& o_office_no1 &"' "  
  strSql = strSql & ", o_office_no2		= '"& o_office_no2 &"' "  
  strSql = strSql & ", o_office_no3		= '"& o_office_no3 &"'"
  strSql = strSql & ", o_name			= '"& o_name &"'"
  strSql = strSql & ", o_judi_no1		= '"& o_judi_no1 &"'"
  strSql = strSql & ", o_judi_no2 		= '"& o_judi_no2 &"'" 
  strSql = strSql & ", o_zipcode1 		= '"& o_zipcode1 &"'" 
  strSql = strSql & ", o_zipcode2		= '"& o_zipcode2 &"'" 
  strSql = strSql & ", o_address		= '"& o_address &"'"
  strSql = strSql & ", o_type1			= '"& o_type1 &"'"
  strSql = strSql & ", o_type2			= '"& o_type2 &"'"
  strSql = strSql & ", o_tel1			= '"& o_tel1 &"'"
  strSql = strSql & ", o_tel2			= '"& o_tel2 &"'"
  strSql = strSql & ", o_tel3			= '"& o_tel3 &"'"
  strSql = strSql & ", o_fax1			= '"& o_fax1 &"'"
  strSql = strSql & ", o_fax2			= '"& o_fax2 &"'"
  strSql = strSql & ", o_fax3			= '"& o_fax3 &"'"

  IF len(trim(filename1))>1 THEN
	strSql = strSql & ", o_logo			= '"& filename1 &"'"
  End If

  strSql = strSql & "  where o_code = '"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)

  strSql = " update dealer_info set dealer_name='"& o_com_name &"'  where dealer_code='"&o_code&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url "회사정보가 수정 되었습니다. ","company_info_regist.asp"
  %>