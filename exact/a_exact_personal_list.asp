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
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &"님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
  end if	 
  
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
  
  s_dealer_code			= WORD_CHANGE(Request("s_dealer_code"),20)		' 선택된 거래처 
  s_gaetong_code		= WORD_CHANGE(Request("s_gaetong_code"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)
  date_chk				= WORD_CHANGE(Request("date_chk"),20)

  If date_chk=""		Then	date_chk="0"			End If  
 
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  s_link_txt ="s_gaetong_code="& s_gaetong_code &"&date_chk="& date_chk &"&s_date_start="& s_date_start &"&s_date_end="& s_date_end 
  s_link_txt = s_link_txt &"&s_article_idx1="& s_article_idx1 &"&s_article_idx2="& s_article_idx2 &"&s_option_idx="& s_option_idx &"&s_dealer_code="& s_dealer_code


  If date_chk="0" Then
  	s_date_start=""
	s_date_end=""
  End if
  
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<SCRIPT type="text/JavaScript" src="/include/js/custom_goods.asp"></SCRIPT>
<script type="text/JavaScript">

function toggle_img(src)
{
	allchecked=document.getElementById('allcheck').value;
	//var form=document.all.frm_exact.elements;
	var charge_idx = document.getElementsByName("g_yuchi_m_id")
	
	if(allchecked==0)
	{
		document.getElementById('allcheck').value="1";
		document.getElementById('toggle_img1').src = "/images/button/cancel.gif";
		
		for( var i=0; i<charge_idx.length; i++) 
			{
				charge_idx[i].checked=true;
			}

	}	
	else
	{
		document.getElementById('allcheck').value="0";
		document.getElementById('toggle_img1').src = "/images/button/select.gif";

		for( var i=0; i<charge_idx.length; i++) 
			{
				charge_idx[i].checked=false;
			}

	}
}	

function exact_submit()
{
	//var form=document.all.frm_exact.elements;
	var charge_idx = document.getElementsByName("g_yuchi_m_id")
	
	mail_del_chk="";
	for( var i=0; i<charge_idx.length; i++) 
	{
		if(charge_idx[i].checked==true)
		{
			mail_del_chk="O";
		}
	}
		
	if(mail_del_chk=="O")
	{
		var ans=confirm(" 현재 검색된 고객 정보가 일괄적으로 수정됩니다 \n\n 일괄 정산 처리 하시겠습니까?");
		if(ans==true)
		{
			NewWindow('a_exact_personal_batch.asp','a_exact_personal','600','350','no');
			document.all.frm_exact.target="a_exact_personal";
			document.all.frm_exact.action="a_exact_personal_batch.asp";
			document.all.frm_exact.submit();
		}
		else
		{
			return;
		}	        		
	}
	else
	{
		alert(" 사원을 한명 이상 선택해 주세요!");
		return;
	}	
}

</script>

<body>
<div class="outerContainer">
<table width="100%" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ 내용 시작  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">전체 정산관리</li>
		</ul>
		</div>
		<form id='frm_exact' name='frm_exact' method='post' action='a_exact_personal_list.asp'>
		<input type="hidden" name="ss_article_idx1" value="<%=s_article_idx1%>">
		<input type="hidden" name="ss_article_idx2" value="<%=s_article_idx2%>">
		<input type="hidden" name="ss_option_idx" value="<%=s_option_idx%>">

		<input type="hidden" name="ss_gaetong_code" value="<%=s_gaetong_code%>">
		<input type="hidden" name="ss_date_chk" value="<%=date_chk%>">
		<input type="hidden" name="ss_date_start" value="<%=s_date_start%>">
		<input type="hidden" name="ss_date_end" value="<%=s_date_end%>">
		<input type="hidden" id="allcheck" name="allcheck" value="0">

		<table width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr>
			<td colspan='2'>
				<select name="s_dealer_code" class="txtbox" style="width:130px;">
				<option value="">::협력점::</option>
				<%				
				strSql = " select * from dealer_info where (dealer_insu='Y' and dealer_view='Y')"

				If s_group_code<>"" Then
				strSql = strSql & " and dealer_group_code='"&s_group_code&"' "
				End if

				strSql = strSql & " order by dealer_name asc"
				set objRs=objCnn.Execute(strSql)
					
				Do until objRs.EOF 
					dealer_code		= objRs("dealer_code")
					dealer_name		= objRs("dealer_name")
				%>
					<option value="<%=dealer_code%>"  <% if s_dealer_code=dealer_code then %> selected <% end if %>> <%=dealer_name%> </option>
				<%
					objRs.movenext
				Loop
				objRs.close
				%>
				</select>
				<select name="s_article_idx1" class="txtbox"  style="width:110px;" onchange="s_article_change(this,'frm_exact',this.selectedIndex);">
				<option value="0" <% if s_article_idx1="0" then %> selected <% end if %>> 회사선택</option>           
				<% 
				strSql = " select * from code_article where article_step2=0 order by article_idx Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
					<option value="<%=article_idx%>" <% if CInt(s_article_idx1)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
				Loop
				%>	
				</select>
				<select name="s_article_idx2" class="txtbox"  style="width:100px;" onchange="s_option_change(this,'frm_exact',this.selectedIndex);">
				<option value="0" <% if s_article_idx2="0" then %> selected <% end if %>> ::상품선택::</option> 
				<% 
				If s_article_idx1<>"0" then

				strSql = " select * from code_article where article_step1="&s_article_idx1&" and article_step2>0 "
				strSql = strSql & " order by article_name Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					article_idx		= objRs("article_idx")
					article_name	= objRs("article_name")
				%>	
				<option value="<%=article_idx%>" <% if CInt(s_article_idx2)=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
				Loop
				objRs.close
				End if
				%>	
				</select>
				<select name="s_option_idx" class="txtbox"  style="width:160px;">
				<option value="0" <% if s_option_idx="0" then %> selected <% end if %>> ::상품옵션:: </option>
				<% 
				If s_option_idx<>""  then
				
				strSql = " select * from code_article_option where article_idx=" & s_article_idx2 & " "
				strSql = strSql & " order by option_name Asc"
				Set objRs=objCnn.Execute(strSql)							
				
				Do until objRs.EOF   	
					option_idx			= objRs("option_idx")
					option_name			= objRs("option_name")
				%>	
				<option value="<%=option_idx%>" <% if s_option_idx=CStr(option_idx) then %> selected <% end if %>><%=option_name%></option>
				<% 
					objRs.MoveNext
				Loop
				objRs.close
				End if
				%>	
				</select>
				
				<select name="s_gaetong_code" class="txtbox" style="width:90px;">
				<option value="" <% if s_gaetong_code="" then %> selected <% end if %>>::개통상태::</option>          
				<% 
				strSql = " select * from code_gaetong order by gaetong_code Asc"
				Set objRs0=objCnn.Execute(strSql)

				Do until objRs0.EOF   	
					gaetong_code		= objRs0("gaetong_code")
					gaetong_name		= objRs0("gaetong_name")
				%>	
				<option value="<%=gaetong_code%>" <% if s_gaetong_code=gaetong_code then %> selected <% end if %>><%=gaetong_name%></option>
				<% 
					objrs0.MoveNext
				Loop
				%>	
				</select>

				<select name="date_chk" class="txtbox" style="width:120px;">
				<option value="0" <% If date_chk="0" Then %> selected <% End If %>>::검색조건::</option>
				<option value="1" <% If date_chk="1" Then %> selected <% End If %>>접수일</option>
				<option value="2" <% If date_chk="2" Then %> selected <% End If %>>개통일</option>
				<option value="3" <% If date_chk="3" Then %> selected <% End If %>>해약일</option>
				<option value="4" <% If date_chk="4" Then %> selected <% End If %>>정산예정</option>
				<option value="5" <% If date_chk="5" Then %> selected <% End If %>>정산완료</option>
				<option value="6" <% If date_chk="6" Then %> selected <% End If %>>정산예정(미완료)</option>
				</select>
				<input type="text" name="s_date_start" class="txtbox" size='9' value="<%=s_date_start%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=s_date_start&code2=&code3=&form_name=frm_exact','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">~<input type="text" class="txtbox" name="s_date_end" size='9' value="<%=s_date_end%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onClick="NewWindow('/include/asp/calendar.asp?code1=s_date_end&code2=&code3=&form_name=frm_exact','cal_write','250','300','no');" onMouseOver="this.style.cursor='hand';">
				<img src="/images/button/btn_search01.gif" align='absmiddle' border=0 onClick="result_customer_search('frm_exact');" onMouseOver="this.style.cursor='hand';"></nobr>
			</td>
		</tr>
		<tr>
			<td align='right'>
				<a href="a_exact_personal_excel.asp?<%=s_link_txt%>"><span class="btn_m_white01"> 엑셀저장</span></a>
				<a href="a_exact_list.asp?<%=s_link_txt%>"><span class="btn_m_white01"> 목록으로</span></a>				 
			</td>			
		</tr>
		</table>
	
		<table width=100% cellspacing="0" cellpadding="0" border=0  class="table_css">
		<tr>
			<Th class="head_Gray_TLB" rowspan='2'>No</th>
			<Th class="head_Gray_TLB" rowspan='2'>일괄</th>
			<th class="head_Gray_TLB" rowspan='2'>사원명</th>
			<th class="head_Gray_TLB" rowspan='2'>은행명</th>
			<th class="head_Gray_TLB" rowspan='2'>계좌번호</th>
			<th class="head_Gray_TLB" rowspan='2'>예금주</th>
			<th class="head_Gray_TLB" rowspan='2'>약정금액</th>
			<th class="head_Gray_TLB" colspan='5'>차감내역</th>
			<th class="head_Gray_TLB" rowspan='2'>번들수수료</th>
			<th class="head_Gray_TLB" rowspan='2'>부가서비스</th>
			<th class="head_Gray_TLB" rowspan='2'>결합수수료</th>
			<th class="head_Gray_TLB" rowspan='2'>정산금액</th>
			<th class="head_Gray_TLB" rowspan='2'>부가세<br>원천세</th>
			<th class="head_Gray_TLB" rowspan='2'>세금차감</th>
			<th class="head_Gray_TLB" rowspan='2'>총 정산금액</th>
			<th class="head_Gray_TLBR" rowspan='2'>정산내역서</th>
		</tr>
		<tr>
			<th class="head_Gray_TLB" width=70>본사사은품</th>
			<th class="head_Gray_TLB" width=70>사은품</th>
			<th class="head_Gray_TLB" width=70>할인탭</th>
			<th class="head_Gray_TLB" width=70>미비서류</th>
			<th class="head_Gray_TLB" width=70>기타</th>
		</tr>

  <%
	strSql = " select K.g_yuchi_m_id, K.t_charge_promise, K.t_charge_sp_top, K.t_charge_sp, K.t_charge_sale, "
	strSql = strSql & " K.t_charge_document, K.t_charge_gita, K.t_charge_bundle, K.t_charge_combine, K.t_charge_buga, Y.m_name, "
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

  'response.write strSql
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 20

  recordcount	= objRs.recordcount

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  else
	totalpage = objRs.pagecount
	objRs.absolutepage = page
	recordcount	= objRs.recordcount

	i=1
	Do until objRs.EOF 
		t_charge_promise		= money_chk(objRs("t_charge_promise"))
		t_charge_sp_top			= money_chk(objRs("t_charge_sp_top"))
		t_charge_sp				= money_chk(objRs("t_charge_sp"))
		t_charge_sale			= money_chk(objRs("t_charge_sale"))
		t_charge_document		= money_chk(objRs("t_charge_document"))
		t_charge_gita			= money_chk(objRs("t_charge_gita"))
		t_charge_bundle			= money_chk(objRs("t_charge_bundle"))
		t_charge_buga			= money_chk(objRs("t_charge_buga"))
		t_charge_combine		= money_chk(objRs("t_charge_combine"))
		t_charge_sum			= CDbl(t_charge_promise-cdbl(t_charge_sp_top+t_charge_sp+t_charge_sale+t_charge_document+t_charge_gita)+t_charge_bundle + t_charge_buga + t_charge_combine)
	
		tt_charge_promise		= CDbl(tt_charge_promise+t_charge_promise)
		tt_charge_sp_top		= CDbl(tt_charge_sp_top+t_charge_sp_top)
		tt_charge_sp			= CDbl(tt_charge_sp+t_charge_sp)
		tt_charge_sale			= CDbl(tt_charge_sale+t_charge_sale)
		tt_charge_document		= CDbl(tt_charge_document+t_charge_document)
		tt_charge_gita			= CDbl(tt_charge_gita+t_charge_gita)
		tt_charge_bundle		= CDbl(tt_charge_bundle+t_charge_bundle)
		tt_charge_buga			= CDbl(tt_charge_buga+tt_charge_buga)
		tt_charge_combine		= CDbl(tt_charge_combine+t_charge_combine)
		tt_charge_sum			= CDbl(tt_charge_sum+t_charge_sum)

		g_yuchi_m_id			= objRs("g_yuchi_m_id")			'아이디
		m_name					= objRs("m_name")				'사원명
		m_bank_name				= objRs("m_bank_name")			'예금주
		bank_name				= objRs("bank_name")			'은행명
		m_bank_no				= objRs("m_bank_no")			'계좌번호
		

		tax_persent = "3.3%"
		d_t_charge_tax		= Fix(t_charge_sum*0.033)			
		d_t_charge_sum		= Fix(t_charge_sum-d_t_charge_tax)

		td_t_charge_tax		= td_t_charge_tax + d_t_charge_tax
		td_t_charge_sum		= td_t_charge_sum + d_t_charge_sum

		
		d_t_charge_tax		= money_change(d_t_charge_tax)
		d_t_charge_sum		= money_change(d_t_charge_sum)



		t_charge_promise		= money_change(t_charge_promise)
		t_charge_sp_top		= money_change(t_charge_sp_top)
		t_charge_sp			= money_change(t_charge_sp)
		t_charge_sale			= money_change(t_charge_sale)
		t_charge_document		= money_change(t_charge_document)
		t_charge_gita			= money_change(t_charge_gita)
		t_charge_bundle		= money_change(t_charge_bundle)			
		t_charge_buga			= money_change(t_charge_buga)			
		t_charge_combine			= money_change(t_charge_combine)			
		t_charge_sum			= money_change(t_charge_sum)
	
		
	%>
		<tr height=30 onmouseover="style.backgroundColor='#CEE3F6';this.style.cursor='hand';" onmouseout="style.backgroundColor='white'">
			<td class="list_LB_center"> <%=i%> </td>
			<td class="list_LB_center"><input type="checkbox" id="g_yuchi_m_id" name="g_yuchi_m_id" value="<%=g_yuchi_m_id%>"></td>
			<td class="list_LB_center"><a href="a_exact_list.asp?<%=s_link_txt%>&s_yuchi_m_id=<%=g_yuchi_m_id%>"><%=m_name%></a></td>
			<td class="list_LB_center"><%=bank_name%></td>
			<td class="list_LB_center"><%=m_bank_no%></td>
			<td class="list_LB_center"><%=m_bank_name%></td>
			<td class="list_LB_center"><%=t_charge_promise%></td>
			<td class="list_LB_center"><%=t_charge_sp_top%></td>
			<td class="list_LB_center"><%=t_charge_sp%></td>
			<td class="list_LB_center"><%=t_charge_sale%></td>
			<td class="list_LB_center"><%=t_charge_document%></td>
			<td class="list_LB_center"><%=t_charge_gita%></td>
			<td class="list_LB_center"><%=t_charge_bundle%></td>
			<td class="list_LB_center"><%=t_charge_buga%></td>
			<td class="list_LB_center"><%=t_charge_combine%></td>
			<td class="list_LB_center"><span class='red'><%=t_charge_sum%></span></td>
			<td class="list_LB_center"><%=tax_persent%></td>
			<td class="list_LB_center"><%=d_t_charge_tax%></td>
			<td class="list_LB_center"><%=d_t_charge_sum%></td>
			<td class="list_LBR_center"><a href="javascript:NewWindow('/exact_view/a_exact_regist_p_top.asp?<%=s_link_txt%>&g_yuchi_m_id=<%=g_yuchi_m_id%>','tax_view',900,700,'yes');
			"><img src="/images/button/btn_send.gif" align="absmiddle"></a></td>			
		</tr>
	<%
		i=i+1
		objRs.movenext
	Loop
	End if
  %>
		<Tr height=30>
			<Td colspan='3' class="list_LB_center">
				<img id="toggle_img1" src="/images/button/select.gif" valign='abmiddle' onClick="toggle_img(this.src);">
				<a href="javascript:exact_submit();"><img src="/images/button/apply.gif" border=0></a>
			</td>
			<Td colspan='3' class="list_LB_center"> <b>정산 합계</b> </td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_promise)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_sp_top)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_sp)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_sale)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_document)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_gita)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_bundle)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_buga)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_combine)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(tt_charge_sum)%></span></td>
			<Td class="list_LB_center">&nbsp;</td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(td_t_charge_tax)%></span></td>
			<Td class="list_LB_center"><span class='blue'><%=money_change(td_t_charge_sum)%></span></td>
			<Td class="list_LBR_center">&nbsp;</td>
		</tr>	  
		</table>	
		</form>	

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
  DBClose()
  %>