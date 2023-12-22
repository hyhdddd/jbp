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
  if ad_c_code<>"A" Then
	Alert_back session_m_name &" 님은 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If

  area_idx			= WORD_CHANGE(Request("area_idx"),20)

  If area_idx="" Then
	Alert_back " 접근이 잘못되었습니다."
	Response.end
  End If
  
  '삭제 일 경우 상품 검색
  strSql = "select * from customer_goods where g_code_area="&area_idx&" "
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	strSql = "delete code_area where area_idx="&area_idx
	Set objRs=objCnn.Execute(strSql)
	Alert_url "코드가 삭제 되었습니다. ","area_list.asp"
	Response.End		
  Else
	alert_back " 이 코드를 사용하는 고객이 존재 합니다. \n\n 고객상품을 모두 삭제후 삭제하실 수 있습니다."
	Response.end
  End If
  %>