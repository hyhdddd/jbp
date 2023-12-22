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
 
  if ad_i_a_company="A" Then
  else
	Alert_back session_m_name&" 님은 삭제 관리권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  dealer_code		= WORD_CHANGE(Request("dealer_code"),20)

  '본사코드는 삭제할 수 없다.
  If o_code=dealer_code Then
	Alert_back "본사코드는 삭제할 수 없습니다."
  End If
  
  '사원이 존재하면 삭제할 수 없다.
  strSql = " select * from emp_list where m_dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		Alert_back " 삭제하려는 회사에 소속된 사원들이 존재합니다. \n\n 삭제하기 위해서는 사원소속을 모두 바꾸어 주세요"
		Response.end
  End if

  '인계거래처로 사용되고 있으면 삭제할 수 없다.
  strsql = " select count(*) from customer_goods where g_trans_out_dealer='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " 삭제할려는 거래처는 고객정보(인계거래처)로 ("&custom_cnt&" 건) 사용되고 있습니다. \n\n 인계거래처로 선택된 모든 고객정보를 수정해 주셔야 삭제 가능합니다."
			Response.End
		End if
  End if

  '인수거래처로 사용되고 있으면 삭제할 수 없다.
  strsql = " select count(*) from customer_goods where g_trans_in_dealer='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " 삭제할려는 거래처는 고객정보(인수거래처)로 ("&custom_cnt&" 건) 사용되고 있습니다. \n\n 인수거래처로 선택된 모든 고객정보를 수정해 주셔야 삭제 가능합니다."
			Response.End
		End if
  End if

  '정산관리 - 정산내역서에서 사용되고 있으면 삭제할 수 없다.
  strsql = " select count(*) from exact_list where s_dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  Else
		custom_cnt = objRs(0)

		If custom_cnt>0 then
			Alert_back " 삭제할려는 거래처는 정산관리 - 정산내역서에서 ("&custom_cnt&" 건) 사용되고 있습니다. \n\n 정산내역서에서 해당 거래처를 삭제하거나 수정해 주셔야 코드 삭제 가능합니다."
			Response.end
		End if
		
  End if

  strSql ="delete dealer_info where dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)

  Alert_url " 코드를 삭제했습니다.","a_company_list.asp"

  %>