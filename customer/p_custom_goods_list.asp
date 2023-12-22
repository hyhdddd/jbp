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

  if ad_b_p_custom="N" then
 	Alert_URL session_m_name&" 님은 고객 상품 관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	  
  
  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)
  s_gaetong_code	= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  s_search_key		= WORD_CHANGE(Request("s_search_key"),20)
  s_date_start		= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end		= WORD_CHANGE(Request("s_date_end"),20)
  s_article_idx1	= WORD_CHANGE(Request("s_article_idx1"),20)
  s_article_idx2	= WORD_CHANGE(Request("s_article_idx2"),20)
  s_option_idx		= WORD_CHANGE(Request("s_option_idx"),20)
  s_g_set			= WORD_CHANGE(Request("s_g_set"),20)
  s_receipt_chk		= WORD_CHANGE(Request("s_receipt_chk"),20)
  list_cnt			= WORD_CHANGE(Request("list_cnt"),20)				'출력 갯수
  g_goods_idx_chk	= WORD_CHANGE(Request("g_goods_idx"),20)			

  If s_article_idx1="" Then	s_article_idx1="0"  End If
  If s_article_idx2="" Then	s_article_idx2="0"  End If
  If s_option_idx="" Then	s_option_idx="0"  End If
  If s_g_set	=""  Then	s_g_set="0"		  End If

  If list_cnt="" Then	list_cnt="30"  End If


  s_link_txt ="search_key="&search_key&"&search_txt="&search_txt&"&s_gaetong_code="&s_gaetong_code&"&s_dealer_code="&s_dealer_code&"&s_search_key="&s_search_key&"&s_date_start="&s_date_start&"&s_date_end="&s_date_end&"&s_article_idx1="&s_article_idx1&"&s_article_idx2="&s_article_idx2&"&s_option_idx="&s_option_idx&"&s_receipt_chk="&s_receipt_chk&"&list_cnt="&list_cnt

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
<script language="javascript">
<!--

	function batch_submit(form_name)
	{
		var frm=eval("document.all."+form_name);
	
		chk="X";
		for( var i=0; i<frm.length; i++) 
        	{
               var ele = frm.elements[i];
                if(ele.name == 'g_goods_idx')
                	{
                		if(ele.checked == true)
                		chk="O";
                	}		
        	}	
        		
        	if(chk=="O")
        	{
        		var ans=confirm(" 파일을 첨부 하시겠습니까?");
        		if(ans==true)
        		{
					NewWindow('p_custom_goods_batch.asp','p_customer_batch','410','300','no');
					frm.target="p_customer_batch";
					frm.action="p_custom_goods_batch.asp";
        			frm.submit();
        		}
        		else
        		{
        			return;
        		}	        		
        	}
        	else
        	{
        		alert(" 고객을  선택해 주세요!");
        		return;
        	}	
	}

-->
</script>
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
		<div class="sub_title" style="background:url(/images/common/sub_t_end.gif) top repeat-x;width:100%;"><img src="/images/common/sub01_t01.gif"></div>

		<form id='frm_custom' name='frm_custom' method='post' action='p_custom_goods_list.asp'>

		<table width="100%" cellspacing=0 cellpadding=0 border=0>
		<tr height="30"> 
			<td colspan='2'>
				<select name="s_article_idx1"  class='txtbox' style="width:110px;" onchange="s_article_change(this,'frm_custom',this.selectedIndex);">
				<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>> 회사선택           
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
				<select name="s_article_idx2"  class='txtbox' style="width:110px;" onchange="s_option_change(this,'frm_custom',this.selectedIndex);">
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
				
				<select name="s_option_idx"  class='txtbox' style="width:150px;">
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
				End if
				%>	
				</select>
				<select name="s_g_set"  class='txtbox' style="width:100px;">
				<option value="0" <% If s_g_set="0" Then %>selected <% End If %>> ::셋트선택:: </option>
				<option value="A" <% If s_g_set="A" Then %>selected <% End If %>> 단독 </option>
				<option value="B" <% If s_g_set="B" Then %>selected <% End If %>> DPS  </option>
				<option value="C" <% If s_g_set="C" Then %>selected <% End If %>> TPS </option>
				</select>
				<select name="s_gaetong_code"  class='txtbox' >
				<option value="" <% if s_gaetong_code="" then %> selected <% end if %>> :개통상태:          
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
				End If
				objRs.close
				%>	
				</select>
				<select name="s_search_key"  class='txtbox' >
				<option value="" <% If s_search_key="" Then %>selected<%end if %>>:: 날짜 항목 ::
				<option value="g_date_yuchi" <% If s_search_key="g_date_yuchi" Then %>selected<%end if %>>접수일
				<option value="g_date_gaetong" <% If s_search_key="g_date_gaetong" Then %>selected<%end if %>>개통일
				</select>
				
				<input type="text" name="s_date_start" class="txtbox" size='10' value="<%=s_date_start%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"> <img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"> ~ <input type="text" name="s_date_end" size='10' class="txtbox"  value="<%=s_date_end%>" readonly onblur="BlurColor(this);" onFocus="FocusColor(this);this.select();"> <img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_custom','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				
				<select name="date_gigan"  class='txtbox' style="width:60px;" onchange="fncDateCalculator('frm_custom',this,'s_date_start','s_date_end');">
				<option value="">기간</option>
				<option value="A">오늘</option>
				<option value="B">어제</option>
				<option value="C">이번달</option>
				<option value="D">지난달</option>
				</select>

				<span onClick="send_custom_goods('frm_custom');"><img src="/images/button/btn_search01.gif"  align='absmiddle' border=0></span>
			</td>
		</tr>
		<tr>
			<td>		  					
				<select name="search_key" valign='absmiddle' class="txtbox">
				<option value="c_name"> 고객명 </option>				
				<option value="g_service_no">가입서비스번호</option>								
				<option value="g_address"> 주 소 </option>											
				<option value="g_goods_idx"> 고객번호 </option>											
				</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send('frm_custom');"> <img src="/images/button/btn_search01.gif" onClick="Search('frm_custom');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>					
			<td align="right">
				<select name="list_cnt"  class='txtbox' onchange="submit();">
				<option value="15" <% If list_cnt="15" Then %> selected <% End If %>>15개 출력</option>
				<option value="30" <% If list_cnt="30" Then %> selected <% End If %>>30개 출력</option>
				<option value="50" <% If list_cnt="50" Then %> selected <% End If %>>50개 출력</option>
				<option value="70" <% If list_cnt="70" Then %> selected <% End If %>>70개 출력</option>
				</select>
				
				<img src="/images/button/btn_receipt04.gif" onclick="location.href='p_custom_goods_list.asp?s_receipt_chk=O&list_cnt=<%=list_cnt%>';" align='absmiddle' border="0">

				<% If ad_b_p_excel="Y" Then %>
					<a href="p_custom_goods_excel.asp?<%=s_link_txt%>"><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				<% Else %>
					<a href='javascript:alert("<%=session_m_name%> 님은 엑셀 다운 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_excel.gif" border=0 align="absmiddle"></a>
				<% End If %>

				<% if ad_b_p_custom="W" OR ad_b_p_custom="E" OR ad_b_p_custom="A" then %>
				<a href="/customer/p_custom_regist_top.asp"><img src="/images/button/btn_new.gif" align='absmiddle' border="0"></a>
				<% else %>
				<a href='javascript:alert("<%=session_m_name%> 님은 접수 등록 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_new.gif" border="0"></a>
				<% end if %>	
			</td>
		</tr>
		</table>


  <%
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  top_cnt = page * list_cnt
  strSql = " select  TOP " &top_cnt& " A.g_goods_idx, A.c_name, A.g_article_idx1, A.g_article_idx2, A.g_set, A.g_article_cnt, "
  strSql = strSql & " G.promise_name, H.sale_name, A.g_yuchi_m_id , A.g_date_yuchi, A.c_tel1, A.c_tel2, E.gaetong_color, "
  strSql = strSql & " A.g_date_gaetong, A.g_writeday, A.g_sp_name, A.g_sp_price, A.g_service_no, F.black_type, "
  strSql = strSql & " B.m_name as yuchi_name, C.article_name , D.article_name as article_name1, A.g_receipt_type, "
  strSql = strSql & " E.gaetong_name, A.g_consult_type, A.g_consult_bigo, O.service_name, A.g_sp_give_type, "
  strSql = strSql & " A.c_jumin1, A.c_jumin2, A.g_sp_price_top, A.g_sp_name_top, "
  strSql = strSql & " K.option_name, A.g_sp_date_start, A.g_sp_date_end, A.g_date_gaetong_hope, A.g_date_gaetong_hope_time  "
  strSql1 = ""
  strSql1 = strSql1 & "		from customer_goods A left outer  "
  strSql1 = strSql1 & " 		join emp_list B ON A.g_yuchi_m_id=B.m_id "
  strSql1 = strSql1 & "	   left	join code_article C on A.g_article_idx1=C.article_idx "
  strSql1 = strSql1 & "	   left	join code_article D on A.g_article_idx2=D.article_idx "
  strSql1 = strSql1 & "	   left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql1 = strSql1 & "		left join customer_goods_black F on A.c_jumin1=F.black_jumin1 and  A.c_jumin2=F.black_jumin2 "
  strSql1 = strSql1 & "	  left join code_promise G on  A.g_code_promise=G.promise_idx"
  strSql1 = strSql1 & "	   left join code_sale H on A.g_code_sale=H.sale_idx"
  strSql1 = strSql1 & "	   left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql1 = strSql1 & "		left join code_service O ON A.g_code_service=O.service_idx"
  strSql1 = strSql1 & "				where (A.g_yuchi_m_id='"& Session_m_id &"') "


  If s_receipt_chk="O" Then
		strSql1 = strSql1 & "				and (A.g_receipt_type='B')"
  Else
  
	  If search_txt<>"" then
		If search_key="m_name" Then
			strSql1 = strSql1 & "			and (B.m_name like '%"&search_txt&"%')"
		Else
			strSql1 = strSql1 & "			and  (A."&search_key&" like '%"&search_txt&"%') "
		End If
	  Else	  
		If s_gaetong_code<>"" Then
			strSql1 = strSql1 & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
		End If

		If s_article_idx1<>"0" Then
			strSql1 = strSql1 & "			and (A.g_article_idx1="&s_article_idx1 & ") "
		End if

		If s_article_idx2<>"0" Then
			strSql1 = strSql1 & "			and (A.g_article_idx2="&s_article_idx2 & ") "
		End If

		If s_option_idx<>"0" Then
			strSql1 = strSql1 & "			and (A.g_option_idx="&s_option_idx & ") "
		End If

		If s_g_set<>"0" Then
			strSql1 = strSql1 & "			and (A.g_set='"&s_g_set & "') "
		End If

		If s_search_key="g_date_yuchi" then	'유치일 검색
			strSql1 = strSql1 & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
		ElseIf s_search_key="g_date_gaetong" then
			strSql1 = strSql1 & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
			strSql1 = strsql1 & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
		End If

	  End If
  End if
  
  strSql2 = ""
  strSql2 = strSql2 & "						order by  A.receipt_order_p desc, A.g_date_yuchi Desc,g_goods_idx desc "
  strSql = strSql & strSql1 & strSql2
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = list_Cnt
	
  recordcount	= objRs.recordcount
  %>
		<div style="margin-top:5px;"></div>
		<TABLE width="100%" border=0 cellspacing=1 cellpadding=0 id="board_table2">
		<tr height="33">
			<Td class="head">No</Td> 
			<Td class="head">수정</Td>        
			<Td class="head">고객명</Td>        
			<Td class="head">유치자</Td>          
			<Td class="head">접수일</Td>        
			<Td class="head">통신사</Td>  
			<Td class="head">상품명</Td>  
			<Td class="head">옵션</Td>
			<Td class="head">할인탭</Td> 
			<Td class="head">셋트</Td>
			<Td class="head">가입.번호</Td>
			<Td class="head">개통일</Td>        
			<Td class="head">개통상태</Td>   
			<Th class="head">본사사은품</th>
			<Td class="head">사은품</td>
			<Td class="head">금액</td>
			<Td class="head">지급처</Td>
			<Td class="head">지급완료</Td>
			<Td class="head">약정</Td>
			<Td class="head">최종상담내용</Td>
		</tr>
  <%
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
		<tr height="30">
			<td colspan='21' class="con5"> 고객 등록상품이 없습니다. </td>
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
		c_jumin1			= objRs("c_jumin1")
		c_jumin2			= objRs("c_jumin2")
		c_tel1				= objRs("c_tel1")
		c_tel2				= objRs("c_tel2")
		article_name		= objRs("article_name")
		article_name1		= objRs("article_name1")
		option_name			= objRs("option_name")
		g_receipt_type		= objRs("g_receipt_type")

		black_type			= objRs("black_type")						'블랙리스트
		black_type_txt1		= black_type_txt(black_type)

		g_service_no		= objRs("g_service_no")						'가입서비스번호
		g_yuchi_m_id		= objRs("g_yuchi_m_id")						'유치자 아이디
		g_date_gaetong		= objRs("g_date_gaetong")					'개통일
		yuchi_name			= objRs("yuchi_name")
		article_name		= objRs("article_name")
		g_date_yuchi		= fnc_date_change(objRs("g_date_yuchi"))	'접수일
		g_writeday			= fnc_date_change(objRs("g_writeday"))
		article_name1		= objRs("article_name1")
		gaetong_name		= objRs("gaetong_name")						'개통 현황
		gaetong_color		= objRs("gaetong_color")
		promise_name		= objRs("promise_name")
		sale_name			= objRs("sale_name")			
		g_sp_name			= objRs("g_sp_name")						'사은품 명
		g_sp_name_txt		= Left(g_sp_name,10)						'사은품 명
		g_sp_price			= money_change(objRs("g_sp_price"))			'사은품 금액
		g_sp_date_start		= objRs("g_sp_date_start")					'사은품 예정
		g_sp_date_end		= objRs("g_sp_date_end")					'사은품 지급완료
		g_consult_type		= objRs("g_consult_type")
		g_consult_type_list	= fnc_consult_list(g_consult_type)
		g_consult_bigo		= objRs("g_consult_bigo")					'최근상담내용
		g_set				= fnc_g_set(objRs("g_set"))					'셋트유형
		service_name		= objRs("service_name")						'부가서비스 

		g_article_cnt		= objRs("g_article_cnt")							'회선수
		g_sp_give_type		= objRs("g_sp_give_type")							'사은품 지급처
		g_sp_give_type_txt	= fnc_g_sp_give_type(g_sp_give_type,"P")
		g_sp_name_top		= objRs("g_sp_name_top")							'본사사은품명		
		g_sp_price_top		= money_change(objRs("g_sp_price_top"))				'본사사은품 금액		


		If IsNull(g_consult_bigo)=false Then
			g_consult_bigo		= Replace(g_consult_bigo,"""","&quot;")					'최근상담내용
		End If
		
		If black_type="A" Or black_type="B" Or black_type="C" then
			c_name_color	= "color:Orange;font-weight:bold;"
		Else
			c_name_color	= ""
		End If	
		
		If g_receipt_type="B" Then
			bg_txt = "style='background-color:#F3F781'"
			no_txt = "<img src='/images/button/btn_receipt03.gif' align='absmiddle' border=0>"
			bg_color = "#F3F781"
		elseIf g_receipt_type="I" Then
			bg_txt = "style='background-color:#F3F781'"
			no_txt = "<img src='/images/button/btn_receipt01.gif' align='absmiddle' border=0>"
			bg_color = "#F3F781"
		Else
			bg_txt = " "
			no_txt=i
			bg_color = "white"
		End If		

		If g_goods_idx_chk	= CStr(g_goods_idx) Then
			bg_txt = "style='background-color:#CEE3F6'"
			bg_color = "#CEE3F6"
		End if		
		
	%>
		<!--#include virtual="/include/asp/customer_marking.asp"-->
		<tr height="30" <%=bg_txt%> onmouseover="style.backgroundColor='#CEE3F6';this.style.cursor='hand';" onmouseout="style.backgroundColor='<%=bg_color%>'">
			<td class="con5"><%=no_txt%></td>
			<td class="con4" align='center'><input type="radio" name="g_goods_idx" value="<%=g_goods_idx%>"> </td>			
			<td class="con4"><a href="p_custom_goods_regist.asp?g_goods_idx=<%=g_goods_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><span style="<%=c_name_color%>" title='<%=c_name%>: <%=c_jumin1%>-<%=c_jumin2%> , Tel.<%=c_tel2%>'><b><%=Left(c_name,8)%></b></a></td>        
			<td class="con4"><span title="연락처 : <%=m_htel%>"><%=Left(yuchi_name,5)%></span></td>          
			<td class="con4"><span title="최초등록일:<%=g_writeday%>"><%=g_date_yuchi%></span></td>          
			<td class="con2"><span title="<%=article_name%>"><%=Left(article_name,6)%></span></td>        
			<td class="con2"><span title="<%=article_name1%>"><%=Left(article_name1,6)%></span></td>        
			<td class="con2"><span class='red' title='<%=option_name%>'><%=Left(option_name,10)%></span></td>
			<td class="con4"><span title="<%=sale_name%>"><%=Left(sale_name,6)%></span></td>
			<td class="con4"><%=g_set%></td>
			<td class="con4"><b><%=g_service_no%></b></td>
			<td class="con4"><%=g_date_gaetong%></td>          
			<td class="con4"><b><span style='color:<%=gaetong_color%>;'><%=gaetong_name%></span></b></td>          			
			<td class="con4"><span title="<%=g_sp_name_top%>"><%=g_sp_price_top%></span></td>
			<td class="con2"><span title="<%=g_sp_name%>"><%=g_sp_name_txt%></span></td>
			<td class="con4"><%=g_sp_price%></td>
			<td class="con4"><%=g_sp_give_type_txt%></td>
			<td class="con4"><span class='red'><%=g_sp_date_end%></span></td>
			<td class="con4"><span title="<%=promise_name%>"><%=Left(promise_name,2)%></span></td>
			<td class="con2"><span title="<%=g_consult_bigo%>"><%=g_consult_type_list%> <%=Left(Trim(g_consult_bigo),10)%></span></td>
		</tr>   
  <% 
    i=i+1
	objRs.movenext
  Loop
  End If
  
%>		  
  		<tr height=30>
			<td class="con1" colspan='20'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:batch_submit('frm_custom');"><img src="/images/button/btn_file.gif" border=0 align='absmiddle'></a>
			</td>
		</tr>
		</table>	
		</form>	

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
			link_url = "p_custom_goods_list.asp?"&s_link_txt&"&"
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