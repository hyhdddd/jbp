  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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
  if ad_c_code="N" then
	Alert_back session_m_name &" ���� ���������� �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if
  
  duty_idx		= WORD_CHANGE(Request("duty_idx"),20)
  duty_name		= WORD_CHANGE(request("duty_name"),20)
   
  if duty_idx<>"" then  
	strSql = " update code_duty set "
	strSql = strSql & "  duty_name = '"& duty_name &"' where duty_idx='"&duty_idx&"'"
	set objRs=objCnn.Execute(strSql)

	Alert_url "�μ� �ڵ尡 ���� �Ǿ����ϴ�. ","duty_list.asp"  
  else  

	strSql = "Select ISNULL(MAX(duty_idx)+1,1) from code_duty "
	set objRs=objCnn.Execute(strSql)
	duty_idx	= objRs(0)

	If Len(duty_idx)=1 Then
		duty_code="I00"&duty_idx
	ElseIf Len(duty_idx)=2 Then
		duty_code="I0"&duty_idx
	ElseIf Len(duty_idx)=3 Then
		duty_code="I"&duty_idx
	End If

	strSql =" select duty_code from code_duty where duty_code='"&duty_code&"'"
	set objRs=objCnn.Execute(strSql)
  
	if objRs.eof or objRs.bof then
	Else
		Alert_back "�μ� �ڵ� �ߺ��Դϴ�.. \n\n �ٽ� �Է��� �ּ���! "
		response.end
	end if  
    	
	strSql = "INSERT INTO code_duty (duty_idx, duty_code, duty_name,duty_writeday) VALUES "
	strSql = strSql & "("& duty_idx &",'"& duty_code &"','"& duty_name &"',getdate())"
	set objRs=objCnn.Execute(strSql) 

  Alert_url " �μ��ڵ尡 ��ϵǾ����ϴ�.","duty_list.asp"
  End if
  %>