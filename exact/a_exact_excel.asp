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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	 

  filename="전체정산(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename
 
  search_txt			= WORD_CHANGE(Request("search_txt"),20)
  search_key			= WORD_CHANGE(Request("search_key"),20)  
  dealer_chk			= WORD_CHANGE(Request("dealer_chk"),20)			' 거래 형태
  s_dealer_code			= WORD_CHANGE(Request("s_dealer_code"),20)		' 선택된 거래처 
  s_dealer_code1		= WORD_CHANGE(Request("s_dealer_code1"),20)		' 선택된 거래처 
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)
  date_chk				= WORD_CHANGE(Request("date_chk"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
  s_set					= WORD_CHANGE(Request("s_set"),20)
  s_yuchi_m_id			= WORD_CHANGE(Request("s_yuchi_m_id"),20)
  s_code_area			= WORD_CHANGE(money_chk(Request("s_code_area")),20)

  s_group_code			= WORD_CHANGE(Request("s_group_code"),20)
  s_code_service		= WORD_CHANGE(Request("s_code_service"),20)

  if dealer_chk="" Then		dealer_chk="1"	  End if 
  If date_chk="" Then		date_chk="0"	  End If
  
  If date_chk="0" Then
  	s_date_start=""
	s_date_end=""
  End if  
   

  If s_dealer_code="" Then
	yutong_name=""
  Else  
	  strSql =  "SELECT dealer_name from dealer_info where dealer_code='"&s_dealer_code&"'"
	  Set objRs=objCnn.Execute(strSql)

	  yutong_name	= objRs("dealer_name")
	  objRs.close
  End if

  %>

  
<meta http-equiv=Content-Type content='text/html; charset=ks_c_5601-1987'> 
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

<table width=100% cellspacing="1" cellpadding="0" border=1>
<tr height='30'>
	<Th bgcolor='gray' rowspan='2'>No</th>
	<Th bgcolor='gray' rowspan='2'>정산종류</th>
	<th bgcolor='gray' rowspan='2'>상부점</th>
	<th bgcolor='gray' rowspan='2'>협력점</th>
	<th bgcolor='gray' rowspan='2'>유치자</th>
	<Th bgcolor='gray' rowspan='2'>고객명</th>
	<Th bgcolor='gray' rowspan='2'>가입서비스</th>
	<Th bgcolor='gray' rowspan='2'>상품명</th>
	<Th bgcolor='gray' rowspan='2'>상품옵션</th>
	<th bgcolor='gray' rowspan='2'>부가서비스</th>
	<th bgcolor='gray' rowspan='2'>할인탭</th>
	<Th bgcolor='gray' rowspan='2'>셋트유형</th>
	<th bgcolor='gray' rowspan='2'>접수일</th>
	<th bgcolor='gray' rowspan='2'>개통일</th>

	<th bgcolor='gray' rowspan='2'>약정금액</th>
	<th bgcolor='gray' colspan='5'>차감내역</th>
	<th bgcolor='gray' rowspan='2'>번들수수료</th>
	<th bgcolor='gray' rowspan='2'>부가서비스</th>
	<th bgcolor='gray' rowspan='2'>결합수수료</th>
	<th bgcolor='gray' rowspan='2'>정산금액</th>
	<th bgcolor='gray' rowspan='2'>정산예정일</th>
	<th bgcolor='gray' rowspan='2'>정산 비고</th>
	<Th bgcolor='gray' rowspan='2'>미비서류 비고</th>
	<Th bgcolor='gray' rowspan='2'>본사 사은품</th>
	<Th bgcolor='gray' rowspan='2'>본사 금액</th>
	<Th bgcolor='gray' rowspan='2'>사은품</th>
	<Th bgcolor='gray' rowspan='2'>사은품 지급처</th>
	<Th bgcolor='gray' rowspan='2'>금액</th>
	<Th bgcolor='gray' rowspan='2'>지급예정</th>
	<Th bgcolor='gray' rowspan='2'>지급완료</th>
	<th bgcolor='gray' rowspan='2'>약정</th>
	<th bgcolor='gray' rowspan='2'>지역</th>

	<Th bgcolor='gray' rowspan='2'>회선수</th>
	<th bgcolor='gray' rowspan='2'>상태</th>
	<th bgcolor='gray' rowspan='2'>정산완료일</th>
</tr>
<tr height='30'>
	<th bgcolor='gray' width=70>본사사은품</th>
	<th bgcolor='gray' width=70>사은품</th>
	<th bgcolor='gray' width=70>할인탭</th>
	<th bgcolor='gray' width=70>미비서류</th>
	<th bgcolor='gray' width=70>기타</th>
</tr>


  <%
 
  strSql = " Select H.g_charge_type, A.g_goods_idx as gg_idx, A.g_goods_idx, A.g_article_idx1, A.goods_settop1_chk, A.goods_settop2_chk, "
  strSql = strSql & " A.g_yuchi_m_id, A.g_date_yuchi, A.g_date_gaetong, A.g_service_no, M.dealer_name as dealer_name1,  "
  strSql = strSql & " A.g_writeday, G.dealer_name,  B.m_name as yuchi_name, A.g_article_cnt, H.g_charge_bigo_doc, "

  strSql = strSql & " H.g_charge_promise, H.g_charge_sp_top, H.g_charge_sp, H.g_charge_sale, H.g_charge_gita, H.g_charge_bundle, H.g_charge_buga, H.g_charge_combine, " 
  strSql = strSql & " H.g_charge_document, H.g_charge_bigo, H.g_charge_date1, H.g_charge_date1, H.g_charge_date2, " 

  strSql = strSql & " A.g_sp_name, A.g_sp_price, A.g_sp_give_type, A.g_sp_date_start, L.area_name, "
  strSql = strSql & " A.g_sp_date_end, C.article_name, D.article_name as article_name1,  "
  strSql = strSql & " E.gaetong_name, E.gaetong_color, A.c_name, O.service_name, A.g_sp_name_top, A.g_sp_price_top,  "
  strSql = strSql & " I.promise_name, J.sale_name , K.option_name, A.g_set "
  strSql = strSql & "		from customer_goods A full  "
  strSql = strSql & "			 join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx"
  strSql = strSql & " 		left join emp_list B ON  A.g_yuchi_m_id=B.m_id "
  strSql = strSql & "		left join code_article C on  A.g_article_idx1=C.article_idx "
  strSql = strSql & "		left join code_article  D on  A.g_article_idx2=D.article_idx "
  strSql = strSql & "		left join code_gaetong E on  A.g_code_gaetong_idx=E.gaetong_code"
  strSql = strSql & "		left join dealer_info G ON  A.g_trans_in_dealer=G.dealer_code"
  strSql = strSql & "		left join code_promise I on  A.g_code_promise=I.promise_idx"
  strSql = strSql & "		left join code_sale J on  A.g_code_sale=J.sale_idx"
  strSql = strSql & "		left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql = strSql & "		left join code_area L ON A.g_code_area=L.area_idx"
  strSql = strSql & "		left join dealer_info M ON  A.g_trans_out_dealer=M.dealer_code"
  strSql = strSql & "		left join code_service O ON A.g_code_service=O.service_idx"
  strSql = strSql & "				where 1=1 "

  If search_txt<>"" Then
	If search_key="m_name" Then
		strSql = strSql & "			and (B.m_name like '%"&search_txt&"%') "
	Else
		strSql = strSql & "			and (A."&search_key&" like '%"&search_txt&"%') "
	End If		
  Else
	'회사
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End if

	'상품
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'옵션
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If

	'셋트유형
	If s_set<>"" Then
		If s_set="D" then	'셋추1
			strSql = strSql &"		and (A.goods_settop1_chk='O') "
		ElseIf s_set="E" Then
			strSql = strSql &"		and (A.goods_settop2_chk='O') "
		else
		strSql = strSql &"			and (A.g_set='"& s_set & "') "
		End if
	End If

	'개통
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'협력점
	If s_dealer_code<>"" then
		strSql = strSql & "			and (A.g_trans_in_dealer='"&s_dealer_code&"') "	
	End If

	'유치자
	If s_yuchi_m_id<>"" Then
		strSql = strSql & "			and (A.g_yuchi_m_id='"&s_yuchi_m_id & "') "
	End If

	'상부점
	If s_dealer_code1<>"" then
		  strSql = strSql & "		and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
	End If

	'정산그룹별 검색
	If s_group_code<>""  Then
		strSql = strSql & "			and (G.dealer_group_code='"&s_group_code&"') "
	End If

	'부가서비스 검색
	If s_code_service<>"" And s_code_service<>"0"  Then
		strSql = strSql & "			and A.g_code_service="&s_code_service&" "
	End If
	
	'지역 검색
	If s_code_area<>"0"  Then
		strSql = strSql & "			and A.g_code_area= "&s_code_area&" "
	End If		
	
	'접수일
	If date_chk="1" Then
		strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
	End If

	'개통일
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'해약일
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'정산완료일
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If

	'정산예정일 + 미완료
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If
	
  End If 

  strSql = strSql &"				order by  A.g_date_yuchi Desc, A.g_goods_idx desc "
  
  'response.write strSql
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  else
	
	i=1
	Do until objRs.EOF 
		g_goods_idx				= objRs("g_goods_idx")
		article_name			= objRs("article_name")
		article_name1			= objRs("article_name1")
		c_name					= objRs("c_name")								'고객명		
		g_charge_type_txt		= fnc_charge_type(objRs("g_charge_type"))
		gg_idx					= objRs("gg_idx")

		g_date_yuchi			= fnc_date_change(objRs("g_date_yuchi"))
		g_date_gaetong			= Left(objRs("g_date_gaetong"),10)
		g_writeday				= Left(objRs("g_writeday"),10)
		option_name				= objRs("option_name")
		dealer_name				= objRs("dealer_name")
		dealer_name1			= objRs("dealer_name1")								'상부점
		area_name				= objRs("area_name")

		g_charge_promise		= money_chk(objRs("g_charge_promise"))
		g_charge_sp_top			= money_chk(objRs("g_charge_sp_top"))
		g_charge_sp				= money_chk(objRs("g_charge_sp"))
		g_charge_sale			= money_chk(objRs("g_charge_sale"))
		g_charge_document		= money_chk(objRs("g_charge_document"))
		g_charge_gita			= money_chk(objRs("g_charge_gita"))
		g_charge_bundle			= money_chk(objRs("g_charge_bundle"))
		g_charge_buga			= money_chk(objRs("g_charge_buga"))
		g_charge_combine		= money_chk(objRs("g_charge_combine"))
		g_charge_sum			= CDbl(g_charge_promise-cdbl(g_charge_sp_top+g_charge_sp+g_charge_sale+g_charge_document+g_charge_gita)+g_charge_bundle+g_charge_buga+g_charge_combine)

		g_charge_bigo			= objRs("g_charge_bigo")

		g_charge_promise		= money_change(g_charge_promise)
		g_charge_sp_top			= money_change(g_charge_sp_top)
		g_charge_sp				= money_change(g_charge_sp)
		g_charge_sale			= money_change(g_charge_sale)
		g_charge_document		= money_change(g_charge_document)
		g_charge_gita			= money_change(g_charge_gita)
		g_charge_bundle			= money_change(g_charge_bundle)
		g_charge_buga			= money_change(g_charge_buga)
		g_charge_combine		= money_change(g_charge_combine)
		g_charge_sum			= money_change(g_charge_sum)

		t_charge_promise		= CDbl(t_charge_promise+g_charge_promise)
		t_charge_sp_top			= CDbl(t_charge_sp_top+g_charge_sp_top)
		t_charge_sp				= CDbl(t_charge_sp+g_charge_sp)
		t_charge_sale			= CDbl(t_charge_sale+g_charge_sale)
		t_charge_document		= CDbl(t_charge_document+g_charge_document)
		t_charge_gita			= CDbl(t_charge_gita+g_charge_gita)
		t_charge_bundle			= CDbl(t_charge_bundle+g_charge_bundle)
		t_charge_buga			= CDbl(t_charge_buga+g_charge_buga)
		t_charge_sum			= CDbl(t_charge_sum+g_charge_sum)

		g_charge_date1			= objRs("g_charge_date1")							'정산 예정일
		g_charge_date2			= objRs("g_charge_date2")							'정산 완료일

		gaetong_name			= objRs("gaetong_name")
		gaetong_color			= objRs("gaetong_color")

		g_sp_name_top			= Left(objRs("g_sp_name_top"),10)					'본사 사은품 명
		g_sp_price_top			= money_change(objRs("g_sp_price_top"))				'본사 사은품 금액
			
		g_sp_name				= objRs("g_sp_name")								'사은품 명
		g_sp_name_txt			= Left(g_sp_name,10)								'사은품 명
		g_sp_price				= money_change(objRs("g_sp_price"))					'사은품 금액
		g_sp_give_type			= objRs("g_sp_give_type")							'사은품 지급처
		
		g_sp_give_type_txt		= fnc_g_sp_give_type(g_sp_give_type,"A")

		g_sp_date_start			= objRs("g_sp_date_start")							'사은품 예정
		g_sp_date_end			= objRs("g_sp_date_end")							'사은품 지급완료
		g_set					= fnc_g_set(objRs("g_set"))							'셋트유형


		goods_settop1_chk		= objRs("goods_settop1_chk")
		goods_settop2_chk		= objRs("goods_settop2_chk")

		If goods_settop1_chk="O" Then
			g_set				= "셋추1"
		End If

		If goods_settop2_chk="O" Then
			g_set				= "셋추2"
		End If

		promise_name			= objRs("promise_name")								'상품 약정
		sale_name				= objRs("sale_name")								'할인탭
		yuchi_name				= objRs("yuchi_name")								'유치자
		service_name			= objRs("service_name")								'부가서비스 
		g_service_no			= objRs("g_service_no")
		g_article_cnt			= objRs("g_article_cnt")							'회선수
		g_charge_bigo_doc		= objRs("g_charge_bigo_doc")						'미비서류 비고
	%>
<!--#include virtual="/include/asp/customer_marking.asp"-->
<tr height="27">
	<td><%=i%>
	<td><%=g_charge_type_txt%> </td>
	<td style="mso-number-format:\@"><%=dealer_name1%></td>
	<td><%=dealer_name%></td>
	<td><%=yuchi_name%></td>
	<td><%=c_name%></td>        
	<td style="mso-number-format:\@"><%=g_service_no%></td>        
	<td><%=article_name%>_<%=article_name1%></td>
	<td><%=option_name%></td>
	<td style="mso-number-format:\@"><%=service_name%></td>
	<td><%=sale_name%></td>
	<td><%=g_set%></td>
	<td><%=g_date_yuchi%></td>
	<td><%=g_date_gaetong%></td>
	<td><%=g_charge_promise%></td>
	<td><%=g_charge_sp_top%></td>
	<td><%=g_charge_sp%></td>
	<td><%=g_charge_sale%></td>
	<td><%=g_charge_document%></td>
	<td><%=g_charge_gita%></td>
	<td><%=g_charge_bundle%></td>
	<td><%=g_charge_buga%></td>
	<td><%=g_charge_combine%></td>
	<td><%=g_charge_sum%></td>
	<td><%=g_charge_date1%></td>
	<td style="mso-number-format:\@"><%=g_charge_bigo%></td>
	<td style="mso-number-format:\@"><%=g_charge_bigo_doc%></td>
	<td><%=g_sp_name_top%></td>
	<td><%=g_sp_price_top%></td>
	<td><%=g_sp_name_txt%></td>
	<td><%=g_sp_give_type_txt%></td>
	<td><%=g_sp_price%></td>
	<td><%=g_sp_date_start%></td>
	<td><%=g_sp_date_end%></td>	
	<td><%=promise_name%></td>
	<td style="mso-number-format:\@"><%=area_name%></td>

	<td><%=g_article_cnt%></td>
	<td><%=gaetong_name%></td>
	<td><%=g_charge_date2%></td>

</tr>
	<%
		i=i+1
		objRs.movenext
	Loop
	End if
  %>

<Tr height="30">
	<Td align='center' colspan='14' ><b>현재 화면 정산 합계</b> </td>
	<Td><%=money_change(t_charge_promise)%></td>
	<Td><%=money_change(t_charge_sp_top)%></td>
	<Td><%=money_change(t_charge_sp)%></td>
	<Td><%=money_change(t_charge_sale)%></td>
	<Td><%=money_change(t_charge_document)%></td>
	<Td><%=money_change(t_charge_gita)%></td>
	<Td><%=money_change(t_charge_bundle)%></td>
	<Td><%=money_change(t_charge_buga)%></td>
	<Td><%=money_change(t_charge_combine)%></td>
	<Td><%=money_change(t_charge_sum)%></td>
	<Td colspan='15'>&nbsp;</td>
</tr>		
</table>
  <%
  DBClose()
  %>