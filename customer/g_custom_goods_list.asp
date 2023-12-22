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
  StartTimer = Timer()
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <%
  Login_chk(Session_m_id)

  if ad_b_g_custom="N" then
 	Alert_URL session_m_name &" 님은 인계처 관리권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	  
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_gaetong_code	= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_search_key		= WORD_CHANGE(Request("s_search_key"),20)
  s_date_start		= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end		= WORD_CHANGE(Request("s_date_end"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("s_article_idx2"),20)
  s_option_idx		= WORD_CHANGE(Request("s_option_idx"),20)
  s_g_set			= WORD_CHANGE(Request("s_g_set"),20)
  s_receipt_chk		= WORD_CHANGE(Request("s_receipt_chk"),20)
  s_sp_give_type	= WORD_CHANGE(Request("s_sp_give_type"),20)
  list_cnt			= WORD_CHANGE(Request("list_cnt"),20)			'출력 갯수
  g_goods_idx_chk	= WORD_CHANGE(Request("g_goods_idx"),20)			

  If list_cnt="" Then		list_cnt="30"  End If
  If s_article_idx1="" Then	s_article_idx1="0"  End If
  If s_article_idx2="" Then	s_article_idx2="0"  End If
  If s_option_idx="" Then	s_option_idx="0"  End If
  If s_g_set	="" Then	s_g_set="0"		End If

  s_link_txt ="search_key="&search_key&"&search_txt="&search_txt&"&s_gaetong_code="&s_gaetong_code&"&s_search_key="&s_search_key&"&s_date_start="&s_date_start&"&s_date_end="&s_date_end&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&s_article_idx2&"&s_option_idx="&s_option_idx&"&s_g_set="&s_g_set&"&s_receipt_chk="&s_receipt_chk&"&s_sp_give_type="&s_sp_give_type&"&list_cnt="&list_cnt


  strSql = " Select m_dealer_code from emp_list where m_id='"&Session_m_id&"'"
  Set objRs=objCnn.Execute(strSql)

  m_dealer_code		= objRs(0)
  objRs.close   
  %>
<!DOCTYPE html>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>

<body>
<div class="outerContainer">
<table width="100%" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
		<!--#include virtual="/include/asp/cms_top.asp"-->
	</td>
</tr>
<tr height="400"> 
	<td valign='top'>

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title" style="background:url(/images/common/sub_t_end.gif) top repeat-x;width:100%;"><img src="/images/common/sub01_t08_1.gif"></div>

		<form id='frm_custom' name='frm_custom' method='post' action='g_custom_goods_list.asp'>
		<table width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table3">
		<tr height="30">			
			<td colspan='2'>
				<select name="s_article_idx1" style="width:90px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="s_article_change(this,'frm_custom',this.selectedIndex);">
				<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>>회사선택           
				<% 
				strSql = " select * from code_article where article_step2=0 "
				strSql = strSql & " and article_view='Y' "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else						 
				i = 1
				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
					<option value="<%=article_idx%>" <% if CInt(s_article_idx1)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				Loop
				End if
				%>	
				</select>
				<select name="s_article_idx2" style="width:100px;" onblur="BlurColor(this);" onFocus="FocusColor(this);" onchange="s_option_change(this,'frm_custom',this.selectedIndex);">
				<option value="0" <% if s_article_idx2="0" then %> selected <% end if %>> 상품선택 
				<% 
				If s_article_idx1<>"0" then

				strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else							 
					i = 1
					Do until objRs.EOF   	
						article_idx		= objRs("article_idx")
						article_name	= objRs("article_name")
					%>	
						<option value="<%=article_idx%>" <% if CInt(s_article_idx2)=article_idx then %> selected <% end if %>><%=article_name%></option>
					<% 
						objrs.MoveNext
						i=i+1 
					Loop
					End If
				End if
				%>	
				</select>
				<select name="s_option_idx" style="width:130px;" onblur="BlurColor(this);" onFocus="FocusColor(this);">
				<option value="0" <% if s_option_idx="0" then %> selected <% end if %>> 상품옵션 </option>
				<% 
				If s_option_idx<>""  then
				
				strSql = " select * from code_article_option where article_idx=" & s_article_idx2 & " and option_view='Y' "
				strSql = strSql & " order by option_order Asc"
				Set objRs=objCnn.Execute(strSql)							
				
				if objRs.BOF or objRs.EOF then
				else
			 
					i = 1
					Do until objRs.EOF   	
						option_idx			= objRs("option_idx")
						option_name			= objRs("option_name")
					%>	
						<option value="<%=option_idx%>" <% if s_option_idx=CStr(option_idx) then %> selected <% end if %>><%=option_name%></option>
					<% 
						objRs.MoveNext
						i=i+1 
					Loop
				End If
				objRs.close
				End if
				%>	
				</select>
				<select name="s_g_set" style="width:60px;" onblur="BlurColor(this);" onFocus="FocusColor(this);">
				<option value="0" <% If s_g_set="0" Then %>selected <% End If %>>셋트</option>
				<option value="A" <% If s_g_set="A" Then %>selected <% End If %>> 단독 </option>
				<option value="B" <% If s_g_set="B" Then %>selected <% End If %>> DPS  </option>
				<option value="C" <% If s_g_set="C" Then %>selected <% End If %>> TPS </option>
				</select>
				<select name="s_sp_give_type" style="width:90px;">
				<option value="" <% If s_sp_give_type="" Then %> selected <% End If %>> 사은품 유형 </option>
				<option value="A" <% If s_sp_give_type="A" Then %> selected <% End If %>>유치자 지급</option>
				<option value="B" <% If s_sp_give_type="B" Then %> selected <% End If %>>고객센터(자체)</option>
				<option value="C" <% If s_sp_give_type="C" Then %> selected <% End If %>>고객센터(상부)</option>
				<option value="E" <% If s_sp_give_type="E" Then %> selected <% End If %>> 사은품 없음 </option>
				<option value="F" <% If s_sp_give_type="F" Then %> selected <% End If %>> 본사상품권 + 현금 </option>

				</select>
				<select name="s_gaetong_code" style="width:70px;" onblur="BlurColor(this);" onFocus="FocusColor(this);">
				<option value="" <% if s_gaetong_code="" then %> selected <% end if %>>개통상태          
				<% 
				strSql = " select * from code_gaetong order by gaetong_order Asc"
				Set objRs0=objCnn.Execute(strSql)

				if objRs0.BOF or objRs0.EOF then
				else
			 
				i = 1
				Do until objRs0.EOF   	
					gaetong_code		= objRs0("gaetong_code")
					gaetong_name		= objRs0("gaetong_name")
				%>	
					<option value="<%=gaetong_code%>" <% if s_gaetong_code=gaetong_code then %> selected <% end if %>><%=gaetong_name%></option>
				<% 
					objrs0.MoveNext
					i=i+1 
				Loop
				End if
				%>	
				</select>
				<select name="s_search_key" style="width:100px;">
				<option value="" <% If s_search_key="" Then %>selected<%end if %>>::날짜항목::
				<option value="g_date_yuchi" <% If s_search_key="g_date_yuchi" Then %>selected<%end if %>>접수일
				<option value="g_date_gaetong" <% If s_search_key="g_date_gaetong" Then %>selected<%end if %>>개통일			
				<option value="goods1" <% If s_search_key="goods1" Then %>selected<%end if %>>지급예정(개통고객)
				<option value="goods2" <% If s_search_key="goods2" Then %>selected<%end if %>>지급완료(개통고객)	
				<option value="goods3" <% If s_search_key="goods3" Then %>selected<%end if %>>지급예정(미개통고객)
				<option value="goods4" <% If s_search_key="goods4" Then %>selected<%end if %>>지급완료(미개통고객)
				</select>
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">~<input type="text" name="s_date_end" size='9' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				
				<select name="date_gigan" style="width:60px;" onchange="fncDateCalculator('frm_custom',this,'s_date_start','s_date_end');">
				<option value="">기간</option>
				<option value="A">오늘</option>
				<option value="B">어제</option>
				<option value="C">이번달</option>
				<option value="D">지난달</option>
				</select>

				<span onClick="send_custom_goods('frm_custom');"><img src="/images/button/btn_search01.gif"  align='absmiddle' border=0></span>	
			</td>
		</tr>
		<tr height="30"> 
			<td style="border-style:none">		  					
				<select name="search_key" valign='absmiddle' class="txtbox">
					<option value="c_name"> 고객명 </option>	
					<option value="m_name"> 유치자 </option>								
					<option value="g_service_no">가입서비스번호</option>								
					<option value="g_address"> 주 소 </option>											
				</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send('frm_custom');"><img src="/images/button/btn_search01.gif" onClick="Search('frm_custom');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>
			<td align="right" style="border-style:none">
				<select name="list_cnt" onchange="submit();">
				<option value="15" <% If list_cnt="15" Then %> selected <% End If %>>15개 출력</option>
				<option value="30" <% If list_cnt="30" Then %> selected <% End If %>>30개 출력</option>
				<option value="50" <% If list_cnt="50" Then %> selected <% End If %>>50개 출력</option>
				<option value="70" <% If list_cnt="70" Then %> selected <% End If %>>70개 출력</option>
				</select>

				<% If ad_b_g_excel="Y" Then %>
					<a href="g_custom_goods_excel.asp?<%=s_link_txt%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				<% Else %>
					<a href='javascript:alert("<%=session_m_name%> 님은 엑셀 다운 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				<% End If %>
				&nbsp;
			</td>
		</tr>
		</table>
		</form>	


  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  
  top_cnt = page * list_cnt
  strSql = " select  TOP " &top_cnt& " A.g_goods_idx, A.c_jumin1, A.c_jumin2, A.g_article_idx1, A.g_article_idx2, "
  strSql = strSql & " A.g_yuchi_m_id , A.g_date_yuchi, A.g_date_gaetong_hope, A.g_date_gaetong_hope_time,"
  strSql = strSql & " A.g_date_gaetong, A.g_writeday, A.c_tel1, A.c_tel2, A.g_sp_name, A.g_sp_price, A.g_set, "
  strSql = strSql & " B.m_name as yuchi_name, C.article_name , D.article_name as article_name1, A.g_sp_give_type, "
  strSql = strSql & " E.gaetong_color, A.c_name, G.promise_name, H.sale_name, A.g_sp_date_start, A.g_sp_date_end, "
  strSql = strSql & " L.dealer_name, E.gaetong_name, A.g_article_cnt, A.g_sp_price_top, A.g_sp_name_top, "
  strSql = strSql & " B.m_tel1, B.m_tel2, A.g_consult_type, A.g_consult_bigo, "
  strSql = strSql & " K.option_name, A.g_service_no, A.g_receipt_type, "
  strSql = strSql & " M.dealer_name as dealer_name1 "
  strSql1 = ""
  strSql1 = strSql1 & "		from customer_goods A left outer  "
  strSql1 = strSql1 & " 		 join emp_list B ON A.g_yuchi_m_id=B.m_id "
  strSql1 = strSql1 & "		left join code_article C on A.g_article_idx1=C.article_idx"
  strSql1 = strSql1 & "		left join code_article D on A.g_article_idx2=D.article_idx"
  strSql1 = strSql1 & "		left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql1 = strSql1 & "		left join code_promise G on A.g_code_promise=G.promise_idx"
  strSql1 = strSql1 & "		left join code_sale H on A.g_code_sale=H.sale_idx"
  strSql1 = strSql1 & "		left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql1 = strSql1 & "		left join dealer_info L ON L.dealer_code=B.m_dealer_code"
  strSql1 = strSql1 & "		left join dealer_info M ON A.g_trans_out_dealer=M.dealer_code"
  strSql1 = strSql1 & "				where (A.g_trans_out_dealer='"&m_dealer_code&"')"


  If s_receipt_chk="O" Then
		strSql1 = strSql1 & "			and (A.g_receipt_type='B' or A.g_receipt_type='C') "
  Else
  
	  If search_txt<>"" then
		If search_key="m_name" Then
			strSql1 = strSql1 & "		and (B.m_name like '%"&search_txt&"%')"
		Else
			strSql1 = strSql1 & "		and  (A."&search_key&" like '%"&search_txt&"%') "
		End If
	  Else	  
		  If s_gaetong_code<>"" Then
			strSql1 = strSql1 & "		and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
		  End If

		  If s_dealer_code<>"" then
			  strSql1 = strSql1 & "		and (A.g_trans_in_dealer='"&s_dealer_code&"')"
		  End If

 		  If s_dealer_code1<>"" then
			  strSql1 = strSql1 & "		and (A.g_trans_out_dealer='"&s_dealer_code1&"')"
		  End If

		  If s_article_idx1<>"0" Then
				strSql1 = strSql1 & "	and (A.g_article_idx1="&s_article_idx1 & ") "
		  End if

		  If s_article_idx2<>"0" Then
				strSql1 = strSql1 & "	and (A.g_article_idx2="&s_article_idx2 & ") "
		  End If

		  If s_option_idx<>"0" Then
				strSql1 = strSql1 & "	and (A.g_option_idx="&s_option_idx & ") "
		  End If

		  '셋트유형
		  If s_g_set<>"0" Then
				strSql1 = strSql1 & "	and (A.g_set='"&s_g_set & "') "
		  End If
	  
		  '사은품 지급 유형
 		  If s_sp_give_type<>"" then
			  strSql1 = strSql1 & "		and (A.g_sp_give_type='"&s_sp_give_type&"')"
		  End If
		  
		  If s_search_key="g_date_yuchi" then	'유치일 검색
			strSql1 = strSql1 & "		and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
		  ElseIf s_search_key="g_date_gaetong" then
			strSql1 = strSql1 & "		and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "	
		  ElseIf s_search_key="goods1" then
			'개통고객 중 지급예정
			strSql1 = strSql1 & "		and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
			strSql1 = strSql1 & "		and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
		  ElseIf s_search_key="goods2" Then
			'개통고객 중 지급완료
			strSql1 = strSql1 & "		and ((A.g_date_gaetong is not null) or (A.g_date_gaetong<>'')) "
			strSql1 = strSql1 & "		and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "		
		  ElseIf s_search_key="goods3" Then
			'미개통고객 중 지급예정
			strSql1 = strSql1 & "		and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
			strSql1 = strSql1 & "		and (A.g_sp_date_start>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_sp_date_start<='"&s_date_end&" 23:59:59') "		
		  ElseIf s_search_key="goods4" Then
			'미개통고객 중 지급완료
			strSql1 = strSql1 & "		and ((A.g_date_gaetong is null) or (A.g_date_gaetong='')) "
			strSql1 = strSql1 & "		and (A.g_sp_date_end>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "		and (A.g_sp_date_end<='"&s_date_end&" 23:59:59') "	
		  End if
	  End If
  End if

  strSql2 = ""
  strSql2 = strSql2 & "						order by   A.receipt_order_a desc, A.g_date_yuchi Desc, g_goods_idx desc  "
  strSql = strSql & strSql1 & strSql2
  'Response.write strSql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = list_Cnt
	
  recordcount	= objRs.recordcount
  %>
		<table width=100%  cellspacing=1 cellpadding=0 border=0  id="board_table2">        
		<tr height="30">
			<th class="head">No</th> 
			<th class="head">고객명</th>        
			<th class="head">접수일</th>        
			<th class="head">통신사</th>  
			<th class="head">상품명</th>
			<th class="head">옵션</th>
			<th class="head">셋트</th>
			<th class="head">가입.번호</th>
			<th class="head">개통상태</th>   
			<th class="head">개통일</th>   
			<Th class="head">본사사은품</th>		
			<Td class="head">사은품</td>
			<Td class="head">금액</td>
			<Td class="head">지급처</td>
			<Td class="head">지급완료</td>
			<th class="head">약정</th>
			<th class="head">최종상담내용</th>
		</tr>
  <%
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height="30">
			<td colspan='19' class="con5"> 고객 등록상품이 없습니다. </td>
		</tr>
  <%
  Else
  %>

   <%
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount  	
  		 
	i = 1
	chk=1
	Do until objRs.EOF Or i>objRs.PageSize 
		g_goods_idx			= objRs("g_goods_idx")
		c_name				= objRs("c_name")							'고객명
		article_name		= objRs("article_name")
		article_name1		= objRs("article_name1")
		option_name			= objRs("option_name")
		g_receipt_type		= objRs("g_receipt_type")

		If g_receipt_type="B" then
			bg_txt = "style='background-color:#F3F781'"
			no_txt = "<img src='/images/button/btn_receipt03.gif' align='absmiddle' border=0 title='"&g_goods_idx&"'>"
			bg_color = "#F3F781"
		ElseIf  g_receipt_type="C" Then
			bg_txt = "style='background-color:#F3F781'"
			no_txt = "<img src='/images/button/btn_receipt06.gif' align='absmiddle' border=0 title='"&g_goods_idx&"'>"
			bg_color = "#F3F781"
		ElseIf  g_receipt_type="I" Then
			bg_txt = "style='background-color:#F3F781'"
			no_txt = "<img src='/images/button/btn_receipt01.gif' align='absmiddle' border=0 title='"&g_goods_idx&"'>"
			bg_color = "#F3F781"
		Else
			bg_txt = " "
			no_txt=g_goods_idx
			bg_color = "white"
		End If
		
		If g_goods_idx_chk	= CStr(g_goods_idx) Then
			bg_txt = "style='background-color:#CEE3F6'"
			bg_color = "#CEE3F6"
		End if	

		c_jumin1			= objRs("c_jumin1")
		c_jumin2			= objRs("c_jumin2")
		c_tel1				= objRs("c_tel1")
		c_tel2				= objRs("c_tel2")
		g_service_no		= objRs("g_service_no")						'가입서비스번호
		g_yuchi_m_id		= objRs("g_yuchi_m_id")						'유치자 아이디
		g_date_gaetong		= objRs("g_date_gaetong")					'개통일
		yuchi_name			= objRs("yuchi_name")
		article_name		= objRs("article_name")
		article_name1		= objRs("article_name1")
		gaetong_name		= objRs("gaetong_name")						'개통 현황
		gaetong_color		= objRs("gaetong_color")					'개통 색상
		promise_name		= objRs("promise_name")
		sale_name			= objRs("sale_name")
		m_tel1				= objRs("m_tel1")							'유치자 연락처
		m_tel2				= objRs("m_tel2")							'유치자 연락처
		dealer_name			= objRs("dealer_name")						'거래처명
		g_date_yuchi		= fnc_date_change(objRs("g_date_yuchi"))	'접수일
		g_writeday			= fnc_date_change(objRs("g_writeday"))
		g_sp_name			= objRs("g_sp_name")						'사은품 명
		g_sp_name_txt		= Left(g_sp_name,10)						'사은품 명
		g_sp_price			= money_change(objRs("g_sp_price"))			'사은품 금액
		g_sp_date_start		= objRs("g_sp_date_start")					'사은품 예정
		g_sp_date_end		= objRs("g_sp_date_end")					'사은품 지급완료
		g_consult_type		= objRs("g_consult_type")
		g_consult_type_list	= fnc_consult_list(g_consult_type)
		g_consult_bigo		= objRs("g_consult_bigo")					'최근상담내용
		g_set				= fnc_g_set(objRs("g_set"))						'셋트유형
		g_out_dealer_name	= objRs("dealer_name1")
		g_sp_give_type		= objRs("g_sp_give_type")							'사은품 지급처		
		g_sp_give_type_txt	= fnc_g_sp_give_type(g_sp_give_type,"A")
		g_article_cnt		= objRs("g_article_cnt")							'회선수
		g_sp_name_top		= objRs("g_sp_name_top")							'본사사은품명		
		g_sp_price_top		= money_change(objRs("g_sp_price_top"))				'본사사은품 금액

		If IsNull(g_consult_bigo)=false Then
			g_consult_bigo		= Replace(g_consult_bigo,"""","&quot;")		
		End if			
	%>
		<!--#include virtual="/include/asp/customer_marking.asp"-->
		<tr height="30" <%=bg_txt%> style="font-size:11px;" onmouseover="style.backgroundColor='#CEE3F6';this.style.cursor='hand';" onmouseout="style.backgroundColor='<%=bg_color%>'">
			<td class="con5"><%=no_txt%></td>
			<td class="con4"><a href="g_custom_goods_regist.asp?g_goods_idx=<%=g_goods_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>" title="<%=c_name%> : <%=c_jumin1%>-<%=c_jumin2%> , Tel.<%=c_tel2%>"><b><%=Left(c_name,10)%></b></a></td>        
			<td class="con4"><span title="최초등록일:<%=g_writeday%>"><%=g_date_yuchi%></span></td>          
			<td class="con2"><span title='<%=article_name%>'><%=Left(article_name,6)%></span></td>  
			<td class="con2"><span title='<%=article_name1%>'><%=Left(article_name1,6)%></span></td> 
			<td class="con2"><span class='red' title="<%=option_name%>" style="font-size:11px;"><%=Left(option_name,6)%></span></td>
			<td class="con4"><%=g_set%></td>
			<td class="con4"><b><%=g_service_no%></b></td>
			<td class="con4"><%=g_date_gaetong%></td>          
			<td class="con4"><b><span style='color:<%=gaetong_color%>;'><%=gaetong_name%></span></b></td>          
			<td class="con4"><span title="<%=g_sp_name_top%>"><%=g_sp_price_top%></span></td>
			<td class="con2"><span title="<%=g_sp_name%>"><%=g_sp_name_txt%></span></td>
			<td class="con4"><%=g_sp_price%></td>
			<td class="con4"><%=g_sp_give_type_txt%></span></td>
			<td class="con4"><span class='red' style="font-size:11px;"><%=g_sp_date_end%></span></td>
			<td class="con4"><%=promise_name%></td>
			<td class="con2"><span title="<%=g_consult_bigo%>"><%=g_consult_type_list%> <%=Left(g_consult_bigo,10)%></span></td>
		</tr>   
  <% 
    i=i+1
	objRs.movenext
  Loop
  End if  
%>		 
		</table>    

		<div class="pagelist">
			<%
			strSql = "select count(g_goods_idx) " & strSql1
			Set objRs=objCnn.Execute(strSql)

			recordcount = objRs(0)

			totalpage = int((recordCount-1)/list_Cnt)+1
			' Request mychoice						
			' Request totalpage
			' Request page
			' Request nowblock
			' Request link_url
			' Request link_tail :마지막 Request 값
			mychoice=10
			link_url = "g_custom_goods_list.asp?"&s_link_txt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><span class='blue'>[ <%=recordcount%> 건 ] </span></b>
  <% 
  endTimer = Timer() 
  runtimer = endTimer - StartTimer
  response.write "&nbsp;&nbsp;&nbsp;&nbsp;<span style='color:white;font-size:11px;'>["& FormatNumber(runtimer, 3)&" sec] </span>" 
  %> 
		</div>    
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
<tr>
    <td height="70" valign="bottom">
	  	<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
</div>
  <%
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>