   <%
  '====================================='
  ' 프로젝트 : 엔터소프트
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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if

  policy_idx			= WORD_CHANGE(request("policy_idx"),20)					
  policy_date			= WORD_CHANGE(request("policy_date"),20)				
  policy_date_hour		= WORD_CHANGE(request("policy_date_hour"),20)
  policy_date_minute	= WORD_CHANGE(request("policy_date_minute"),20)  
  policy_date			= policy_date & " " & policy_date_hour &":"&policy_date_minute &":00"
  group_code			= WORD_CHANGE(request("group_code"),20)			
  page					= WORD_CHANGE(request("page"),20)

  If policy_idx<>"" Then
	  strSql = "select * from charge_policy where policy_idx<>"&policy_idx&" and "
	  strSql = strSql & " group_code='"&group_code&"' and policy_date='"&policy_date&"'"
	  Set objRs=objCnn.Execute(strSql)

	  
	  If objRs.eof Or objRs.bof Then
		
	  Else
		Alert_back "같은 날짜와  정산그룹의 정책이 이미 존재합니다. \n\n 정책 확인후 정책 수정을 해 주시기 바랍니다."
		Response.end
	  End if
	  
	  strSql = " update charge_policy set "
	  strSql = strSql & " policy_date = '"& policy_date &"'"
	  strSql = strSql & ", group_code = '"& group_code &"'"
	  strSql = strSql & " where policy_idx="&policy_idx
	  set objRs=objCnn.Execute(strSql)
	  Alert_url " 정책이 수정 되었습니다. ","policy_list.asp?page="&page
  Else 
	  strSql = "select * from charge_policy where group_code='"&group_code&"' and policy_date='"&policy_date&"'"
	  Set objRs=objCnn.Execute(strSql)
	  
	  If objRs.eof Or objRs.bof Then
		
	  Else
		Alert_back "같은 날짜와  정산그룹의 정책이 이미 존재합니다. \n\n 정책 확인후 정책 수정을 해 주시기 바랍니다."
		Response.end
	  End if


	  strSql = "Select ISNULL(MAX(policy_idx)+1,1) from charge_policy "
	  set objRs=objCnn.Execute(strSql)
	  policy_idx	= objRs(0)
	  
	  strSql = " INSERT INTO charge_policy (policy_idx, policy_date, group_code, writeday )"
	  strSql = strSql & " values ("
	  strSql = strSql & "  " & policy_idx & " "
	  strSql = strSql & ",'" & policy_date & "' "
	  strSql = strSql & ",'" & group_code & "' "
	  strSql = strSql & ",getdate())"
	  set objRs=objCnn.Execute(strSql)
	  Alert_url " 정책이 등록 되었습니다. ","policy_list.asp?page="&page  
  End if

  Set objRs = Nothing
  Set objCnn = Nothing
  set UploadForm=Nothing
  
  %>
