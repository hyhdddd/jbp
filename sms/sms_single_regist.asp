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

  c_name				= WORD_CHANGE(Request("c_name"),20)				'고객명
  g_yuchi_m_id			= WORD_CHANGE(request("g_yuchi_m_id"),20)			'유치자 아이디
  g_article_idx1		= WORD_CHANGE(Request("g_article_idx1"),10)			'상품명
  g_article_idx2		= WORD_CHANGE(Request("g_article_idx2"),10)		'상품명
  g_code_gaetong_idx	= WORD_CHANGE(request("g_code_gaetong_idx"),10)		'개통상태

  m_name				= WORD_CHANGE(Request("m_name"),20)
  m_htel1				= WORD_CHANGE(Request("m_htel1"),20)
  m_htel2				= WORD_CHANGE(Request("m_htel2"),20)
  m_htel3				= WORD_CHANGE(Request("m_htel3"),20)

  '상품정보
  strSql= " select article_name from code_article where article_idx='"&g_article_idx1&"' "
  set objRs=objCnn.Execute(strSql)
  article_name1		= objRs("article_name")

  strSql= " select article_name from code_article where article_idx='"&g_article_idx2&"' "
  set objRs=objCnn.Execute(strSql)
  article_name2		= objRs("article_name")

  '개통상태 출력
  strSql = " select gaetong_name from code_gaetong "
  strSql = strSql & " where  gaetong_code='"&g_code_gaetong_idx&"' "
  set objRs=objCnn.Execute(strSql)
  gaetong_name		= objRs("gaetong_name")

  '구버전 : m_htel1 + m_htel2 + m_htel3 , 신버전 : m_tel2
  strSql= " select m_tel2 as emp_tel from emp_list "
  strSql = strSql & " where m_id='"&g_yuchi_m_id&"' "
  set objRs=objCnn.Execute(strSql)
  emp_tel		= Replace(objRs("emp_tel"),"-","")
 
  strSql = " select o_com_name,o_tel1 + o_tel2 + o_tel3 as o_tel from company_info where o_code='"& o_code &"'"
  Set objRs=objCnn.Execute(strSql)
  o_com_name	= objRs("o_com_name")
  o_tel			= objRs("o_tel")

  message = "고객("&c_name&")님 상품 ("& article_name1 &"_"&article_name2 & ")이 "&gaetong_name&" 되었습니다. -"& o_com_name &"-"
  message_cnt=10

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
	if(frm.phone1.value=="")
	{
		alert("수신번호를 입력하세요");
		frm.phone1.focus();
		return;
	}

	if(isNaN(frm.phone1.value))
	{
		alert("수신번호를 숫자로만 기입하세요");
		frm.phone1.focus();
		return;
	}

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
	//if(parseInt(txt_length)>80)
	//{
	//	alert(" 글자수는 80자 까지 입니다.");
	//	frm.content.focus();
	//	return;
	//}
	
	frm.submit();
}
-->
</script>
<body topmargin=0 leftmargin=0 bgcolor="#FFFFFF" text="#000000">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<body leftmargin=0 topmargin=0>
	<form name="sms_frm" method="Post" action="sms_single_regist_ok.asp">
	<input type="hidden" name="o_code" value="<%=o_code%>">
	<input type="hidden" name="m_id" value="<%=session_m_id%>">

	<table width="180" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td width="180" height="49" align="center" valign="bottom" background="/images/sms/sms_top.gif">
			<table width="130" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>&nbsp;</td>
			</tr>
			</table>
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
		<td height="186" align="center" valign="top" background="/images/sms/sms_bg02.gif">
			<table width="134" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50" align="right" valign="top" style="padding-top:3" >
					<font color="3677C0" style="font-size: 11px" >수 신&nbsp;</font>
				</td>
				<td width="91" align="left">
					<input name="phone1" class='txtbox' type=text maxlength='12'size='12' value = "<%=emp_tel%>" style="ime-mode:disabled;" OnKeyUp="fncOnlyNumber(this);">
				</td>
			</tr>		
			<tr>
				<td  width="50" align="right" style="padding-top:3">
					<font color="3677C0" style="font-size: 11px">발 신&nbsp;</font>
				</td>
				<td  align="left">
					<input  name="phone2"  type=text class='txtbox'  maxlength='11' size=12 value = "<%=o_tel%>" style="ime-mode:disabled;" OnKeyUp="fncOnlyNumber(this);">
				</td>
			</tr>
			<tr height=20>
				<td colspan='2'></td>
			</tr>
			<tr height=80>
				<td colspan='2' class="table_list4">
					<span class='red' style="font-size: 12px"><b>기능설명</b></span>:
					<font color="3677C0" style="font-size: 12px">
					고객을 유치한 유치자에게 </font><font color="red" style="font-size: 12px">고객정보 상태(개통,취소등)</font><font color="3677C0" style="font-size: 12px">를 문자메세지로 전송하는 기능입니다..</font>
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