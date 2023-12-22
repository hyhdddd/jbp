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

  tname				= WORD_CHANGE(Request("tname"),20)
  e_exact_idx		= WORD_CHANGE(Request("e_exact_idx"),20)
  s_dealer_code		= WORD_CHANGE(Request("s_dealer_code"),20)
  s_charge_chk		= WORD_CHANGE(Request("s_charge_chk"),20)

  page				= WORD_CHANGE(Request("page"),20)
  
  if e_exact_idx<>"" then
	strSql = "SELECT * FROM exact_list A left outer join dealer_info B ON A.s_dealer_code=B.dealer_code "
	strSql = strSql & " where A.e_exact_idx = " & e_exact_idx
	Set objRs=objCnn.Execute(strSql)

	e_m_id				= objRs("e_m_id")
	e_title				= objRs("e_title")
	e_contents			= objRs("e_contents")
	e_fname1			= objRs("e_fname1")
	e_fname2			= objRs("e_fname2_excel")
	e_exact_date1		= objRs("e_exact_date1")
	e_exact_date2		= objRs("e_exact_date2")
	s_dealer_code1		= objRs("s_dealer_code")
	e_charge_chk_date	= objRs("e_charge_chk_date")
	e_request_txt		= objRs("e_request_txt")
	e_charge_chk		= objRs("e_charge_chk")
	exact_passwd		= objRs("exact_passwd")

	s_date_start		= objRs("s_date_start")
	s_date_end			= objRs("s_date_end")
	s_gaetong_code		= objRs("s_gaetong_code")
	date_chk			= objRs("date_chk")
	t_charge_sum_n		= objRs("tax_price_n")
	dealer_name			= objRs("dealer_name")

	t_charge_promise	= money_chk(objRs("charge_promise"))
	t_charge_sp			= money_chk(objRs("charge_sp"))
	t_charge_sp_top		= money_chk(objRs("charge_sp_top"))
	t_charge_document	= money_chk(objRs("charge_document"))
	t_charge_gita		= money_chk(objRs("charge_gita"))
	t_charge_sale		= money_chk(objRs("charge_sale"))
	t_charge_bundle		= money_chk(objRs("charge_bundle"))
	t_charge_buga		= money_chk(objRs("charge_buga"))
	t_charge_combine	= money_chk(objRs("charge_combine"))

	dealer_com_yn		= objRs("tax_chk")
	charge_gita1		= objRs("charge_gita1")
	charge_gita1_bigo	= objRs("charge_gita1_bigo")

	charge_gongje		= objRs("charge_gongje")
	charge_gongje_bigo	= objRs("charge_gongje_bigo")

	'파일명에서 확장자 뽑기
	if len(e_fname1)>0 then
		filepath1	= o_code&"/exact/"&left(e_fname1, InstrRev(e_fname1,"/"))  
		filename1	= mid(e_fname1, InstrRev(e_fname1,"/")+1)  
		strExt		= ucase(Mid(e_fname1,Instr(e_fname1,".")+1))
		Ext_img		= file_strExt_chk(strExt)
	end If	


	'파일명에서 확장자 뽑기
	if len(e_fname2)>0 then
		filepath2	= o_code&"/exact/"&left(e_fname2, InstrRev(e_fname2,"/"))  
		filename2	= mid(e_fname2, InstrRev(e_fname2,"/")+1)  
	end If	

 End if
 
  %>
<!DOCTYPE html> 
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<link href="/include/css/style_button.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">

function fnc_board_regist(form_name,chk)
{
	var frm	 = document.getElementById(form_name);

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
</script>
<script language="Javascript">

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
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">전체 정산내역서</li>
		</ul>
		</div>

		<form id="frm_board" name="frm_board" action="a_exact_regist_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="e_exact_idx"  value="<%=e_exact_idx%>">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<input type="hidden" name="s_dealer_code" value="<%=s_dealer_code%>">
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
		<input type="hidden" name="charge_document" value="<%=t_charge_document%>">
		<input type="hidden" name="charge_gita" value="<%=t_charge_gita%>">
		<input type="hidden" name="page" value="<%=page%>">
		<input type="hidden" name="s_charge_chk" value="<%=s_charge_chk%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">
		<tr height=30> 
			<th class="head_Gray_TLB">제&nbsp;&nbsp;&nbsp;목 </th>
			<td class="list_TLBR_left"> 
				<input type="text" class="txtbox" name="e_title" size="50" value="<%=e_title%>">
			</td>
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
			<td class="list_LBR_left" colspan='2' style="padding:5px;">
				<table width='100%' border=0 cellspacing="0" cellpadding="0" class="table_css">
				<tr height='20'>
					<Th rowspan='2' class="head_Gray_TLB">약정금액</th>
					<Th colspan='5' class="head_Gray_TLB">차감 항목</th>
					<Th rowspan='2' class="head_Gray_TLB">번들수수료</th>
					<Th rowspan='2' class="head_Gray_TLB">부가서비스</th>
					<Th rowspan='2' class="head_Gray_TLB">결합수수료</th>
					<Th rowspan='2' class="head_Gray_TLBR">합계</th>
				</tr>
				<tr height='20'>
					<Th align='center' class="head_Gray_TLB">본사사은품</th>
					<Th align='center' class="head_Gray_TLB">사은품</th>
					<Th align='center' class="head_Gray_TLB">할인탭</th>
					<Th align='center' class="head_Gray_TLB">미비서류</th>
					<Th align='center' class="head_Gray_TLB">기타</th>
				</tr>
				<tr height='30'>
					<Td class="list_LB_center"><%=money_change(t_charge_promise)%></td>
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
				<input type="text" class='txtbox' name="charge_gita1" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');" value="<%=charge_gita1%>">원
				&nbsp;&nbsp;&nbsp;
				정산내용:
				<input type="text" class='txtbox' name="charge_gita1_bigo" size='30' maxlength='50'  value="<%=charge_gita1_bigo%>"><span class='red'> 이 항목은 세액에 포함되는 금액 </span>
			</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> 공제 정산 </th>
			<td class="list_LBR_left">&nbsp; 
				<input type="text" class='txtbox' name="charge_gongje" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');" value="<%=charge_gongje%>">원
				&nbsp;&nbsp;&nbsp;
				정산내용:
				<input type="text" class='txtbox' name="charge_gongje_bigo" size='30' maxlength='50' value="<%=charge_gongje_bigo%>"><span class='red'> 이 항목은 세액 계산후 공제되는 금액 </span>
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
					&nbsp;&nbsp; <a href="javascript:NewWindow('/exact_view/a_exact_tax_view.asp?e_exact_idx=<%=e_exact_idx%>','tax_view',850,600,'no');">
					<img src="/images/button/btn_tax.gif" align='absmiddle'></a>
				<% End If %>
				<% End If %>
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
			<th class="head_Gray_LB"> 확인 비밀번호 </th>
			<td class="list_LBR_left"> <input type="text" name="exact_passwd" size='20' maxlength='20' class='txtbox' value="<%=exact_passwd%>"> 
				<span class='red'> 협력점 확인시 입력해야할 비밀번호힙니다. (입력하지 않으면 비밀번호 없이 확인 가능합니다) </span>
			</td>
		</tr>
		<tr height=30> 
			<td colspan='2' class="list_LBR_left" style="padding:3px;"> 
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
		<% If e_charge_chk="B" Or e_charge_chk="C" Then %>
		<tr height=30> 
			<th class="head_Gray_LB">요청 내용</th>
			<td class="list_LBR_left"><%=e_request_txt%></td>
		</tr>
		<tr>
			<th class="head_Gray_LB"> 요청일자 </th>
			<td class="list_LBR_left"> <%=e_charge_chk_date%></td>
		</tr>
		<% End If %>
		<tr>
			<th class="head_Gray_LB"> 요청 상태 </th>
			<td class="list_LBR_left">
				<select name="e_charge_chk">
				<option value="A" <% If e_charge_chk="A" Or e_charge_chk="" Then %> selected <% End If %>> 미요청 </option>
				<option value="B" <% If e_charge_chk="B" Then %> selected <% End If %>> 재요청</option>
				<option value="C" <% If e_charge_chk="C" Then %> selected <% End If %>> 정산요청 </option>
				<option value="D" <% If e_charge_chk="D" Then %> selected <% End If %>> 재발송 </option>
				<option value="E" <% If e_charge_chk="E" Then %> selected <% End If %>> 정산완료 </option>
				<option value="F" <% If e_charge_chk="F" Then %> selected <% End If %>>지급보류</option>
				</select>
			</td>
		</tr>
		</table>

		<div class="alignRight"> 
			<a href="a_exact_list.asp?page=<%=page%>&s_dealer_code=<%=s_dealer_code%>&s_charge_chk=<%=s_charge_chk%>"><span class="btn_m_white01"> 목록으로</span></a> 
			<span class="btn_m_white01" onclick="fnc_board_regist('frm_board','<%=e_charge_chk%>');"> 저장하기</span>

				<% If e_exact_idx<>"" Then %>

				<% If ad_r_a_exact="A" Then %>
					<a href="javascript:board_del_ok('a_exact_regist_del_ok.asp?e_exact_idx=<%=e_exact_idx%>')"><span class="btn_m_white01"> 삭제하기</span></a> 
				<% Else %>
					<a href ='javascript:alert("<%=session_m_name%> 님은 삭제 권한이 없습니다. 관리자에 문의하세요!");'><span class="btn_m_white01"> 삭제하기</span></a>
				<% End If %>

				<% End If %>


			</td>
		</tr>
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