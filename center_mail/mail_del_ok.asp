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

  set FSO=Server.CreateObject("Scripting.FileSystemObject")

  mail_list_idx	= WORD_CHANGE(request("mail_list_idx"),20)
  message_idx 	= WORD_CHANGE(request("message_idx"),20)
  message_chk 	= WORD_CHANGE(request("message_chk"),20)
     
  if message_chk = "send" then   
	' ���� �ε��� O ó��
  	strSql = "update mail_message set delete_day=getdate(), message_del='O' where board_idx="&message_idx
  	set objRs=objCnn.Execute(stRSql)

	'������� Ȯ���� ������ ���ų� ��� ����(F) �� �����̸�, ���� ���� ���� ��
	' mail_message ���� �� ÷������ ����
	strSql = "select * from mail_list where message_idx="&message_idx&" and message_del<>'F'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		strSql = " Select * from mail_message where board_idx="&message_idx
		'response.write strSql
		Set objRs1=objCnn.Execute(strSql)

		fname1			= objRs1("file1")

		If fname1<>"" Then
			DEL_DIR1="/file_data/"&o_code &"/MAIL"&fname1
			DEL_DIR1 = Server.MapPath(DEL_DIR1)
			
			if fso.FileExists(DEL_DIR1) then 
				fileo=fso.DeleteFile(DEL_DIR1) 
			end if   

		End If

		'�������� ����
		strSql = " delete mail_message where board_idx="&message_idx
		Set objRs=objCnn.Execute(strSql)
		
		'���� ������ϵ� ��� ����
		strSql = " delete mail_list where message_idx="&message_idx
		Set objRs=objCnn.Execute(strSql)
		
	End If
	
  Elseif message_chk="to" Then  
  		strSql = "update mail_list set delete_day=getdate(), message_del='O' "
		strSql = strSql & " where board_idx="&mail_list_idx
	  	set objRs=objCnn.Execute(stRSql)  	
  Elseif message_chk="del" Then
  		strSql = "update mail_list set delete_day=getdate(),message_del='F' where board_idx="&mail_list_idx
	  	set objRs=objCnn.Execute(stRSql)  	

		strSql = " select * from mail_list where message_idx="&message_idx&" and message_del<>'F'"
		Set objRs=objCnn.Execute(strSql)

		If objRs.eof Or objRs.bof Then
			strSql = "select * from mail_message where board_idx="&message_idx&" and message_del='O'"
			Set objRs1=objCnn.Execute(strSql)

			If objRs1.eof Or objRs1.bof Then
			else
				fname1			= objRs1("file1")

				If fname1<>"" Then
					DEL_DIR1="/file_data/"&o_code &"/MAIL"&fname1
					DEL_DIR1 = Server.MapPath(DEL_DIR1)
					
					if fso.FileExists(DEL_DIR1) then 
						fileo=fso.DeleteFile(DEL_DIR1) 
					end if 
				End If

				'�������� ����
				strSql = " delete mail_message where board_idx="&message_idx
				Set objRs=objCnn.Execute(strSql)
				
				'���� ������ϵ� ��� ����
				strSql = " delete mail_list where message_idx="&message_idx
				Set objRs=objCnn.Execute(strSql)				

			End if
		End if
  end if	
  
  if message_chk="send" Then
	Alert_url " ������ ���������� �����Ͽ����ϴ�.","mail_send_list.asp"
  elseif message_chk="to" Then
	Alert_url " ������ ���������� �����Ͽ����ϴ�.","mail_to_list.asp"
  elseif message_chk="del" Then
	Alert_url " ������ ���������� �����Ͽ����ϴ�.","mail_del_list.asp"
  end if
  %>
