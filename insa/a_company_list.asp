  <%
  '====================================='
  ' ������Ʈ : CenterCms PROJECT
  ' ��    �� : HTTP://WWW.CenterCMS.CO.KR
  ' �������� : 2009/03/01 ~2009/05/31
  ' �� �� �� : �� �� �� 
  ' �� �� �� : cak0280@nate.com
  ' ��    �� : 011-9619-8280
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->
  <%
  Login_chk(Session_m_id)

  if ad_i_a_company="N" then
	Alert_url session_m_name &" ���� �ŷ�ó��� ���ٱ����� �����ϴ�. �����ڿ��� �����ϼ���! ","/main.asp"
  end if
  

  search_key		= WORD_CHANGE(Request("search_key"),20)
  search_txt		= WORD_CHANGE(Request("search_txt"),20)

  dealer_code		= WORD_CHANGE(request("dealer_code"),20)
  chk				= WORD_CHANGE(Request("chk"),20)
  board_idx			= WORD_CHANGE(Request("board_idx"),20)
  
  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 
  
  if dealer_code<>"" then
  	strSql = " select * from dealer_info where dealer_code='"&dealer_code&"'"
  	set objRs=objCnn.Execute(strSql)
  	
	If objRs.eof Or objRs.bof Then
		dealer_code=""
	Else
		dealer_idx			= objRs("dealer_idx")
	  	dealer_code			= objRs("dealer_code")
  		dealer_name			= objRs("dealer_name")
		dealer_com_yn		= objRs("dealer_com_yn")
		dealer_com_no		= objRs("dealer_com_no")		' ����� ��ȣ
		dealer_com_jumin	= objRs("dealer_com_jumin")		' ���� �ֹι�ȣ
		dealer_bank_name	= objRs("dealer_bank_name")		' ���� ������
		dealer_bank_cd		= CInt(money_chk(objRs("dealer_bank_cd")))		' ���� �ڵ�
		dealer_bank_no		= objRs("dealer_bank_no")		' ���� ���¹�ȣ
		dealer_zipcode1		= objRs("dealer_zipcode1")		' ȸ�� �����ȣ1
		dealer_address		= objRs("dealer_address")		' ȸ�� �ּ�
		dealer_email		= objRs("dealer_email")			' ȸ�� Email
		dealer_tel1			= objRs("dealer_tel1")			' ȸ�� ��ȭ
		dealer_tel2			= objRs("dealer_tel2")			' ȸ�� �޴���
		dealer_file1		= objRs("dealer_file1")			' ÷������1
		dealer_file2		= objRs("dealer_file2")			' ÷������2
		dealer_service1		= objRs("dealer_service1")		' ����
		dealer_service2		= objRs("dealer_service2")		' ����
		dealer_insu			= objRs("dealer_insu")			' ������/�����
		dealer_ingea		= objRs("dealer_ingea")			' ������/�����
		dealer_writeday		= objRs("dealer_writeday")		' ȸ�� �����
		dealer_view			= objRs("dealer_view")			'���� �ŷ�����
		dealer_group_code	= objRs("dealer_group_code")
		dealer_bigo			= objRs("dealer_bigo")			'���� ���

		dealer_ingea_url	= objRs("dealer_ingea_url")		'����� URL
		dealer_ingea_id		= objRs("dealer_ingea_id")		'����� URL
		dealer_ingea_passwd	= objRs("dealer_ingea_passwd")	'����� URL
		
	End If
	objRs.close
  Else
	If chk="P" Then
		strSql = " select * from dealer_partner_info where board_idx="&board_idx
		Set objRs=objCnn.Execute(strSql)

		If objRs.bof Or objRs.bof Then
		Else
			dealer_name			= objRs("dealer_name")
			dealer_com_yn		= objRs("dealer_com_yn")
			dealer_com_no		= objRs("dealer_com_no")
			dealer_bank_name	= objRs("dealer_bank_name")			' ���� ������
			dealer_bank_cd		= CInt(money_chk(objRs("dealer_bank_cd")))			' ���� �ڵ�
			dealer_bank_no		= objRs("dealer_bank_no")			' ���� ���¹�ȣ
			dealer_zipcode1		= objRs("dealer_zipcode1")			' ȸ�� �����ȣ1
			dealer_address		= objRs("dealer_address")			' ȸ�� �ּ�			
		End if
	End If
	
	dealer_ingea_url	= "http://"
	dealer_view="Y"
  end If

 If dealer_com_yn="Y" Or dealer_com_yn="" Then
	business_chk1 = "checked"
 Else
	business_chk2 = "checked"
 End If


 if len(dealer_file1)>0 then
	filepath1=o_code &"/partner_info/"	
 end If
 if len(dealer_file2)>0 Then
	filepath2=o_code &"/partner_info/"	
 end If

  If dealer_bank_cd="" Or IsNull(dealer_bank_cd) Then
	dealer_bank_cd=0
  End If


  s_link_txt ="search_key="&search_key&"&search_txt="&search_txt

 %>
<title>:::::::<%=o_com_name%> �����ý��� :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script language="javascript">
<!--
function dealer_search(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.search_txt.value=="")
	{
		alert("�˻�� �Է��� �ּ���!")
		return;
	}
	
	search_key = frm.search_key.value;
	search_txt = frm.search_txt.value;

	location.href="/insa/a_company_list.asp?search_txt="+search_txt+"&search_key="+search_key;
}


function auto_enter_send1(frm_name)
{
	var frm=eval("document.all."+frm_name);
	if(event.keyCode == 13)
	{
		dealer_search(frm_name);
	}
}

	function a_company_del(code)
	{
		ans=confirm("�ڵ� ����ñ� ���ؼ��� ȸ�� �Ҽ� ����� ����� �ϸ�, �������� ������/����� �ŷ�ó�� ����ϰ� ������ �������� ������ �����ϼž� �մϴ�. \n\n �ڵ带 ����ðڽ��ϱ�? ");
		if(ans==true)
		{
			location.href="a_company_del_ok.asp?dealer_code="+code
		}
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="0">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      	</td>
</tr>
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
				
		<!------------------ ���� ����  ------------------>
		<div class="sub_title"><img src="/images/common/sub03_t03.gif"></div>
		
		<form name="frm_dealer" Method="POST" action="a_company_regist_ok.asp" ENCTYPE="MULTIPART/FORM-DATA">
		<input type="hidden" name="dealer_idx" value="<%=dealer_idx%>">
		<input type="hidden" name="page" value="<%=page%>">

		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<Tr>
			<td colspan='4' class="description"> 
				* ȸ��� �ŷ��ϴ� ��� �ŷ�ó�� ������ �Է��ϴ� ������ �Դϴ�.  <br>
				* �ŷ�ó ������ '�ŷ�ó ������� , �� ������/����� �������� ���� �� �ֽ��ϴ�. <br>
				<span class='red'>* �ѹ� ����� �ŷ�ó �ڵ�/ID�� ������ �Ұ��� �մϴ�. <br>
				* �ŷ�ó ������ ��Ȯ�� �Է��Ͻð� �����Ͻñ� �ٶ��ϴ�. <br></span>
			</td>
		</tr>				
		<tr height=30> 
			<th width="130">�ŷ�ó ��ȣ</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_name" maxlength="20" size="20"  value="<%=dealer_name%>"  maxlength="30" onBlur="BlurColor(this)" onFocus="FocusColor(this);" <% If dealer_code=o_code Then %> readonly <% End If %> >&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio"  name="dealer_com_yn" value="Y" <%=business_chk1%>>�����&nbsp;&nbsp;	
				<input type="radio"  name="dealer_com_yn" value="N" <%=business_chk2%>>��  ��
			</td>
			<td width="130" class='con9'>ȸ�籸��</td>
			<td width="370">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox"  name="dealer_insu" value="Y" <% If dealer_insu="Y" Then %> checked <% End If %>>������&nbsp;&nbsp;	
				<input type="checkbox"  name="dealer_ingea" value="Y" <% If dealer_ingea="Y" Then %> checked <% End If %>>�����
			</td>
		</tr>
		<tr height=25>
			<th width="130">����ڹ�ȣ</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_com_no" maxlength="12" size="20" value="<%=dealer_com_no%>" onFocus="FocusColor(this);" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_com_jumin');">&nbsp;
				<font color="blue">* 000-00-00000 </font>
			</td>
			<th width="130">�ֹι�ȣ</th>
			<td width="370">
				<input type="Text" class="txtbox" name="dealer_com_jumin" maxlength="14" size="20" value="<%=dealer_com_jumin%>" onBlur="BlurColor(this)" onFocus="FocusColor(this);" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_bank_name');">&nbsp;
				<font color="blue">* 000000-0000000 </font>
			</td>
		</tr>
		<tr>
			<th>��ǥ��</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_name" size="20" value="<%=dealer_bank_name%>" onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_dealer','dealer_email');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('ȸ�� ��ǥ�� ���� ������(�ִ�20��)�� �Է��� �ִ� �� �Դϴ�.(ȸ�� ��ǥ�� ���� �����ڰ� �����ϰ� �Է��ϼ���.)');">		
			</td>
			<th> �̸��� </th>
			<Td> 
				<input type="text" name="dealer_email" class="txtbox" maxlength="30" size="30" style="ime-mode:disabled;" value="<%=dealer_email%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service1');">
			</td>
		</tr>
		<tr>
			<th>����</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_service1" maxlength="20" size="20" value="<%=dealer_service1%>" onBlur="BlurColor(this)" OnKeyUp="EnterNextFocus('frm_dealer','dealer_service2');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('ȸ�� ����(�ִ�8��)�� �Է��� �ִ� �� �Դϴ�.');">		
			</td>
			<th>����</th>
			<Td> 
				<input type="text" name="dealer_service2" class="txtbox" maxlength="20" size="20" value="<%=dealer_service2%>" OnKeyUp="EnterNextFocus('frm_dealer','dealer_bank_cd');"> <img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('ȸ�� ����(�ִ�8��)�� �Է��� �ִ� �� �Դϴ�.');">
			</td>
		</tr>
		<tr> 
			<th>�ŷ�����</th>
			<td>
				<select name="dealer_bank_cd" class="txtbox">
				<option value="0" <% if dealer_bank_cd="0" then %> selected <% end if %>> ���� ���� 
			<% 
			strSql= " select board_idx,bank_name from code_bank order by bank_name ASC"
			set objRs1=objCnn.Execute(strSql)

			Do until objRs1.EOF
				bank_board_idx	= objRs1(0)
				bank_name		= objRs1(1)
			%>                      							
				<option value="<%=bank_board_idx%>" <% if bank_board_idx=dealer_bank_cd then %> selected 
				<% end if %>><%=bank_name%></option>
			<%
				objRs1.movenext
			Loop
			%>
				</select>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('�ŷ�ó ������ �Է��� �ִ� �� �Դϴ�.');">
			</td>
			<th>���¹�ȣ</th>
			<td>
				<input type="Text" class="txtbox" name="dealer_bank_no" maxlength="20" size="20"  value="<%=dealer_bank_no%>" onBlur="BlurColor(this)" onFocus="FocusColor(this);" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel1');">&nbsp;
				<font color="blue">* 000-000-000000 </font>
			</td>
		</tr>
		<tr>
			<th> ��ȭ </th>
			<Td> 
				<input type="text" name="dealer_tel1" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel1%>" 
				OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,','); EnterNextFocus('frm_dealer','dealer_tel2');">&nbsp
				<font color="blue">* 02-000-0000 </font>
			</td>				
			<th> �ѽ���ȣ </th>
			<Td> 
				<input type="text" name="dealer_tel2" class="txtbox" maxlength="13" size="20" style="ime-mode:disabled;" value="<%=dealer_tel2%>" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;
				<font color="blue">* 010-000-0000 </font>
			</td>
		</tr>
		<tr height=25>
			<th> ȸ�� �ּ�</th>
			<td colspan='3' class="table_list2">
				<input  type="text" class="txtbox" size="6" maxlength="6" id="dealer_zipcode1" name="dealer_zipcode1" readonly value="<%=dealer_zipcode1%>">
				<input class="txtbox" type="text" size="70" maxlength="70" id="dealer_address"  name="dealer_address" onFocus="FocusColor(this);"  value="<%=dealer_address%>"><img src="/images/button/btn_search01.gif" Border="0" align="absmiddle" style="cursor:pointer;" onclick="sample4_execDaumPostcode('dealer_zipcode1','dealer_address');">
			</td>
		</tr>
		<tr> 
			<th>����׷켳��</th>
			<td>
				<select name="dealer_group_code" class="txtbox">
				<option value="0" <% if dealer_group_code="0" then %> selected <% end if %>> �׷� ���� 
			<% 
			strSql= " select group_code,group_name from code_group order by group_name ASC"
			set objRs1=objCnn.Execute(strSql)

			Do until objRs1.EOF
				group_code		= objRs1(0)
				group_name		= objRs1(1)
			%>                      							
				<option value="<%=group_code%>" <% if dealer_group_code=group_code then %> selected 
				<% end if %>><%=group_name%></option>
			<%
				objRs1.movenext
			Loop
			%>
				</select>
			</td>
			<th>�ŷ�����</th>
			<td>
				<input type="radio" name="dealer_view" value="Y" <% If dealer_view="Y" Then %> checked <% End If %>>�ŷ��� &nbsp;&nbsp;&nbsp;
				<input type="radio" name="dealer_view" value="N" <% If dealer_view="N" Then %> checked <% End If %>>�ŷ����� &nbsp;&nbsp;&nbsp;
			</td>
		</tr>	
		<tr>
			<th> ����� ������ </th>
			<td> 
				<input type="Text" class="txtbox" name="dealer_ingea_url" maxlength="40" size="40"  value="<%=dealer_ingea_url%>" onBlur="BlurColor(this)" onFocus="FocusColor(this);"></td>
			<th> ����� ID </th>
			<td> 
				<input type="Text" class="txtbox" name="dealer_ingea_id" maxlength="20" size="20"  value="<%=dealer_ingea_id%>" onBlur="BlurColor(this)" onFocus="FocusColor(this);">
				�н�����
				<input type="Text" class="txtbox" name="dealer_ingea_passwd" maxlength="20" size="20"  value="<%=dealer_ingea_passwd%>" onBlur="BlurColor(this)" onFocus="FocusColor(this);">
			</td>
		</tr>
		<tr> 
			<th>÷������1</th>
			<td> 
				<input type="file" name="dealer_file1" size="40" class="txtbox" onBlur="BlurColor(this)" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file1)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file1%>&fpath=<%=filepath1%>"><%=dealer_file1%></a>
				<% End If %>
				<img src="/images/Common/icon_help.gif" border="0" align='absmiddle' onmouseover="this.style.cursor='hand';" onclick="alert('�ŷ�ó�� ����� �纻/���� �纻/�ֹε���� �纻 ���� �����Ҽ� �ֽ��ϴ�.(�����̸��� �ִ�20��)');">
			</td>		
			<th>÷�� ����2</th>
			<td> 
				<input type="file" name="dealer_file2" size="40" class="txtbox" onBlur="BlurColor(this)" 
				onFocus="FocusColor(this);this.select();">
				<% If Len(dealer_file2)>0 Then %>
				<a href="/include/asp/file_down.asp?fname=<%=dealer_file2%>&fpath=<%=filepath2%>"><%=dealer_file2%></a>
				<% End If %>

			</td>
		</tr>
		<tr> 
			<th>��Ÿ ����</th>
			<td colspan='4'>
				<textarea name="dealer_bigo" rows=4 class="txtbox" cols=130><%=dealer_bigo%></textarea>
			</td>
		</tr>
		<tr height=30> 
			<Td colspan='4'>&nbsp;
				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<a href="a_company_list.asp"><img src="/images/button/btn_new.gif" border="0"></a>
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� �ŷ�ó ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0"></a> 
				<% end if %>      									

				<% if ad_i_a_company="W" or ad_i_a_company="E" or ad_i_a_company="A" then %>
					<img src="/images/button/btn_save.gif" border=0 onclick="send_dealer();">
				<% else %>
					<a href ='javascript:alert("<%=session_m_name%> ���� �ŷ�ó ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_save.gif" border="0"></a> 
				<% end if %> 	
				
				<% If dealer_code<>"" Then %>
					<% if ad_i_a_company="A" then %>
						<img src="/images/button/btn_delete.gif" border=0 onclick="a_company_del('<%=dealer_code%>');">
					<% else %>
						<a href ='javascript:alert("<%=session_m_name%> ���� �������� ���������� �����ϴ�.");'><img src="/images/button/btn_delete.gif" border="0"></a> 
					<% end if %>  
				<% End If %>
			</td>	
		</tr>
		</table>				
		
		<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height="30"> 
			<td colspan='10' class='con2'  style="border-style:none">		  					
				<select name="search_key" valign='absmiddle' class="txtbox">
					<option value="dealer_name"> ȸ��� </option>	
					<option value="dealer_bank_name"> ��ǥ�� </option>								
				</select><input type="text" class="txtbox" name="search_txt" size='20' align='absmiddle' OnKeyUp="auto_enter_send1('frm_dealer');"><img src="/images/button/btn_search01.gif"  onClick="dealer_search('frm_dealer');" onMouseOver="this.style.cursor='hand';" align='absmiddle' border="0">
			</td>
		</tr>
		<tr height=30>             
			<td class="head" width="20">No</td>
			<td class="head" width="70">�ŷ�ó�ڵ�</td>
			<td class="head">�ŷ�ó ��ȣ</td>
			<td class="head" width="100">��ǥ��</td>
			<td class="head" width="100">�ŷ�ó����ó</td>
			<td class="head" width="100">���¹�ȣ</td>
			<td class="head" width="100">����׷�</td>
			<td class="head" width="100">�ŷ�����</td>
			<td class="head" width="100">������</td>
		</tr>

  <%
 
  strSql = " select * from dealer_info A left outer "
  strSql = strSql & "	join code_group B ON A.dealer_group_code=B.group_code "
  strSql = stRSql & "		where 1=1 "

  If search_txt<>"" then
	strSql = strSql & "			and  A."&search_key&" like '%"&search_txt&"%'"
  End If

  strSql = strSql & "			order by dealer_code desc"
  
  objRs.Open strSql, objCnn, 3
  objRs.PageSize = 15
  
  if objRs.BOF or objRs.EOF Then
	paging_chk="X"
  %>
				<tr height=25>
					<td colspan='6'>�ŷ�ó�� �������� �ʽ��ϴ�.</td>
				</tr>
  <%
  else      		   
  	i = 1
    totalpage = objRs.pagecount
    objRs.absolutepage = page
	recordcount	= objRs.recordcount

  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize 
		dealer_idx			= objRs("dealer_idx")
  		dealer_code			= objRs("dealer_code")
  		dealer_name			= objRs("dealer_name")
		dealer_com_yn		= objRs("dealer_com_yn")
		dealer_com_no		= objRs("dealer_com_no")
		dealer_insu			= objRs("dealer_insu")
		dealer_ingea		= objRs("dealer_ingea")
		dealer_bank_name	= objRs("dealer_bank_name")
		dealer_bank_cd		= objRs("dealer_bank_cd")
		dealer_bank_no		= objRs("dealer_bank_no")
		dealer_zipcode1		= objRs("dealer_zipcode1")		' ȸ�� �����ȣ1
		dealer_address		= objRs("dealer_address")		' ȸ�� �ּ�	
		dealer_com_jumin	= objRs("dealer_com_jumin")
		dealer_email		= objRs("dealer_email")
		dealer_tel1			= objRs("dealer_tel1")
		dealer_tel2			= objRs("dealer_tel2")
		dealer_file1		= objRs("dealer_file1")
		dealer_file2		= objRs("dealer_file2")
  		dealer_writeday		= Left(objRs("dealer_writeday"),10)
		group_name			= objRs("group_name")

		dealer_view			= objRs("dealer_view")
		If dealer_view="Y" Then
			dealer_view_txt="�ŷ���"
		Else
			dealer_view_txt="<span class='red'>�ŷ�����</span>"
		End if
  %>
		<tr height=30>             
			<td class="con5"><%=i%></td>
			<td class="con4"><a href="a_company_list.asp?dealer_code=<%=dealer_code%>&page=<%=page%>&nowblock=<%=nowblock%>&<%=s_link_txt%>"><%=dealer_code%></a></td>
			<td class="con4"><%=dealer_name%></td>
			<td class="con4"><%=dealer_bank_name%></td>
			<td class="con4">&nbsp;<%=dealer_tel1%></td>
			<td class="con4">&nbsp;<%=dealer_bank_no%></td>
			<td class="con4">&nbsp;<%=group_name%></td>
			<td class="con4">&nbsp;<%=dealer_view_txt%></td>
			<td class="con4"><%=dealer_writeday%></td>
		</tr>


  <% 
    	objrs.MoveNext
    	i=i+1 
	loop
   end if					
  %>   
		</table>

		<div class="pagelist">	
		<%
		' Request mychoice						
		' Request totalpage
		' Request page
		' Request nowblock
		' Request link_url
		' Request link_tail :������ Request ��
		mychoice=10
		link_url = "a_company_list.asp?"&s_link_txt&"&"
		%>
		<!--#include virtual="/include/asp/list_paging.asp"-->
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<b><span class='blue'>[ <%=recordcount%> �� ] </span></b>
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
  objRs.Close
  objCnn.Close
  Set objRs = Nothing 
  Set objCnn = Nothing
  %>

