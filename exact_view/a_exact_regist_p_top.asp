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
  if ad_r_a_exact="N" then
 	Alert_back session_m_name &" ���� ��ü ������� ������ �����ϴ�. �����ڿ��� �����ϼ���!"
	Response.end
  end if	


  s_date_start			= WORD_CHANGE(request("s_date_start"),20)		'�˻� ��¥ ������
  s_date_end			= WORD_CHANGE(request("s_date_end"),20)			'�˻� ��¥ ������
  s_gaetong_code		= WORD_CHANGE(request("s_gaetong_code"),20)		'�����ڵ�
  g_yuchi_m_id			= WORD_CHANGE(Request("g_yuchi_m_id"),20)		'��ġ��	
  date_chk				= WORD_CHANGE(Request("date_chk"),20)			'��¥ �׸�
  s_article_idx1		= WORD_CHANGE(money_chk(Request("s_article_idx1")),20)
  s_article_idx2		= WORD_CHANGE(money_chk(Request("s_article_idx2")),20)
  s_option_idx			= WORD_CHANGE(money_chk(Request("s_option_idx")),20)
 

  If date_chk=""		Then	date_chk="0"			End If  

	strSql = " select K.g_yuchi_m_id, K.t_charge_promise, K.t_charge_sp_top, K.t_charge_sp, K.t_charge_sale, "
	strSql = strSql & " K.t_charge_document, K.t_charge_gita, K.t_charge_bundle, K.t_charge_buga, K.t_charge_combine, Y.m_name, "
	strSql = strSql & " Y.m_bank_name, Y.m_bank_no, Z.bank_name "
	strSql = strSql & "	from ( "
	strSql = strSql & "		select A.g_yuchi_m_id, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_promise),0) as t_charge_promise, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_sp_top),0) as t_charge_sp_top, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_sp),0) as t_charge_sp, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_sale),0) as t_charge_sale, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_document),0) as t_charge_document, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_gita),0) as t_charge_gita, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_bundle),0) as t_charge_bundle, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_combine),0) as t_charge_combine, "
	strSql = strSql & "		ISNULL(SUM(H.g_charge_buga),0) as t_charge_buga "
	strSql = strSql & "			from customer_goods A full join customer_goods_charge H ON A.g_goods_idx=H.g_goods_idx "
	strSql = strSql & "				where (A.g_yuchi_m_id='"& g_yuchi_m_id &"') "

	'ȸ��
	If s_article_idx1<>"0" Then
		strSql = strSql & "			and (A.g_article_idx1="&s_article_idx1 & ") "
	End if

	'��ǰ
	If s_article_idx2<>"0" Then
		strSql = strSql & "			and (A.g_article_idx2="&s_article_idx2 & ") "
	End If

	'�ɼ�
	If s_option_idx<>"0" Then
		strSql = strSql & "			and (A.g_option_idx="&s_option_idx & ") "
	End If

	'����
	If s_gaetong_code<>"" Then
		strSql = strSql & "			and A.g_code_gaetong_idx='"& s_gaetong_code &"'"	
	End If

	'������
	If date_chk="1" Then
		strSql = strSql & "			and (A.g_date_yuchi>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_yuchi<='"&s_date_end&" 23:59:59') "		
	End If

	'������
	If date_chk="2" Then
		strSql = strSql & "			and (A.g_date_gaetong>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_date_gaetong<='"&s_date_end&" 23:59:59') "		
	End If

	'�ؾ���
	If date_chk="3" Then
		strSql = strSql & "			and (A.g_cancel_date>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (A.g_cancel_date<='"&s_date_end&" 23:59:59') "		
	End If

	'���꿹����
	If date_chk="4" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		
	End If

	'����Ϸ���
	If date_chk="5" Then
		strSql = strSql & "			and (H.g_charge_date2>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date2<='"&s_date_end&" 23:59:59') "		
	End If


	'���꿹���� + �̿Ϸ�
	If date_chk="6" Then
		strSql = strSql & "			and (H.g_charge_date1>='"&s_date_start&" 00:00:00') "
		strSql = strSql & "			and (H.g_charge_date1<='"&s_date_end&" 23:59:59') "		

		strSql = strSql & "			and (H.g_charge_date2='' or H.g_charge_date2 is null) "		
	End If


	strSql = strSql & "				group by A.g_yuchi_m_id ) K "
	strSql = strSql & "			left outer join emp_list Y ON K.g_yuchi_m_id=Y.m_id "
	strSql = strSql & "			left join code_bank Z ON Y.m_bank_cd=Z.board_idx "
	'Response.write strSql
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
	
  m_name					= objRs("m_name")				'��� ��

  dealer_com_yn				= "N"
		
  d_t_charge_tax			= Fix(t_charge_sum_n*0.1)			
  t_charge_sum_y			= Fix(t_charge_sum_n+d_t_charge_tax)

  d_t_charge_tax			= Fix(t_charge_sum_n*0.033)			
  t_charge_sum_p			= Fix(t_charge_sum_n-d_t_charge_tax)

  %>

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT type="text/JavaScript" src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">

function fnc_board_regist(form_name)
{
	var frm = document.getElementById(form_name);
	
	if(frm.e_title.value=="")
	{
		alert("���� ������ �Է��� �ּ���!");
		frm.e_title.focus();
		return;
	}

	if(frm.e_exact_date1.value=="" || frm.e_exact_date2.value=="")
	{
		alert("���� �Ⱓ�� �Է��� �ּ���");
		return;
	}

	frm.submit();
}

function board_del_ok(url)
{
	ans=confirm("���� �����Ͻðڽ��ϱ�?");
	if(ans==true)
	{
		location.replace(url);
	}
}


//3�ڸ� �ĸ� ���
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

	p_value1		= p_value + j_value;		//�����ݾ� ���
	//p_value2		= setFormatPrice(p_value1);
	html_txt = "&nbsp;<span class='red'>"+setFormatPrice(p_value1)+" �� </span>";	//����ݾ�
	html_txt = html_txt + "&nbsp;&nbsp;&nbsp; "
	html_txt = html_txt + "<span class='blue'>( ���ױݾ� : &nbsp;"+setFormatPrice(p_value)+" �� )</span>";	//���ױݾ�
	price1.innerHTML = html_txt
}

window.onload	= function()
{
	tax_calcu('frm_board');
}
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">			
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub06_t06.gif" width='880'></div>

		<form id="frm_board" name="frm_board" action="a_exact_regist_p_top_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="e_exact_idx"  value="<%=e_exact_idx%>">
		<input type="hidden" name="e_charge_chk"  value="A">
		<input type="hidden" name="e_exact_type"  value="P">

		<input type="hidden" name="s_article_idx1" value="<%=s_article_idx1%>">
		<input type="hidden" name="s_article_idx2" value="<%=s_article_idx2%>">
		<input type="hidden" name="s_option_idx" value="<%=s_option_idx%>">
		<input type="hidden" name="g_yuchi_m_id" value="<%=g_yuchi_m_id%>">

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
		<input type="hidden" name="charge_gita" value="<%=t_charge_gita%>">
		<input type="hidden" name="charge_document" value="<%=t_charge_document%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_css">
		<tr height=30> 
			<th class="head_Gray_TLB">��&nbsp;&nbsp;&nbsp;�� </th>
			<td class="list_TLBR_left"> 
				<input type="text" class="txtbox" name="e_title" size="50" value="<%=e_title%>">
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB">���� �Ⱓ </th>
			<td class="list_LBR_left"> 
				<input type="text" name="e_exact_date1" class="txtbox" size='10' value="<%=e_exact_date1%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_exact_date1&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"> ~
				<input type="text" name="e_exact_date2" class="txtbox" size='10' value="<%=e_exact_date2%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=e_exact_date2&code2=&code3=&form_name=frm_board','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� ��ü </th>
			<td class="list_LBR_left"> <%=m_name%>	</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� ������ </th>
			<td class="list_LBR_left" style="padding:3px;">
				<table width='100%' border=0 cellspacing="0" cellpadding="0" class="table_css">
				<tr height='20'>
					<Th rowspan='2' class="head_Gray_TLB">�����ݾ�</th>
					<Th colspan='5' class="head_Gray_TLB">���� �׸�</th>
					<Th rowspan='2' class="head_Gray_TLB">���������</th>
					<Th rowspan='2' class="head_Gray_TLB">�ΰ�����</th>
					<Th rowspan='2' class="head_Gray_TLB">���ռ�����</th>
					<Th rowspan='2' class="head_Gray_TLBR">�հ�</th>
				</tr>
				<tr height='20'>
					<Th align='center' class="head_Gray_TLB">�������ǰ</th>
					<Th align='center' class="head_Gray_TLB">����ǰ</th>
					<Th align='center' class="head_Gray_TLB">������</th>
					<Th align='center' class="head_Gray_TLB">�̺񼭷�</th>
					<Th align='center' class="head_Gray_TLB">��Ÿ</th>
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
			<th class="head_Gray_LB"> ��Ÿ ���� </th>
			<td class="list_LBR_left">&nbsp; 
				<input type="text" class='txtbox' name="charge_gita1" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');">��
				&nbsp;&nbsp;&nbsp;
				���곻��:
				<input type="text" class='txtbox' name="charge_gita1_bigo" size='30' maxlength='50'> <span class='red'> �� �׸��� ���׿� ���ԵǴ� �ݾ� </span>
			</td>
		</tr>
		<tr height="30">
			<th class="head_Gray_LB"> ���� ���� </th>
			<td class="list_LBR_left">&nbsp; 
				<input type="text" class='txtbox' name="charge_gongje" size='8' maxlength='8' onKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');tax_calcu('frm_board');">��
				&nbsp;&nbsp;&nbsp;
				���곻��:
				<input type="text" class='txtbox' name="charge_gongje_bigo" size='30' maxlength='50'><span class='red'> �� �׸��� ���� ����� �����Ǵ� �ݾ� </span>
			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ������ �ݾ� </th>
			<td class="list_LBR_left"><div id="price1"></div></td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> ���� ��꼭 </th>
			<td class="list_LBR_left"> 	
				<input type="radio" name="tax_chk" value="Y" <% If dealer_com_yn="Y" Then %> checked <% End If %> onclick="tax_calcu('frm_board')">���� &nbsp;&nbsp;
				<input type="radio" name="tax_chk" value="P" <% If dealer_com_yn="P" Then %> checked <% End If %> onclick="tax_calcu('frm_board')">��õ�� &nbsp;&nbsp;
				<input type="radio" name="tax_chk" value="N" <% If dealer_com_yn="N" Then %> checked <% End If %>onclick="tax_calcu('frm_board')">�̹���
				
				<% If e_exact_idx<>"" Then %>
				<% If dealer_com_yn="Y" Then %>
					&nbsp;&nbsp; <a href="javascript:NewWindow('/exact/a_exact_tax_view.asp?e_exact_idx=<%=e_exact_idx%>','tax_view',850,600,'no');">
					[���ݰ�꼭 ���]</a>
				<% End If %>
				<% End If %>

			</td>
		</tr>
		<tr height=30> 
			<th class="head_Gray_LB"> Ȯ�� ��й�ȣ </th>
			<td class="list_LBR_left"> <input type="text" name="exact_passwd" size='20' maxlength='20' class='txtbox'> 
				<span class='red'> ������ Ȯ�ν� �Է��ؾ��� ��й�ȣ���ϴ�. (�Է����� ������ ��й�ȣ ���� Ȯ�� �����մϴ�) </span>
			</td>
		</tr>

		<% If e_exact_idx<>"" Then %>
		<tr>
			<th class="head_Gray_LB"> �� ����Ʈ </td>
			<td class="list_LBR_left">
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>">
					<img src="/images/button/btn_excel.gif" align='absmiddle'></a>
			</td>
		</tr>
		<% End If %>
		<tr height=30> 
			<td colspan='2' class="list_LBR_left"> 
			<textarea cols="80" class="ckeditor" id="board_contents" name="board_contents" rows="10" style="background-color: yellow;"><%=e_contents%></textarea>
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
			<td align='center' colspan="2"> 
				<img src="/images/button/btn_regist.gif" onclick="fnc_board_regist('frm_board');" onmouseover="this.style.cursor='hand';"> 
			</td>
		</tr>
		</table>
		</form>	
		<!------------------ ���� ����  ------------------>					          
</div>	