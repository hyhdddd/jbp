   <%
  '====================================='
  ' 프로젝트 : SENQ PROJECT
  ' 목    적 : HTTP://OSS.SENQ.CO.KR
  ' 개발일자 : 2007/08/15 ~2008/08/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
  '====================================='
  Response.Expires = 0
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <%
  m_id					= WORD_CHANGE(Request("m_id"),20)
  m_name				= WORD_CHANGE(request("m_name"),40)
  m_passwd				= WORD_CHANGE(request("m_passwd"),40)
  m_jumin1				= WORD_CHANGE(request("m_jumin1"),20)
  m_jumin2				= WORD_CHANGE(request("m_jumin2"),20)
  m_zipcode1			= WORD_CHANGE(request("m_zipcode1"),20)
  m_zipcode2			= WORD_CHANGE(request("m_zipcode2"),20)
  m_address				= WORD_CHANGE(request("m_address"),200)
  m_email				= WORD_CHANGE(request("m_email"),70)
  m_tel1				= WORD_CHANGE(request("m_tel1"),30)
  m_tel2				= WORD_CHANGE(request("m_tel2"),30)
  m_bigo				= WORD_CHANGE(request("m_bigo"),0)
  dealer_name			= WORD_CHANGE(request("dealer_name"),40)
  dealer_com_yn			= WORD_CHANGE(Request("dealer_com_yn"),20)
  dealer_com_no			= WORD_CHANGE(Request("dealer_com_no"),40)
  dealer_bank_name		= WORD_CHANGE(Request("dealer_bank_name"),40)		' 은행 예금주
  dealer_bank_cd		= WORD_CHANGE(Request("dealer_bank_cd"),20)			' 은행 코드
  dealer_bank_no		= WORD_CHANGE(Request("dealer_bank_no"),20)			' 은행 계좌번호
  dealer_zipcode1		= WORD_CHANGE(Request("dealer_zipcode1"),20)		' 회사 우편번호1
  dealer_zipcode2		= WORD_CHANGE(Request("dealer_zipcode2"),20)		' 회사 우편번호2
  dealer_address		= WORD_CHANGE(Request("dealer_address"),200)			' 회사 주소
  dealer_tel1			= WORD_CHANGE(Request("dealer_tel1"),30)
  dealer_tel2			= WORD_CHANGE(Request("dealer_tel2"),30)

  If m_name="" Or m_id="" Or m_passwd="" Or dealer_name=""  Then
	Alert_back "잘못된 접근입니다."
  End If
  
  
  strSql =" select m_id from emp_list where m_id='"&m_id&"'"
  set objRs=objCnn.Execute(strSql)
	  
  if objRs.eof or objRs.bof then
  Else
	Alert_back " 아이디가 이미 존재 합니다. \n\n 다시 입력해 주세요! "
	response.end
  end if  
	  
  strSql = "Select ISNULL(MAX(board_idx)+1,1) from dealer_partner_info "
  set objRs=objCnn.Execute(strSql)
  board_idx	= objRs(0)

  strSql = "INSERT INTO dealer_partner_info (board_idx, o_code, m_id, m_passwd, m_name, "
  strSql = strSql & " m_zipcode1, m_zipcode2, m_address, m_tel1, m_tel2,m_email, m_bigo, "
  strSql = strSql & " dealer_name, dealer_com_yn, dealer_com_no, "
  strSql = strSql & " dealer_zipcode1, dealer_zipcode2, dealer_address, dealer_tel1, dealer_tel2, d_writeday) VALUES "
  strSql = strSql & "( " & board_idx & "  "
  strSql = strSql & ",'" & o_code & "' "
  strSql = strSql & ",'" & m_id & "' "
  strSql = strSql & ",'" & m_passwd & "' "
  strSql = strSql & ",'" & m_name & "' "
  strSql = strSql & ",'" & m_zipcode1 & "'"
  strSql = strSql & ",'" & m_zipcode2 & "'"
  strSql = strSql & ",'" & m_address & "'"  
  strSql = strSql & ",'" & m_tel1 & "'"
  strSql = strSql & ",'" & m_tel2 & "'"
  strSql = strSql & ",'" & m_email & "'"
  strSql = strSql & ",'" & m_bigo & "'"
  strSql = strSql & ",'" & dealer_name & "'"
  strSql = strSql & ",'" & dealer_com_yn & "'"
  strSql = strSql & ",'" & dealer_com_no & "'"
  strSql = strSql & ",'" & dealer_zipcode1 & "'"
  strSql = strSql & ",'" & dealer_zipcode2 & "'"
  strSql = strSql & ",'" & dealer_address & "'"
  strSql = strSql & ",'" & dealer_tel1 & "'"
  strSql = strSql & ",'" & dealer_tel2 & "'"
  strSql = strSql & ",getdate())"
  set objRs=objCnn.Execute(strSql)

  Alert " 파트너 신청이 완료되었습니다. \n\n 관리자가 확인 후 빠른시간안에 연락드리도록 하겠습니다. \n\n 감사합니다."
  win_close()
  %>