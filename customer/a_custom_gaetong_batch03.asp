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

  strSql = "delete customer_up_temp"
  Set objRs=objCnn.Execute(strSql)
   
  Dim arry_length(5)

  Set objFSO = CreateObject("Scripting.FileSystemObject")

  filename		= Request("filename")
  filename		= Server.MapPath(filename)
  
  Set objTextFile = objFSO.OpenTextFile(filename, 1)

  'sReadAll = objTextFile.ReadAll
  
  j=0
  do while objTextFile.AtEndOfStream <> True

	readline1 = Split(objTextFile.readline,Chr(9))
	
	'ù���̸� �ʵ� ã��
	If j=0 Then
		For i=0 To UBound(readline1)

			If Trim(readline1(i))="���Լ��񽺹�ȣ" Then
				arry_length(1)=i

				'Response.write "���Լ��񽺹�ȣ("&i&") "
			End if

			If Trim(readline1(i))="�����ڸ�" Then
				arry_length(2)=i			
				'Response.write "�����ڸ�("&i&") "
			End If

			If  Trim(readline1(i))="������" Then
				arry_length(3)=i
				'Response.write "������("&i&") "
			End if

			If  Trim(readline1(i))="������" Then
				arry_length(4)=i				
				'Response.write "������("&i&") "
			End If			
		Next
    Else
		'response.write Trim(readline1(arry_length(1))) &":"&Trim(readline1(arry_length(2))) &":"&Replace(Trim(readline1(arry_length(3))),"/","-") &":"&Trim(readline1(arry_length(4))) &"<br>"

		c_service_no	= Trim(readline1(arry_length(1)))
		c_name			= Trim(readline1(arry_length(2)))
		c_gaetong_date	= Replace(Trim(readline1(arry_length(3))),"/","-")
		c_jupsu_date	= Trim(readline1(arry_length(4)))

		If c_service_no <> "" Then
			strSql = "insert into customer_up_temp (c_service_no, c_name, c_gaetong_date, c_jupsu_date,c_up_chk) "
			strSql = strSql & " values('"& c_service_no &"', '"&  c_name &"', '"& c_gaetong_date &"','"& c_jupsu_date &"','X')"
			Set objRs=objCnn.Execute(strSql)
		End if

		'response.write readline1(i)&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		
	End if

	

	j=j+1
  Loop
  
  objTextFile.close
  set objTextFile=Nothing
  set objFSO=Nothing

  'Win_link "a_custom_gaetong_batch04.asp"


  strSql = "select count(*) from customer_up_temp"
  Set objRs= objCnn.execute(strSql)

  count_chk	= objRs(0)
  %>

<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />


<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
<tr height='30'>
	<td colspan='5'> �ϰ� ������Ʈ�� ��� (<%=count_chk%>�� )</td>
</tr>
<tr height='30'>
	<td colspan='5' style='text-align:right;'><b> [<a href="a_custom_gaetong_batch04.asp">������Ʈ �����ϱ�</a>]</b> </td>
</tr>
<tr height="30">
	<th class="head">No</th> 
	<th class="head">�����ڸ�</th>
	<th class="head">���Լ��񽺹�ȣ</th>        
	<th class="head">������</th>        
	<th class="head">������</th>      
</tr>
  <%
  strSql = "select * from customer_up_temp order by board_idx asc"
  Set objRs=objCnn.Execute(strSql)
  
  i=1
  Do Until objRs.eof	
	board_idx		= objRs("board_idx")
	c_name			= objRs("c_name")
	c_service_no	= objRs("c_service_no")
	c_gaetong_date	= objRs("c_gaetong_date")
	c_jupsu_date	= objRs("c_jupsu_date")
  %>
<tr height='30'>
	<td class="con5"><%=i%></td>
	<td class='con4'><%=c_name%></td>
	<td class='con4'><%=c_service_no%></td>
	<td class='con4'><%=c_gaetong_date%></td>
	<td class='con4'><%=c_jupsu_date%></td>
</tr>
  <%
	i=i+1
	objRs.movenext
  Loop
  %>
</table>

			



