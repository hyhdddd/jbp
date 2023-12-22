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
  
  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)
  gift_idx			= WORD_CHANGE(Request("gift_idx"),20)

  if gift_idx<>"" then
	strSql = "SELECT * FROM board_gift where gift_idx = " & gift_idx
	Set objRs=objCnn.Execute(strSql)

	gift_date		= objRs("gift_date")
	gift_money		= objRs("gift_money")
	gift_status		= objRs("gift_status")

	If gift_status="접수" Then
		gift_status	= "<span style='color:blue;'>접수</span>"
	ElseIf gift_status="완료" Then
		gift_status	= "<span style='color:red;'>완료</span>"
	End If
	
  Else
	gift_status		= "신청"
  end if  
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

	$("#addItemBtn").click(function() {					

		//$(".item").append("<tr>" + $(".item > tr:first").html() + "</tr>");    
	
		strTxt = ""
		strTxt = strTxt + "<tr> ";
		strTxt = strTxt + "		<td class='list_LB_center'>1</td> ";
		strTxt = strTxt + "		<td class='list_LB_center'><input type='hidden' class='txtbox Wid90' name='bank_idx[]' value='0'/><input type='text' class='txtbox Wid90' name='bank_name[]'/></td> ";
		strTxt = strTxt + "		<td class='list_LB_center'><input type='text' class='txtbox Wid90' name='bank_no[]'/></td> ";
		strTxt = strTxt + "		<td class='list_LB_center'><input type='text' class='txtbox Wid90' name='bank_money[]' onKeyUp=\"fncOnlyNumber(this); fnc_bank_calcu('frm_board');\"/></td> ";
		strTxt = strTxt + "		<td class='list_LBR_center'><input type='text' class='txtbox Wid90' name='bank_owner[]'/></td> ";
		strTxt = strTxt + "</tr> ";
			
		$(".item").append(strTxt);
		CntFrush();    
	});    

});
</script>

<script type="text/javascript">

function CntFrush()
{    
	// class item의 tr개수만큼 반복    
	$(".item > tr").each(function(index) {       		
		$(".item > tr:eq("+index+") > td:eq(0)").text((index+1));    
	});    
	
} 


function fnc_bank_calcu(form_name)
{
	var frm				= document.getElementById(form_name);
	var obj_money		= document.getElementsByName("bank_money[]")
	
	total_money			= 0;

	for( var i=0; i<obj_money.length; i++) 
	{
		list_money		= "0"+obj_money[i].value;
		list_money		= parseInt(list_money);

		total_money			= total_money + list_money;
		
	}	
	
	frm.gift_money.value = total_money;

}


function fnc_board_regist(form_name)
{
	var frm = document.getElementById(form_name);

	if(frm.gift_date.value=="")
	{
		alert("사은품 신청일을 입력해주세요.");
		frm.gift_date.focus();
		return;
	}
	
	var ans = confirm("저장하시겠습니까?");

	if (ans==true)
	{
		frm.submit();
	}
}

function fnc_board_del(form_name, gift_idx)
{
	var frm = document.getElementById(form_name);
	
	var ans = confirm("데이터를 삭제하시겠습니까?");

	if(ans==true)
	{	
		frm.action = "a_apply_del_ok.asp";
		frm.submit();
	}
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
			<li class="txt">추가사은품 신청</li>
		</ul>
		</div>

		<form id="frm_board" name="frm_board" action="p_gift_regist_ok.asp" METHOD="POST">
		<input type="hidden" name="gift_idx"  value="<%=gift_idx%>">
		<input type="hidden" name="page"  value="<%=page%>">
		<input type="hidden" name="nowblock"  value="<%=nowblock%>">
		<input type="hidden" name="s_link_txt"  value="<%=s_link_txt%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">사은품 신청일</th>
			<td width='85%' class="list_TLBR_left"><input type='text' class="txtbox" id='gift_date' name='gift_date' size=10 value='<%=gift_date%>' readonly></td>
		</tr>
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">사은품 목록</th>
			<td width='85%' class="list_TLBR_left" style="padding:3px;">
				<table width='100%' border="0" cellspacing="0" cellpadding="0" class="table_css">
				<tr>
					<th colspan='5' style="text-align:right;"><span class="btn_m_orange02" id="addItemBtn"> 목록추가</span></th>
				</tr>
				<tr> 
					<th class="head_Gray_TLB Wid05">순번</th> 
					<th class="head_Gray_TLB Wid20">은행명</th> 
					<th class="head_Gray_TLB Wid10">계좌번호</th> 
					<th class="head_Gray_TLB Wid05">금액</th> 
					<th class="head_Gray_TLBR Wid10">예금주</th> 
				</tr> 
				<tbody class="item"> 

  <% 
  If gift_idx<>"" Then 
	strSql = "select * from board_gift_bank where gift_idx="& gift_idx &" order by bank_idx asc"
	Set objRs = objCnn.Execute(strSql)
	
	i = 1 
	Do Until objRs.eof
		bank_idx			= objRs("bank_idx")
		bank_name			= objRs("bank_name")
		bank_no				= objRs("bank_no")
		bank_owner			= objRs("bank_owner")
		bank_money			= objRs("bank_money")
  %>
				<tr>
					<td class="list_LB_center"><%=i%></td> 
					<td class="list_LB_center">
						<input type="hidden" class="txtbox Wid90" name="bank_idx[]" value="<%=bank_idx%>"/>
						<input type="text" class="txtbox Wid90" name="bank_name[]" value="<%=bank_name%>" /></td> 
					<td class="list_LB_center"><input type="text" class="txtbox Wid90" name="bank_no[]" value="<%=bank_no%>" /></td> 
					<td class="list_LB_center"><input type="text" class="txtbox Wid90" name="bank_money[]" value="<%=bank_money%>"  onKeyUp="fncOnlyNumber(this); fnc_bank_calcu('frm_board');"/></td> 
					<td class="list_LBR_center"><input type="text" class="txtbox Wid90" name="bank_owner[]" value="<%=bank_owner%>" /></td> 
				</tr> 
  <%
		objRs.movenext
	Loop
  %>

  <% Else %>
				<tr>
					<td class="list_LB_center">1</td> 
					<td class="list_LB_center">
						<input type="hidden" class="txtbox Wid90" name="bank_idx[]" value="0"/>
						<input type="text" class="txtbox Wid90" name="bank_name[]"  /></td> 
					<td class="list_LB_center"><input type="text" class="txtbox Wid90" name="bank_no[]"  /></td> 
					<td class="list_LB_center"><input type="text" class="txtbox Wid90" name="bank_money[]"  onKeyUp="fncOnlyNumber(this); fnc_bank_calcu('frm_board');"/></td> 
					<td class="list_LBR_center"><input type="text" class="txtbox Wid90" name="bank_owner[]"  /></td> 
				</tr> 
  <% End If %>

				</tbody> 
				</table>
			</td>
		</tr>
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">사은품 합계</th>
			<td width='85%' class="list_TLBR_left"><input type='text' class="txtbox" id='gift_money' name='gift_money' size=10 value='<%=gift_money%>' readonly></td>
		</tr>
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">상태</th>
			<td width='85%' class="list_TLBR_left"><%=gift_status%></td>
		</tr>

		</table>

		<div class="alignRight">      
			<a href="p_gift_list.asp?page=<%=page%>&nowblock=<%=nowblock%>&<%=s_link_txt%>"><span class="btn_m_white01"> 목록으로</span></a> 

			<% If gift_status="신청" Then %>
			<span class="btn_m_white01" onclick="fnc_board_regist('frm_board');"> 저장하기</span>
			<% Else %>
			<span class="btn_m_white01" onclick="alert('신청상태가 아니면 수정할 수 없습니다.');"> 저장하기</span>
			<% End If %>
		</div>
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