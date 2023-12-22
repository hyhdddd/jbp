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
  
  '같은부서, 파트너, 상사가 존재하지 않으면 B 처리
  If my_report_step="1" Then

	'글주인의 m_duty 를 구한다음....
	'm_duty의 결제권자(종사자) 가 없으면,,,, decision2_yn에 B 처리
	strSql = " select B.m_duty from emp_work_report A left outer "
	strSql = strSql & "		join emp_list B on A.w_m_id=B.m_id "
	strSql = strSql & "			where w_board_idx="&w_board_idx
	Set objRs=objCnn.Execute(strSql)
	
	If objRs.eof Or objRs.bof Then
		Alert_back " 업무일지 작성자의 부서가 존재하지 않습니다. \n\n 인사관리에서 확인해 주세요!"
		Response.end
	Else
			'종사자중에 부서 결제권자 유무 찾기
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
		Alert_back " 총결제권자(사장) 가 지정되어 있지 않습니다. \n\n 인사관리에서 확인해 주세요!"
		Response.end
	End If
			
  End if
 
  Alert_url " 결재 후 보고 하였습니다.","work_report_list.asp?page="+page
  
  objCnn.close
  Set objRs = Nothing
  Set objCnn = Nothing
  %>
