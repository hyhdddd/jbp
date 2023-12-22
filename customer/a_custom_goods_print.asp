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

  if ad_b_a_custom="N" And ad_b_g_custom="N" then
	Alert_URL session_m_name &" 님은 고객상품 관리권한이 없습니다. 관리자에게 문의하시기 바랍니다.","/main.asp"
	Response.end
  End If
  
  g_goods_idx		= WORD_CHANGE(request("g_goods_idx"),20)			'고객 상품 정보

  If g_goods_idx<>"" Then
	strSql = " select A.g_goods_idx, A.c_name, A.c_type, A.c_jumin1, A.c_jumin2, A.c_tel1, A.c_tel2, A.c_tel3, "
	strSql = strsql & " A.c_office_no, A.c_zipcode1, A.c_zipcode2, A.c_address, A.c_email, "
	strSql = strSql & " A.g_sp_bank_code, A.g_sp_bank_acount, A.g_sp_bank_name, "
	strSql = strsql & " A.g_article_idx1, A.g_article_idx2, A.g_option_idx, A.c_jumin_date, "
	strSql = strSql & " A.g_yuchi_m_id , A.g_date_yuchi, A.g_date_gaetong, A.g_service_no, "
	strSql = strSql & " A.g_zipcode1, A.g_zipcode2, A.g_address, A.g_bigo, A.g_set, "
	strSql = strSql & " A.g_file1, A.g_file2, A.g_file3, A.g_file4, A.g_bank_cd, A.g_bank_no, A.g_bank_name, "
	strSql = strSql & " A.g_code_course_idx,  A.g_sp_date_start, A.g_sp_date_end, "
	strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, "
	strSql = strSql & " A.g_code_promise, A.g_sp_name, A.g_sp_price, A.g_cancel_date, "
	strSql = strSql & " A.g_writeday, B.m_name as yuchi_name, A.g_sp_give_type, "
	strsql = strSql & " A.g_give_type, A.g_card_cd, A.g_card_no, A.g_card_gigan , A.g_card_gigan1, A.g_date_gaetong_hope, "
	strSql = strSql & " C.article_name as article1_txt, D.bank_name, E.article_name as article2_txt, D.bank_name ,"
	strSql = strSql & " F.gaetong_name, A.g_bank_jumin1, A.g_bank_jumin2, M.card_name, J.service_name, "
	strSql = strSql & " G.course_name, H.promise_name, I.sale_name, "
	strSql = strSql & " K.option_name "
	strSql = strSql & "	from customer_goods A left outer  "
	strSql = strSql & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id "
	strSql = strSql & "	   left join code_article C on A.g_article_idx1=C.article_idx "
	strSql = strSql & "	   left join code_bank  D on A.g_bank_cd=D.board_idx "
	strSql = strSql & "	   left join code_article E on A.g_article_idx2=E.article_idx"
    strSql = strSql & "	   left join code_gaetong F on A.g_code_gaetong_idx=F.gaetong_code"
    strSql = strSql & "	   left join code_course G on A.g_code_course_idx=G.course_code"
    strSql = strSql & "	   left join code_promise H on A.g_code_promise=H.promise_idx"
    strSql = strSql & "	   left join code_sale  I on A.g_code_sale=I.sale_idx"
    strSql = strSql & "	   left join code_service  J on A.g_code_service=J.service_idx"
    strSql = strSql & "	   left join code_article_option K on A.g_option_idx=K.option_idx"
	strSql = strSql & "	   left join code_card  M on A.g_card_cd=M.board_idx "
	strSql = strSql & "			where A.g_goods_idx="&g_goods_idx
	strSql = strSql & "					order by A.g_goods_idx Desc "
	Set objRs=objCnn.Execute(strSql)
		c_name				= objRs("c_name")					'고객명
		c_type				= objRs("c_type")					'고객 타입
		c_jumin1			= objRs("c_jumin1")					'고객 주민번호
		c_jumin2			= objRs("c_jumin2")					'고객 주민번호
		c_tel1				= objRs("c_tel1")					'핸드폰
		c_tel2				= objRs("c_tel2")					'핸드폰
		c_tel3				= objRs("c_tel3")					'핸드폰
		c_email				= objRs("c_email")					'이메일
		c_office_no			= objRs("c_office_no")				'사업자 번호
		c_zipcode1			= objRs("c_zipcode1")				'고객우편번호
		c_zipcode2			= objRs("c_zipcode2")				'고객우편번호
		c_address			= objRs("c_address")				'고객주소
		c_jumin_date		= objRs("c_jumin_date")				'주민번호 발급일자
		g_article_idx1		= objRs("g_article_idx1")			'상품명
		g_date_yuchi		= Left(objRs("g_date_yuchi"),10)	'접수일
		g_zipcode1			= objRs("g_zipcode1")				'설치 주소
		g_zipcode2			= objRs("g_zipcode2")				'설치 주소
		g_address			= objRs("g_address")				'설치 주소
		g_bigo				= objRs("g_bigo")					'상품 비고
		g_set				= fnc_g_set(objRs("g_set"))			'셋트유형
		g_bank_cd			= objRs("g_bank_cd")				'은행코드
		g_bank_no			= objRs("g_bank_no")				'계좌번호
		g_bank_name			= objRs("g_bank_name")				'예금주
		bank_name			= objRs("bank_name")				'은행명
		g_file1				= objRs("g_file1")		
		g_file2				= objRs("g_file2")
		g_file3				= objRs("g_file3")
		g_file4				= objRs("g_file4")
		yuchi_name			= objRs("yuchi_name")				'상품 유치자
		article1_txt		= objRs("article1_txt")				'상품 회사명
		article2_txt		= objRs("article2_txt")				'상품 이름
		g_date_gaetong		= objRs("g_date_gaetong")			'상품 개통일
		gaetong_name		= objRs("gaetong_name")				'상품 개통 상태
		g_option_idx		= objRs("g_option_idx")				'상품 옵션	
		g_sp_name			= objRs("g_sp_name")				'사은품 명
		g_sp_date_start		= objRs("g_sp_date_start")			'사은품 배송예정일
		g_sp_date_end		= objRs("g_sp_date_end")			'사은품 배송완료일
		g_sp_price			= objRs("g_sp_price")				'사은품 금액
		course_name			= objRs("course_name")				'상품 접수경로
		promise_name		= objRs("promise_name")				'상품 약정
		sale_name			= objRs("sale_name")				'상품 할인탭

		g_give_type			= objRs("g_give_type")				'납부정보
		g_card_cd			= objRs("g_card_cd")				'카드사
		g_card_no			= objRs("g_card_no")				'카드번호
		g_card_gigan		= objRs("g_card_gigan")				'카드 유효기간
		g_card_gigan1		= objRs("g_card_gigan1")			'카드 유효기간

		g_card_gigan		= g_card_gigan&"년 "&g_card_gigan1&"월"


		g_sp_give_type		= objRs("g_sp_give_type")			'사은품 지급방법(A/자체지급 , B/센터지급 , C/인계센터지급		
		g_date_gaetong_hope	= objRs("g_date_gaetong_hope")		'개통희망일

		g_bank_jumin1		= objRs("g_bank_jumin1")			'이체정보 주민번호(고객명과 다를경우)
		g_bank_jumin2		= objRs("g_bank_jumin2")			'이체정보 주민번호(고객명과 다를경우)
		g_service_no		= objRs("g_service_no")				'가입서비스번호
		option_name			= objRs("option_name")
		card_name			= objRs("card_name")
		service_name		= objRs("service_name")

		'사은품 계좌정보
		g_sp_bank_code		= objRs("g_sp_bank_code")							'사은품 계좌 은행코드
		g_sp_bank_acount	= objRs("g_sp_bank_acount")							'사은품 계좌 은행계좌
		g_sp_bank_name		= objRs("g_sp_bank_name")							'사은품 계좌 은행예금주

		g_sum_money_chk		= objRs("g_sum_money_chk")							'합산청구종류
		g_sum_money_txt		= objRs("g_sum_money_txt")							'합산청구종류

		g_bigo				= replace(g_bigo,chr(13) & chr(10),"<br>")

		'3개월 이상된 데이터 암호화 하기
		'g_writeday			= fnc_date_change(objRs("g_writeday"))
		'g_writeday_old		= dateDiff("d",g_writeday, now)


		'If g_writeday_old>=30 Then 
		'	c_name				= left(c_name,2)&"*"
		'	c_jumin2			= left(c_jumin2,1)&"*******"
		'	c_address			= left(c_address,10)&" ***** " 
		'	g_bigo				= " ******** "

		'	If c_tel1<>"" Then 
		'	c_tel1				= left(c_tel1,3)&"-****-"&right(c_tel1,4)
		'	End If

		'	If c_tel2<>"" Then 
		'	c_tel2				= left(c_tel2,3)&"-****-"&right(c_tel2,4)
		'	End If

		'	if g_sp_bank_acount<>"" then
		'	g_sp_bank_acount	= left(g_sp_bank_acount,5)&" ***** "
		'	end if

		'	if give_jumin2<>"" then
		'	give_jumin2			= left(give_jumin2,1)&"*******"
		'	end if

		'	if give_no<>"" then 
		'	give_no				= left(give_no,5)&" ***** "
		'	end if
			
		'	if g_bank_no<>"" then 
		'	g_bank_no			= left(g_bank_no,5)&" ***** "
		'	end if

		'	if c_jumin_date<>"" then 
		'	c_jumin_date		= "*******"
		'	end if

		'	if g_address<>"" then 
		'	g_address			= left(g_address,10)&" *****"
		'	end if

		'	If g_card_no<>"" Then
		'	g_card_no			= "*******"	
		'	End If
			
		'	If g_bank_jumin2<>"" then
		'	g_bank_jumin2		= left(g_bank_jumin2,1)&"*******"
		'	End If
			
		'	If g_card_jumin2<>"" then
		'	g_card_jumin2		= left(g_card_jumin2,1)&"*******"
		'	End If

		'	If g_sp_bank_jumin2<>"" Then
		'	g_sp_bank_jumin2	= left(g_sp_bank_jumin2,1)&"*******"	
		'	End If
			
		'	If g_card_gigan<>"" Then
		'	g_card_gigan	= "**"	
		'	End If
			
		'	If g_card_gigan1<>"" Then
		'	g_card_gigan1	= "**"	
		'	End If
			
		'	If g_move_name<>"" Then
		'	g_move_name		= left(g_move_name,2)&"*"
		'	End If
			
		'	If g_move_tel1<>"" Then
		'	g_move_tel1		= left(g_move_tel1,3)&"-****-"&right(g_move_tel1,4)
		'	End If
			
		'	If g_move_tel2<>"" Then
		'	g_move_tel2		= left(g_move_tel2,3)&"-****-"&right(g_move_tel2,4)
		'	End if
			
		'	If g_move_jumin2<>"" then
		'	g_move_jumin2		= left(g_move_jumin2,1)&"*******"
		'	End If
			
		'End If
  End if
  %>
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />  
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body>
<div class="outerContainer_pop">
<!------------------ 내용 시작  ------------------>
<div class="sub_title"><img src="/images/common/sub01_t01_01.gif"></div>
<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3" >
<tr height="30">
	<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;고객 정보 </td>
</tr>
<tr height="30">
	<th width='130'>고 객 명</th>
	<td width='270'><%=c_name%> </td>
	<th width='130'>고객 구분 </th>
	<td width='270'>
		<% If c_type="C" Then %> 개인 <% End If %>
		<% If c_type="O" Then %> 사업자 <% End If %>
		<% If c_type="F" Then %> 외국인 <% End If %></td>
</tr>
<tr>
	<th>주민번호</th>
	<td><%=c_jumin1%>-<%=c_jumin2%></td>
	<th>사업자번호</th>
	<td><%=c_office_no%></td>
</tr>
<tr height="30">
	<th>주&nbsp;&nbsp;소</th>
	<td colspan='3'>(우:<%=c_zipcode1%>-<%=c_zipcode2%>) &nbsp;&nbsp;<%=c_address%></td>
</tr>
<tr height="30">
	<th>전화번호</th>
	<Td><%=c_tel1%></td>
	<th>핸 드 폰</th>
	<Td><%=c_tel2%></td>
</tr>	
<tr height="30">
	<th>이 메 일</th>
	<Td><%=c_email%></td>
	<th>주민 발급일</th>
	<Td><%=c_jumin_date%></td>	
</tr>
<tr height="30">
	<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;상품 정보 </td>
</tr>
<tr height="30">
	<th> 가입서비스번호 </th>
	<td><%=g_service_no%></td>
	<th>접수 일자</th>
	<td><%=g_date_yuchi%></td>
</tr>

<tr height="30">
	<th> 가입 상품  </th>
	<td colspan='3'> <%=article1_txt%>&nbsp;&nbsp;&nbsp;<%=article2_txt%>&nbsp;&nbsp;&nbsp;<%=option_name%> &nbsp;&nbsp;&nbsp;(세트:<%=g_set%>)</td>
</tr>
<tr height="30">
	<th> 상품 약정 </th>
	<Td><%=promise_name%></td>
	<th> 할 인 탭 </th>
	<Td><%=sale_name%></td>
</tr>
<tr>
	<th> 부가서비스 </th>
	<Td><%=service_name%></td>
	<th>개 통 일 </th>
	<td> <%=g_date_gaetong%><font color='red'>(<%=gaetong_name%>)</td>
</tr>
<tr height="30">
	<th> 설치장소 </th>
	<td colspan='3'>(우:<%=g_zipcode1%>-<%=g_zipcode2%>) <%=g_address%></td>
</tr>
<tr>
	<th> 방문 예정일 </th>
	<td><%=g_date_gaetong_hope%>&nbsp;&nbsp;<%=ii%>시
	<th>해약일자 </th>
	<td><%=g_cancel_date%></td>
</tr>	
<tr height="30">
	<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;납부 정보</td>
</tr>
<tr height="30">						
	<th> 납부 종류 </th>
	<Td colspan='3'>  
		<% If g_give_type="A" Then %>
			계좌이체
		<% ElseIf g_give_type="B" Then %>
			카드납부
		<% ElseIf g_give_type="C" Then %>
			지로납부
		<% ElseIf g_give_type="D" Then %>
			합산청구
		<% End If %>
	</td>
</tr>	
<% If g_give_type="A" Then %>
<tr height="30"> 
	<th>은 행 명</th>
	<td>(<%=bank_name%>)&nbsp;&nbsp; <%=g_bank_no%></td>
	<th>예 금 주</th>
	<td><%=g_bank_name%>
		&nbsp;&nbsp;
		주민번호 : <%=g_bank_jumin1%>-<%=g_bank_jumin2%>
	</td>
</tr>
<% End If %>

<% If g_give_type="B" Then %>
<tr height="30"> 
	<th>카 드 사</th>
	<td>(<%=card_name%>)&nbsp;&nbsp; <%=g_card_no%></td>
	<th>카드유효기간</th>
	<td><%=g_card_gigan%></td>
</tr>
<% End If %>

<% If g_give_type="D" Then %>
<tr height="30"> 
	<th>합산 청구</th>
	<td>
		<% If g_sum_money_chk="A" Then %>
		전화비 합산
		<% End If %>

		<% If g_sum_money_chk="B" Then %>
		인터넷 합산
		<% End If %>

	</td>
	<th>합산 비고</th>
	<td><%=g_sum_money_txt%></td>
</tr>
<% End If %>
<tr height="30">
	<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;사은품 정보</td>
</tr>
<tr height="30"> 
	<th> 사은품 명 </th>
	<td><%=g_sp_name%></td>
	<th> 사은품 금액 </th>
	<td> <%=money_change(g_sp_price)%> 원</td>
</tr>
<tr height="30"> 
	<th> 사은품 지급예정 </th>
	<td><%=g_sp_date_start%></td>
	<th> 사은품 지급완료 </th>
	<td> <%=g_sp_date_end%>&nbsp;

	(지급처 :
		<% If g_sp_give_type="A" Then %>
			유치자지급
		<% ElseIf g_sp_give_type="B" Then %>
			고객센터지급(자체)
		<% ElseIf g_sp_give_type="C" Then %>
			고객센터지급(인계)
		<% ElseIf g_sp_give_type="D" Then %>
			본사지급
		<% End If %>)
	</td>
</tr>
<tr height="30">
	<th> 사은품 계좌</th>
	<td> 
		<%
		strSql = " select * from code_bank where board_idx="&g_sp_bank_code&" order by bank_name Asc"
		Set objRs=objCnn.Execute(strSql)
					
		if objRs.BOF or objRs.EOF Then
			bank_name			= "&nbsp;"
		else
			bank_name			= objRs("bank_name")
		End if
		%> 
		(<%=bank_name%>) &nbsp;&nbsp; <%=g_sp_bank_acount%>
	</td>
	<th> 예금주 </th>
	<td>
		<%=g_sp_bank_name%>
	</td>
</tr>
<tr height="60"> 
	<th>기타 내용</th>
	<td colspan='3'><%=g_bigo%>
	</td>
</tr>		
</table>

<!------------------ 내용 종료  ------------------>
</div> 
<script language="javascript">
<!--
	window.print();
-->
</script>