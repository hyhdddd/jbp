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
  
  m_name			= session_m_name
  content			= WORD_CHANGE(request("content"),0)
  group_idx			= WORD_CHANGE(Request("group_idx"),0)
  group_idx			= Split(group_idx,",")
  phone2			= WORD_CHANGE(Request("phone2"),20)

  senddate			= Left(now,10) & " "& FormatDateTime(now,4)  


  strSql = " select count(*) from sms_group_emp where o_code='"&o_code&"'"

  For i=0 To UBound(group_idx)
	  If i=0 Then 
		strSql = strSql & " and group_idx="& Trim(group_idx(i))   
	  Else		
		strSql = strSql & " or group_idx="& Trim(group_idx(i))    
	  End if
  Next
  
  Set objRs=objCnn.Execute(strSql)

  message_cnt = objRs(0)

  If message_cnt=0 Then
	Alert_back "������ SMS �׷쿡 ������ ����� �������� �ʽ��ϴ�."
	Response.end
  End If

  'SMS ���� �ҷ�����
  'SMS ���� ����
  strSql = " select * from SMS_MESSAGE_CNT  where s_o_code='"&o_code&"' "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then	
	strSql = " SELECT ISNULL(MAX(s_board_idx)+1,1) from SMS_MESSAGE_CNT "
	Set objRs=objCnn.Execute(strSql)

	s_board_idx	= objRs(0)

	strSql = " INSERT INTO SMS_MESSAGE_CNT (s_board_idx, s_o_code, s_message1, s_message2, s_writeday)"
	strSql = strSql & " values ("
	strSql = strSql & "  "& s_board_idx &" "
	strSql = strSql & ", '"& o_code &"'"
	strSql = strSql & ", 400, 0, "
	strSql = strSql & ", Getdate()) "	
	Set objRs=objCnn.Execute(strSql)
  End If
  

  strSql = " select s_message1 from sms_message_cnt where s_o_code='"&o_code&"' "
  Set objRs=objCnn.Execute(strSql)

  s_message1_cnt = objRs(0)


  If s_message1_cnt=0 Or s_message1_cnt<0 Then
	Alert_back " ���۰����� SMS ������ �����ϴ�. \n\n SMS ���� �޴����� SMS �� ������ �ֽ� �� �̿��� �ֽñ� �ٶ��ϴ�!"
	Response.End
  End If

  If s_message1_cnt<message_cnt Then
	Alert_back " ���۰����� SMS �� ���� ���Ƽ� ������ �� �����ϴ�. \n\n �ܿ� SMS �� : "&s_message1_cnt&"�� �Դϴ�.\n\n ���� SMS �� : "&message_cnt &"�� �Դϴ�. \n\n�ΰ����� SMS ���� �޴����� SMS�� �����Ͻ� �� �̿��� �ֽñ� �ٶ��ϴ�!"
	Response.end
  End If
  
   
  'SMS ī���� ����
  strSql = " update SMS_MESSAGE_CNT set s_message1 = s_message1-"&message_cnt&",s_message2 = s_message2+"&message_cnt&"  "
  strSql = strSql & " WHERE s_o_code='"& o_code &"' "
  Set objRs=objCnn.Execute(strSql)
 

  strSql = "select B.m_tel2 from sms_group_emp A left outer join "
  strSql = strSql & "	emp_list B ON A.emp_idx=B.m_idx "
  strSql = strSql & "		 where A.o_code='"&o_code&"' "

  For i=0 To UBound(group_idx)
	   If i=0 Then 
		strSql = strSql & " and A.group_idx="& Trim(group_idx(i))   
	  Else		
		strSql = strSql & " or A.group_idx="& Trim(group_idx(i))    
	  End if
  Next
  
  Set objRs=objCnn.Execute(strSql) 




  URL_NAME	= UCase(Request.ServerVariables("SERVER_NAME"))
  %>


<form method="post" action="http://entersoft.kr/sms/sms_send_ok.asp" name="frm_sms">
<input type="hidden" name="o_code" value="<%=o_code%>">
<input type="hidden" name="m_id" value="<%=session_m_id%>">
<input type="hidden" name="m_name" value="<%=m_name%>">
<input type="hidden" name="URL_NAME" value="<%=url_name%>">
<input type="hidden" name="phone2" value="<%=phone2%>">
<input type="hidden" name="content" value="<%=content%>">
<% 
	i=1
	Do Until objRs.eof 
		phone1 = objRs("m_tel2") 
%>
<input type="hidden" name="phone1" value="<%=phone1%>">
<% 
		i=i+1
		objRs.movenext 
	Loop 
%>
</form>

<script language="javascript">
<!--
	var frm=document.all.frm_sms;
	frm.submit();
-->
</script>