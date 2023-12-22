  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 목    적 : http://entersoft.kr
  ' 개발일자 : 2014/01/01 ~2014/12/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
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
  
  m_name		= session_m_name
  content		= WORD_CHANGE(request("content"),0)				'내용
  phone_list	= WORD_CHANGE(request("phone_list"),0)
  phone2		= WORD_CHANGE(request("phone2"),20)

  If Len(phone_list)<>0 then
	  phone_list=left(phone_list,len(phone_list)-1)
  Else
  End if
  
  phone1		= split(phone_list,"_")
  message_cnt   = ubound(phone1)+1

  'SMS 갯수 불러오기
  'SMS 기초 셋팅
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
	Alert_back " 전송가능한 SMS 갯수가 없습니다. \n\n SMS 관리 메뉴에서 SMS 를 충전해 주신 후 이용해 주시기 바랍니다!"
	Response.End
  End If

  If s_message1_cnt<message_cnt Then
	Alert_back " 전송가능한 SMS 수 보다 많아서 전송할 수 없습니다. \n\n 잔여 SMS 수 : "&s_message1_cnt&"개 입니다.\n\n 전송 SMS 수 : "&message_cnt+1 &"개 입니다. \n\n부가서비스 SMS 관리 메뉴에서 SMS를 충전하신 후 이용해 주시기 바랍니다!"
	Response.end
  End If   

  'SMS 카운터 변경
  strSql = " update SMS_MESSAGE_CNT set s_message1 = s_message1-"&message_cnt&",s_message2 = s_message2+"&message_cnt&"  "
  strSql = strSql & " WHERE s_o_code='"& o_code &"' "
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

<%	For i=1 To message_cnt %>
<input type="hidden" name="phone1" value="<%=phone1(i-1)%>">
<%	Next  %>
</form>

<script language="javascript">
<!--
	var frm=document.all.frm_sms;
	frm.submit();
-->
</script>