  <%
  '====================================='
  ' ������Ʈ : ���ͼ���Ʈ
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 010-9619-8289
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
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
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
	initCal({id:"apply_date",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});			
});
</script>

<script type="text/javascript">
<!--
function fnc_apply_regist(form_name)
{
	var frm = document.getElementById(form_name);
	
	if(frm.apply_date.value=="")
	{
		alert("�������� ������ �ּ���");
		return;
	}

	var ans = confirm("�������� ��û�Ͻðڽ��ϱ�?");

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
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">������ ��û</li>
		</ul>
		</div>

		<form id="frm_board" name='frm_board' method='post' action='p_apply_regist_ok.asp'>

		<table width="100%" cellspacing=0 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th class="head_Gray_TLB" style="width:15%;"> ������ </th>
			<td class="list_TLBR_left" style="width:85%;">
				<input type="text" id="apply_date" name="apply_date" class="txtbox" size='10' readonly>
				<span class="btn_m_orange01" onclick="fnc_apply_regist('frm_board');"> ��û�ϱ�</span>
			</td>			
		</tr>
		</table>
		</form>	

		<br><br>

		<table width="100%" cellspacing=1 cellpadding=0 border=0 class="table_css">
		<tr height=30>             
			<th width=30  class="head_Gray_TLB">No.</th>
			<th width=100 class="head_Gray_TLB">���� ��û��</th>
			<th width=100 class="head_Gray_TLB">��û��</th>
			<th width=100 class="head_Gray_TLB">��ü��</th>
			<th width=100 class="head_Gray_TLB">����</th>
			<th width=70 class="head_Gray_TLBR">�����</th>
		</tr>
  <% 
  
  strSql = " select A.apply_idx, A.apply_date, A.apply_status, B.m_name, A.apply_writeday, C.dealer_name "
  strSql = strSql &"	from exact_apply A left outer "
  strSql = strSql &"		 join emp_list B ON A.apply_m_id=B.m_id "
  strSql = strSql &"		 join dealer_info C ON B.m_dealer_code=C.dealer_code "
  strSql = stRSql &"		where A.apply_m_id='"& session_m_id &"' "

  strSql = strSql &"			order by A.apply_idx desc"  
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
		<tr height=30>
			<td class="list_LBR_center" colspan='11'> ���� �������� �ʽ��ϴ�.</td>	
		</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		apply_idx		= objRs("apply_idx") 
  		apply_date		= Left(objRs("apply_date"),10)
  		dealer_name		= objRs("dealer_name")
  		m_name			= objRs("m_name")
		apply_writeday	= fnc_date_change(objRs("apply_writeday"))
 
 		apply_status		= objRs("apply_status")

		If apply_status="����" Then
			apply_status	= "<span style='color:blue;'>����</span>"
		ElseIf apply_status="�Ϸ�" Then
			apply_status	= "<span style='color:red;'>�Ϸ�</span>"
		End If
		
  %>			  
		<tr height=30>
			<td class="list_LB_center"><%=i%></td>	
			<td class="list_LB_center"><%=apply_date%></td>	
			<td class="list_LB_center"><%=m_name%></td>	
			<td class="list_LB_center"><%=dealer_name%></td>	
			<td class="list_LB_center"><%=apply_status%></td>	
			<td class="list_LBR_center"><%=apply_writeday%></td>	
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
			link_url = "p_apply_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
			%>
			<!--#include virtual="/include/asp/list_paging.asp"-->
		</div>
		<!------------------ ���� ����  ------------------>					          			
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