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
 	Alert_back session_m_name &" 님은 관리 권한이 없습니다. 관리자에게 문의하세요!"
	Response.end
  end if		

  policy_idx		= WORD_CHANGE(request("policy_idx"),20)
  article_idx1		= WORD_CHANGE(Request("s_article_idx1"),20)

  If policy_idx<>"" then
  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code"
  strSql = strSql & "			where A.policy_idx="& policy_idx
  Set objRs=objCnn.Execute(strSql)

  group_code	= objRs("group_code")
  group_name	= objRs("group_name")
  policy_date	= fnc_date_change(objRs("policy_date"))
  End If
  

  If article_idx1="" Or article_idx1="0" then
	   strSql = " select * from code_article where article_step2=0 and article_view='Y' order by article_order asc "
	  Set objRs=objCnn.Execute(strSql)

	  If objRs.eof Or objRs.bof Then
	  Else
		article_idx1		= objRs("article_step1")
	  End If
  

  End If
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>

<script type="text/javascript">
<!--
function fnc_change_article(form_name)
{
	var frm	= document.getElementById(form_name);
	frm.action="charge_combine.asp";
	frm.submit();
}

function fnc_regist(form_name)
{
	var frm	= document.getElementById(form_name);
	frm.submit();
}

function charge_del_ok(url)
{
	ans=confirm("정책을 삭제하시겠습니까?");
	if(ans==true)
	{
		location.replace(url);
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
			<li class="txt">수수료 정책</li>
		</ul>
		</div>

		<form id="frm_board" name="frm_board" Method="POST" action="charge_combine_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_css">
		<tr height='30'>
			<td colspan='4' class="list_TLBR_left">
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		<tr height='30'>
			<th width='15%' class="head_Gray_TLB">정책 일자	</th>
			<td width='85%' class="list_TLBR_left"><%=policy_date%>
				&nbsp;&nbsp;&nbsp;	
				<a href="/charge/charge_promise.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 약정수수료</span></a>
				<a href="/charge/charge_sale.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 할인탭</span></a>
				<a href="/charge/charge_bundle.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 번들수수료</span></a>
				<a href="/charge/charge_document.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 미비서류</span></a>
				<a href="/charge/charge_buga.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 부가서비스</span></a>
				<a href="/charge/charge_combine.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 결합수수료</span></a>
				<a href="javascript:charge_del_ok('policy_del_ok.asp?policy_idx=<%=policy_idx%>')"><span class="btn_m_white01"> 정책삭제</span></a> 
			</td>
		</tr>
		<tr height='30'>
			<th class="head_Gray_LB">정책 그룹명	</th>
			<td class="list_LBR_left"><%=group_name%></td>
		</tr>
		<tr height='30'>
			<th class="head_Gray_LB">회사 선택	</th>
			<td class="list_LBR_left">
				<select name="s_article_idx1" class="txtbox" style="width:120px;" onchange="fnc_change_article('frm_board');">
				<option value="0" <% if article_idx="0" then %> selected <% end if %>> 회사선택</option>           
				<% 
				strSql = " select * from code_article where article_step2=0 and article_view='Y'order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF   	
					c_article_idx		= objRs("article_idx")
					c_article_name		= objRs("article_name")
				%>	
				<option value="<%=c_article_idx%>" <% if CInt(article_idx1)=c_article_idx then %> selected <% end if %>><%=c_article_name%></option>
				<% 
					objrs.MoveNext
				Loop
				%>	
				</select>
				
			</td>
		</tr>
		</table>	

		<br>
			
		<TABLE width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th class="head_Gray_TLB" width="30%">결합</th> 
			<th class="head_Gray_TLBR" width="70%">정산금액</th> 
		</tr>
 
  <% 
 
	strSql = " select * from code_combine where  article1_idx="& article_idx1 &" and combine_view='Y' order by combine_order asc "
	Set objRs=objCnn.Execute(strSql)

	Do Until objRs.Eof
		combine_idx		= objRs("combine_idx")
		combine_name	= objRs("combine_name")

		strSql = " select top 1 combine_charge from charge_combine where policy_idx="& policy_idx &" and combine_idx="& combine_idx &" "
		Set objRs1=objCnn.Execute(strSQl)

		If objRs1.eof Or objRs1.bof Then
				combine_charge		= ""
		Else
				combine_charge		= objRs1("combine_charge")
		End If
	%>
		<tr height='30'>
			<td class="list_LB_center"><%=combine_name%></td>			
			<td class='list_LBR_center'><input type="text" class='txtbox' name="A<%=combine_idx%>" size='8' onKeyUp="fncOnlyNum(this);" value="<%=combine_charge%>"></td>
		</tr>
		<%
			
			objRs.movenext
			i=i+1
		Loop
			
   objRs.close
  %>   
		<tr>
			<td colspan='3' align='right'>		
				<span class="btn_m_white01" onclick="fnc_regist('frm_board');"> 저장하기</span>
			</td>
		</tr>
		</table>
		</form>
		
		<!------------------ 내용 종료  ------------------>
	</td>
</tr>
<tr>
	<td>
		<!--#include virtual="/include/asp/cms_bottom.asp"-->
	</td>
</tr>
</table>
