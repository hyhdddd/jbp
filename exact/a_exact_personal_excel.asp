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
  filename="전체정산_개인별(20"&Left(Create_code(),10)&").xls"		
  Response.addHeader "Content-Disposition","attachment;filename="&filename

  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
  end if	 
  
  dealer_chk			= WORD_CHANGE(Request("dealer_chk"),20)			' 거래 형태
  s_dealer_code			= WORD_CHANGE(Request("s_dealer_code"),20)		' 선택된 거래처 
  date_chk				= WORD_CHANGE(Request("date_chk"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)

  if dealer_chk="" Then
	dealer_chk="1"
  End if
 
  If date_chk="" Then
	date_chk="0"
  End If
  
  If date_chk="0" Then
  	s_date_start=""
	s_date_end=""
  End If
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
	<th bgcolor='gray' rowspan='2'>사원명</th>
	<th bgcolor='gray' rowspan='2'>은행명</th>
	<th bgcolor='gray' rowspan='2'>계좌번호</th>
	<th bgcolor='gray' rowspan='2'>예금주</th>
	<th bgcolor='gray' rowspan='2'>약정금액</th>
	<th bgcolor='gray' colspan='5'>차감내역</th>
	<th bgcolor='gray' rowspan='2'>번들수수료</th>
	<th bgcolor='gray' rowspan='2'>부가서비스</th>
	<th bgcolor='gray' rowspan='2'>결합수수료</th>
	<th bgcolor='gray' rowspan='2'>정산금액</th>
	<th bgcolor='gray' rowspan='2'>부가세<br>원천세</th>
	<th bgcolor='gray' rowspan='2'>세금차감</th>
	<th bgcolor='gray' rowspan='2'>총 정산금액</th>
</tr>
<tr height='30'>
	<th bgcolor='gray' width=70>본사사은품</th>
	<th bgcolor='gray' width=70>사은품</th>
	<th bgcolor='gray' width=70>할인탭</th>
	<th bgcolor='gray' width=70>미비서류</th>
	<th bgcolor='gray' width=70>기타</th>
</tr>

  <%
  strSql = " select K.g_yuchi_m_id, K.t_charge_promise, K.t_charge_sp_top, K.t_charge_sp, K.t_charge_sale, "
  strSql = strSql & " K.t_charge_document, K.t_charge_gita, K.t_charge_bundle, K.t_charge_buga, K.t_charge_combine, Y.m_name, "
  strSql = strSql & " Y.m_bank_name, Y.m_bank_no, Z.bank_name "
  strSql = strSql & "	from ( "
  strSql = strSql & "		select A.g_yuchi_m_id, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_promise),0) as t_charge_promise, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_sp_top),0) as t_charge_sp_top, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_sp),0) as t_charge_sp, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_sale),0) as t_charge_sale, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_document),0) as t_charge_document, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_gita),0) as t_charge_gita, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_bundle),0) as t_charge_bundle, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_combine),0) as t_charge_combine, "
  strSql = strSql & "		ISNULL(SUM(H.g_charge_buga),0) as t_charge_buga "
  strSql = strSql & "			from customer_goods A full join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx "
  strSql = strSql & "				where 1=1 "
	
  '협력점 
  If s_dealer_code<>"" then
  strSql = strSql & "			and A.g_trans_in_dealer='"& s_dealer_code &"' "
  End if

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

  '개통
  If s_gaetong_code<>"" Then
  strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
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


  strSql = strSql & "				group by A.g_yuchi_m_id ) K "
  strSql = strSql & "			left outer join emp_list Y ON K.g_yuchi_m_id=Y.m_id "
  strSql = strSql & "			left join code_bank Z ON Y.m_bank_cd=Z.board_idx "
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  else

	i=1
	Do until objRs.EOF 
		t_charge_promise		= money_chk(objRs("t_charge_promise"))
		t_charge_sp_top			= money_chk(objRs("t_charge_sp_top"))
		t_charge_sp				= money_chk(objRs("t_charge_sp"))
		t_charge_sale			= money_chk(objRs("t_charge_sale"))
		t_charge_document		= money_chk(objRs("t_charge_document"))
		t_charge_gita			= money_chk(objRs("t_charge_gita"))
		t_charge_bundle			= money_chk(objRs("t_charge_bundle"))
		t_charge_combine		= money_chk(objRs("t_charge_combine"))
		t_charge_buga			= money_chk(objRs("t_charge_buga"))
		t_charge_sum			= CDbl(t_charge_promise-cdbl(t_charge_sp_top+t_charge_sp+t_charge_sale+t_charge_document+t_charge_gita)+t_charge_bundle + t_charge_buga + t_charge_combine)
	
		tt_charge_promise		= CDbl(tt_charge_promise+t_charge_promise)
		tt_charge_sp_top		= CDbl(tt_charge_sp_top+t_charge_sp_top)
		tt_charge_sp			= CDbl(tt_charge_sp+t_charge_sp)
		tt_charge_sale			= CDbl(tt_charge_sale+t_charge_sale)
		tt_charge_document		= CDbl(tt_charge_document+t_charge_document)
		tt_charge_gita			= CDbl(tt_charge_gita+t_charge_gita)
		tt_charge_bundle		= CDbl(tt_charge_bundle+t_charge_bundle)
		tt_charge_buga			= CDbl(tt_charge_buga+t_charge_buga)
		tt_charge_combine		= CDbl(tt_charge_combine+t_charge_combine)
		tt_charge_sum			= CDbl(tt_charge_sum+t_charge_sum)

		g_yuchi_m_id			= objRs("g_yuchi_m_id")			'아이디
		m_name					= objRs("m_name")				'사원명
		m_bank_name				= objRs("m_bank_name")			'예금주
		bank_name				= objRs("bank_name")			'은행명
		m_bank_no				= objRs("m_bank_no")			'계좌번호
		

		tax_persent				= "3.3%"
		d_t_charge_tax			= Fix(t_charge_sum*0.033)			
		d_t_charge_sum			= Fix(t_charge_sum-d_t_charge_tax)

		td_t_charge_tax			= td_t_charge_tax + d_t_charge_tax
		td_t_charge_sum			= td_t_charge_sum + d_t_charge_sum

		
		d_t_charge_tax			= money_change(d_t_charge_tax)
		d_t_charge_sum			= money_change(d_t_charge_sum)



		t_charge_promise		= money_change(t_charge_promise)
		t_charge_sp_top			= money_change(t_charge_sp_top)
		t_charge_sp				= money_change(t_charge_sp)
		t_charge_sale			= money_change(t_charge_sale)
		t_charge_document		= money_change(t_charge_document)
		t_charge_gita			= money_change(t_charge_gita)
		t_charge_bundle			= money_change(t_charge_bundle)			
		t_charge_buga			= money_change(t_charge_buga)	
		t_charge_combine		= money_change(t_charge_combine)	
		t_charge_sum			= money_change(t_charge_sum)
	
	%>
<tr height=30>
	<td><%=i%></td>
	<td><%=m_name%></a></td>
	<td><%=bank_name%></td>
	<td style="mso-number-format:\@"><%=m_bank_no%></td>
	<td><%=m_bank_name%></td>
	<td><%=t_charge_promise%></td>
	<td><%=t_charge_sp_top%></td>
	<td><%=t_charge_sp%></td>
	<td><%=t_charge_sale%></td>
	<td><%=t_charge_document%></td>
	<td><%=t_charge_gita%></td>
	<td><%=t_charge_bundle%></td>
	<td><%=t_charge_buga%></td>
	<td><%=t_charge_combine%></td>
	<td><font color='red'><%=t_charge_sum%></span></td>
	<td><%=tax_persent%></td>
	<td><%=d_t_charge_tax%></td>
	<td><%=d_t_charge_sum%></td>
</tr>
	<%
		i=i+1
		objRs.movenext
	Loop
	End if
  %>
<Tr height=30>
	<Td colspan='5' align='center'> <b>현재 화면 정산 합계</b> </td>
	<Td><font color='blue'><%=money_change(tt_charge_promise)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_sp_top)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_sp)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_sale)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_document)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_gita)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_bundle)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_buga)%></font></td>
	<Td><font color='blue'><%=money_change(tt_charge_sum)%></font></td>
	<Td>&nbsp;</td>
	<Td><font color='blue'><%=money_change(td_t_charge_tax)%></font></td>
	<Td><font color='blue'><%=money_change(td_t_charge_sum)%></font></td>
</tr>	   
</table>	
  <%
  DBClose()
  %>