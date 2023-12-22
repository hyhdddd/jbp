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

  c_m_gamang_idx			= WORD_CHANGE(Request("c_m_gamang_idx"),20)
  c_m_m_id					= WORD_CHANGE(Request("c_m_m_id"),20)
  c_m_name					= WORD_CHANGE(Request("c_m_name"),20)
  c_m_course_idx			= WORD_CHANGE(Request("c_m_course_idx"),20)
  c_m_sex					= WORD_CHANGE(Request("c_m_sex"),20)
  c_m_jumin1				= WORD_CHANGE(Request("c_m_jumin1"),20)
  c_m_jumin2				= WORD_CHANGE(Request("c_m_jumin2"),20)
  c_m_zipcode1				= WORD_CHANGE(Request("c_m_zipcode1"),20)
  c_m_zipcode2				= WORD_CHANGE(Request("c_m_zipcode2"),20)
  c_m_address				= WORD_CHANGE(Request("c_m_address"),50)
  c_m_htel1					= WORD_CHANGE(Request("c_m_htel1"),30)
  c_m_mtel1					= WORD_CHANGE(Request("c_m_mtel1"),30)
  c_m_use_goods1			= WORD_CHANGE(Request("c_m_use_goods1"),40)
  c_m_use_goods2			= WORD_CHANGE(Request("c_m_use_goods2"),40)
  c_m_use_goods3			= WORD_CHANGE(Request("c_m_use_goods3"),40)
  c_m_use_goods4			= WORD_CHANGE(Request("c_m_use_goods4"),40)
  c_m_use_goods1_gita		= WORD_CHANGE(Request("c_m_use_goods1_gita"),50)
  c_m_use_goods2_gita		= WORD_CHANGE(Request("c_m_use_goods2_gita"),50)
  c_m_use_goods3_gita		= WORD_CHANGE(Request("c_m_use_goods3_gita"),50)
  c_m_use_goods4_gita		= WORD_CHANGE(Request("c_m_use_goods4_gita"),50)  
  c_m_content				= WORD_CHANGE(Request("c_m_content"),0)
  c_m_goods					= WORD_CHANGE(Request("c_m_goods"),30)

  If c_m_gamang_idx<>"" Then 
  	strsql = "select * from customer_gamang where c_m_gamang_idx="&c_m_gamang_idx
  	set objRs=objCnn.execute(strsql)
  	
  	if objRs.bof or objRs.eof then
		Alert_back " 접근이 잘못 됐습니다."  		
  	else
  		c_m_m_id1 = objRs("c_m_m_id")
  		
  		if c_m_m_id1<>session_m_id then
  			'Alert_back " 최초 접수자와 관리자만 가망고객 수정이 가능합니다."
  			'response.end
  		end if
  	end If
	
  	strSql = " update customer_gamang set "
	strSql = strSql & "  c_m_course_idx = '"&c_m_course_idx &"'"  
	strSql = strSql & ", c_m_name = '"&c_m_name &"'"  
	strSql = strSql & ", c_m_sex = '"&c_m_sex &"'"  
	strSql = strSql & ", c_m_zipcode1 = '"&c_m_zipcode1 &"'"  
	strSql = strSql & ", c_m_zipcode2 = '"&c_m_zipcode2 &"'"  
	strSql = strSql & ", c_m_address = '"&c_m_address &"'"  
	strSql = strSql & ", c_m_htel1 = '"&c_m_htel1 &"'"  
	strSql = strSql & ", c_m_mtel1 = '"&c_m_mtel1 &"'"  
	strSql = strSql & ", c_m_jumin1 = '"&c_m_jumin1 &"'"  
	strSql = strSql & ", c_m_jumin2 = '"&c_m_jumin2 &"'"  
	strSql = strSql & ", c_m_use_goods1 = '"&c_m_use_goods1 &"'"  
	strSql = strSql & ", c_m_use_goods2 = '"&c_m_use_goods2 &"'"  
	strSql = strSql & ", c_m_use_goods3 = '"&c_m_use_goods3 &"'"  
	strSql = strSql & ", c_m_use_goods4 = '"&c_m_use_goods4 &"'" 
	strSql = strSql & ", c_m_use_goods1_gita = '"&c_m_use_goods1_gita &"'"  
	strSql = strSql & ", c_m_use_goods2_gita = '"&c_m_use_goods2_gita &"'"  
	strSql = strSql & ", c_m_use_goods3_gita = '"&c_m_use_goods3_gita &"'"  
	strSql = strSql & ", c_m_use_goods4_gita = '"&c_m_use_goods4_gita &"'" 
	strSql = strSql & ", c_m_goods = '"&c_m_goods &"'" 
	strSql = strSql & ", c_m_content = '"&c_m_content &"'" 
	strSql = strSql & "  where c_m_gamang_idx="&c_m_gamang_idx	
	set objRs=objCnn.Execute(strSql)

  Else
  
	strSql = "select ISNULL(MAX(c_m_gamang_idx)+1,1) from customer_gamang"
	Set objRs=objCnn.Execute(strSql)

	c_m_gamang_idx=objRs(0)

	strSql = "INSERT INTO customer_gamang (c_m_gamang_idx, c_m_o_code, c_m_m_id, c_m_course_idx, c_m_name, c_m_sex, c_m_zipcode1, "
	strSql = strSql & " c_m_zipcode2, c_m_address ,c_m_htel1, c_m_mtel1, c_m_jumin1, c_m_jumin2, c_m_use_goods1, "
	strSql = strSql & " c_m_use_goods2, c_m_use_goods3, c_m_use_goods4, c_m_use_goods1_gita, c_m_use_goods2_gita, "
	strSql = strsql & " c_m_use_goods3_gita, c_m_use_goods4_gita,"
	strSql = strSql & " c_m_goods,c_m_content,c_m_writeday) VALUES "
	strSql = strSql & "( " & c_m_gamang_idx & " "
	strSql = strSql & ",'" & o_code & "'"
	strSql = strSql & ",'" & c_m_m_id & "'"
	strSql = strSql & ",'" & c_m_course_idx & "'"
	strSql = strSql & ",'" & c_m_name & "'"
	strSql = strSql & ",'" & c_m_sex & "'"
	strSql = strSql & ",'" & c_m_zipcode1 & "'"
	strSql = strSql & ",'" & c_m_zipcode2 & "'"
	strSql = strSql & ",'" & c_m_address & "'"
	strSql = strSql & ",'" & c_m_htel1 & "'"
	strSql = strSql & ",'" & c_m_mtel1 & "'"
	strSql = strSql & ",'" & c_m_jumin1 & "'"
	strSql = strSql & ",'" & c_m_jumin2 & "'"
	strSql = strSql & ",'" & c_m_use_goods1 & "'"
	strSql = strSql & ",'" & c_m_use_goods2 & "'"
	strSql = strSql & ",'" & c_m_use_goods3 & "'"
	strSql = strSql & ",'" & c_m_use_goods4 & "'"	
	strSql = strSql & ",'" & c_m_use_goods1_gita & "'"
	strSql = strSql & ",'" & c_m_use_goods2_gita & "'"
	strSql = strSql & ",'" & c_m_use_goods3_gita & "'"
	strSql = strSql & ",'" & c_m_use_goods4_gita & "'"	
	strSql = strSql & ",'" & c_m_goods & "'"	
	strSql = strSql & ",'" & c_m_content & "',Getdate())"	
	set objRs=objCnn.Execute(strSql)	

   
	  consult_bigo				= Trim(Request("consult_bigo"))			'비고
	  consult_bigo 				= CheckWord(consult_bigo)
	  consult_type				= "A"
		
	  consult_date				= Request("consult_date")
	  consult_date_hour			= Request("consult_date_hour")  
	  consult_date_minute		= Request("consult_date_minute")  

	  if consult_date="" Then
		consult_date=""
	  else
		consult_date1 = consult_date_hour&":"&consult_date_minute
		consult_date  = consult_date &" "&consult_date1
	  end if  

	  If consult_bigo="" And consult_date="" Then
	  
	  else	  
		  strSql = "select ISNULL(MAX(consult_idx)+1,1) from customer_gamang_consult"
		  Set objRs=objCnn.Execute(strSql)

		  consult_idx=objRs(0) 

		 strSql = "INSERT INTO customer_gamang_consult(consult_idx, o_code, consult_m_id, c_m_gamang_idx,"	
		 strSql = strSql & "consult_type, consult_bigo, "

		  If consult_date<>"" then
			strSql = strSql & " consult_date,  "
		  End If

		  strSql = strSql & " consult_writeday) VALUES " 
		  strSql = strSql & "("
		  strSql = strSql & "   "& consult_idx &"  "
		  strSql = strSql & ", '"& o_code &"'"
		  strSql = strSql & ", '"& session_m_id &"'"
		  strSql = strSql & ",  "& c_m_gamang_idx &" "
		  strSql = strSql & ", '"& consult_type &"'"  		
		  strSql = strSql & ", '"& consult_bigo &"'"

		  If consult_date<>"" then
			strSql = strSql & " ,'"& consult_date&"'"
		  End If
		  
		  strSql = strSql & ",getdate())"
		  'Response.write strSql
		  set objRs=objCnn.Execute(strSql)

		 
		  '고객이력
		  strSql = " update customer_gamang set "
		  strSql = strSql & "  c_m_consult_type	= '"&consult_type&"' "
		  strSql = strSql & ", c_m_consult_bigo	= '"&consult_bigo&"' "
		  strSql = strSql & "	where c_m_gamang_idx	= "&c_m_gamang_idx&" "
		  set objRs=objCnn.Execute(strSql)
		End if
  End if	
	
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  
  Alert_Url " 가망고객 접수가 완료되었습니다.","y_gamang_list.asp"
  %>