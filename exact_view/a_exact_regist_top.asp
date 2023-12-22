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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <%
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if	

  tname					="regist_top"
  s_date_start			= WORD_CHANGE(request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(request("s_date_end"),20)
  s_gaetong_code		= WORD_CHANGE(request("s_gaetong_code"),20)
  s_dealer_code			= WORD_CHANGE(Request("dealer_code"),20)
  date_chk				= WORD_CHANGE(Request("date_chk"),20)
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
 

  If date_chk=""		Then	date_chk="0"			End If  

	board_contents			= ""
	e_charge_chk			= "A"



  strSql = "  select K.d_id, K.t_charge_promise,K.t_charge_sp_top, K.t_charge_sp, K.t_charge_sale, K.t_charge_document, "
  strSql = strSql & " K.t_charge_gita, K.t_charge_bundle, K.t_charge_buga, K.t_charge_combine, Y.dealer_name , Y.dealer_bank_name, Y.dealer_bank_no,"
  strSql = strSql & " Y.dealer_com_yn , Z.bank_name from "
  strSql = strSql & " (select A.g_trans_in_dealer as d_id, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_promise),0) as t_charge_promise, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_sp_top),0) as t_charge_sp_top, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_sp),0) as t_charge_sp, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_sale),0) as t_charge_sale, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_document),0) as t_charge_document, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_gita),0) as t_charge_gita, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_bundle),0) as t_charge_bundle, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_combine),0) as t_charge_combine, "
  strSql = strSql & " ISNULL(SUM(H.g_charge_buga),0) as t_charge_buga"

  strSql = strSql & "	from customer_goods A full join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx "
  strSql = strSql & "		where 1=1 "

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
  

  strSql = strSql & "				group by A.g_trans_in_dealer ) K"
  strSql = strSql & "	left outer join dealer_info Y ON K.d_id=Y.dealer_code  "
  strSql = strSql & "		  left join code_bank Z ON Y.dealer_bank_cd=Z.board_idx "
  strSql = strSql & "		where Y.dealer_code='"&s_dealer_code&"'"
  'Response.write stRSql
  Set objRs=objCnn.Execute(strSql)

  t_charge_promise			= money_chk(objRs("t_charge_promise"))
  t_charge_sp_top			= money_chk(objRs("t_charge_sp_top"))
  t_charge_sp				= money_chk(objRs("t_charge_sp"))
  t_charge_sale				= money_chk(objRs("t_charge_sale"))
  t_charge_document			= money_chk(objRs("t_charge_document"))
  t_charge_gita				= money_chk(objRs("t_charge_gita"))
  t_charge_bundle			= money_chk(objRs("t_charge_bundle"))
  t_charge_buga				= money_chk(objRs("t_charge_buga"))
  t_charge_combine			= money_chk(objRs("t_charge_combine"))
  t_charge_sum_n			= CDbl(t_charge_promise-cdbl(t_charge_sp_top+t_charge_sp+t_charge_sale+t_charge_document+t_charge_gita)+t_charge_bundle + t_charge_buga + t_charge_combine)
	
  dealer_name				= objRs("dealer_name")			'거래처 명
  dealer_com_yn				= objRs("dealer_com_yn")		'사업자유무

  If dealer_com_yn="N" Then
	dealer_com_yn="P"
  End if
		
  d_t_charge_tax			= Fix(t_charge_sum_n*0.1)			
  t_charge_sum_y			= Fix(t_charge_sum_n+d_t_charge_tax)

  d_t_charge_tax			= Fix(t_charge_sum_n*0.033)			
  t_charge_sum_p			= Fix(t_charge_sum_n-d_t_charge_tax)
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script type="text/JavaScript">

function fnc_board_regist(form_name,chk)
{
	var frm = document.getElementById(form_name);

	frm.e_charge_chk.value=chk;
	
	if(frm.e_title.value=="")
	{
		alert("정산 제목을 입력해 주세요!");
		frm.e_title.focus();
		return;
	}

	if(frm.e_exact_date1.value=="" || frm.e_exact_date2.value=="")
	{
		alert("정산 기간을 입력해 주세요");
		return;
	}

	if(frm.session_m_id.value=="")
	{
		alert(" 로그인후 사용해 주세요! ");
		return;
	}
	
	frm.submit();
}

function board_del_ok(url)
{
	ans=confirm("글을 삭제하시겠습니까?");
	if(ans==true)
	{
		location.replace(url);
	}
}


//3자리 컴마 출력
function setFormatPrice(strNum) 
{
	   var strNum = String(strNum);
	   var result = '';

	   for(var i=0; i<strNum.length; i++) {
	   	   if(i%3==0 && i!=0) 
			result = ',' + result;
	   	    result = strNum.charAt(strNum.length-(i+1)) + result;
	   }
		
	   return result;
}

function tax_calcu(frm)
{
	var frm=eval("document.all."+frm);

	if(frm.charge_gita1.value=="")
	{
		g_value=0;
	}
	else
	{
		g_value = parseInt(frm.charge_gita1.value);
	}

	if(frm.charge_gongje.value=="")
	{
		j_value=0;
	}
	else
	{
		j_value = parseInt(frm.charge_gongje.value);
	}

	if (frm.tax_price_n.value=="")
	{
		p_value = 0
	}
	else
	{
		p_value		= parseInt(frm.tax_price_n.value);
	} 

	p_value		= p_value + g_value;

	if (frm.tax_chk[0].checked==true)
	{
		p_value_tax = parseInt(p_value*0.1);
		p_value		= p_value + p_value_tax;
	}

	if (frm.tax_chk[1].checked==true)
	{
		p_value_tax = parseInt(p_value*0.033);
		p_value		= p_value - p_value_tax;
	}

	if (frm.tax_chk[2].checked==true)
	{
	}

	p_value1		= p_value + j_value;		//공제금액 계산
	//p_value2		= setFormatPrice(p_value1);
	html_txt = "&nbsp;<span class='red'>"+setFormatPrice(p_value1)+" 원 </span>";	//정산금액
	html_txt = html_txt + "&nbsp;&nbsp;&nbsp; "
	html_txt = html_txt + "<span class='blue'>( 세액금액 : &nbsp;"+setFormatPrice(p_value)+" 원 )</span>";	//세액금액
	price1.innerHTML = html_txt
}


window.onload	= function()
{
	tax_calcu('frm_board');
}

</script>

<body>
<div class="outerContainer">	

		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub06_t06.gif" width='880'></div>

		<form id="frm_board" name="frm_board" action="a_exact_regist_top_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="e_exact_idx"  value="<%=e_exact_idx%>">
		<input type="hidden" name="e_exact_type"  value="Y">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<input type="hidden" name="e_charge_chk" value="<%=e_charge_chk%>">
		<input type="hidden" name="s_dealer_code" value="<%=s_dealer_code%>">

		<input type="hidden" name="s_article_idx1" value="<%=s_article_idx1%>">
		<input type="hidden" name="s_article_idx2" value="<%=s_article_idx2%>">
		<input type="hidden" name="s_option_idx" value="<%=s_option_idx%>">

		<input type="hidden" name="s_gaetong_code" value="<%=s_gaetong_code%>">
		<input type="hidden" name="s_date_start" value="<%=s_date_start%>">
		<input type="hidden" name="s_date_end" value="<%=s_date_end%>">
		<input type="hidden" name="date_chk" value="<%=date_chk%>">
		<input type="hidden" name="tax_price_n" value="<%=t_charge_sum_n%>">

		<input type="hidden" name="charge_promise" value="<%=t_charge_promise%>">
		<input type="hidden" name="charge_sp_top" value="<%=t_charge_sp_top%>">
		<input type="hidden" name="charge_sp" value="<%=t_charge_sp%>">
		<input type="hidden" name="charge_sale" value="<%=t_charge_sale%>">
		<input type="hidden" name="charge_bundle" value="<%=t_charge_bundle%>">
		<input type="hidden" name="charge_buga" value="<%=t_charge_buga%>">
		<input type="hidden" name="charge_combine" value="<%=t_charge_combine%>">
		<input type="hidden" name="charge_gita" value="<%=t_charge_gita%>">
		<input type="hidden" name="charge_document" value="<%=t_charge_document%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">제&nbsp;&nbsp;&nbsp;목 </th>
			<td width="85%" class="list_TLBR_left"><input type="text" class="txtbox" name="e_title" size="50" value="<%=e_title%>"></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB">정산 기간 </th>
			<td class="list_LBR_left"> 
				<input type="text" name="e_exact_date1" class="txtbox" size='10' value="<%=e_exact_date1%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_exact_date1&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"> ~
				<input type="text" name="e_exact_date2" class="txtbox" size='10' value="<%=e_exact_date2%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_exact_date2&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> 정산 업체 </th>
			<td class="list_LBR_left"> <%=dealer_name%>	</td>
		</tr>
		<tr height=30> 
			<td class="list_LBR_left" style="padding:3px;" colspan='2'>
				<table width='100%%' border=0 cellspacing="0" cellpadding="0" class="table_css">
				<tr height='20'>
					<Th rowspan='2' class="head_Gray_TLB">약정금액</th>
					<Th colspan='5' class="head_Gray_TLB">차감내역</th>
					<Th rowspan='2' class="head_Gray_TLB">번들수수료</th>
					<Th rowspan='2' class="head_Gray_TLB">부가서비스</th>
					<Th rowspan='2' class="head_Gray_TLB">결합수수료</th>
					<Th rowspan='2' class="head_Gray_TLBR">합계</th>
				</tr>
				<tr height='20'>
					<Th class="head_Gray_LB">본사사은품</th>
					<Th class="head_Gray_LB">사은품</th>
					<Th class="head_Gray_LB">할인탭</th>
					<Th class="head_Gray_LB">미비서류</th>
					<Th class="head_Gray_LBR">기타</th>
				</tr>
				<tr height='30'>
					<Td class="list_LB_center"> <%=money_change(t_charge_promise)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_sp_top)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_sp)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_sale)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_document)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_gita)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_bundle)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_buga)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_combine)%></td>
					<Td class="list_LBR_center"><%=money_change(t_charge_sum_n)%></td>
				</tr>
				</table><br>
			</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> 기타 정산 </th>
			<td class="list_LBR_left">&nbsp; 
				<input type="text" class='txtbox' name="charge_gita1" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');">원
				&nbsp;&nbsp;&nbsp;
				정산내용:
				<input type="text" class='txtbox' name="charge_gita1_bigo" size='30' maxlength='50'> <span class='red'> 이 항목은 세액에 포함되는 금액 </span>
			</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> 공제 정산 </th>
			<td class="list_LBR_left">&nbsp; 
				<input type="text" class='txtbox' name="charge_gongje" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');">원
				&nbsp;&nbsp;&nbsp;
				정산내용:
				<input type="text" class='txtbox' name="charge_gongje_bigo" size='30' maxlength='50'><span class='red'> 이 항목은 세액 계산후 공제되는 금액 </span>
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> 실정산 금액 </th>
			<td class="list_LBR_left"><div id="price1"></div></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> 세금 계산서 </th>
			<td class="list_LBR_left"> 	
				<input type="radio" name="tax_chk" value="Y" <% If dealer_com_yn="Y" Then %> checked <% End If %> onclick="tax_calcu('frm_board')">발행 &nbsp;&nbsp;
				<input type="radio" name="tax_chk" value="P" <% If dealer_com_yn="P" Then %> checked <% End If %> onclick="tax_calcu('frm_board')">원천세 &nbsp;&nbsp;
				<input type="radio" name="tax_chk" value="N" <% If dealer_com_yn="N" Then %> checked <% End If %>onclick="tax_calcu('frm_board')">미발행
				
				<% If e_exact_idx<>"" Then %>
				<% If dealer_com_yn="Y" Then %>
					&nbsp;&nbsp; <a href="javascript:NewWindow('/exact/a_exact_tax_view.asp?e_exact_idx=<%=e_exact_idx%>','tax_view',850,600,'no');">
					[세금계산서 출력]</a>
				<% End If %>
				<% End If %>

			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> 확인 비밀번호 </th>
			<td class="list_LBR_left"> <input type="text" name="exact_passwd" size='20' maxlength='20' class='txtbox'> 
				<span class='red'> 협력점 확인시 입력해야할 비밀번호힙니다. (입력하지 않으면 비밀번호 없이 확인 가능합니다) </span>
			</td>
		</tr>

		<% If e_exact_idx<>"" Then %>
		<tr>
			<th class="head_Gray_LB"> 고객 리스트 </td>
			<td class="list_LBR_left">
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>">
					<img src="/images/button/btn_excel.gif" align='absmiddle'></a>
			</td>
		</tr>
		<% End If %>
		<tr height=30> 
			<td colspan='2' class="head_Gray_LB"> 
			<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10" style="background-color: yellow;"><%=e_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents', {
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>					
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> 파일 </th>
			<td class="list_LBR_left"><input type="file" class="txtbox" name="e_fname1" size="40">&nbsp;&nbsp;&nbsp;
			<% if len(e_fname1)>0 then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
				<% else %>&nbsp;<% end if %>
			</td>
		</tr>
		<tr height=30>            
			<td align='center' colspan="2"> 
				
				<img src="/images/button/btn_regist.gif" onclick="send_board_write('frm_board','<%=e_charge_chk%>');" onmouseover="this.style.cursor='hand';"> 

				<% If e_charge_chk="B" Then %>
				<a href="javascript:fnc_board_regist('frm_board','D');"><img src="/images/button/btn_re_post.gif" border="0"></a>&nbsp;&nbsp;
				<% End If %>

				<% If e_exact_idx<>"" Then %>
				<a href="javascript:fnc_board_regist('frm_board','E');"><img src="/images/button/btn_account_ok.gif" border="0"></a>

				<% If ad_r_a_exact="A" Then %>
					<a href="javascript:board_del_ok('a_exact_regist_del_ok.asp?e_exact_idx=<%=e_exact_idx%>')"><img src="/images/button/btn_delete.gif" border="0"></a> 
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 삭제 권한이 없습니다. 관리자에 문의하세요!");'><img src="/images/button/btn_delete.gif" border="0"></a>
				<% End If %>

				<% End If %>


			</td>
		</tr>
		</table>
		</form>	
		<!------------------ 내용 종료  ------------------>					          
</div>	