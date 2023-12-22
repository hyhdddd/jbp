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

  area_idx			= WORD_CHANGE(request("area_idx"),20)
  area_name			= WORD_CHANGE(request("area_name"),20)
  area_view			= WORD_CHANGE(request("area_view"),20)
  article_idx		= WORD_CHANGE(Request("article_idx"),20)
  area_policy		= WORD_CHANGE(Request("area_policy"),20)
  
  if area_idx<>"" then  
    If area_policy="Y" Then
		strSql ="select count(area_idx) from code_area where article_idx="&article_idx&" "
		strSql = strSql & " and area_idx<>"&area_idx&" "
		Set objRs=objCnn.Execute(strSql)

		area_cnt	= objRs(0)

		If area_cnt>=10 Then
			area_msg =" 수수료설정 지역이 10개 이상은 표시될 수 없어서 '정책표 미적용' 으로 저장하였습니다."
			area_policy = "N"
		Else
			area_msg = ""
		End if
    End If
    
	strSql = " update code_area set "
	strSql = strSql & " area_name = '"& area_name &"'"
	strSql = strSql & ", area_view = '"& area_view &"'"
	strSql = strSql & ", area_policy = '"& area_policy &"'"
	strSql = strSql & " where area_idx="&area_idx&" "
	set objRs=objCnn.Execute(strSql)

	Alert_url "코드가 수정 되었습니다. \n\n"& area_msg,"area_list.asp"
	Response.end
  else   
	strSql = "Select ISNULL(MAX(area_idx)+1,1) from code_area "
	set objRs=objCnn.Execute(strSql)
	area_idx	= objRs(0)

    If area_policy="Y" Then
		strSql ="select count(area_idx) from code_area where article_idx="&article_idx&" "
		Set objRs=objCnn.Execute(strSql)

		area_cnt	= objRs(0)

		If area_cnt>=10 Then
			area_msg =" 수수료설정 지역이 10개 이상은 표시될 수 없어서 '정책표 미적용' 으로 저장하였습니다."
			area_policy = "N"
		Else
			area_msg = ""
		End if
    End If	

	strSql = "INSERT INTO code_area (area_idx, article_idx, area_view, area_name, "
	strSql = strSql & " area_order, area_policy, area_writeday) VALUES "
	strSql = strSql & " ("& area_idx &","&article_idx&", '"& area_view &"',"
	strSql = strSql & " '" & area_name & "',"& area_idx &", '"&area_policy&"', getdate())"
	set objRs=objCnn.Execute(strSql) 
  end if      

  Alert_url "코드가 등록되었습니다.\n\n"&area_msg,"area_list.asp"
  %>