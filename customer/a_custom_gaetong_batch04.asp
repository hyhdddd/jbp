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

	strSql = "select * from code_gaetong where gaetong_name='개통완료'"
	Set objRs=objCnn.Execute(strSql)

	g_code_gaetong_idx = objRs("gaetong_code")

	strSql = "select * from customer_up_temp order by board_idx asc"
	Set objRs=objCnn.Execute(strSql)

	Do Until objRs.eof
		board_idx		= objRs("board_idx")
		c_name			= objRs("c_name")
		c_service_no	= objRs("c_service_no")
		c_gaetong_date	= objRs("c_gaetong_date")

		strSql = "select * from customer_goods where g_service_no='"&c_service_no&"' and c_name='"&c_name&"'"
		'Response.write strSql &"<br>"
		Set objRs1=objCnn.Execute(strSql)
		
		If objRs1.eof Or objRs.bof Then
			
		Else
			g_goods_idx		= objRs1("g_goods_idx")

 			'개통코드 로그 저장
			strSql = "select g_code_gaetong_idx from customer_goods where g_goods_idx="&g_goods_idx
			Set objRs3=objCnn.Execute(strSql)

			g_code_gaetong_old		= objRs3(0)

			If g_code_gaetong_idx<>g_code_gaetong_old Then
				strSql = " INSERT INTO customer_gaetong_log (g_goods_idx, log_m_id, log_code_gaetong, log_writeday) "
				strSql = strSql & "values ("&g_goods_idx&",'"&session_m_id&"','"&g_code_gaetong_idx&"',getdate())"
				Set objRs3=objCnn.Execute(strSql)
			End If

			'고객정보 수정
			strSql = "update customer_goods set g_date_gaetong='"&c_gaetong_date&"',g_code_gaetong_idx='"&g_code_gaetong_idx&"' where g_goods_idx="&g_goods_idx
			Set objRs2 = objcnn.Execute(strSql)
			
			strSql = "Update customer_up_temp set c_up_chk='O' where board_idx="&board_idx
			Set objRs3=objCnn.Execute(strSql)
		End if

		objRs.movenext
	Loop
	
	'Response.end
	Win_link "a_custom_gaetong_batch05.asp"
  %>