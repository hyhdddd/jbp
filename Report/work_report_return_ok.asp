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

  page			= Request("page")
  w_board_idx 	= WORD_CHANGE(request("w_board_idx"),20)
  

  strSql = " select m_duty , all_decision , duty_decision from emp_list"
  strSql = stRSql & " where m_id='"&session_m_id &"'"
  set objRs=objCnn.Execute(stRsql)
  
  m_duty			= objRs("m_duty")
  all_decision		= objRs("all_decision")
  duty_decision		= objRs("duty_decision")
  
  If all_decision="O" Then
	my_report_step="3"
  Elseif duty_decision="O" Then
	my_report_step="2"
  Else
	my_report_step="1"
  End If
  

  strSql = " update emp_work_report set w_decision"&my_report_step&"_yn='Y' where w_board_idx="&w_board_idx
  set objRs=objCnn.Execute(strSql)
  
  '�����μ�, ��Ʈ��, ��簡 �������� ������ B ó��
  If my_report_step="1" Then

	'�������� m_duty �� ���Ѵ���....
	'm_duty�� ��������(������) �� ������,,,, decision2_yn�� B ó��
	strSql = " select B.m_duty from emp_work_report A left outer "
	strSql = strSql & "		join emp_list B on A.w_m_id=B.m_id "
	strSql = strSql & "			where w_board_idx="&w_board_idx
	Set objRs=objCnn.Execute(strSql)
	
	If objRs.eof Or objRs.bof Then
		Alert_back " �������� �ۼ����� �μ��� �������� �ʽ��ϴ�. \n\n �λ�������� Ȯ���� �ּ���!"
		Response.end
	Else
			'�������߿� �μ� �������� ���� ã��
			m_duty = objRs("m_duty")

			strSql = " select duty_decision from emp_list "
			strSql = strSql & " where m_duty='"& m_duty &"' and duty_decision='O' and m_status='O'"
			Set objRs=objCnn.Execute(strSql)

			If objRs.eof Or objRs.bof Then
				strSql = " update emp_work_report set w_decision2_yn='B' where w_board_idx="& w_board_idx
				set objRs=objCnn.Execute(strSql)
			Else
					blank_chk=""			
			End if
	End if


  ElseIf my_report_step="2" then

	strSql = " select all_decision from emp_list "
	strSql = strSql & " where all_decision='O' and m_status='O'"
	Set objRs=objCnn.Execute(strSql)

	If objRs.eof Or objRs.bof Then
		Alert_back " �Ѱ�������(����) �� �����Ǿ� ���� �ʽ��ϴ�. \n\n �λ�������� Ȯ���� �ּ���!"
		Response.end
	End If
			
  End if
 
  Alert_url " ���� �� ���� �Ͽ����ϴ�.","work_report_list.asp?page="+page
  
  objCnn.close
  Set objRs = Nothing
  Set objCnn = Nothing
  %>
