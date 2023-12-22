<%
  Session.codepage = "949"
  Response.charset="euc-kr"
  fname	= request("fname")
  fpath	= request("fpath")
  
  '크롬다운시 체크
  If InStr(Request.ServerVariables("HTTP_USER_AGENT"), "Chrome") > 0 Then
	Response.ContentType = "application/x-download"
    Response.AddHeader "Content-Disposition","attachment; filename="&fname
  Else
	Response.ContentType = "application/x-download"
    Response.AddHeader "Content-Disposition","attachment; filename="&fname
	Response.AddHeader "Content-Transfer-Encoding", "binary"
	Response.AddHeader "Preagma", "no-cache"
	Response.AddHeader "Expires", "0"
  End If


Dim phyFilePath, objFs, objStream, strFile

DOWN_DIR = "/file_data/"&FPATH&FNAME

if instr(DOWN_DIR,"../")>0 Or instr(LCase(DOWN_DIR),".asp")>0 then
	Response.Write "잘못된 접근 입니다."
	Response.end
end if

phyFilePath = Server.MapPath(DOWN_DIR)   


Set objFs = Server.CreateObject("scripting.FileSystemObject")

If Not objFs.FileExists(phyFilePath) Then
	Response.Write "파일이 존재하지 않습니다."
	Response.end
Else
	Set objStream = Server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.Type=1
	objStream.LoadFromFile phyFilePath
	strFile = objStream.Read
	Response.BinaryWrite strFile
End If

Set strFile = Nothing
Set objStream = Nothing
Set objFs = Nothing
%>

