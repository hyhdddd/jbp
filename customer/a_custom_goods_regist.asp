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
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"--> 
  <!--#include virtual="/include/asp/meta_config.asp"--> 
  <%
  g_goods_idx		= WORD_CHANGE(request("g_goods_idx"),20)
  page				= WORD_CHANGE(Request("page"),20)
  nowblock			= WORD_CHANGE(Request("nowblock"),20)
  s_link_txt		= WORD_CHANGE(Request("s_link_txt"),0)

  if ad_b_a_custom="N" then
	Alert_URL session_m_name &" ���� ����ǰ ���������� �����ϴ�. �����ڿ��� �����Ͻñ� �ٶ��ϴ�.","/main.asp"
	Response.end
  End if
		
  if g_goods_idx<>"" then
  	strSql = "select A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_option_idx, A.g_set, A.g_code_gaetong_idx, "
	strSql = strSql & " A.g_zipcode1, A.g_zipcode2, A.g_address, A.g_date_yuchi, A.g_service_no, A.g_article_cnt, A.g_code_combine,  "
	strSql = strsql & " A.g_bank_cd , A.g_bank_no, A.g_bank_name, F.black_type, A.g_cancel_date, A.g_writeday, "
	strSql = strSql & " A.g_sp_bank_code, A.g_sp_bank_acount, A.g_sp_bank_name, A.g_sp_bank_memo, A.g_sp_bank_jumin1, A.g_sp_bank_jumin2, A.g_code_service,  "
	strSql = strSql & " A.g_file1, A.g_file2, A.g_file3, A.g_file4, A.g_receipt_type, A.c_auth_chk, "
	strSql = strSql & " A.g_code_course_idx, A.g_sp_date_start, A.g_sp_name, A.g_sp_price, A.g_goods_ref, "
	strSql = strSql & " A.g_code_promise, A.g_yuchi_m_id, A.g_jupsu_m_id, A.g_trans_out_dealer, A.g_give_chk, "
	strSql = strSql & " A.g_sp_give_type, A.g_bank_jumin1, A.g_bank_jumin2, A.g_give_type, A.g_date_gaetong, "
	strSql = strSql & " A.g_card_cd, A.g_card_no , A.g_card_gigan, A.g_card_gigan1, A.g_card_name, A.g_card_jumin1, A.g_card_jumin2, "
	strSql = strSql & " A.g_sum_money_chk, A.g_sum_money_txt, A.g_code_area, A.g_code_document, "
	strSql = strSql & " A.g_date_gaetong_hope, A.g_date_gaetong_hope_time, A.g_sp_name_top, A.g_sp_price_top, "

	strSql = strSql & " A.g_move_tel1, A.g_move_name, A.g_move_jumin1, A.g_move_jumin2, A.g_move_date, "
	strSql = strSql & " A.g_move_tel2, A.g_move_company, A.g_move_memo,"

	strSql = strSql & " A.c_type, A.c_jumin1, A.c_jumin2, A.c_tel2, A.c_tel2_com, A.c_office_no, A.c_office_name, A.c_zipcode1, A.c_zipcode2, "
	strSql = strSql & " A.c_address, A.c_tel1, A.c_email, A.c_jumin_date, A.g_sp_date_end, m_dealer_code, "
	strSql = strSql & " B.bank_name, A.c_name as c_name , A.g_bigo , A.g_code_sale "
	strSql = strSql & "		from customer_goods A left outer join code_bank B ON A.g_bank_cd=B.board_idx "
	strSql = strSql & "			join emp_list D ON A.g_yuchi_m_id=D.m_id 	"
    strSql = strSql & "		left join customer_goods_black F on A.c_jumin1=F.black_jumin1 and  A.c_jumin2=F.black_jumin2 "

	strSql = strSql & "				where A.g_goods_idx="&g_goods_idx 	
  	set objRs=objCnn.Execute(strSql)
  		
  	if objRs.eof or objRs.bof then  	
  	Else
		g_goods_idx			= objRs("g_goods_idx")
		g_goods_ref			= objRs("g_goods_ref")
		g_article_idx1		= objRs("g_article_idx1")
		g_article_idx2		= objRs("g_article_idx2")
		g_option_idx		= objRs("g_option_idx")
		g_set				= objRs("g_set")				'��Ʈ����
		g_zipcode1			= objRs("g_zipcode1")
		g_zipcode2			= objRs("g_zipcode2")
		g_address			= objRs("g_address")
		g_date_yuchi		= objRs("g_date_yuchi")			'��ġ��

		g_date_yuchi_hour	= Hour(g_date_yuchi)
		g_date_yuchi_minute	= minute(g_date_yuchi)

		g_bank_cd			= objRs("g_bank_cd")
		g_bank_no			= objRs("g_bank_no")
		g_bank_name			= objRs("g_bank_name")
		bank_name			= objRs("g_bank_name")
		c_name				= objRs("c_name")

		g_sp_price			= objRs("g_sp_price")			'����ǰ �ݾ�
		g_sp_name			= objRs("g_sp_name")			'����ǰ �̸�
		g_sp_date_start		= objRs("g_sp_date_start")		'����ǰ ���޿�����
		g_sp_date_end		= objRs("g_sp_date_end")		'����ǰ ���޿Ϸ���
		g_sp_give_type		= objRs("g_sp_give_type")		'����ǰ ���޹��(A/��ü���� , B/�������� , C/�ΰ輾������
		g_file1				= objRs("g_file1")		
		g_file2				= objRs("g_file2")
		g_file3				= objRs("g_file3")
		g_file4				= objRs("g_file4")
		g_code_course_idx	= objRs("g_code_course_idx")	'�������
		g_code_promise		= objRs("g_code_promise")
		g_bigo				= objRs("g_bigo")
		g_code_sale			= objRs("g_code_sale")
		g_yuchi_m_id		= Trim(objRs("g_yuchi_m_id"))
		g_jupsu_m_id		= objRs("g_jupsu_m_id")			'������

		g_bank_jumin1		= objRs("g_bank_jumin1")		'��ü���� �ֹι�ȣ(����� �ٸ����)
		g_bank_jumin2		= objRs("g_bank_jumin2")		'��ü���� �ֹι�ȣ(����� �ٸ����)

		g_give_type			= objRs("g_give_type")			'��������
		g_give_chk			= objRs("g_give_chk")			'�������� - ����
		g_card_cd			= objRs("g_card_cd")			'ī���
		g_card_no			= objRs("g_card_no")			'ī���ȣ
		g_card_gigan		= objRs("g_card_gigan")			'ī�� ��ȿ�Ⱓ
		g_card_gigan1		= objRs("g_card_gigan1")		'ī�� ��ȿ�Ⱓ
		g_card_name			= objRs("g_card_name")			'ī�� ��ȿ�Ⱓ
		g_card_jumin1		= objRs("g_card_jumin1")		'ī�� ��ȿ�Ⱓ
		g_card_jumin2		= objRs("g_card_jumin2")		'ī�� ��ȿ�Ⱓ

		g_date_gaetong_hope	= objRs("g_date_gaetong_hope")	'���������
		g_date_gaetong_hope_time = objRs("g_date_gaetong_hope_time")
		g_service_no		= objRs("g_service_no")			'���Լ��񽺹�ȣ
		g_trans_out_dealer	= objRs("g_trans_out_dealer")	'�����
		g_date_gaetong		= objRs("g_date_gaetong")		'������
		g_code_gaetong_idx	= objRs("g_code_gaetong_idx")	'�������
		'������
		c_type				= objRs("c_type")
		c_jumin1			= objRs("c_jumin1")
		c_jumin2			= objRs("c_jumin2")
		c_tel2				= objRs("c_tel2")
		c_tel2_com			= objRs("c_tel2_com")
		c_office_no			= objRs("c_office_no")
		c_office_name		= objRs("c_office_name")

		c_zipcode1			= objRs("c_zipcode1")
		c_zipcode2			= objRs("c_zipcode2")
		c_address			= objRs("c_address")
		c_tel1				= objRs("c_tel1")
		c_email				= objRs("c_email")
		c_auth_chk			= objRs("c_auth_chk")
		c_jumin_date		= objRs("c_jumin_date")
		m_dealer_code		= objRs("m_dealer_code")

		g_receipt_type		= objRs("g_receipt_type")							'ȸ�ſ�û

		'����ǰ ��������
		g_sp_bank_code		= objRs("g_sp_bank_code")							'����ǰ ���� �����ڵ�
		g_sp_bank_acount	= objRs("g_sp_bank_acount")							'����ǰ ���� �������
		g_sp_bank_name		= objRs("g_sp_bank_name")							'����ǰ ���� ���࿹����
		g_sp_bank_memo		= objRs("g_sp_bank_memo")							'����ǰ ���� ����޸�
		g_sp_bank_jumin1	= objRs("g_sp_bank_jumin1")							'����ǰ ���� ����޸�
		g_sp_bank_jumin2	= objRs("g_sp_bank_jumin2")							'����ǰ ���� ����޸�

		g_code_service		= objRs("g_code_service")							'�ΰ�����
		g_cancel_date		= objRs("g_cancel_date")							'�ؾ�����
		g_article_cnt		= objRs("g_article_cnt")							'ȸ����
		g_writeday			= fnc_date_change(objRs("g_writeday"))

		g_sum_money_chk		= objRs("g_sum_money_chk")							'�ջ�û������
		g_sum_money_txt		= objRs("g_sum_money_txt")							'�ջ�û������
		g_code_area			= money_chk(objRs("g_code_area"))					'���� ����
		g_code_document		= objRs("g_code_document")							'�̺񼭷�

		g_move_tel1			= objRs("g_move_tel1")								'��ȣ�̵� �׸�
		g_move_name			= objRs("g_move_name")
		g_move_jumin1		= objRs("g_move_jumin1")
		g_move_jumin2		= objRs("g_move_jumin2")
		g_move_date			= objRs("g_move_date")
		g_move_tel2			= objRs("g_move_tel2")
		g_move_company		= objRs("g_move_company")
		g_move_memo			= objRs("g_move_memo")
  
  		g_sp_name_top		= objRs("g_sp_name_top")	
		g_sp_price_top		= objRs("g_sp_price_top")	
		g_code_combine		= objRs("g_code_combine")	

		If IsNull(g_code_document) Then g_code_document="" End if
		
		if len(g_file1)>0 then
			filepath1 = o_code &"/customer/"&left(g_file1, InstrRev(g_file1,"/"))  
  	    	filename1 = mid(g_file1, InstrRev(g_file1,"/")+1)  
  		end If
		if len(g_file2)>0 Then
			filepath2 = o_code &"/customer/"&left(g_file2, InstrRev(g_file2,"/"))  
  	    	filename2 = mid(g_file2, InstrRev(g_file2,"/")+1)  
  		end If
		if len(g_file3)>0 Then
			filepath3 = o_code &"/customer/"&left(g_file3, InstrRev(g_file3,"/"))  
  	    	filename3 = mid(g_file3, InstrRev(g_file3,"/")+1)  
  		end If
		if len(g_file4)>0 then
			filepath4 = o_code &"/customer/"&left(g_file4, InstrRev(g_file4,"/"))  
  	    	filename4 = mid(g_file4, InstrRev(g_file4,"/")+1)  
  		end If

		black_type			= objRs("black_type")

		If black_type="A" Or black_type="B" Or black_type="C" then
			c_name_color	= "style='color:Orange;font-weight:bold;'"
		Else
			c_name_color	= ""
		End If
		
		'�˶���� ����
		strSql = "update customer_goods_alarm set alarm_chk='O' where goods_idx="&g_goods_ref
		Set objRs = objcnn.Execute(strSql)

	end If
  Else

	yea = year(date)
	mon = month(date)
	dayy = day(date)

	if Cint(mon) < 10 Then mon = "0" & mon  end if
	if Cint(dayy) < 10 then	dayy = "0" & dayy  end if 
	g_date_yuchi = yea &"-"& mon &"-"& dayy

	g_receipt_type	= "A"					'ȸ�ſ�û �⺻(A:û�� , B:ȸ�ſ�û , C:�����Ϸ�
  end If

  %>
<!--#include virtual="/include/asp/customer_marking.asp"-->

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<Script type="text/JavaScript" src="/include/js/jquery-ui-1.10.3.custom.js"></script>
<SCRIPT language=JavaScript src="/include/js/common.js?v=20231109"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/custom_goods.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/emp_select.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/sale_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/promise_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/service_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/area_change.asp"></SCRIPT>
<SCRIPT language=JavaScript src="/include/js/js_combine.asp"></SCRIPT>

<% If https_chk="off" Then %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% Else %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<% End If %>

<script language="javascript">
<!--
	function custom_consult_reply(form_name)
	{
		var frm=eval("document.all."+form_name);

		if(frm.consult_bigo.value=="")
		{
			alert("������ �Է��� �ּ���!");
			frm.consult_bigo.focus();
			return;
		}

		if(frm.consult_type.value=="B")
		{
			ans=confirm("��ġ�ڿ��� ȸ�ſ�û �Ͻðڽ��ϱ�?");
			if (ans==false)
			{
				return;
			}
		}


		if(frm.consult_type.value=="J")
		{
			if(frm.g_receipt_type_chk.value!="I")
			{
				alert("�Ϻ������� ��ο�û�� ��쿡�� ��δ亯�� �Ͻ� �� �ֽ��ϴ�.");
				frm.consult_type.focus();
				return;
			}
			else
			{
				ans=confirm("�Ϻ��� ��û���׿� �亯�� �Ͻðڽ��ϱ�?");
				if (ans==false)
				{
					return;
				}	
			}
		}

		frm.action="a_custom_goods_consult_ok.asp";
		frm.submit();
	}

	function reply_del_ok(url)
	{
		ans=confirm("�̷±��� �����Ͻðڽ��ϱ�?");
		if(ans==true)
		{
			location.replace(url);
		}
	}

	function trans_custom(form_name,dealer_code)
	{
		var frm		= eval("document.all."+form_name);
		
		g_goods_idx	= frm.g_goods_idx.value;

		var dealer_cd = eval("document.all."+form_name+"."+dealer_code); 
		
		if(dealer_cd.value=="0")
		{
			alert("������� ������ �ּ���!");
			return;
		}

		a_url = "a_custom_goods_trans.asp?g_goods_idx="+g_goods_idx+"&dealer_code="+dealer_cd.value;

		aa = NewWindow(a_url,'custom_trans',1000,700,'yes');

	}
	function trans_custom1(form_name,dealer_code)
	{
		var frm		= eval("document.all."+form_name);
		
		g_goods_idx	= frm.g_goods_idx.value;

		var dealer_cd = eval("document.all."+form_name+"."+dealer_code); 
		
		if(dealer_cd.value=="0")
		{
			alert("������� ������ �ּ���!");
			return;
		}

		a_url = "a_custom_goods_login.asp?dealer_code="+dealer_cd.value;

		aa = window.open(a_url,'_new');

	}
	
	function file_del_ok(url)
	{
		ans=confirm("������ �����Ͻðڽ��ϱ�?");
		if(ans==true)
		{
			location.replace(url);
		}
	}

-->
</script>
<script language="Javascript">
window.onload	= function()
{
	style_view_chk('frm_custom_regist','A');
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
			<li class="txt">��ü ������</li>
		</ul>
		</div>


		<form id="frm_custom_regist" name="frm_custom_regist" action="a_custom_goods_regist_ok.asp" ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST"> 
		<input type="hidden" name="g_goods_idx" value="<%=g_goods_idx%>">
		<input type="hidden" name="g_jupsu_m_id" value="<%=g_jupsu_m_id%>">
		<input type="hidden" name="page" value="<%=page%>">
		<input type="hidden" name="nowblock" value="<%=nowblock%>">
		<input type="hidden" name="s_link_txt" value="<%=s_link_txt%>">
		<input type="hidden" name="g_receipt_type_chk" value="<%=g_receipt_type%>">


		<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table3">
		<tr height="30">
			<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;������ </td>
		</tr>
		<Tr>
			<th width="130"> �� �� �� </th>
			<td width="370">
				<input type="text" name="c_name" size="15" class="txtbox" value="<%=c_name%>" maxlength=20 OnKeyUp="EnterNextFocus('frm_custom_regist','c_jumin1');">
				&nbsp;

				<%
				if black_type="A" Then
					Response.write "<b><span class='red'>�� ���� ��</span></b>"
				Elseif black_type="B" Then
					Response.write "<b><span class='red'>�� ��� ��</span></b>"
				ElseIf black_type="C" Then
					Response.write "<b><span class='red'>�� �ҷ� ��</span></b>"
				End If
				%>

			</td>			
			<th width="130"> �� �� </th>
			<td width="370"> 
				<input type="radio" name="c_type" value="C" style="border-style:none;" <% if c_type="C" then %> checked <% end if %>>���� 
				<input type="radio" name="c_type" value="O" style="border-style:none;" <% if c_type="O" then %> checked <% end if %>>����� 
				<input type="radio" name="c_type" value="F" style="border-style:none;" <% if c_type="F" then %> checked <% end if %>>�ܱ��� </td>
		</tr>
		<tr>
			<th> �ֹι�ȣ </th>
			<td> 
				<input type="text" name="c_jumin1" class="txtbox" value="<%=c_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_jumin2'); fncNextFocus(this,6,'frm_custom_regist','c_jumin2');">-<input type="text" name="c_jumin2" class="txtbox" value="<%=c_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_office_no'); fncNextFocus(this,7,'frm_custom_regist','c_office_no');">
				
				<span title="Ŭ���Ͻø� �ֹι�ȣ�� ����˴ϴ�." onclick="copy_clipboard('<%=c_jumin1%><%=c_jumin2%>');"><img src="/images/button/btn_copy.gif" align='absmiddle' onmouseover="this.style.cursor='hand';"></span>
				
				<img src="/images/button/btn_black_chk.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="black_search('frm_custom_regist');">
			</td>
						
			<th> ����ڹ�ȣ</th>
			<td>
				<input type="text" name="c_office_no" class="txtbox" value="<%=c_office_no%>" size="20" maxlength="20"	style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','c_tel1'); fncNextFocus(this,10,'frm_custom_regist','c_tel1');" >
				&nbsp;&nbsp;
				��ǥ��
				<input type="text" name="c_office_name" class="txtbox" value="<%=c_office_name%>" size="15" maxlength="15" ></td>
		</tr>				
		<tr>
			<th> �ּ� </th>
			<td colspan="3">
				<input type="text" id="c_zipcode1" name="c_zipcode1" class="txtbox" value="<%=c_zipcode1%>" size="6" maxlength="6" OnKeyPress="onlyNumber()"  style="ime-mode:disabled;" readonly>
				<input type="text" id="c_address" name="c_address" class="txtbox" value="<%=c_address%>"  size="80" maxlength="80"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('c_zipcode1','c_address');">
			</td>
		</tr>	
		<tr>
			<th> ��ȭ </th>
			<Td> 
				<input type="text" name="c_tel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','c_tel2');">&nbsp
				<font color="blue">* 02-000-0000 </font>
			</td>				
			<th> �ڵ��� </th>
			<Td> 
				<input type="text" name="c_tel2" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=c_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','c_email');">
				
				
				<select name="c_tel2_com" class='txtbox'>
				<option value="">::��Ż�:: </option>
				<option value="SK" <% If c_tel2_com="SK" Then %> selected <% End If %>>SK</option>
				<option value="LG" <% If c_tel2_com="LG" Then %> selected <% End If %>>LG </option>
				<option value="KT" <% If c_tel2_com="KT" Then %> selected <% End If %>>KT</option>
				<option value="SK�˶���" <% If c_tel2_com="SK�˶���" Then %> selected <% End If %>>SK�˶���</option>
				<option value="LG�˶���" <% If c_tel2_com="LG�˶���" Then %> selected <% End If %>>KT�˶���</option>
				<option value="KT�˶���" <% If c_tel2_com="KT�˶���" Then %> selected <% End If %>>LG�˶���</option>
				</select>

				<img src="/images/button/btn_black_chk.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="black_search_tel('frm_custom_regist','c_tel2');">

			</td>
		</tr>	
		<tr>						
			<th> �̸��� </th>
			<Td> 
				<input type="text" name="c_email" class="txtbox" size="30" style="ime-mode:disabled;" value="<%=c_email%>" OnKeyUp="EnterNextFocus('frm_custom_regist','c_email');">
			</td>
		<th>  </th>
			<td> </td>
		</tr>
		<tr>
			<th> </th>
			<td>
				</td>
			<td class='con9'> ����� </td>
			<td>
				<select name="g_trans_out_dealer" class="txtbox" style="width:150px;">
				<option value="0">:: ȸ�� ����::</option> 
				<% 
				strSql = " select dealer_code, dealer_name from dealer_info "
				strSql = strSql & " where ((dealer_ingea='Y' and dealer_view='Y') or dealer_code='"&g_trans_out_dealer&"' ) order by dealer_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					dealer_code=objRs(0)
					dealer_name=objRs(1)
				%>                      	
				<option value="<%=dealer_code%>" <% if dealer_code=g_trans_out_dealer then %> selected <% end if %>><%=dealer_name%></option>
				<%
					objRs.movenext
				Loop
				%>
				</select>
				<img src="/images/button/btn_ingea_trans.gif" onmouseover="this.style.cursor='hand';" onclick="trans_custom('frm_custom_regist','g_trans_out_dealer');">
				&nbsp;
				<img src="/images/button/btn_ingea_login.gif" onmouseover="this.style.cursor='hand';" onclick="trans_custom1('frm_custom_regist','g_trans_out_dealer');">
			</td>				
		</tr>	
		<tr>
			<td class='con9'> �� ġ ��  </td>
			<td>
				<select name="dealer_code" class="txtbox" style="width:130px;" onchange="change_emp_select(this,'frm_custom_regist',this.selectedIndex);">
				<option value="0">:: ȸ�� ����::</option>                  												
				<% 
				strSql = " select dealer_code, dealer_name from dealer_info "
				strSql = strSql & " where ((dealer_insu='Y' and dealer_view='Y') or dealer_code='"&m_dealer_code&"') order by dealer_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					dealer_code1=objRs(0)
					dealer_name=objRs(1)
				%>                      	
				<option value="<%=dealer_code1%>" <% if UCase(dealer_code1)=UCase(m_dealer_code) then %> selected <% end if %>><%=dealer_name%></option>
				<%
					objRs.movenext
				Loop
				%>
				</select>
				<select name="g_yuchi_m_id" class="txtbox" style="width:100px;">
				<option value="0">::��ġ��::</option>
				<% 
				strSql= " select m_id, m_name,m_status from emp_list where  m_dealer_code='"&m_dealer_code&"' and (m_id='"&g_yuchi_m_id&"' or m_status='O') order by m_name ASC"
				set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF
					m_id			= Trim(objRs("m_id"))
					m_name			= objRs("m_name")					
				%>
				<option value="<%=m_id%>" <% if UCase(g_yuchi_m_id)=UCase(m_id) then %> selected <% end if %>><%=m_name%></option>
				<%
					objRs.movenext
				Loop
				%>			
				</select>
			</td>
			<th> �湮 ������ </th>
			<td>
				<input type="text" class="txtbox" name="g_date_gaetong_hope" size='10' value="<%=g_date_gaetong_hope%>" readonly>
				<select name="g_date_gaetong_hope_time" class='txtbox'>
				<% For i=0 To 24 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>
						
				<option value="<%=ii%>" <% If g_date_gaetong_hope_time=CStr(ii) Then %> selected <% End If %>><%=ii%>�� </option>
				<% Next %>
				</select>
				<img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_date_gaetong_hope&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"></td>
		</tr>
		<tr height="30">
			<td colspan='4'>&nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ǰ���� </td>
		</tr>
		<Tr>
			<td class='con9'>���Լ��񽺹�ȣ</td>
			<td> 
				<input type="text" name="g_service_no" size="15" class="txtbox" value="<%=g_service_no%>">
				<span title="Ŭ���Ͻø� ���Լ��񽺹�ȣ�� ����˴ϴ�." onclick="copy_clipboard('<%=g_service_no%>');"><img src="/images/button/btn_copy.gif" align='absmiddle' onmouseover="this.style.cursor='hand';"></span>
				&nbsp;&nbsp;&nbsp;
				<input type="text" name="g_article_cnt" class="txtbox" value="<%=g_article_cnt%>" size="2" maxlength="2" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);"><span class='red'>ȸ��</font>
				</td>
			<th>������</th>
			<td>
				<input type="text" name="g_date_yuchi" class="txtbox" size='10' value="<%=Left(g_date_yuchi,10)%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_date_yuchi&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="g_date_yuchi_hour" class='txtbox'>
				<% For i=0 To 23 %>
					<% If i<10 Then 
						ii=i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If g_date_yuchi_hour=i Then %> selected <% End If %>><%=ii%>�� </option>
					<% Next %>
				</select>
				<select name="g_date_yuchi_minute" class='txtbox'>
				<% For i=0 To 59 %>
					<% If i<10 Then 
						ii="0"&i
						Else
						ii=i
						End if
					%>						
					<option value="<%=ii%>" <% If g_date_yuchi_minute=i Then %> selected <% End If %>><%=ii%>�� </option>
					<% Next %>
				</select>(<span class='red'>���:<%=g_writeday%></span>)
			</td>
		</tr>
		<Tr>
			<th>��ǰ����</th>
			<td>
				<select name="g_article_idx1" class="txtbox" style="width:100px;" onchange="article_change(this,'frm_custom_regist',this.selectedIndex,'R'); area_change(this,'frm_custom_regist',this.selectedIndex); fnc_combine_change(this,'frm_custom_regist',this.selectedIndex,'g_code_combine');">
				<option value="0" <% if g_article_idx1="0" then %> selected <% end if %>> ȸ�缱��           
				<% 
				strSql = " select * from code_article where article_step2=0  "
				strSql = strSql & " and (article_idx="&g_article_idx1&" or article_view='Y') "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else						 
				i = 1
				Do until objRs.EOF   	
					article_idx			= objRs("article_idx")
					article_name		= objRs("article_name")
				%>	
					<option value="<%=article_idx%>" <% if g_article_idx1=article_idx then %> selected <% end if %>><%=article_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				Loop
				End if
				%>	
				</select><select name="g_article_idx2" class="txtbox" style="width:120px;" onchange="option_change(this,'frm_custom_regist',this.selectedIndex,'R');sale_change(this,'frm_custom_regist',this.selectedIndex);service_change1(this,'frm_custom_regist',this.selectedIndex);promise_change1(this,'frm_custom_regist',this.selectedIndex);">
				<option value="0" <% if g_article_idx2="0" then %> selected <% end if %>> ��ǰ���� 
				<% 
				If g_article_idx2<>"" then
				strSql = " select * from code_article where article_step2>0 and article_step1="&g_article_idx1&" "
				strSql = strSql & " and (article_idx="&g_article_idx2&" or article_view='Y') "
				strSql = strSql & " order by article_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else							 
					i = 1
					Do until objRs.EOF   	
						article_idx		= objRs("article_idx")
						article_name	= objRs("article_name")
					%>	
						<option value="<%=article_idx%>" <% if g_article_idx2=article_idx then %> selected <% end if %>><%=article_name%></option>
					<% 
						objrs.MoveNext
						i=i+1 
					Loop
					End If
				End if
				%>	
				</select><select name="g_option_idx" class="txtbox" style="width:130px;">
				<option value="0" <% if g_option_idx="0" then %> selected <% end if %>> ��ǰ�ɼ� </option>
				<% 
				If g_option_idx<>""  then
				strSql = " select * from code_article_option where article_idx=" & g_article_idx2 & " "
				strSql = strSql & " order by option_order Asc"
				Set objRs=objCnn.Execute(strSql)							
				
				if objRs.BOF or objRs.EOF then
				else
			 
				i = 1
					Do until objRs.EOF   	
						option_idx			= objRs("option_idx")
						option_name			= objRs("option_name")
					%>	
						<option value="<%=option_idx%>" <% if g_option_idx=option_idx then %> selected <% end if %>><%=option_name%></option>
					<% 
						objRs.MoveNext
						i=i+1 
					Loop
				End If
				End if
				%>	
				</select></td>
			<th> ��Ʈ���� </th>
			<td>				
				<select name="g_set" class="txtbox" style="width:150px;">
				<option value="0" <% If g_set="0" Then %>selected <% End If %>> ��Ʈ ���� </option>
				<option value="A" <% If g_set="A" Then %>selected <% End If %>> �ܵ� </option>
				<option value="B" <% If g_set="B" Then %>selected <% End If %>> DPS  </option>
				<option value="C" <% If g_set="C" Then %>selected <% End If %>> TPS </option>
				</select>
			</td>
		</tr>			
		<Tr>
		
			<th>��ǰ����</th>
			<td>
				<select name="g_code_promise1" class="txtbox" style="width:150px;">
				<option value="0" <% if g_code_promise="0" then %> selected <% end if %>>��������           
				<% 
				If g_goods_idx<>"" Then	
				If g_code_promise="" Or IsNull(g_code_promise) Then g_code_promise=0 End if
				strSql = " select * from code_promise where (promise_view='Y' or promise_idx="&g_code_promise&") "
				strSql = strSql & "  and article_idx="&g_article_idx2&""
				strSql = strSql & " order by promise_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else
					 
				i = 1
				Do until objRs.EOF   	
					promise_idx			= objRs("promise_idx")
					promise_name		= objRs("promise_name")
				%>	
					<option value="<%=promise_idx%>" <% if promise_idx=g_code_promise then %> selected <% end if %>><%=promise_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				Loop
				End If
				End if
				%>	
				</select>
				</td>
			<th>������</th>
			<td>
				<select name="g_code_sale" class="txtbox" style="width:150px;">
				<option value="0" <% if g_code_sale="0" then %> selected <% end if %>> ������ ����           
				<% 

				If g_goods_idx<>"" then
				strSql = " select * from code_sale where (sale_view='Y' or sale_idx='"&g_code_sale&"') and article_idx="&g_article_idx2&" "
				strSql = strSql & " order by sale_order Asc"
				'Response.write strSql
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else
					 
				i = 1
					Do until objRs.EOF  
						sale_idx		= objRs("sale_idx")
						sale_name		= objRs("sale_name")
						sale_view		= objRs("sale_view")
				%>	
					<option value="<%=sale_idx%>" <% if sale_idx=g_code_sale then %> selected <% end if %>><%=sale_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					Loop
				End If
				End If
				%>	
				</select></td>
		</tr>
		<tr>
			<th> �ΰ����� </th>
			<Td> 
				<select name="g_code_service1" class="txtbox" style="width:150px;">
				<option value="0" <% if g_code_service="0" then %> selected <% end if %>> �ΰ�����           
				<% 

				If g_goods_idx<>"" then
				strSql = " select * from code_service where (service_view='Y' or service_idx='"&g_code_service&"') and article_idx="&g_article_idx2&" "
				strSql = strSql & " order by service_order Asc"
				'Response.write strSql
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else
					 
				i = 1
					Do until objRs.EOF  
						service_idx			= objRs("service_idx")
						service_name		= objRs("service_name")
						service_view		= objRs("service_view")
				%>	
					<option value="<%=service_idx%>" <% if service_idx=g_code_service then %> selected <% end if %>><%=service_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					Loop
				End If
				End If
				%>	
				</select>
			</td>
			<td class='con9'>��������</td>
			<td>
				<input type="text" name="g_date_gaetong" size='10' class="txtbox" value="<%=g_date_gaetong%>" readonly
				onblur="BlurColor(this);" 
				onFocus="FocusColor(this);this.select();"><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_date_gaetong&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="g_code_gaetong_idx" class="txtbox" >
					<option value=""> �������
					<% 
					strSql = " select gaetong_code, gaetong_name from code_gaetong order by gaetong_order Asc"
					Set objRs=objCnn.Execute(strSql)

					if objRs.BOF or objRs.EOF then
					else
						 
					i = 1
						Do until objRs.EOF   	
							gaetong_code		= objRs("gaetong_code")
							gaetong_name		= objRs("gaetong_name")
					%>	
						<option value="<%=gaetong_code%>" <% if gaetong_code=g_code_gaetong_idx then %> selected <% end if %>><%=gaetong_name%></option>
					<% 
							objrs.MoveNext
							i=i+1 
						Loop
					End if
					%>	
				</select>
				<span onclick="sms_trans('document.all.frm_custom_regist ','/sms/sms_single_regist.asp?c_name=<%=c_name%>&g_yuchi_m_id=<%=g_yuchi_m_id%>&g_article_idx1=<%=g_article_idx1%>&g_article_idx2=<%=g_article_idx2%>');"  onmouseover="this.style.cursor='hand';">
				<img src="/images/button/btn_sms.gif" align="absmiddle" border=0></span>

				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('SMS���� - ��ġ�ڿ��� ������ ������ ���ڸ޼����� ������ �� �ִ� ����Դϴ�.');">
			</td>	
		</tr>
		<tr>
			<th> ���� ���� </th>
			<td>
				<select name="g_code_area" class="txtbox" style="width:150px;">
				<option value="0" selected> ::���� ����:: </option>
				<%
				strSql = " select area_idx, area_name from code_area where "
				strSql = strSql & " (area_view='Y' or area_idx="&g_code_area&") and article_idx="&g_article_idx1&"  "
				strSql = strSql & " order by area_order Asc"
				Set objRs=objCnn.Execute(strSql)

				if objRs.BOF or objRs.EOF then
				else
					i = 1
					Do until objRs.EOF  
						area_idx		= objRs("area_idx")
						area_name		= objRs("area_name")
				%>	
				<option value="<%=area_idx%>" <% if CInt(area_idx)=CInt(g_code_area) then %> selected <% end if %>><%=area_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					Loop
				End If
				%>
				</select>
			</td>
			<th>�ؾ����� </th>
			<td>
				<input type="text" name="g_cancel_date" size='10' class="txtbox" value="<%=g_cancel_date%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_cancel_date&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
			</td>
		</tr>
		<tr>
			<th> ���� </th>
			<td>
				<select name="g_code_combine" class="txtbox" style="width:150px;">
				<option value="0" <% If g_code_combine=0 Then %> selected <% End If %>> ::���ռ���:: </option>
				<%
				strSql = " select * from code_combine where (article1_idx="& money_chk(g_article_idx1) &") and (combine_idx="& money_chk(g_code_combine) &" or combine_view='Y') order by combine_order Asc"
				Set objRs=objCnn.Execute(strSql)

				Do until objRs.EOF  
					combine_idx			= objRs("combine_idx")
					combine_name		= objRs("combine_name")
				%>	
				<option value="<%=combine_idx%>" <% if combine_idx=money_chk(g_code_combine) then %> selected <% end if %>><%=combine_name%></option>
				<% 
					objrs.MoveNext
				Loop
				%>
				</select>
			</td>
			<th> </th>
			<td></td>
		</tr>


		<tr>
			<th> ��ġ ��� </th>
			<td colspan='3'>
				<input type="text" id="g_zipcode1" name="g_zipcode1" class="txtbox" value="<%=g_zipcode1%>" size="6" maxlength="6" readonly>
				<input type="text" id="g_address" name="g_address" class="txtbox"  value="<%=g_address%>"  size="80" maxlength="80" OnKeyDown="enter_chk('c_tel1');"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('g_zipcode1','g_address');"></td>
		</tr>	
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;��ȣ�̵� </td>
		</tr>
		<tr>
			<th> ��ȭ ��ȣ </th>
			<td> <input type="text" name="g_move_tel1" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=g_move_tel1%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
			<th> �� �� �� </th>
			<td> <input type="text" name="g_move_name" class="txtbox" size="20" maxlength='20' value="<%=g_move_name%>"></td>
		</tr>
		<tr>
			<th> �ֹ� ��ȣ</th>
			<td> 
				<input type="text" name="g_move_jumin1" class="txtbox" value="<%=g_move_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_move_jumin2'); fncNextFocus(this,6,'frm_custom_regist','g_move_jumin2');">-<input type="text" name="g_move_jumin2" class="txtbox" value="<%=g_move_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);"></td>
			<th> �� �� ó</th>
			<td> 
				<input type="text" name="g_move_tel2" class="txtbox" size="20" style="ime-mode:disabled;" value="<%=g_move_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');"></td>
		</tr>
		<tr>
			<th> �߱� ����</th>
			<td>
				<input type="text" name="g_move_date" class="txtbox" size="40" maxlength='40' value="<%=g_move_date%>">
			</td>
			<th> ���� ��Ż� </th>
			<td>
				<select name="g_move_company" class="txtbox" style="width:130px;">
				<option value="">:: ���� :: </option>
				<option value="SK" <% If g_move_company="SK" Then %> selected <% End If %>>SK</option>
				<option value="LG" <% If g_move_company="LG" Then %> selected <% End If %>>LG </option>
				<option value="KT" <% If g_move_company="KT" Then %> selected <% End If %>>KT</option>
				</select>

				�޸�<input type="text" name="g_move_memo" class="txtbox" size="30" maxlength='30' value="<%=g_move_memo%>">
			</td>
		</tr>
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;�̺� ���� ���� <span class='red'>(�������� �׸�)</span> &nbsp;&nbsp;
			<span class='red'>* �̺񼭷��� ���ؼ��� üũ�� �ּ���! </span>
			</td>
		</tr>
		<tr> 
			<th> �̺� ���� </th>
			<td colspan='3'>
			<%
				g_code_document1	= Split(g_code_document,",")
				
				strSql = "select * from code_document where article_idx="&g_article_idx1&" and document_view='Y' "
				strSql = strSql & " order by document_order asc "
				Set objRs1=objCnn.Execute(strSql)

				Do Until objRs1.eof
					document_idx		= objRs1("document_idx")
					document_name		= objRs1("document_name")
					document_chk		= ""
					For i=0 To UBound(g_code_document1)
						If CStr(document_idx)=Trim(g_code_document1(i)) Then
							document_chk = "checked "						
						End if
					Next
			%>
					<input type="checkbox" name="g_code_document" value="<%=document_idx%>" <%=document_chk%>><%=document_name%> &nbsp;&nbsp;
			<%
					objRs1.movenext
				loop
			%>
			</td>
		</tr>
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;���� ����</td>
		</tr>
		<tr>						
			<th> ���� ���� </th>
			<Td> 
				<input type="radio" name="g_give_type" value="A" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="A" Or g_give_type="" Then %> checked <% End If %> >������ü&nbsp;
				<input type="radio" name="g_give_type" value="B" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="B" Then %> checked <% End If %>>ī�峳��&nbsp;
				<input type="radio" name="g_give_type" value="C" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="C" Then %> checked <% End If %>>���γ���&nbsp;
				<input type="radio" name="g_give_type" value="D" onclick="style_view_chk('frm_custom_regist','A');" <% If g_give_type="D" Then %> checked <% End If %>>�ջ�û��
			</td>
			<th> ���� ����</th>
			<td>				
				<input type="radio" name="g_give_chk" value="A" <% If g_give_chk="A" Or IsNull(g_give_chk) Or g_give_chk="" Then %> checked <% End if %>>����&nbsp;&nbsp;
				<input type="radio" name="g_give_chk" value="B" <% If g_give_chk="B" Then %> checked <% End if %>>�����&nbsp;&nbsp;
				<input type="radio" name="g_give_chk" value="C" <% If g_give_chk="C" Then %> checked <% End if %>>����&nbsp;&nbsp;
			</td>
		</tr>	
		<tr id="style_view_15">
			<th> �ջ� û�� </th>
			<td>
				<input type="radio" name="g_sum_money_chk" value="A" <% If g_sum_money_chk="A" Then %> checked <% End If %>> ��ȭ�� �ջ�&nbsp;&nbsp;
				<input type="radio" name="g_sum_money_chk" value="B" <% If g_sum_money_chk="B" Then %> checked <% End If %>> ���ͳ� �ջ�&nbsp;&nbsp;				
			</td>
			<th> �ջ� ���</th>
			<td> <input type="text" name="g_sum_money_txt" class="txtbox" value="<%=g_sum_money_txt%>" size="20" maxlength="20" onKeyUp="EnterNextFocus('frm_custom_regist','dealer_code');"> </td>
		</tr>
		<tr id="style_view_01"> 
			<th>��������</th>
			<td>  
				<select name="g_bank_cd" class="txtbox" style="width:120px;">
				<option value="0" <% if g_bank_cd="0" then %> selected <% end if %>> ���� ���� 
				<%
			 
				strSql = " select * from code_bank order by bank_name Asc"
				Set objRs=objCnn.Execute(strSql)
				
				if objRs.BOF or objRs.EOF then
				else
					 
				i = 1
				Do until objRs.EOF   	
					bank_idx			= objRs("board_idx")
					bank_name			= objRs("bank_name")
				%>	
					<option value="<%=bank_idx%>" <% If g_bank_cd=bank_idx Then %> selected <% End If %>><%=bank_name%></option>
				<% 
					objrs.MoveNext
					i=i+1 
				loop	
			   objRs.close
			   end if					
				%> 
				</select>
				���¹�ȣ <input type="text" name="g_bank_no" class="txtbox" value="<%=g_bank_no%>" size="25" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','g_bank_name');" onBlur="BlurColor(this)"></td>
			<th> �� �� �� </th>
			<td>
				<input type="text" name="g_bank_name" class="txtbox" value="<%=g_bank_name%>"  size="10"  onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_name');">
				&nbsp;&nbsp;&nbsp;
				�ֹι�ȣ<input type="text" name="g_bank_jumin1" class="txtbox" value="<%=g_bank_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_bank_jumin2'); fncNextFocus(this,6,'frm_custom_regist','g_bank_jumin2');">-<input type="text" name="g_bank_jumin2" class="txtbox" value="<%=g_bank_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">
				
				</td>
		</tr>
		<tr id="style_view_02"> 
			<th>ī������</th>
			<td>
				<select name="g_card_cd" class="txtbox" style="width:100px;">
					<option value="0" <% if g_card_cd="0" Or g_card_cd="" then %> selected <% end if %>> ī��� 
				<%
				 
					strSql = " select * from code_card order by card_name Asc"
					Set objRs=objCnn.Execute(strSql)
					
					if objRs.BOF or objRs.EOF then
					else
						 
					i = 1
					Do until objRs.EOF   	
						card_board_idx		= objRs("board_idx")
						card_name			= objRs("card_name")
				%>	
						<option value="<%=card_board_idx%>" <% If g_card_cd=card_board_idx Then %> selected <% End If %>><%=card_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					loop	
				   objRs.close
				   end if					
				%> 
				</select>
				ī���ȣ <input type="text" name="g_card_no" class="txtbox" value="<%=g_card_no%>" size="30" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); fncReplaceCheck(this,'/'); EnterNextFocus('frm_custom_regist','g_card_gigan');" onBlur="BlurColor(this)"></td>
			<th> ��ȿ�Ⱓ </th>
			<td>
				<input type="text" name="g_card_gigan" class="txtbox" value="<%=g_card_gigan%>"  size="4" maxlength="4"
				onBlur="BlurColor(this)">��&nbsp;
				<input type="text" name="g_card_gigan1" class="txtbox" value="<%=g_card_gigan1%>"  size="2" maxlength="2"
				onBlur="BlurColor(this)">��&nbsp;
				</td>
		</tr> 
		<tr  id="style_view_09"> 
			<th>ī���� ��</th>
			<td>
				<input type="text" name="g_card_name" class="txtbox" value="<%=g_card_name%>" size="15" maxlength="15" onBlur="BlurColor(this)"></td>
			<th> �ֹι�ȣ </th>
			<td>
				<input type="text" name="g_card_jumin1" class="txtbox" value="<%=g_card_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);fncNextFocus(this,6,'frm_custom_regist','g_card_jumin2');">-<input type="text" name="g_card_jumin2" class="txtbox" value="<%=g_card_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">&nbsp;(���� �ٸ� ���)</td>
		</tr> 
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;�������ǰ ����</td>
		</tr>
		<tr>
			<th>���� ����ǰ</th>
			<td> 
				<input type="text" class="txtbox" name="g_sp_name_top" value="<%=g_sp_name_top%>" size="30" maxlength="40" >
			<th>�������ǰ �ݾ� </th>
			<td>
				<input type="text" class="txtbox" name="g_sp_price_top" value="<%=g_sp_price_top%>" size="10" maxlength="6" OnKeyUp="fncOnlyNumber(this);" style="ime-mode:disabled" id="g_sp_price_top" onclick="select_price(this.id)">�� 
			</td>
		</tr>
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;����ǰ ����</td>
		</tr>
		<tr> 
			<th>����ǰ ��</th>
			<td>
				<input type="text" class="txtbox" name="g_sp_name" value="<%=g_sp_name%>" size="30" maxlength="30" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_price');"></td>
			<th> ����ǰ �ݾ� </th>
			<td>
				<input type="text" class="txtbox" name="g_sp_price" value="<%=g_sp_price%>" size="10" maxlength="10"OnKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_sp_date_start'); " style="ime-mode:disabled"  id="g_sp_price" onclick="select_price(this.id)">�� &nbsp;
			</td>
		</tr>
		<tr>
			<th> ���޿����� </th>
			<td>
				<input type="text" class="txtbox" name="g_sp_date_start" size='10' value="<%=g_sp_date_start%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_start&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';"></td>
			<th> ���޿Ϸ��� </th>
			<td>
				<input type="text" class="txtbox" name="g_sp_date_end" size='10' value="<%=g_sp_date_end%>" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=g_sp_date_end&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
				<select name="g_sp_give_type" class="txtbox" style="background-color:#fdd9d9;">
				<option value="" <% If g_sp_give_type="" Then %> selected <% End If %>> ������ ���� </option>
				<option value="B" <% If g_sp_give_type="B" Then %> selected <% End If %>> ���� ���� </option>
				<option value="G" <% If g_sp_give_type="G" Then %> selected <% End If %>> ������ </option>


				<!--
				<option value="E" <% If g_sp_give_type="E" Then %> selected <% End If %>> ����ǰ ���� </option>
				<option value="A" <% If g_sp_give_type="A" Then %> selected <% End If %>> ��ġ�� ���� </option>
				<option value="C" <% If g_sp_give_type="C" Then %> selected <% End If %>> ������ ������� </option>
				<option value="F" <% If g_sp_give_type="F" Then %> selected <% End If %>> �����ǰ�� + ���� </option>
				-->
				</select></td>
		</tr>
		<tr> 
			<th>����ǰ����</th>
			<td>
				<select name="g_sp_bank_code" class="txtbox" style="width:120px;">
					<option value="0" <% if g_sp_bank_code="0" then %> selected <% end if %>> �������� 
				<%
				 
					strSql = " select * from code_bank order by bank_name Asc"
					Set objRs=objCnn.Execute(strSql)
					
					if objRs.BOF or objRs.EOF then
					else
						 
					i = 1
					Do until objRs.EOF   	
						bank_board_idx		= objRs("board_idx")
						bank_name			= objRs("bank_name")
				%>	
						<option value="<%=bank_board_idx%>" <% If g_sp_bank_code=bank_board_idx Then %> selected <% End If %>><%=bank_name%></option>
				<% 
						objrs.MoveNext
						i=i+1 
					loop	
				   objRs.close
				   end if					
				%> 
				</select>
				���¹�ȣ <input type="text" name="g_sp_bank_acount" class="txtbox" value="<%=g_sp_bank_acount%>" size="25" maxlength="30"  style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_custom_regist','g_sp_bank_name');" onBlur="BlurColor(this)"></td>
			<th> �� �� �� </th>
			<td>
				<input type="text" name="g_sp_bank_name" class="txtbox" value="<%=g_sp_bank_name%>"  size="10" maxlength=10
				onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_custom_regist','g_sp_bank_jumin1');"
				onFocus="FocusColor(this);this.select();">&nbsp;
				�ֹι�ȣ<input type="text" name="g_sp_bank_jumin1" class="txtbox" value="<%=g_sp_bank_jumin1%>" size="6" maxlength="6" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this); EnterNextFocus('frm_custom_regist','g_sp_bank_jumin2'); fncNextFocus(this,6,'frm_custom_regist','g_sp_bank_jumin2');">-<input type="text" name="g_sp_bank_jumin2" class="txtbox" value="<%=g_sp_bank_jumin2%>" size="7" maxlength="7" style="ime-mode:disabled;" onKeyUp="fncOnlyNumber(this);">&nbsp;
				�޸�:<input type="text" name="g_sp_bank_memo" class="txtbox" value="<%=g_sp_bank_memo%>" size="15" maxlength="20"></td>
		</tr> 
		<tr height="30">
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;÷�� ���� </td>
		</tr>
		<tr height="30"> 
			<th>÷�� ����1</th>
			<td> 
				<input type="file" name="g_file1" size="30" class="txtbox" onBlur="BlurColor(this)">
				<% If Len(g_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename1%>&fpath=<%=filepath1%>"><%=filename1%></a>
					<% If ad_b_a_custom="A" Then %>
					<span onclick="file_del_ok('a_custom_goods_file_del.asp?g_goods_idx=<%=g_goods_idx%>&file_chk=g_file1');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
					<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
					</span>	
					<% End If %>
				<% End If %>
			</td>
			<th> ÷�� ����2 </th>
			<td> 
				<input type="file" name="g_file2" size="30" class="txtbox" onBlur="BlurColor(this)"onFocus="FocusColor(this);this.select();">
				<% If Len(g_file2)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename2%>&fpath=<%=filepath2%>"><%=filename2%></a>
					<% If ad_b_a_custom="A" Then %>
					<span onclick="file_del_ok('a_custom_goods_file_del.asp?g_goods_idx=<%=g_goods_idx%>&file_chk=g_file2');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
					<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
					</span>	
					<% End If %>

				<% End If %>
			</td>
		</tr>
		<tr height='30'>
			<th> ÷�� ����3 </th>
			<td> 
				<input type="file" name="g_file3" size="30" class="txtbox" onBlur="BlurColor(this)">
				<% If Len(g_file3)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename3%>&fpath=<%=filepath3%>"><%=filename3%></a>
					<% If ad_b_a_custom="A" Then %>
					<span onclick="file_del_ok('a_custom_goods_file_del.asp?g_goods_idx=<%=g_goods_idx%>&file_chk=g_file3');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
					<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
					</span>	
					<% End If %>

				<% End If %>
			</td>
			<th> ÷�� ����4 </th>
			<td> 
				<input type="file" name="g_file4" size="30" class="txtbox" onBlur="BlurColor(this)" 
			onFocus="FocusColor(this);this.select();">
				<% If Len(g_file4)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=filename4%>&fpath=<%=filepath4%>"><%=filename4%></a>
					<% If ad_b_a_custom="A" Then %>
					<span onclick="file_del_ok('a_custom_goods_file_del.asp?g_goods_idx=<%=g_goods_idx%>&file_chk=g_file4');" onmouseover="this.style.cursor='hand';">&nbsp;&nbsp;
					<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
					</span>	
					<% End If %>

			<% End If %>
			</td>
		</tr>
		<tr> 
			<th>��Ÿ ����</th>
			<td colspan='3'>
				<textarea name="g_bigo" class="txtbox" style="width:99%;height:150px;"><%=g_bigo%></textarea>
			</td>
		</tr>
		<tr height='30'>
			<td colspan='4'> &nbsp;&nbsp;&nbsp;<img src="/images/button/btn_arrow.gif">&nbsp;&nbsp;���� ��ǰ ���</td>
		</tr>
		<tr height='30'>
			<td colspan='4' align='center'>

				<TABLE width="99%" border=0 cellspacing=0 cellpadding=0 id="board_table2">
					<tr height="30">
					<th class="head">����</th>  
					<th class="head">����.��ȣ</th>  
					<th class="head">��Ż�</th>  
					<th class="head">��ǰ��</th>  
					<th class="head">�ɼ�</th>
					<th class="head">������</th>        
					<th class="head">�������</th>  
					<th class="head">����</th>
					<th class="head">������</th>
					<th class="head">�ΰ�����</th>
					<Th class="head">����ǰ</th>
					<Th class="head">�ݾ�</td>
					<Th class="head">����ó</th>
				</tr>
  <%
  If g_goods_ref="" Or IsNull(g_goods_ref) Then
	g_goods_ref=0
  End If
  
  strSql = " select  A.g_goods_idx, A.g_article_idx1, A.g_article_idx2, A.g_service_no,  "
  strSql = strSql & " A.g_date_gaetong, A.g_sp_name, A.g_sp_price, A.g_set, "
  strSql = strSql & " C.article_name as article_name1 , D.article_name as article_name2, A.g_sp_give_type, "
  strSql = strSql & " E.gaetong_name, E.gaetong_color, A.c_name, G.promise_name, H.sale_name, "
  strSql = strSql & " O.service_name, K.option_name "
  strSql = strSql & "		from customer_goods A left outer  "
  strSql = strSql & "		     join code_article C on A.g_article_idx1=C.article_idx"
  strSql = strSql & "		left join code_article D on A.g_article_idx2=D.article_idx"
  strSql = strSql & "		left join code_gaetong E on A.g_code_gaetong_idx=E.gaetong_code"
  strSql = strSql & "		left join code_promise G on A.g_code_promise=G.promise_idx"
  strSql = strSql & "		left join code_sale H on  A.g_code_sale=H.sale_idx"
  strSql = strSql & "		left join code_article_option K on A.g_option_idx=K.option_idx"
  strSql = strSql & "		left join code_service O ON  A.g_code_service=O.service_idx"
  strSql = strSql & "				where A.g_goods_ref="& g_goods_ref&" "
  Set objRs=objCnn.Execute(strSql)
  i=1
  Do Until objRs.eof
		l_g_goods_idx			= objRs("g_goods_idx")
		l_c_name				= objRs("c_name")
		l_article_name1			= objRs("article_name1")
		l_article_name2			= objRs("article_name2")
		l_option_name			= objRs("option_name")
		l_g_date_gaetong		= Left(objRs("g_date_gaetong"),10)
		l_gaetong_color			= objRs("gaetong_color")
		l_gaetong_name			= objRs("gaetong_name")
		l_promise_name			= objRs("promise_name")
		l_sale_name				= objRs("sale_name")
		l_service_name			= objRs("service_name")
		l_g_sp_give_type		= objRs("g_sp_give_type")
		l_g_sp_give_type_txt	= fnc_g_sp_give_type(l_g_sp_give_type,"A")
		l_g_sp_name				= objRs("g_sp_name")						'����ǰ ��
		l_g_sp_price			= money_chk(objRs("g_sp_price"))			'����ǰ �ݾ�
		l_g_sp_price_sum		= l_g_sp_price_sum + l_g_sp_price
		l_g_sp_price			= money_change(objRs("g_sp_price"))			'����ǰ �ݾ�
		l_g_service_no			= objRs("g_service_no")
		
		If i=1 then
			strSql_consult = " A.g_goods_idx="&l_g_goods_idx &" "
		Else
			strSql_consult = strSql_consult & " or A.g_goods_idx="&l_g_goods_idx &" "
		End if

  %>
				<tr height="30" style="font-size:11px;">
					<td class="con5"><b>
						<a href="a_custom_goods_regist.asp?g_goods_idx=<%=l_g_goods_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&s_link_txt=<%=Server.URLEncode(s_link_txt)%>"><span title="<%=c_name%>"><%=Left(c_name,10)%></span></a></b></td> 
					<td class="con4"><%=l_g_service_no%></td>        
					<td class="con2"><span title="<%=l_article_name1%>"><%=Left(l_article_name1,6)%></span></td>        
					<td class="con2"><span title="<%=l_article_name2%>"><%=Left(l_article_name2,6)%></span></td>       
					<td class="con2"><span title="<%=l_option_name%>"><%=Left(l_option_name,10)%></td>
					<td class="con4"><%=l_g_date_gaetong%></td>          
					<td class="con4"><b><span style='color:<%=l_gaetong_color%>' title="<%=l_gaetong_name%>">
						<%=Left(l_gaetong_name,4)%></span></b></td>          
					<td class="con4"><span title="<%=l_promise_name%>"><%=Left(l_promise_name,4)%></span></td>
					<td class="con4"><span title="<%=l_sale_name%>"><%=Left(l_sale_name,8)%></span></td>
					<td class="con4"><span title="<%=l_service_name%>"><%=Left(l_service_name,8)%></span></td>
					<td class="con2"><span title="<%=g_sp_name%>"><%=Left(l_g_sp_name,6)%></span></td>
					<td class="con4"><%=l_g_sp_price%></td>
					<td class="con4"><%=l_g_sp_give_type_txt%></td>
				</tr> 
  <%
	i=i+1
	objRs.movenext
  Loop
  %>
				<tr height='30'>
					<td class="con5" colspan='10'> &nbsp; </td>
					<td class="con4"> <b><span class='blue'> �� �� </span></b></td>
					<td class="con4"> <%=money_change(l_g_sp_price_sum)%> </td>
					<td class="con4"> &nbsp;</td>
					
				</tr>
				</table>
				<br>
			</td>
		</tr>
		</table>
		<div class="button">
			<a href="a_custom_goods_list.asp?g_goods_idx=<%=g_goods_idx%>&page=<%=page%>&nowblock=<%=nowblock%>&<%=s_link_txt%>"><img src="/images/button/btn_list.gif" border=0 align='absmiddle'></a>

			<% if ad_b_a_custom="E" or ad_b_a_custom="A" then %>
				<span onClick="send_custom_goods_regist('frm_custom_regist','A');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_save.gif"  border="0" align='absmiddle'></span>
			<% Else %>
				<a href ='javascript:alert("<%=session_m_name%> ���� ���� ������ �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif"  border="0" align='absmiddle' onmouseover="this.style.cursor='hand';"></a>
			<% End If %>

			
			<a href="a_custom_regist_top.asp?g_goods_idx_new=<%=g_goods_idx%>"><img src="/images/button/btn_custom_add.gif" align="absmiddle"></a>


			
			<span onclick="a_custom_print('<%=g_goods_idx%>');"><img src="/images/button/btn_custom_print.gif" border=0 align='absmiddle' onmouseover="this.style.cursor='hand';"></span>
		</div>

	<span id="spanRight" style="border-right: 1px solid #C7C7C7;width:1000px;height:180px;overflow-y:scroll;">

		<table width='100%' border=0 cellspacing="1" cellpadding="0">
		<tr>
			<Td valign='top' width='750'>
				<table width=100% border=0 cellspacing="1" cellpadding="0" id="board_table2">
				<tr height="30">
					<td colspan='7' class='con9' style='text-align:left;'>&nbsp;&nbsp; * �� �̷� </b></td>
				</tr>
				<tr>
					<td class='head' width='50'>����</td>
					<td class='head' width='60'>�ۼ���</td>
					<td class='head' width='350'>����</td>
					<td class='head' width='90'>��������</td>
					<td class='head' width='50'>����</td>
					<td class='head' width='90'>�ۼ���</td>
				</tr>
<%
  strSql = " select A.consult_idx, A.g_goods_idx, A.consult_type, A.consult_date, A.consult_bigo, A.consult_writeday, "
  strSql = strSql & " B.m_name as m_name, A.consult_m_id, A.consult_date_view "
  strSql = strSql & "		from customer_goods_consult A left outer "
  strSql = stRSql & "			join emp_list B ON A.consult_m_id=B.m_id "
  strSql = strSql & "				where (" & strSql_consult & ")"
  strSql = strSql & "						order by A.consult_idx desc "
  'Response.write strSQl
  Set objRs=objCnn.Execute(strSql)

  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
				<tr height='30'>
					<td class='con5' colspan='7'>��ϵ� �̷��� �������� �ʽ��ϴ�.</td>			
				</tr>		
  <%	
  else

	i = 1				
	Do until objRs.EOF 	
		consult_idx			= objRs("consult_idx")
		consult_type		= objRs("consult_type")
		consult_date		= objRs("consult_date")

		If Len(Minute(consult_date))=1 Then
			consult_date_minute = "0"&Minute(consult_date)
		Else
			consult_date_minute = Minute(consult_date)		
		End If
		
		If Len(Hour(consult_date))=1 Then
			consult_date_Hour = "0"&Hour(consult_date)
		Else
			consult_date_Hour = Hour(consult_date)		
		End If
		
		If consult_date<>"" then
			consult_date		= left(consult_date,10)&"&nbsp;"&consult_date_Hour&":"&consult_date_minute
		Else
			consult_date = ""
		End if

		m_name				= objRs("m_name")		
		consult_type_txt	= fnc_consult_txt(consult_type)
		consult_bigo		= objRs("consult_bigo")
		consult_writeday	= objRs("consult_writeday")
		consult_writeday	= left(consult_writeday,10)&"&nbsp;"&Hour(consult_writeday)&":"&Minute(consult_writeday)

		consult_m_id		= objRs("consult_m_id")
		consult_date_view	= objRs("consult_date_view")

		If consult_date_view="Y" Then
			consult_date_view_txt = "<span class='red'>����</span>"
			consult_date_img	  = "<img src='/images/button/btn_reply_view_change1.gif' border=0 align='absmiddle'>"
			
		Else
			consult_date_view_txt = "����"
			consult_date_img	  = "<img src='/images/button/btn_reply_view_change2.gif' border=0 align='absmiddle'>"
		End if

%>	
				<tr height="25">
					<td class='con5'><%=consult_type_txt%></td>
					<td class="con4"><%=m_name%></td>
					<td class='con2'><%=consult_bigo%>
						<% If session_m_step="M" Then %>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span title="�̷±� ����" onclick="reply_del_ok('a_custom_goods_consult_del.asp?consult_idx=<%=consult_idx%>&g_goods_idx=<%=g_goods_idx%>');" onmouseover="this.style.cursor='hand';">
							<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
						</span>
						<% End If %>
					</td>
					<td class="con4"><nobr><%=consult_date%></nobr></td>
					<td class="con4">
						<%'=consult_date_view_txt%>
						<% If LCase(consult_m_id)=LCase(session_m_id) Or session_m_step="M" Then %>
						<span onclick="consult_date_view_apply('a_custom_goods_consult_view.asp?consult_idx=<%=consult_idx%>&g_goods_idx=<%=g_goods_idx%>&consult_date_view=<%=consult_date_view%>');"  onmouseover="this.style.cursor='hand';"><%=consult_date_img%></span>
						<% Else %>
							<span onclick='javascript:alert("�ۼ��ڸ� ����ǥ�ø� ������ �� �ֽ��ϴ�.");'><%=consult_date_img%></span>
						<% End If %>

					</td>
					<td class="con4"><nobr><%=consult_writeday%></nobr></td>
				</tr>
	
  <% 
			objrs.MoveNext
			i=i+1 
		loop
		objRs.close
  End if			
	%>			
				</table>
			</td>
			<td width='250' valign='top'>
				<table width=100% border=0 cellspacing="1" cellpadding="0" id="board_table2">
				<tr height='30'>
					<td colspan='17' class='con9' style='text-align:left;'> &nbsp; * ������� ���� ���� <b>&nbsp;&nbsp;&nbsp;</b></td>
				</tr>
				<tr>
					<th class="head" width="80">�����</th>
					<th class="head" width="80">�������</th>
					<th class="head" width="130">�����Ͻ�</th>
				</tr>

  <%
  strSql = " select A.board_idx, B.m_name, C.gaetong_color, C.gaetong_name, A.log_writeday "
  strSql = strSql & "	from customer_gaetong_log A left outer  "
  strSql = strSql & "	    join emp_list B ON A.log_m_id=B.m_id "	
  strSql = strSql & "  left join code_gaetong C ON A.log_code_gaetong=C.gaetong_code "
  strSql = strSql & "			where A.g_goods_idx="&g_goods_idx&" "
  strSql = strSql & "				order by board_idx desc"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
  %>
				<tr height='30'>
					<td class='con5' colspan='17'> ������ �������� �ʽ��ϴ�.</td>
				</tr>
  <%
  Else
	i=1
	Do Until objRs.eof
		board_idx				= objRs("board_idx")
		m_name					= objRs("m_name")
		gaetong_color			= objRs("gaetong_color")
		gaetong_name			= objRs("gaetong_name")
		log_writeday			= fnc_date_change(objRs("log_writeday"))
  %>
				<tr height='25'>
					<td class="con5"><%=m_name%></td>
					<td class="con4"><nobr><span style='color:<%=gaetong_color%>;'><%=gaetong_name%></span>
						<% If session_m_step="M" Then %>
						<span title="�̷±� ����" onclick="reply_del_ok('a_custom_goods_log_del.asp?board_idx=<%=board_idx%>&g_goods_idx=<%=g_goods_idx%>');" onmouseover="this.style.cursor='hand';">
						<img src="/images/button/btn_reply_delete.gif" border=0 align='absmiddle'>
						</span>
						<% End If %></nobr>
					</td>
					<td class="con4"><%=log_writeday%></td>
				</tr>
  <%
		i=i+1
		objRs.movenext
	loop

  End if
  %>
				</table>
			</td>
		</tr>
		</table>
		</span>
	
		<table width=100% border=0 cellspacing="0" cellpadding="0" id="board_table2" style="border-top: 1px solid #C7C7C7;">
		<tr height="30">
			<td colspan='5' class='head' style='text-align:left;'>&nbsp;&nbsp; * �̷� ��� </b></td>
		</tr>
		<tr>
			<td class='head' width='100'>��㱸��</td>
			<td class='con1'  width='350'>
				<select name="consult_type" class="txtbox" >
					<option value="A"> ���޸� </option>
					<option value="G"> �����޸� </option>
					<option value="K"> VOC �߻� </option>
					<option value="B"> ȸ�ſ�û </option>
					<option value="D"> ȸ�ſϷ� </option>
					<option value="J"> ��δ亯 </option>
				</select>
			</td>
			<td class='head'  width='100'>��������</td>
			<td class='con1'  width='350'>
				 <input type="text" class="txtbox" name="consult_date" size='10' value="" readonly><img src="/images/button/btn_calendar.gif" align="absmiddle" onclick="NewWindow('/include/asp/calendar.asp?code1=consult_date&code2=&code3=&form_name=frm_custom_regist','cal_write','250','300','no');" onmouseover="this.style.cursor='hand';">
				<select name="consult_date_hour">								 
				<option value="00"  selected >00��</option>
				<option value="01">01��</option>
				<option value="02">02��</option>
				<option value="03">03��</option>
				<option value="04">04��</option>
				<option value="05">05��</option>	
				<option value="06">06��</option>
				<option value="07">07��</option>
				<option value="08">08��</option>
				<option value="09">09��</option>
				<option value="10">10��</option>
				<option value="11">11��</option>
				<option value="12">12��</option>
				<option value="13">13��</option>
				<option value="14">14��</option>
				<option value="15">15��</option>
				<option value="16">16��</option>
				<option value="17">17��</option>
				<option value="18">18��</option>
				<option value="19">19��</option>
				<option value="20">20��</option>
				<option value="21">21��</option>
				<option value="22">22��</option>
				<option value="23">23��</option>
				</select>
				<select name="consult_date_minute" class="txtbox" >								    
				<option value="00" selected >00��</option>								   
				<option value="10">10��</option>
				<option value="20">20��</option>
				<option value="30">30��</option>
				<option value="40">40��</option>
				<option value="50">50��</option>								  
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
				��������:<input type="checkbox" name="consult_date_view" value="Y" checked >
			</td>
			<td rowspan='2' class='con4' width="100"> 
				<span onclick="custom_consult_reply('frm_custom_regist');"><img src="/images/button/btn_consult_regist.gif" align='absmiddle'></span>
			</td>
		</tr>
		<tr>
			<td class='head'>����</td>
			<td class='con1' colspan='3'>
				<textarea name="consult_bigo" rows=4 class="txtbox" cols=130></textarea>
			</td>
			
		</tr>
		</table>


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
  <%
  'objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>


