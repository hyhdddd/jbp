  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 011-9619-8280
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
 
  m_id					= WORD_CHANGE(Request("m_id"),20)
  sms_chk				= WORD_CHANGE(Request("sms_chk"),10)				'고객/사원 체크
  g_goods_idx			= WORD_CHANGE(Request("g_goods_idx"),0)				'사원일괄


  if ad_c_sms="N" Or ad_c_sms="R" then
 	Alert session_m_name &" 님은 SMS 관리 권한이 없습니다. SMS관리 쓰기권한 이상이여야 사용가능 합니다. \n\n 관리자에게 문의하세요!"
	Win_close()
  end if	

  '본사 전화번호
  strSql = " select o_com_name,o_tel1 + o_tel2 + o_tel3 as o_tel from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)
  o_com_name	= objRs("o_com_name")
  o_tel			= objRs("o_tel")

  If sms_chk="insa" Then			'사원목록
	strSql = "select * from emp_list where m_id='"&m_id&"'"
	Set objRs=objCnn.Execute(strSql)

	sms_name	= objRs("m_name")
	sms_phone	= objRs("m_tel2")
  ElseIf sms_chk="customer" then		'고객관리 일괄 전송
	g_goods_idx			= split(g_goods_idx,",")
	cnt					= ubound(g_goods_idx)

	Dim sms_name(70)
	Dim sms_phone(70)

		for i=0 to ubound(g_goods_idx)
			strSql = " select * from customer_goods where g_goods_idx="&Trim(g_goods_idx(i))&" "
			Set objRs=objCnn.Execute(strSql)

			Do Until objRs.eof 
				c_tel2		= objRs("c_tel2")
				c_name		= objRs("c_name")
				
				sms_name(i)		= c_name
				sms_phone(i)	= c_tel2

				objRs.movenext
			Loop
		Next
  ElseIf sms_chk="owners" Then
	'거래처 사장님들 검색....
	dealer_code			= WORD_CHANGE(request("dealer_code"),0)
	dealer_code1		= split(dealer_code,",")
	cnt					= ubound(dealer_code1)


  End if

  %>

<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
function dbLength(MaxLn, str) 
{
	var check = "0" ;
	var result = 0;
	if (event.keyCode == 9 || event.keyCode == 13) return false;


	for (var i = 0; i < str.length; i++) 
	{
   		var c = str.charAt(i);
   		var enc = encodeURIComponent(c);      
   		result++;
   		if (enc.length > 3) result++;
	}
  
	if (MaxLn <= result) 
	{  
		if (event.keyCode != 8)
    	{ 
    		event.returnValue=false;   
    		alert("입력할수 있는 제한글자수를 넘겼습니다.\n최대 " + MaxLn + "(한글" + parseInt(MaxLn/2) + ")자까지 가능");
		}        
    	if ((enc.length > 3) && MaxLn < result) 	
    		str = str.substring(0, i - 1 );  
    } 
	
	document.all.sms_frm.txt_length.value= result;
}

function smssend()
{
	var frm = document.all.sms_frm;

	if(frm.phone2.value=="")
	{
		alert("발신번호를 입력하세요");
		frm.phone2.focus();
		return;
	}

	if(isNaN(frm.phone2.value))
	{
		alert("발신번호를 숫자로만 기입하세요");
		frm.phone2.focus();
		return;
	}

	txt_length = frm.txt_length.value;

	if(parseInt(txt_length)==0)
	{
		alert("문자를 입력해 주세요");
		frm.content.focus();
		return;
	}

	chk1="X"
	
	frm.phone_list.value="";
	hid_str="";
	
	if(frm.select_name.length!=0)
	{
		for(i = 0; i < frm.select_name.length; i++) 
       	{
	     	receipt_str = frm.select_name.options[i].value+"_";
			hid_str=hid_str+receipt_str;
		}
	}
	else
	{
		alert("받는사람이 없습니다. \n\n 수신인, 전화번호를 입력하고 적용버튼을 눌러 받는사람을 추가해 주세요");
		return;
	}

	frm.phone_list.value=hid_str;

	ans=confirm("문자를 전송하시겠습니까?");
	if(ans==true)
	{
		frm.submit();
	}
}

//선택된 리스트 삭제기능
function select_name_del(frm)
{
	var frm=eval("document.all."+frm);
	if(frm.select_name.selectedIndex=="-1")
	{
		alert("목록을 선택해 주세요");
		return;
	}
	else
	{
		frm.select_name.options[frm.select_name.selectedIndex] = null;
	}
}

function select_name_add(frm)
{
	var frm=eval("document.all."+frm);

	if(frm.to_tel.value=="")
	{
		alert("받는사람 전화번호를 입력해주세요!");
		frm.to_tel.focus();
		return;
	}

	to_name = "추가";
	to_tel	= frm.to_tel.value;
	
	cnt= frm.select_name.length;
	frm.select_name.options[cnt] = new Option(to_name+":"+to_tel,to_tel);
}

-->
</script>
<body topmargin=0 leftmargin=0 bgcolor="#FFFFFF" text="#000000">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<body leftmargin=0 topmargin=0>
	<form name="sms_frm" method="Post" action="/sms/sms_batch_regist_ok.asp">
	<input type="hidden" name="o_code" value="<%=o_code%>">
	<input type="hidden" name="m_id" value="<%=m_id%>">
	<input type="hidden" name="phone_list" value="<%=phone_list%>">

	<table width="300"  border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table width="180" border="0" cellpadding="0" cellspacing="0">
			<tr> 
				<td width="180" height="49" align="center" valign="bottom" background="/images/sms/sms_top.gif">			
				</td>
			</tr>
			<tr> 
				<td height="215" align="center" valign="top" background="/images/sms/sms_bg01.gif" style="padding-top:3"> 
					<table width="175" height="142" border="0" cellpadding="0" cellspacing="0">
					<tr> 
						<td align="center" valign="bottom" style="padding-bottom:3"> 
							<textarea cols='19' rows='5'  name="content" style="color:#990000; BACKGROUND-ATTACHMENT: fixed; BACKGROUND-IMAGE: url(/images/sms/msg_ui_img07.gif); overflow:hidden " OnKeyDown="dbLength(80, this.value);"  ><%=message%></textarea>
						</td>
					</tr>
					<tr> 
						<td align="center" valign="bottom" class="text01" style="padding-bottom:1">
							<input type=text name="txt_length" readonly size=3 style="background-color:#B96596; border-width:0; color:#FFFFFF; text-align:right; font-family: 돋움; font-size: 11px" value="<%=message_cnt%>"> 
							<font color="#FFFFFF"  style="font-size: 11px">/</font>
							<input name="text" name="txt_length1" type=text style="background-color:#B96596; border-width:0; color:#FFFFFF; border-style:solid;text-align:right; font-family: 돋움; font-size: 11px" value="80" size=2 readonly> 
							<font color="#FFFFFF" style="font-size: 11px"> Byte</font>				  
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="50" align="center" valign="top" background="/images/sms/sms_bg02.gif">
					<table width="150" border="0" cellspacing="0" cellpadding="0">
					<tr height='10'>
						<td colspan='2'></td>
					</tr>
					<tr>
						<td width="50" align="center">
							<font color="3677C0" style="font-size: 11px">발 신</font>
						</td>
						<td  align="left">
							<input  name="phone2"  type=text class='txtbox'  maxlength='11' size=12 value = "<%=o_tel%>" style="ime-mode:disabled;" OnKeyUp="fncOnlyNumber(this);">
						</td>
					</tr>					
					</table>
				</td>
			</tr>
			<tr>
				<td height="61" align="center" valign="top">
					<img src="/images/sms/sms_btm.gif" width="180" height="61" border="0" usemap="#Map">
					<map name="Map">
					<area shape="rect" coords="26,4,95,41" href="javascript:smssend();">
					<area shape="rect" coords="98,4,152,41" href="javascript:self.close();">
					</map>		
				</td>
			</tr>
			</table> 
		</td>
		<td  height="400">
			<table width='100%' cellspacing="0" cellpadding="0" border=0 id="board_table3">
			<tr height='30'>
				<Th> 받는 사람 </th>
			</tr>
			<tr height="340">
				<td valign='top'>
					<select name="select_name" size=4  MULTIPLE  style="height:340; width=150; border-width:1; border-style:solid; border-color:003366;">
					<% If sms_chk="insa" Then %>
					<option value="<%=sms_phone%>"><%=sms_name%>:<%=sms_phone%></option>
					<% End If %>

					<% 
					If sms_chk="customer" Then 
						For i=0 To  ubound(g_goods_idx)							
					%>
						<option value="<%=sms_phone(i)%>"><%=sms_name(i)%>:<%=sms_phone(i)%></option>
					<%
						Next
					End If 
					%>

					<%
					If sms_chk="owners" Then
						For i=0 To UBound(dealer_code1)
							strSql = "select * from emp_list where m_dealer_code='"&Trim(dealer_code1(i))&"' and m_dealer_admin='O'"
							Set objRs=objCnn.Execute(strSql)
							
							If objRs.eof Or objRs.bof Then
							Else
								m_name		= objRs("m_name")
								m_tel2		= objRs("m_tel2")
					%>
						<option value="<%=m_tel2%>"><%=m_name%>:<%=m_tel2%></option>
					<%
							End if
						Next
					End If 
					%>

					</select>
				</td>
			</tr>
			<tr>
				<td align='center'>
					<span onclick="select_name_del('sms_frm');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_delete.gif"></span>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan='2'>
			<span style="font-size:12px;">			
			전화번호<input type="text" name="to_tel" class='txtbox' size='14' style="ime-mode:disabled;" OnKeyUp="fncOnlyNum(this); fncReplaceCheck(this,'.'); fncReplaceCheck(this,',');">&nbsp;&nbsp;
			<img src="/images/button/apply.gif" onclick="select_name_add('sms_frm');" align='absmiddle'> <span class='red'>(SMS 전송추가)</span>
			</span>
		</td>
	</table>
			</form>

<script language="javascript">
<!--
	var frm=document.all.sms_frm;
	str = frm.content.value;
	var check = "0" ;
	var result = 0;

	for (var i = 0; i < str.length; i++) 
	{
   		var c = str.charAt(i);
   		var enc = encodeURIComponent(c);      
   		result++;
   		if (enc.length > 3) result++;
	}
    
	if (100 <= result) 
	{  
   		alert("입력할수 있는 제한글자수를 넘겼습니다.\n최대 " + MaxLn + "(한글" + parseInt(MaxLn/2) + ")자까지 가능");
    } 

	frm.txt_length.value = result;
-->
</script>

