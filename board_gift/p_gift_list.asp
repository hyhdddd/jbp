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
  if ad_p_gift="N" then
 	Alert_back session_m_name &" 님은 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end If

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  %>
<!--#include virtual="/include/asp/meta_config.asp"-->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/javascript" src="/include/js/common.js"></SCRIPT>
<script type="text/javascript" src="/include/js/calendar_beans_v2.0.js"></script>

<script type="text/javascript">		
$(document).ready(function() {
	CalAddCss();
	initCal({id:"gift_date",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});	
	

});
</script>

<script type="text/javascript">
<!--
function fnc_apply_regist(form_name)
{
	var frm = document.getElementById(form_name);
	
	if(frm.gift_date.value=="")
	{
		alert("정산일을 선택해 주세요");
		return;
	}

	var ans = confirm("정산일을 신청하시겠습니까?");

	if (ans==true)
	{
		frm.submit();
	}
	
}
-->
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
			<li class="txt">추가사은품 신청</li>
		</ul>
		</div>

		<table width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr height=30>            
			<td style="text-align:right;">
				<a href="p_gift_regist.asp"><span class="btn_m_white01"> 신청하기</span></a>
			</td>			
		</tr>
		</table>


		<table width="100%" cellspacing=1 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th width=30  class="head_Gray_TLB">No.</th>
			<th width=100 class="head_Gray_TLB">사은품 신청일</th>
			<th width=100 class="head_Gray_TLB">신청자</th>
			<th width=100 class="head_Gray_TLB">업체명</th>
			<th width=70 class="head_Gray_TLB">사은품금액</th>
			<th width=70 class="head_Gray_TLB">상태</th>
			<th width=70 class="head_Gray_TLBR">등록일</th>
		</tr>
  <% 
  
  strSql = " select A.gift_idx, A.gift_date, B.m_name, A.gift_writeday, A.gift_status, A.gift_money, C.dealer_name "
  strSql = strSql &"	from board_gift A left outer "
  strSql = strSql &"		 join emp_list B ON A.gift_m_id=B.m_id "
  strSql = strSql &"		 join dealer_info C ON B.m_dealer_code=C.dealer_code "
  strSql = stRSql &"		where A.gift_m_id='"& session_m_id &"' "

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
			<td class="list_LB_center"><a href="p_gift_regist.asp?gift_idx=<%=gift_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><b><%=gift_date%></b></a></td>	
			<td class="list_LB_center"><%=m_name%></td>	
			<td class="list_LB_center"><%=dealer_name%></td>	
			<td class="list_LB_center"><span style="color:red;"><%=gift_money%></span></td>	
			<td class="list_LB_center"><b><%=gift_status%></b></td>	
			<td class="list_LBR_center"><%=gift_writeday%></td>	
		</tr>	          
  <% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
  %>		  
		</table>

		<div class="pagelist">
			<%
			mychoice=10
			link_url = "p_gift_list.asp?"
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