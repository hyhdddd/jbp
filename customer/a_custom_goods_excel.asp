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
  Response.buffer = ture
  Response.ContentType = "application/vnd.ms-excel"  
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  filename="전체고객상품목록(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  if ad_b_a_excel<>"Y" then
 	Alert_back session_m_name &" 님은 고객 엑셀다운 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	
  
  search_key			= WORD_CHANGE(Request("search_key"),20)
  search_txt			= WORD_CHANGE(Request("search_txt"),20)
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_dealer_code			= WORD_CHANGE(Request("s_dealer_code"),20)
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
  s_search_key			= WORD_CHANGE(Request("s_search_key"),20)

  s_set					= WORD_CHANGE(Request("s_set"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)
  s_dealer_code1		= WORD_CHANGE(Request("s_dealer_code1"),20)
  s_receipt_chk			= WORD_CHANGE(Request("s_receipt_chk"),20)
  s_sp_give_type		= WORD_CHANGE(Request("s_sp_give_type"),20)
  s_yuchi_m_id			= WORD_CHANGE(Request("s_yuchi_m_id"),20)
  %>

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">

<style type="text/css">
<!--  
	A:link    {color:#000000;text-decoration:none;}
	A:visited {color:#000000;text-decoration:none;}
	A:active  {color:#000000;text-decoration:none;}
	A:hover  {color:#8CC84B;text-decoration:none}

	body 
	{
		scrollbar-face-color: #ffffff; scrollbar-shadow-color: #666666; 
		scrollbar-highlight-color: #666666; scrollbar-3dlight-color: #ffffff; 
		scrollbar-darkshadow-color: #ffffff; scrollbar-track-color: #ffffff;
		scrollbar-arrow-color: #666666
	}
	td	{font: 9pt 돋움,GulimChe,Gulim;color: black;}	
//-->
</style>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">

<!------------------ 내용 시작  ------------------>

<table width="3000" cellspacing=1 cellpadding=0 border=1>  
<tr height='30'>
	<th bgcolor='gray' width="50">No</th>
	<th bgcolor='gray'  width="100">고객명</th>

	<th bgcolor='gray'  width="200">통신사</th>
	<th bgcolor='gray'  width="200">상품명</th>
	<th bgcolor='gray'  width="150">상품옵션</th>
	<th bgcolor='gray'  width="50">회선</th>
	<th bgcolor='gray'  width="70">셋트유형</th>
	<th bgcolor='gray'  width="100">가입.번호</th>
	<th bgcolor='gray'  width="150">할인탭</th>
	<th bgcolor='gray'  width="100">약정</th>
	<th bgcolor='gray'  width="140">부가서비스</th>
	<th bgcolor='gray'  width="100">개통상태</th>
	<th bgcolor='gray'  width="100">개통일</th>
	<th bgcolor='gray'  width="100">협력점</th>
	<th bgcolor='gray'  width="100">유치자</th>
	<th bgcolor='gray'  width="100">접수일</th>
	<th bgcolor='gray'  width="100">본사사은품</th>
	<th bgcolor='gray'  width="100">본사사은품금액</th>
	<th bgcolor='gray'  width="100">사은품</th>
	<th bgcolor='gray'  width="100">사은품 지급처</th>
	<th bgcolor='gray'  width="100">금액</th>
	<th bgcolor='gray'  width="100">지급예정</th>
	<th bgcolor='gray'  width="100">지급완료</th>
	<th bgcolor='gray'  width="100">상부점</th>
	<th bgcolor='gray'  width="300">주소</th>
	<th bgcolor='gray'  width="100">주민번호</th>
	<th bgcolor='gray'  width="100">일반전화</th>
	<th bgcolor='gray'  width="100">핸드폰</th>
	<th bgcolor='gray'  width="100">사은품은행</th>
	<th bgcolor='gray'  width="120">사은품계좌</th>
	<th bgcolor='gray'  width="120">사은품예금주</th>
	<th bgcolor='gray'  width="120">사은품메모</th>
	<th bgcolor='gray'  width="100">해약일</th>
	<th bgcolor='gray'  width="100">납부정보</th>
	<th bgcolor='gray'  width="120">은행(카드)사</th>
	<th bgcolor='gray'  width="120">계좌(카드)번호</th>
	<th bgcolor='gray'  width="120">예금(카드)주</th>
	<th bgcolor='gray'  width="150">예금(카드)주민번호</th>
	<th bgcolor='gray'  width="120">카드(유효기간)</th>
	<th bgcolor='gray'  width="100">납부(관계)</th>

	<th bgcolor='gray'  width="100">지역</th>

	<th bgcolor='gray'  width="300">기타</th>
</tr>
<%
if request("page")=""		then  page=1		Else page=Request("page")			end if
if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

strSql = " select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_yuchi_m_id , A.g_date_yuchi, J.option_name, A.g_set,"
strSql = strSql & " A.g_date_gaetong, G.promise_name, H.sale_name, A.g_service_no, A.g_bigo, A.g_give_chk, A.g_writeday,"
strSql = strSql & " A.g_sp_name, A.g_sp_price, A.g_sp_date_start, A.g_sp_date_end, A.c_address, A.c_jumin1, A.c_jumin2, "
strSql = strSql & " A.c_tel1, A.c_tel2, A.g_bank_name, A.g_bank_no, A.g_bank_jumin1, A.g_bank_jumin2, I.bank_name, "
strSql = strSql & " O.service_name, A.g_sp_bank_code, A.g_cancel_date, L.dealer_name as g_trans_in_dealer_name,"
strSql = strSql & " A.g_sp_bank_acount, A.g_sp_bank_name, A.g_sp_bank_memo, F.bank_name as g_sp_bank, "
strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, A.g_sp_price_top, A.g_sp_name_top, A.goods_settop1_chk, A.goods_settop2_chk, "
strSql = strSql & " B.m_name as yuchi_name, C.article_name , D.article_name as article_name1, A.g_sp_give_type, "
strSql = strSql & " A.g_card_no , A.g_card_gigan, A.g_card_gigan1, A.g_card_name, A.g_card_jumin1, A.g_card_jumin2, "
strSql = strSql & " E.gaetong_name, A.c_name, A.g_article_cnt, A.g_give_type,  M.card_name, P.area_name, "
strSql = strSql & " K.dealer_name as g_trans_out_dealer_name "
strSql = strSql & "		from customer_goods A left outer  "
strSql = strSql & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id"
strSql = strSql & "	   left	join code_article C on A.g_article_idx1=C.article_idx"
strSql = strSql & "	   left	join code_article D on A.g_article_idx2=D.article_idx"
strSql = strSql & "	   left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
strSql = strSql & "	   left join code_bank F on A.g_sp_bank_code=F.board_idx "
strSql = strSql & "	   left join code_promise G on A.g_code_promise=G.promise_idx"
strSql = strSql & "	   left join code_sale H on A.g_code_sale=H.sale_idx"
strSql = strSql & "	   left join code_bank I on A.g_bank_cd=I.board_idx "
strSql = strSql & "    left join code_article_option J on A.g_option_idx=J.option_idx"
strSql = strSql & "	   left join dealer_info K ON A.g_trans_out_dealer=K.dealer_code"
strSql = strSql & "	   left join dealer_info L ON L.dealer_code=B.m_dealer_code"
strSql = strSql & "	   left join code_card M ON A.g_card_cd=M.board_idx "
strSql = strSql & "	   left join code_service O ON A.g_code_service=O.service_idx"
strSql = strSql & "	   left join code_area P ON A.g_code_area=P.area_idx"

strSql = strSql & "				where 1=1 "



  If s_receipt_chk="O" Then
		strSql = strSql & "			and (A.g_receipt_type='B' or A.g_receipt_type='C') "
  Else
	  If search_txt<>"" then
		If search_key="m_name" Then
			strSql = strSql & "		and (B.m_name like '%"&search_txt&"%')"
		ElseIf search_key="dealer_name" then
			strSql = strSql & "		and (L.dealer_name like '%"&search_txt&"%') "
		ElseIf search_key="c_name*" Then
			instr_len = InStr(search_txt,"*")

			If instr_len=0 Then
				strSql = strSql & "	and  A.c_name like '%"&search_txt&"%'"
			Else
				first_str	= Left(search_txt,instr_len-1)
				end_str		= mid(search_txt,instr_len+1)

				first_len	= Len(Left(search_txt,instr_len-1)) 
				end_len		= Len(mid(search_txt,instr_len+1))

				If first_len>0 then
				strSql = strSql & "	and  (A.c_name like '"&first_str&"%') "
				End If
				
				If end_len>0 Then
				strSql = strSql & "	and  (A.c_name like '%"&end_str&"') "				
				End if
			End if
		Else
			strSql = strSql & "		and  A."&search_key&" like '%"&search_txt&"%'"
		End If

	  End If

	  If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	  End If

	  If s_dealer_code<>"" then
		  strSql = strSql & "		and (A.g_trans_in_dealer='"&s_dealer_code&"')"
	  End If

	  '회사명
	  If s_article_idx1<>"0" Then
			strSql = strSql & "		and (A.g_article_idx1="&s_article_idx1 & ") "
	  End if

	  '상품명
	  If s_article_idx2<>"0" Then
			strSql = strSql & "		and (A.g_article_idx2="&s_article_idx2 & ") "
	  End If
	  
	  '옵션명
	  If s_option_idx<>"0" Then
			strSql = strSql & "		and (A.g_option_idx="&s_option_idx & ") "
	  End If

	  
	  If s_dealer_code1<>"" then
		  strSql = strSql & "		and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	  End If

	  '셋트유형
	  If s_set<>"" Then
		If s_set="D" then	'셋추1
			strSql = strSql & "	and (A.goods_settop1_chk='O') "
		ElseIf s_set="E" Then
			strSql = strSql & "	and (A.goods_settop2_chk='O') "
		else
			strSql = strSql & "	and (A.g_set='"& s_set & "') "
		End if
	  End If

	  '유치자
	  If s_yuchi_m_id<>"" Then
			strSql = strSql & "		and (A.g_yuchi_m_id='"&s_yuchi_m_id & "') "
	  End If
	  	  
	  '사은품 지급 유형
	  If s_sp_give_type<>"" then
		  strSql = strSql & "		and (A.g_sp_give_type='"&s_sp_give_type&"')"
	  End If

	  If s_search_key="g_date_yuchi" then	
		'유치일 검색
		strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="g_date_gaetong" Then
		'개통일 겁색
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="g_cancel_date" Then
		'해약일 검색
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "	
	  ElseIf s_search_key="goods1" then
		'개통고객 중 지급예정
		strSql = strSql & "			and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
		strSql = strSql & "			and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods2" Then
		'개통고객 중 지급완료
		strSql = strSql & "			and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
		strSql = strSql & "			and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods3" Then
		'미개통고객 중 지급예정
		strSql = strSql & "			and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
		strSql = strSql & "			and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
	  ElseIf s_search_key="goods4" Then
		'미개통고객 중 지급완료
		strSql = strSql & "			and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
		strSql = strSql & "			and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "	
	  ElseIf s_search_key="goods5" Then
		'지급예정 (개통 미지급자)
		strSql = strSql & "			and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
		strSql = strSql & "			and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "	
		strSql = strSql & "			and ((A.g_sp_date_end is null) or (A.g_sp_date_end='')) "
	  ElseIf s_search_key="goods6" Then
		'개통일 (미지급고객)
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strsql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "	
		strSql = strSql & "			and ((A.g_sp_date_end is null) or (A.g_sp_date_end='')) "
	  End If


  End if

  strSql = strSql & "				order by   A.receipt_order_a desc, A.g_date_yuchi Desc,g_goods_idx desc "
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
  paging_chk="X"
%>
<tr>
	<td colspan='22'> 고객 등록상품이 없습니다. </td>
</td>
<%
  else
  i=1

  Do until objRs.EOF
	g_goods_idx			= objRs("g_goods_idx")
	g_yuchi_m_id		= objRs("g_yuchi_m_id")								'유치자 아이디
	g_date_yuchi		= fnc_date_change(objRs("g_date_yuchi"))			'접수일
	g_date_gaetong		= objRs("g_date_gaetong")							'개통일
	yuchi_name			= objRs("yuchi_name")
	article_name		= objRs("article_name")

	article_name1		= objRs("article_name1")
	gaetong_name		= objRs("gaetong_name")								'개통 현황
	c_name				= objRs("c_name")									'고객명
	promise_name		= objRs("promise_name")								'상품 약정
	sale_name			= objRs("sale_name")								'할인탭
	g_service_no		= objRs("g_service_no")								'가입서비스번호
	g_trans_out_dealer_name	= objRs("g_trans_out_dealer_name")				'상부점
	g_trans_in_dealer_name	= objRs("g_trans_in_dealer_name")				'협력점

	g_sp_name			= objRs("g_sp_name")
	g_sp_price			= money_change(objRs("g_sp_price"))
	g_sp_date_start		= objRs("g_sp_date_start")
	g_sp_date_end		= objRs("g_sp_date_end")
	c_address			= objRs("c_address")
	c_tel1				= objRs("c_tel1")
	c_tel2				= objRs("c_tel2")

	option_name			= objRs("option_name")
	c_jumin1			= objRs("c_jumin1")
	c_jumin2			= objRs("c_jumin2")
	g_set				= fnc_g_set(objRs("g_set"))							'셋트유형
	area_name			= objRs("area_name")

	g_sp_give_type		= objRs("g_sp_give_type")							'사은품 지급처
	g_sp_give_type_txt	= fnc_g_sp_give_type(g_sp_give_type,"A")


	g_sp_bank_acount	= objRs("g_sp_bank_acount")
	g_sp_bank_name		= objRs("g_sp_bank_name")
	g_sp_bank_memo		= objRs("g_sp_bank_memo")
	g_sp_bank			= objRs("g_sp_bank")	

	g_bigo				= objRs("g_bigo")
	service_name		= objRs("service_name")								'부가서비스 
	g_cancel_date		= objRs("g_cancel_date")							'해약일
	g_article_cnt		= objRs("g_article_cnt")							'회선수
	
	goods_settop1_chk	= objRs("goods_settop1_chk")
	goods_settop2_chk	= objRs("goods_settop2_chk")


	If goods_settop1_chk="O" Then
		g_set			= "셋추1"
	End If

	If goods_settop2_chk="O" Then
		g_set			= "셋추2"
	End If

	g_sp_name_top		= objRs("g_sp_name_top")							'본사사은품명		
	g_sp_price_top		= money_change(objRs("g_sp_price_top"))				'본사사은품 금액

	g_give_type			= objRs("g_give_type")
	g_give_chk			= fnc_give_chk(objRs("g_give_chk"))

	If g_give_type="A" Then
		g_give_type_txt = "계좌이체"
		give_name			= objRs("bank_name")
		give_no				= objRs("g_bank_no")
		give_bank_name		= objRs("g_bank_name")
		give_jumin1			= objRs("g_bank_jumin1")						'카드 유효기간
		give_jumin2			= objRs("g_bank_jumin2")						'카드 유효기간
		give_gigan			= ""
		give_gigan1			= ""

	ElseIf g_give_type="B" Then
		g_give_type_txt = "카드납부"

		give_name			= objRs("card_name")							'카드번호
		give_no				= objRs("g_card_no")
		give_bank_name		= objRs("g_card_name")							'카드 유효기간
		give_jumin1			= objRs("g_card_jumin1")						'카드 유효기간
		give_jumin2			= objRs("g_card_jumin2")						'카드 유효기간
		give_gigan			= objRs("g_card_gigan")							'카드 유효기간
		give_gigan1			= objRs("g_card_gigan1")						'카드 유효기간
		give_gigan			= give_gigan&"년 "&give_gigan1&"월"
	ElseIf g_give_type="C" then
		g_give_type_txt = "지로납부"
		give_name			= ""									
		give_no				= ""
		give_bank_name		= ""			
		give_jumin1			= ""
		give_jumin2			= ""
		give_gigan			= ""
		give_gigan1			= ""
	ElseIf g_give_type="D" then
		g_sum_money_chk		= objRs("g_sum_money_chk")							'합산청구종류
		g_sum_money_txt		= objRs("g_sum_money_txt")							'합산청구종류
		
		If g_sum_money_chk="A" Then
			g_give_type_txt = "전화비 합산청구"
		End If
		
		If g_sum_money_chk="B" Then
			g_give_type_txt ="인터넷 합산청구 "
		End If

		give_name			= ""								
		give_no				= ""
		give_bank_name		= ""			
		give_jumin1			= ""
		give_jumin2			= ""
		give_gigan			= ""
		give_gigan1			= ""
	End If

	'consult_bigo		= ""
	'strSql = " select * from customer_goods_consult A left outer join emp_list B ON A.consult_m_id=B.m_id "
	'strSql = stRSql & " where A.g_goods_idx="&g_goods_idx&" order by A.consult_writeday desc"
	'Set objRs1=objCnn.Execute(strSql)

	'Do Until objRs1.eof
		'm_name1			= objRs1("m_name")
		'consult_type1	= objRs1("consult_type")
		'consult_bigo1	= objRs1("consult_bigo")

		'consult_type1	= fnc_consult_txt11(consult_type1)
		
		'consult_bigo	= consult_bigo & m_name1&":"&consult_type1&":"&consult_bigo1& "<br><Br>"

		'objRs1.movenext
	'loop
%>
<!--#include virtual="/include/asp/customer_marking.asp"-->
<tr height='30'>
	<td><%=i%></td>
	<td><%=c_name%></td>
	<td><%=article_name%></td>
	
	<td><%=article_name1%></td>
	<td><%=option_name%></td>
	<td><%=g_article_cnt%></td>
	<td><%=g_set%></td>
	<td style="mso-number-format:\@"><%=g_service_no%></td>
	<td><%=sale_name%></td>
	<td><%=promise_name%></td>
	<td><%=service_name%></td>
	<td><%=gaetong_name%></td>
	<td style="mso-number-format:\@"><%=g_date_gaetong%></td>
	<td><%=g_trans_in_dealer_name%></td>
	<td><%=yuchi_name%></td>
	<td style="mso-number-format:\@"><%=g_date_yuchi%></td>

	<td style="mso-number-format:\@"><%=g_sp_name_top%></td>
	<td><%=g_sp_price_top%></td>

	<td><%=g_sp_name%></td>
	<td><%=g_sp_give_type_txt%></td>
	<td><%=g_sp_price%></td>
	<td><%=g_sp_date_start%></td>
	<td><%=g_sp_date_end%></td>
	<td><%=g_trans_out_dealer_name%></td>
	<td><%=c_address%></td>
	<td><%=c_jumin1%>-<%=c_jumin2%></td>
	<td style="mso-number-format:\@"><%=c_tel1%></td>
	<td style="mso-number-format:\@"><%=c_tel2%></td>

	<td style="mso-number-format:\@"><%=g_sp_bank%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_acount%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_name%></td>
	<td style="mso-number-format:\@"><%=g_sp_bank_memo%></td>
	<td style="mso-number-format:\@"><%=g_cancel_date%></td>

	<td style="mso-number-format:\@"><%=g_give_type_txt%></td>	
	<td style="mso-number-format:\@"><%=give_name%></td>	
	<td style="mso-number-format:\@"><%=give_no%></td>	
	<td style="mso-number-format:\@"><%=give_bank_name%></td>	
	<td style="mso-number-format:\@"><%=give_jumin1%>-<%=give_jumin2%></td>	
	<td style="mso-number-format:\@"><%=give_gigan%></td>
	<td style="mso-number-format:\@"><%=g_give_chk%></td>
	<td style="mso-number-format:\@"><%=area_name%></td>
	<td style="mso-number-format:\@"><%=g_bigo%></td>
</tr>
<%
i=i+1
objRs.movenext
Loop
End If
%>		  
</table>
  <%
  DBClose()
  %>
	

       		