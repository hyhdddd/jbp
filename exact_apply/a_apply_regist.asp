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
  if ad_a_gift="N" then
 	Alert_back session_m_name &" ���� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end If	
  
  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)
  apply_idx			= WORD_CHANGE(Request("apply_idx"),20)

  if apply_idx<>"" then
	strSql = "SELECT * FROM exact_apply where apply_idx = " & apply_idx
	Set objRs=objCnn.Execute(strSql)

	apply_date			= objRs("apply_date")
	apply_status		= objRs("apply_status")
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
	initCal({id:"apply_date",type:"day",today:"y",icon:"y", min:"2014", iconUrl:""});			
});
</script>

<script type="text/javascript">

function fnc_board_regist(form_name)
{
	var frm = document.getElementById(form_name);

	if(frm.apply_date.value=="")
	{
		alert("�����û���� �Է����ּ���.");
		frm.apply_date.focus();
		return;
	}
	
	frm.submit();
}
</script>

<script type="text/javascript">

function fnc_board_del(form_name, apply_idx)
{
	var frm = document.getElementById(form_name);
	
	var ans = confirm("�����͸� �����Ͻðڽ��ϱ�?");

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
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">������ ��û����</li>
		</ul>
		</div>

		<form id="frm_board" name="frm_board" action="a_apply_regist_ok.asp" METHOD="POST">
		<input type="hidden" name="apply_idx"  value="<%=apply_idx%>">
		<input type="hidden" name="page"  value="<%=page%>">
		<input type="hidden" name="nowblock"  value="<%=nowblock%>">
		<input type="hidden" name="s_link_txt"  value="<%=s_link_txt%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">

		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">������</th>
			<td width='85%' class="list_TLBR_left"><input type='text' class="txtbox" id='apply_date' name='apply_date' size=10 value='<%=apply_date%>' readonly></td>
		</tr>
		<tr height=30> 
			<th width="15%" class="head_Gray_TLB">����</th>
			<td width='85%' class="list_TLBR_left">
				<select name="apply_status" class="txtbox" style="width:150px;">
				<option value="��û" <% If apply_status="��û" Then %> selected <% End If %>> ��û </option>
				<option value="����" <% If apply_status="����" Then %> selected <% End If %>> ���� </option>
				<option value="�Ϸ�" <% If apply_status="�Ϸ�" Then %> selected <% End If %>> �Ϸ� </option>
				</select>
			</td>
		</tr>
		</table>

		<div class="alignRight">      
			<a href="a_apply_list.asp?page=<%=page%>&nowblock=<%=nowblock%>&<%=s_link_txt%>"><span class="btn_m_white01"> �������</span></a> 
			<span class="btn_m_white01" onclick="fnc_board_regist('frm_board');"> �����ϱ�</span>
			<span class="btn_m_white01" onclick="fnc_board_del('frm_board');"> �����ϱ�</span>
		</div>
		</form>	
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