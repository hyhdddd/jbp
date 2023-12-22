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

  if ad_b_a_custom="N" And ad_b_m_custom="N" then
	Alert_URL session_m_name& " 님은 고객상품 관리권한이 없습니다. 관리자에게 문의하시기 바랍니다.","/main.asp"
	Response.end
  End if

  g_goods_idx		= WORD_CHANGE(request("g_goods_idx"),20)
  dealer_code		= WORD_CHANGE(Request("dealer_code"),20)
  
  If dealer_code="" or IsNull(dealer_code) Or dealer_code="0"  Then
	Alert "상부점을 선택해 주세요!"
	win_close()
  End If
  
  strSql = " select dealer_name, dealer_ingea_url, dealer_ingea_id from dealer_info where dealer_code='"&dealer_code&"'"
  Set objRs=objCnn.Execute(strSql)
	
  dealer_name		= objRs("dealer_name")
  dealer_ingea_url	= objRs("dealer_ingea_url")
  dealer_ingea_id	= objRs("dealer_ingea_id")

  If dealer_ingea_url="" Or IsNull(dealer_ingea_url) Then
	Alert "상부점 전산 도메인을 협력점 정보관리("& dealer_name &")에서 입력해 주세요!"
	win_close()
  End if

  If dealer_ingea_id="" Or IsNull(dealer_ingea_id) Then
	Alert "상부점 전산 입력 ID를 협력점 정보관리("& dealer_name &")에서 입력해 주세요!"
	win_close()
  End if
		
  If g_goods_idx="" Or IsNull(g_goods_idx) Then
	Alert "상품을 선택해 주세요!"
	win_close()
  End If
  
  	strSql = "select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_option_idx, A.g_set, A.g_code_gaetong_idx, "
	strSql = strSql & " A.g_zipcode1, A.g_zipcode2, A.g_address, A.g_date_yuchi, A.g_service_no, A.g_article_cnt,  "
	strSql = strsql & " A.g_bank_cd , A.g_bank_no, A.g_bank_name, A.g_cancel_date, A.g_writeday, "
	strSql = strSql & " A.g_sp_bank_code, A.g_sp_bank_acount, A.g_sp_bank_name, A.g_sp_bank_memo, A.g_code_service,  "
	strSql = strSql & " A.g_file1, A.g_file2, A.g_file3, A.g_file4, A.g_receipt_type, A.c_auth_chk, "
	strSql = strSql & " A.g_code_course_idx, A.g_sp_date_start, A.g_sp_name, A.g_sp_price, A.g_goods_ref, "
	strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, A.g_sp_bank_jumin1, A.g_sp_bank_jumin2, "
	strSql = strSql & " A.g_code_promise, A.g_yuchi_m_id, A.g_jupsu_m_id, A.g_give_chk, "
	strSql = strSql & " A.g_sp_give_type, A.g_bank_jumin1, A.g_bank_jumin2, A.g_give_type, A.g_date_gaetong, "
	strSql = strSql & " A.g_card_cd, A.g_card_no , A.g_card_gigan, A.g_card_gigan1, A.g_card_name, A.g_card_jumin1, A.g_card_jumin2, "

	strSql = strSql & " A.g_move_tel1, A.g_move_name, A.g_move_jumin1, A.g_move_jumin2, A.g_move_date, "
	strSql = strSql & " A.g_move_tel2, A.g_move_company, A.g_move_memo,"

	strSql = strSql & " A.g_date_gaetong_hope, A.g_date_gaetong_hope_time, "
	strSql = strSql & " A.c_type, A.c_jumin1, A.c_jumin2, A.c_tel2, A.c_office_no, A.c_office_name, A.c_zipcode1, A.c_zipcode2, "
	strSql = strSql & " A.c_address, A.c_tel1, A.c_email, A.c_jumin_date, A.g_sp_date_end, "
	strSql = strSql & " A.c_name, A.g_bigo , A.g_code_sale "
	strSql = strSql & "		from customer_goods A "
	strSql = strSql & "				where A.g_goods_idx="&g_goods_idx 	
  	set objRs=objCnn.Execute(strSql)
  		
  	if objRs.eof or objRs.bof then  	
  	Else
		c_name				= objRs("c_name")
		c_type				= objRs("c_type")
		c_jumin1			= objRs("c_jumin1")
		c_jumin2			= objRs("c_jumin2")
		c_office_no			= objRs("c_office_no")
		c_office_name		= objRs("c_office_name")
		c_zipcode1			= objRs("c_zipcode1")
		c_zipcode2			= objRs("c_zipcode2")
		c_address			= objRs("c_address")
		c_tel1				= objRs("c_tel1")
		c_tel2				= objRs("c_tel2")
		c_email				= objRs("c_email")
		c_auth_chk			= objRs("c_auth_chk")
		c_jumin_date		= objRs("c_jumin_date")
		g_code_course_idx	= objRs("g_code_course_idx")		'접수경로

		g_give_type			= objRs("g_give_type")				'납부정보
		g_give_chk			= objRs("g_give_chk")				'납부정보 - 관계

		c_bank_cd			= objRs("g_bank_cd")				'은행코드
		c_bank_no			= objRs("g_bank_no")				'계좌번호
		c_bank_name			= objRs("g_bank_name")				'예금주
		c_bank_jumin1		= objRs("g_bank_jumin1")		'이체정보 주민번호(고객명과 다를경우)
		c_bank_jumin2		= objRs("g_bank_jumin2")		'이체정보 주민번호(고객명과 다를경우)

		c_card_cd			= objRs("g_card_cd")			'카드사
		g_card_no			= objRs("g_card_no")			'카드번호
		g_card_gigan		= objRs("g_card_gigan")			'카드 유효기간
		g_card_gigan1		= objRs("g_card_gigan1")		'카드 유효기간
		g_card_name			= objRs("g_card_name")			'카드 유효기간
		g_card_jumin1		= objRs("g_card_jumin1")		'카드 유효기간
		g_card_jumin2		= objRs("g_card_jumin2")		'카드 유효기간

		'사은품 계좌정보
		g_sp_bank_code		= objRs("g_sp_bank_code")		'사은품 계좌 은행코드
		g_sp_bank_acount	= objRs("g_sp_bank_acount")		'사은품 계좌 은행계좌
		g_sp_bank_name		= objRs("g_sp_bank_name")		'사은품 계좌 은행예금주
		g_sp_bank_jumin1	= objRs("g_sp_bank_jumin1")		'사은품 계좌 은행예금주
		g_sp_bank_jumin2	= objRs("g_sp_bank_jumin2")		'사은품 계좌 은행예금주

		g_set				= objRs("g_set")				'셋트유형
		g_bigo				= Replace(objRs("g_bigo"),"""","&quot;")

		g_sum_money_chk		= objRs("g_sum_money_chk")		'합산청구종류
		g_sum_money_txt		= objRs("g_sum_money_txt")		'합산청구종류


		g_move_tel1			= objRs("g_move_tel1")								'번호이동 항목
		g_move_name			= objRs("g_move_name")
		g_move_jumin1		= objRs("g_move_jumin1")
		g_move_jumin2		= objRs("g_move_jumin2")
		g_move_date			= objRs("g_move_date")
		g_move_tel2			= objRs("g_move_tel2")
		g_move_company		= objRs("g_move_company")
		g_move_memo			= objRs("g_move_memo")
  

	End If
  %>

<form id="frm_trans" name="frm_trans" method="post" action="<%=dealer_ingea_url%>/customer/p_custom_goods_trans.asp">
<input type="hidden" name="dealer_name" value="<%=dealer_name%>">
<input type="hidden" name="g_yuchi_m_id" value="<%=dealer_ingea_id%>">
<input type="hidden" name="c_name" value="<%=c_name%>">
<input type="hidden" name="c_type" value="<%=c_type%>">
<input type="hidden" name="c_jumin1" value="<%=c_jumin1%>">
<input type="hidden" name="c_jumin2" value="<%=c_jumin2%>">
<input type="hidden" name="c_zipcode1" value="<%=c_zipcode1%>">
<input type="hidden" name="c_zipcode2" value="<%=c_zipcode2%>">
<input type="hidden" name="c_address" value="<%=c_address%>">
<input type="hidden" name="c_tel1" value="<%=c_tel1%>">
<input type="hidden" name="c_tel2" value="<%=c_tel2%>">
<input type="hidden" name="c_email" value="<%=c_email%>">
<input type="hidden" name="c_auth_chk" value="<%=c_auth_chk%>">
<input type="hidden" name="c_jumin_date" value="<%=c_jumin_date%>">
<input type="hidden" name="g_code_course_idx" value="<%=g_code_course_idx%>">
<input type="hidden" name="c_office_no" value="<%=c_office_no%>">
<input type="hidden" name="c_office_name" value="<%=c_office_name%>">

<input type="hidden" name="g_give_type" value="<%=g_give_type%>">
<input type="hidden" name="g_give_chk" value="<%=g_give_chk%>">

<input type="hidden" name="c_bank_cd" value="<%=c_bank_cd%>">
<input type="hidden" name="c_bank_no" value="<%=c_bank_no%>">
<input type="hidden" name="c_bank_name" value="<%=c_bank_name%>">
<input type="hidden" name="c_bank_jumin1" value="<%=c_bank_jumin1%>">
<input type="hidden" name="c_bank_jumin2" value="<%=c_bank_jumin2%>">

<input type="hidden" name="c_card_cd" value="<%=c_card_cd%>">
<input type="hidden" name="g_card_no" value="<%=g_card_no%>">
<input type="hidden" name="g_card_gigan" value="<%=g_card_gigan%>">
<input type="hidden" name="g_card_gigan1" value="<%=g_card_gigan1%>">
<input type="hidden" name="g_card_name" value="<%=g_card_name%>">
<input type="hidden" name="g_card_jumin1" value="<%=g_card_jumin1%>">
<input type="hidden" name="g_card_jumin2" value="<%=g_card_jumin2%>">

<input type="hidden" name="g_sp_bank_code" value="<%=g_sp_bank_code%>">
<input type="hidden" name="g_sp_bank_acount" value="<%=g_sp_bank_acount%>">
<input type="hidden" name="g_sp_bank_name" value="<%=g_sp_bank_name%>">
<input type="hidden" name="g_sp_bank_jumin1" value="<%=g_sp_bank_jumin1%>">
<input type="hidden" name="g_sp_bank_jumin2" value="<%=g_sp_bank_jumin2%>">

<input type="hidden" name="g_sum_money_chk" value="<%=g_sum_money_chk%>">
<input type="hidden" name="g_sum_money_txt" value="<%=g_sum_money_txt%>">

<input type="hidden" name="g_set" value="<%=g_set%>">

<input type="hidden" name="g_move_tel1" value="<%=g_move_tel1%>">
<input type="hidden" name="g_move_name" value="<%=g_move_name%>">
<input type="hidden" name="g_move_jumin1" value="<%=g_move_jumin1%>">
<input type="hidden" name="g_move_jumin2" value="<%=g_move_jumin2%>">
<input type="hidden" name="g_move_date" value="<%=g_move_date%>">
<input type="hidden" name="g_move_tel2" value="<%=g_move_tel2%>">
<input type="hidden" name="g_move_company" value="<%=g_move_company%>">
<input type="hidden" name="g_move_memo" value="<%=g_move_memo%>">
<input type="hidden" name="g_bigo" value="<%=g_bigo%>">

</form>

<script language="javascript">
<!--
	var frm=document.all.frm_trans;
	frm.submit();
-->
</script>