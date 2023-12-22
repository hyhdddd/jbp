  <%
  Response.ContentType = "application/unknown"

  L_PIC="/file_data/"
  
  FilePath = Request("FilePath")

  If InStr(FilePath,"../")>0 Then
	Response.write "../"
	Response.end
  End if

  VFilePath = L_PIC&Request("FilePath")
  FilePath = Server.MapPath(VFilePath)

  set fso=Server.CreateObject("SiteGalaxyUpload.filesystemobject")
  set file= fso.OpenBinaryFile(FilePath,1,false)
  Response.BinaryWrite file.readall

  Set fso = nothing
  Response.End
  %>