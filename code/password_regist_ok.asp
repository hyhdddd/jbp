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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)

  If session_m_step<>"M" Then 
	Alert_URL session_m_name &" 님은 관리권한이 없습니다. ","/default.asp"
	Response.end
  End if

  c_name				= WORD_CHANGE(request("c_name"),20)
  c_tel1				= WORD_CHANGE(request("c_tel1"),20)
  c_tel2				= WORD_CHANGE(request("c_tel2"),20)
  c_address				= WORD_CHANGE(request("c_address"),20)
  g_address				= WORD_CHANGE(request("g_address"),20)
  c_jumin2				= WORD_CHANGE(request("c_jumin2"),20)
  c_email				= WORD_CHANGE(request("c_email"),20)
  g_bank_no				= WORD_CHANGE(request("g_bank_no"),20)
  g_bank_jumin2			= WORD_CHANGE(request("g_bank_jumin2"),20)
  g_card_no				= WORD_CHANGE(request("g_card_no"),20)
  g_card_gigan			= WORD_CHANGE(request("g_card_gigan"),20)
  g_sp_bank_acount		= WORD_CHANGE(request("g_sp_bank_acount"),20)
  g_sp_bank_jumin2		= WORD_CHANGE(request("g_sp_bank_jumin2"),20)
  s_date_start			= WORD_CHANGE(request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(request("s_date_end"),20)
  g_move_jumin2			= WORD_CHANGE(request("g_move_jumin2"),20)
  g_card_jumin2			= WORD_CHANGE(request("g_card_jumin2"),20)
  g_move_tel1			= WORD_CHANGE(request("g_move_tel1"),20)
  g_move_tel2			= WORD_CHANGE(request("g_move_tel2"),20)


  strSql = " "
  strSql = strSql & " update customer_goods set "

  If c_name="Y" then
  'strSql = strSql & " 	c_name			= LEFT(c_name,1)+'*'+RIGHT(c_name,1), "      '가운데 자리만
  'strSql = strSql & " c_name			= '*' +  SUBSTRING(c_name,2,LEN(c_name)), "	 '앞 1자리 마킹
  strSql = strSql & " c_name			= case when len(c_name)>3 then left(c_name,2)+'*'+SUBSTRING(c_name,4,LEN(c_name)) "
  strSql = strSql & "						   when len(c_name)=3 then left(c_name,2)+'*' else left(c_name,1)+'*' end , "  '세번째자리만


  End If

  

  If c_tel1="Y" then
  strSql = strSql & " 	c_tel1			= case when len(c_tel1)>4 then left(c_tel1,LEN(c_tel1)-4)+'****' else '' end, "  '뒤4자리
  'strSql = strSql & " 	c_tel1			= case when len(c_tel1)>7 then left(c_tel1,3)+'-****-'"
  'strSql = strSql & "						+SUBSTRING(c_tel1,LEN(c_tel1)-4,LEN(c_tel1))  else '' end, "  '중간4자리
  End If
  
  If c_tel2="Y" then
  strSql = strSql & " 	c_tel2			= case when len(c_tel2)>4 then left(c_tel2,LEN(c_tel2)-4)+'****' else '' end, " '뒤4자리
  'strSql = strSql & " 	c_tel2			= case when len(c_tel2)>7 then left(c_tel2,3)+'-****-'"
  'strSql = strSql & "						+SUBSTRING(c_tel2,LEN(c_tel2)-4,LEN(c_tel2))  else '' end, " '중간4자리
  End If


  
  If c_jumin2="Y" then
  strSql = strSql & " 	c_jumin2		= '*******', "
  End If
  
  If c_email="Y" then
  'strSql = strSql & " 	c_email			= '*****'+ substring(c_email,CHARINDEX('@',c_email),LEN(c_email)), "
  strSql = strSql & " 	c_email			= case when CHARINDEX('@',c_email)>1"
  strSql = strSql & "						 then '***'+ substring(c_email,CHARINDEX('@',c_email),LEN(c_email)) else '' end, "
  End If

  
  If g_bank_no="Y" then
  strSql = strSql & " 	g_bank_no		= left(g_bank_no,6)+'********', "
  End If
  
  If c_address="Y" then
  strSql = strSql & " 	c_address		= left(c_address,10)+'********', "
  End If

  If g_address="Y" then
  strSql = strSql & " 	g_address		= left(g_address,10)+'********', "
  End If
  
  If g_bank_jumin2="Y" then
  strSql = strSql & " 	g_bank_jumin2	= '*******', "
  End If
  
  If g_card_no="Y" then
  strSql = strSql & " 	g_card_no		= left(g_card_no,6)+'********', "
  End If
  
  If g_card_gigan="Y" then
  strSql = strSql & " 	g_card_gigan	= '******', "
  End If
  
  If g_sp_bank_acount="Y" then
  strSql = strSql & " 	g_sp_bank_acount = left(g_sp_bank_acount,6)+'******', "
  End If
  
  If g_sp_bank_jumin2="Y" then
  strSql = strSql & " 	g_sp_bank_jumin2= '*******', "
  End If

  If g_move_jumin2="Y" then
  strSql = strSql & " 	g_move_jumin2= '*******', "
  End If

  If g_move_jumin2="Y" then
  strSql = strSql & " 	g_card_jumin2= '*******', "
  End If

  If g_move_tel1="Y" then
  strSql = strSql & " 	g_move_tel1= '*******', "
  End If

  If g_move_tel2="Y" then
  strSql = strSql & " 	g_move_tel2= '*******', "
  End If

  
  strSql = Left(strSql , Len(strSql)-2)

  strSql = strSql & "		where "
  strSql = strSql & "				(g_date_yuchi>='"&s_date_start&" 00:00:00') "
  strSql = strsql & "			and (g_date_yuchi<='"&s_date_end&" 23:59:59') "	

  'response.write strSql
  'Response.end

  Set objRs=objCnn.Execute(strsql)

  Alert_url "처리되었습니다.","password_list.asp"



 
  %>