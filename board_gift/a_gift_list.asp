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
  <% 	
  if ad_a_gift="N" then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If
  
  search_key			= WORD_CHANGE(Request("search_key"),20)
  search_txt			= WORD_CHANGE(Request("search_txt"),20)
  s_search_key			= WORD_CHANGE(Request("s_search_key"),20)
  s_date_start			= WORD_CHANGE(Request("s_date_start"),20)
  s_date_end			= WORD_CHANGE(Request("s_date_end"),20)

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  
  s_link_txt = "search_key="&search_key&"&search_txt="&search_txt&"&s_search_key="&s_search_key&"&s_date_start="&s_date_start&"&s_date_end="&s_date_end

  %>
<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script type="text/javascript" src="/include/js/calendar_beans_v2.0.js"></script>

<script type="text/javascript">		
$(document).ready(function() {
	CalAddCss();
	initCal({id:"s_date_start",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});			
	initCal({id:"s_date_end",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});	
});
</script>


<script type="text/javascript">

function fnc_toggle()
{
	allchecked	= $("#allcheck").val();
	
	if(allchecked=="X")
	{
		$(':checkbox[name="gift_idx"]').each(function() {
			this.checked=true;
		});

		$("#allcheck").val("O");
		$("#btn_all").html("전체해제");
	} else	{
		$(':checkbox[name="gift_idx"]').each(function() {
			this.checked=false;
		});
		$("#allcheck").val("X");
		$("#btn_all").html("전체선택");
	}

}	



function fnc_batch_regist(form_name)
{
	var frm			= document.getElementById(form_name);
	var gift_idx	= document.getElementsByName("gift_idx")

	chk				= "";
	gift_chk		= "";
	for( var i=0; i<gift_idx.length; i++) 
	{
		if(gift_idx[i].checked==true)
		{
			if(gift_chk=="")
			{
				gift_chk = gift_idx[i].value;
			} else {
				gift_chk = gift_chk+","+gift_idx[i].value;
			}

			chk="O";
		}
	}	
		
	if(chk=="O")
	{
		open_modal_url('a_gift_batch.asp?gift_idx='+gift_chk, '800', '600','X');
	}
	else
	{
		alert("고객을 한명이상 선택해 주세요!");
		return;
	}	
}

function fnc_board_search(form_name)
{
	var frm = document.getElementById(form_name);
	
	frm.submit();
	
}

</script>


<body>
<div class="outerContainer">
<table width="1100" border=0 cellspacing="0" cellpadding="0">
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
			<li class="txt">추가사은품 관리</li>
		</ul>
		</div>

		<form id="frm_board" name='frm_board' method='post' action='a_gift_list.asp'>
		<input type="hidden" id="allcheck" name="allcheck" value="X">

		<table width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr height=30>   
			<td>

				<select name="s_search_key" class='txtbox' style="width:110px;">
				<option value="" <% If s_search_key="" Then %>selected<%end if %>>::날짜 항목::</option>
				<option value="gift_date" <% If s_search_key="gift_date" Then %>selected<%end if %>>추가사은품 신청일</option>
				<option value="gift_writeday" <% If s_search_key="gift_writeday" Then %>selected<%end if %>>등록일 </option>
				</select>				
				<input type="text" id="s_date_start" name="s_date_start" class="txtbox" size='11' value="<%=s_date_start%>" readonly>~<input type="text" id="s_date_end" name="s_date_end" size='11' class="txtbox"  value="<%=s_date_end%>">				
				<select name="date_gigan" class='txtbox' style="width:60px;" onchange="fncDateCalculator('frm_board',this,'s_date_start','s_date_end');">
				<option value="">기간</option>
				<option value="A">오늘</option>
				<option value="B">어제</option>
				<option value="C">이번달</option>
				<option value="D">지난달</option>
				</select>

				<span onClick="fnc_board_search('frm_board');"><img src="/images/button/btn_search01.gif"  align='absmiddle' border=0></span>	
			</td>
		</tr>
		<tr height=30>   
			<td>
			
				<select name="search_key">
				<option value="m_name"> 신청자 </option>				
				<option value="dealer_name"> 업체명 </option>				
				</select>
				<input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle'><span onClick="fnc_board_search('frm_board');"><img src="/images/button/btn_search01.gif" align='absmiddle' border=0></span>
			</td>
		</tr>
		</table>


		<table width="100%" cellspacing=1 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th width=30  class="head_Gray_TLB">No.</th>
			<th width=50 class="head_Gray_TLB">선택</th>
			<th width=100 class="head_Gray_TLB">사은품 신청일</th>
			<th width=100 class="head_Gray_TLB">신청자</th>
			<th width=100 class="head_Gray_TLB">업체명</th>
			<th width=70 class="head_Gray_TLB">사은품금액</th>
			<th width=70 class="head_Gray_TLB">상태</th>
			<th width=70 class="head_Gray_TLB">등록일</th>
			<th width=70 class="head_Gray_TLBR">엑셀</th>
		</tr>
  <% 
  
  strSql = " select A.gift_idx, A.gift_date, B.m_name, A.gift_writeday, A.gift_status, A.gift_money, C.dealer_name "
  strSql = strSql &"	from board_gift A left outer "
  strSql = strSql &"		 join emp_list B ON A.gift_m_id=B.m_id "
  strSql = strSql &"		 join dealer_info C ON B.m_dealer_code=C.dealer_code "
  strSql = stRSql &"		where 1=1 "


  if search_key<>"" Then
	If search_key="m_name" Then 
	  strSql = strSql &"		and (B."& search_key &" like '%"&search_txt&"%') "
	ElseIf search_key="dealer_name" Then 
	  strSql = strSql &"		and (C."& search_key &" like '%"&search_txt&"%') "
	End If	
  end If
  
  If s_date_start<>"" And s_date_end<>"" then
	  If s_search_key="gift_date" then	
		strSql = strSql &"		and (A.gift_date>='"& s_date_start &" 00:00:00') "
		strSql = strSql &"		and (A.gift_date<='"& s_date_end &" 23:59:59') "				
	  ElseIf s_search_key="gift_writeday" Then
		strSql = strSql &"		and (A.gift_writeday>='"& s_date_start &" 00:00:00') "
		strSql = strSql &"		and (A.gift_writeday<='"& s_date_end &" 23:59:59') "	
	  End if
  End If
  
  strSql = strSql &"			order by A.gift_idx desc"  
  objRs.PageSize = 30
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td class="list_LBR_center" colspan='11'> 글이 존재하지 않습니다.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		gift_idx		= objRs("gift_idx") 
  		gift_date		= Left(objRs("gift_date"),10)
  		dealer_name		= objRs("dealer_name")
  		m_name			= objRs("m_name")
		gift_money		= money_change(objRs("gift_money"))
		gift_writeday	= fnc_date_change(objRs("gift_writeday"))
		gift_status		= objRs("gift_status")

		If gift_status="접수" Then
			gift_status	= "<span style='color:blue;'>접수</span>"
		ElseIf gift_status="완료" Then
			gift_status	= "<span style='color:red;'>완료</span>"
		End if
 
  %>			  
		<tr height=30>
			<td class="list_LB_center"><%=i%></td>	
			<td class="list_LB_center"><input type="checkbox" name="gift_idx" value="<%=gift_idx%>"></td>	
			<td class="list_LB_center"><a href="a_gift_regist.asp?gift_idx=<%=gift_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><b><%=gift_date%></b></a></td>	
			<td class="list_LB_center"><%=m_name%></td>	
			<td class="list_LB_center"><%=dealer_name%></td>	
			<td class="list_LB_center"><span style="color:red;"><%=gift_money%></span></td>	
			<td class="list_LB_center"><b><%=gift_status%></b></td>	
			<td class="list_LB_center"><%=gift_writeday%></td>	
			<td class="list_LBR_center"><a href="a_gift_excel.asp?gift_idx=<%=gift_idx%>"><span class="btn_m_green01"> 엑셀</span></a></td>	
		</tr>	          
  <% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
  %>		  
		</table>
		</form>	


		<div class="alignLeft">
			<span class="btn_m_orange01" id="btn_all" onClick="fnc_toggle();"> 전체선택</span>
			<span class="btn_m_green01" id="btn_all" onclick="fnc_batch_regist('frm_board');"> 일괄처리</span>
		</div>

		<div class="pagelist">
			<%
			mychoice=10
			link_url = "a_gift_list.asp?"&s_link_txt&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
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
    DBClose()
  %>