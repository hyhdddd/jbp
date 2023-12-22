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

  m_name			=  session_m_name
  content			= WORD_CHANGE(request("content"),0)
  phone1			= WORD_CHANGE(Request("phone1"),15)								'수신번호
  phone2			= WORD_CHANGE(Request("phone2"),15)								'발신번호
  

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
	strSql = strSql & ", 400, 0 "
	strSql = strSql & ", Getdate()) "	
	Set objRs=objCnn.Execute(strSql)
  End if

  'SMS 갯수 불러오기
  strSql = " select s_message1 from sms_message_cnt where s_o_code='"&o_code&"' "
  Set objRs=objCnn.Execute(strSql)

  s_message1_cnt = objRs(0)

  If s_message1_cnt>0 Then
	strSql = " update SMS_MESSAGE_CNT set s_message1 = s_message1-1,s_message2 = s_message2+1  "
	strSql = strSql & " WHERE s_o_code='"& o_code &"' "
	Set objRs=objCnn.Execute(strSql)
  Else
	Alert_back " SMS 를 발송할 수 없습니다. (SMS 문자메세지를 충전해야 합니다.) \n\n 부가서비스 - SMS 문자 전송내역 메뉴에서 충전할 수 있습니다. "
	Response.end 
  End If
  
  URL_NAME	= UCase(Request.ServerVariables("SERVER_NAME"))
  %>

<form method="post" action="http://entersoft.kr/sms/sms_send_ok.asp" name="frm_sms">
<input type="hidden" name="o_code" value="<%=o_code%>">
<input type="hidden" name="m_id" value="<%=session_m_id%>">
<input type="hidden" name="m_name" value="<%=m_name%>">
<input type="hidden" name="URL_NAME" value="<%=url_name%>">
<input type="hidden" name="phone1" value="<%=phone1%>">
<input type="hidden" name="phone2" value="<%=phone2%>">
<input type="hidden" name="content" value="<%=content%>">
</form>

<script language="javascript">
<!--
	var frm=document.all.frm_sms;
	frm.submit();
-->
</script>