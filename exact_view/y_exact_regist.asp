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
  <!--#include virtual="/include/asp/meta_config.asp"-->
  <% 
  if ad_r_y_exact="N" then
 	Alert_back session_m_name &" ���� �ŷ�ó ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	

  tname			 = WORD_CHANGE(Request("tname"),20)
  e_exact_idx	 = WORD_CHANGE(Request("e_exact_idx"),20)
  exact_passwd1  = WORD_CHANGE(Request("exact_passwd"),20)
  
  if e_exact_idx<>"" then
	strSql = "SELECT * FROM exact_list A left outer join dealer_info B ON A.s_dealer_code=B.dealer_code "
	strSql = strSql & " where A.e_exact_idx = " & e_exact_idx
	Set objRs=objCnn.Execute(strSql)
	
	exact_passwd		= objRs("exact_passwd")

	If exact_passwd="" Or IsNull(exact_passwd) Then
	Else
		If exact_passwd=exact_passwd1 Then
		Else
			If exact_passwd1<>"" Then
				alert_url "��й�ȣ�� ��ġ���� �ʽ��ϴ�.","y_exact_passwd_chk.asp?e_exact_idx="&e_exact_idx
			else
				alert_url "��й�ȣ�� �Է��� �ּ���!","y_exact_passwd_chk.asp?e_exact_idx="&e_exact_idx
			End if
			Response.end
		End if
	End If 

	e_m_id					= objRs("e_m_id")
	e_title					= objRs("e_title")
	e_contents				= objRs("e_contents")
	e_fname1				= objRs("e_fname1")
	e_fname2				= objRs("e_fname2_excel")
	e_exact_date1			= objRs("e_exact_date1")
	e_exact_date2			= objRs("e_exact_date2")
	s_dealer_code			= objRs("s_dealer_code")
	e_charge_chk_date		= objRs("e_charge_chk_date")
	e_request_txt			= objRs("e_request_txt")
	e_charge_chk			= objRs("e_charge_chk")

	s_date_start			= objRs("s_date_start")
	s_date_end				= objRs("s_date_end")
	s_gaetong_code			= objRs("s_gaetong_code")
	date_chk				= objRs("date_chk")
	dealer_name				= objRs("dealer_name")

	tax_chk					= objRs("tax_chk")

	t_charge_promise		= money_chk(objRs("charge_promise"))
	t_charge_sp				= money_chk(objRs("charge_sp"))
	t_charge_sale			= money_chk(objRs("charge_sale"))
	t_charge_document		= money_chk(objRs("charge_document"))
	t_charge_gita			= money_chk(objRs("charge_gita"))
	t_charge_bundle			= money_chk(objRs("charge_bundle"))
	t_charge_buga			= money_chk(objRs("charge_buga"))
	t_charge_combine		= money_chk(objRs("charge_combine"))

	tax_price_n				= money_chk(objRs("tax_price_n"))

	charge_gita1			= money_chk(objRs("charge_gita1"))
	charge_gita1_bigo		= objRs("charge_gita1_bigo")

	charge_gongje			= money_chk(objRs("charge_gongje"))
	charge_gongje_bigo		= objRs("charge_gongje_bigo")

	t_charge_sum_n			= tax_price_n+charge_gita1


	d_t_charge_tax		= Fix(t_charge_sum_n*0.1)			
	t_charge_sum_y		= Fix(t_charge_sum_n+d_t_charge_tax) 

	d_t_charge_tax		= Fix(t_charge_sum_n*0.033)			
	t_charge_sum_p		= Fix(t_charge_sum_n-d_t_charge_tax) 

	If tax_chk="Y" Then
		tax_chk_txt = "<span class='red'> ���� </span>"
		tax_price	= t_charge_sum_y + charge_gongje
		tax_price1	= t_charge_sum_y
	ElseIf tax_chk="P" Then
		tax_chk_txt = "<span class='blue'> ��õ�� </span>"
		tax_price	= t_charge_sum_p + charge_gongje
		tax_price1	= t_charge_sum_p
	Else
		tax_chk_txt = "<span class='black'> �̹��� </span>"
		tax_price	= t_charge_sum_n +charge_gongje
		tax_price1	= t_charge_sum_n
	End If
	

	'���ϸ��� Ȯ���� �̱�
	if len(e_fname1)>0 then
		filepath1	= o_code&"/exact/"&left(e_fname1, InstrRev(e_fname1,"/"))  
		filename1	= mid(e_fname1, InstrRev(e_fname1,"/")+1)  
		strExt		= ucase(Mid(e_fname1,Instr(e_fname1,".")+1))
		Ext_img		= file_strExt_chk(strExt)
	end If	


	'���ϸ��� Ȯ���� �̱�
	if len(e_fname2)>0 then
		filepath2	= o_code&"/exact/"&left(e_fname2, InstrRev(e_fname2,"/"))  
		filename2	= mid(e_fname2, InstrRev(e_fname2,"/")+1)  
	end If	


  Else
	board_contents	= ""
  end if  

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">
<!--
	function exact_request(form_name,chk)
	{
		var frm=eval("document.all."+form_name);
		frm.e_charge_chk.value=chk;
		
		if (chk=="B")
		{
			ans=confirm("���꼭�� ���û �Ͻðڽ��ϱ�?");
		}

		if(chk=="C")
		{
			ans=confirm("���꼭�� Ȯ���Ͻð� ���� �ݾ��� �Ա� ��û�ϴ� ��� �Դϴ�. \n\n ���꼭�� ���� �ݾ��� �����û�Ͻðڽ��ϱ�?");
		}

		if(ans==true)
		{
			frm.action="y_exact_request_ok.asp";
			frm.submit();
		}

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
		
		<!------------------ ���� ����  ------------------>

		<div class="sub_tit">
		<ul>
			<li><img src="/images/img/sub_img.jpg"></li>
			<li class="txt">������ ���곻����</li>
		</ul>
		</div>

		<form name="frm_board" action="a_exact_regist_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="e_exact_idx"  value="<%=e_exact_idx%>">
		<input type="hidden" name="session_m_id"  value="<%=session_m_id%>">
		<input type="hidden" name="e_charge_chk"  value="">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">
		<tr height=30> 
			<th width='15%' class="head_Gray_TLB">����</th>
			<td width='85%' class="list_TLBR_left"> <%=e_title%></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB">����Ⱓ </th>
			<td class="list_LBR_left"> <%=e_exact_date1%> ~ <%=e_exact_date2%></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� ��ü </th>
			<td class="list_LBR_left"> <%=dealer_name%>	</td>
		</tr>
		<tr height=30> 
			<td class="list_LBR_left" colspan='2' style="padding:3px;"><br>
				<table width='100%' border=0 cellspacing="0" cellpadding="0" class="table_css">
				<tr height='20'>
					<Th rowspan='2' class="head_Gray_TLB">�����ݾ�</th>
					<Th colspan='4' class="head_Gray_TLB">��������</th>
					<Th rowspan='2' class="head_Gray_TLB">���������</th>
					<Th rowspan='2' class="head_Gray_TLB">�ΰ�����</th>
					<Th rowspan='2' class="head_Gray_TLB">���ռ�����</th>
					<Th rowspan='2' class="head_Gray_TLBR">�հ�</th>
				</tr>
				<tr height='20'>
					<Th class="head_Gray_LB">����ǰ</th>
					<Th class="head_Gray_LB">������</th>
					<Th class="head_Gray_LB">�̺񼭷�</th>
					<Th class="head_Gray_LB">��Ÿ</th>
				</tr>
				<tr height='30'>
					<Td class="list_LB_center"><%=money_change(t_charge_promise)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_sp)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_sale)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_document)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_gita)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_bundle)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_buga)%></td>
					<Td class="list_LB_center"><%=money_change(t_charge_combine)%></td>
					<Td class="list_LB_center"><%=money_change(tax_price_n)%></td>
				</tr>
				</table><br>
			</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> ��Ÿ ���� </th>
			<td class="list_LBR_left">&nbsp;<%=money_change(charge_gita1)%> ��
				&nbsp;&nbsp;&nbsp;
				<b><span class='red'>(����:<%=charge_gita1_bigo%>)</span></b>
				&nbsp;&nbsp;&nbsp;<span class='blue'>(*���׿� ���ԵǴ� �ݾ�)</span>
				</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> ���� ���� </th>
			<td class="list_LBR_left">&nbsp;<%=money_change(charge_gongje)%> ��
				&nbsp;&nbsp;&nbsp;
				<b><span class='red'>(����:<%=charge_gongje_bigo%>)</span></b>
				&nbsp;&nbsp;&nbsp;<span class='blue'>(*���׿� ���Ե��� �ʴ� �ݾ�)</span>
				</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ������ �ݾ� </th>
			<td class="list_LBR_left">&nbsp;<span class='red'><%=money_change(tax_price)%> ��</span>
				&nbsp;&nbsp;&nbsp;<span class='blue'>( ���ױݾ� : <%=money_change(tax_price1)%> ��)</span></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� ��꼭 </th>
			<td class="list_LBR_left"> <%=tax_chk_txt%>
				&nbsp;&nbsp;
				<% If tax_chk="Y" Then %>
				&nbsp;&nbsp; <a href="javascript:NewWindow('/exact_view/y_exact_tax_view.asp?e_exact_idx=<%=e_exact_idx%>','tax_view',850,600,'no');">
				<img src="/images/button/btn_tax.gif" align='absmiddle'></a>
				<% End If %>
				
			</td>
		</tr>
		<tr>
			<th class="head_Gray_LB"> �� ����Ʈ </td>
			<td class="list_LBR_left">
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>">
				<img src="/images/button/btn_excel.gif" align='absmiddle'></a>
				
			</td>
		</tr>
		<tr height=30> 
			<td colspan='2' class="list_LBR_left" style="padding:3px;"> 
				<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10"><%=e_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents', {
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>						
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� </th>
			<td class="list_LBR_left"><input type="file" class="txtbox" name="e_fname1" size="40">&nbsp;&nbsp;&nbsp;
				<% if len(e_fname1)>0 then %>
					<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
				<% else %>&nbsp;<% end if %>
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB">��û ����</th>
			<td class="list_LBR_left"><textarea name="e_request_txt" class='txtbox' cols="140" rows="4"><%=e_request_txt%></textarea></td>
		</tr>
		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="y_exact_list.asp?&page=<%=page%>"><img src="/images/button/btn_list.gif"  border="0" align="absmiddle"></a>&nbsp;&nbsp;

				<% If e_charge_chk="E" Then %>
					<img src="/images/button/btn_exact_request.gif"  border="0" align="absmiddle" onclick="alert('����Ϸ�� �ǿ� ���ؼ��� ���û �Ͻ� �� �����ϴ�.\n\n �����ڿ� �����ϼ���!');">
					<span onclick="alert('����Ϸ�� �ǿ� ���ؼ��� ���û �Ͻ� �� �����ϴ�.\n\n �����ڿ� �����ϼ���!');">&nbsp;&nbsp;<img src="/images/button/btn_re_request.gif"  border="0" align="absmiddle"></span>

				<% Else %>
					<a href="javascript:exact_request('frm_board','C');"><img src="/images/button/btn_exact_request.gif"  border="0" align="absmiddle"></a>&nbsp;&nbsp;
					<a href="javascript:exact_request('frm_board','B');"><img src="/images/button/btn_re_request.gif"  border="0" align="absmiddle"></a>
				<% End If %>
				
			</td>
		</tr>
		</form>	
		</table>
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