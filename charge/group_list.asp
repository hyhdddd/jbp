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

  policy_idx		=WORD_CHANGE(request("policy_idx"),20)

  If policy_idx<>"" then
  strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
  strSql = strSql & "	from charge_policy  A left outer "
  strSql = strSql & "		join code_group B ON A.group_code=B.group_code"
  strSql = strSql & "			where A.policy_idx="&policy_idx
  Set objRs=objCnn.Execute(strSql)

  group_code	= objRs("group_code")
  group_name	= objRs("group_name")
  policy_date	= fnc_date_change(objRs("policy_date"))
  Else
	Alert_back "정책을 선택하세요!"
  End if
  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>

<script language="javascript">
<!--
function board_del_ok(url)
{
	ans=confirm("정책을 삭제하시겠습니까?");
	if(ans==true)
	{
		location.replace(url);
	}
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


		<form name="frm_group" Method="POST" action="group_use_ok.asp">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>
			  	<!--#include virtual="/include/asp/charge_menu_list.asp"-->
			</td>
		</tr>
		</table>				


		<TABLE width="100%" cellspacing=0 cellpadding=0 border=0 id="board_table2">
		<tr height='30'>
			<td class='head'> 정책일자 </td>
			<td class="con4" style="text-align:left;">&nbsp;<%=policy_date%></td>			
		</tr>
		<tr height='30'>
			<td class='head'> 정산그룹 </td>
			<td class="con4"  style="text-align:left;">&nbsp;<%=group_name%> </td>
		</tr>
		<tr height='30'>
			<td class='head'> 정책 설정 </td>
			<td class="con4"  style="text-align:left;">&nbsp;
				<a href="/charge/charge_promise.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 약정수수료</span></a>
				<a href="/charge/charge_sale.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 할인탭</span></a>
				<a href="/charge/charge_bundle.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 번들수수료</span></a>
				<a href="/charge/charge_document.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 미비서류</span></a>
				<a href="/charge/charge_buga.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 부가서비스</span></a>
				<a href="/charge/charge_combine.asp?group_code=<%=group_code%>&policy_idx=<%=policy_idx%>"><span class="btn_m_white01"> 결합수수료</span></a>
				<a href="javascript:charge_del_ok('policy_del_ok.asp?policy_idx=<%=policy_idx%>')"><span class="btn_m_white01"> 정책삭제</span></a> 

			</td>
		</tr>
		<tr height=30>             
			<td class="head" width=100>번  호</td>
			<td class="head" width=800>딜러 명</td>
		</tr>		
	  <%
	  strSql = " select * from dealer_info where dealer_group_code='"&group_code&"' order by dealer_name  Asc"
	  Set objRs1=objCnn.Execute(strSql)  

	  if objRs1.BOF or objRs1.EOF Then
	  %>
		<tr height=30>
			<td colspan='2' align='center' class="con5">
				소속 협력점이  존재하지 않습니다.
			</td>
		</tr>
  <%
		else      		 
		i=1
  		Do until objRs1.EOF
			dealer_name			= objRs1("dealer_name")
			dealer_code			= objRs1("dealer_code")
			dealer_writeday		= objRs1("dealer_writeday")

  %>	
		<tr height=30>
			<td class="con5"><%=i%></td>
			<td class="con2"><%=dealer_name%></td>
		</tr>
  <% 
			objRs1.MoveNext
   			i=i+1 
		loop
 
	   objRs1.close
		end if					

  %>
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
