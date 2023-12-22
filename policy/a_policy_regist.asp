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
  <!--#include virtual="/include/asp/Config.asp"-->
  <!--#include virtual="/include/asp/admin_chk.asp"-->

  <%
  Login_chk(Session_m_id)
 
  if ad_r_a_exact="N" then
 	Alert_URL session_m_name &" 님은 전체 정산관리 권한이 없습니다. 관리자에게 문의하세요!","/main.asp"
  end if	

  chk				= WORD_CHANGE(request("chk"),10)
  policy_idx		= WORD_CHANGE(Request("policy_idx"),10)

  If policy_idx="" then
	charge_idx		= WORD_CHANGE(Request("charge_idx"),10)
	group_code		= WORD_CHANGE(Request("group_code"),20)


	strsql = " select A.policy_idx, A.policy_date, A.group_code, A.writeday, B.group_name "
	strSql = strSql & "	from charge_policy  A left outer "
	strSql = strSql & "		join code_group B ON A.group_code=B.group_code"
	strSql = strSql & "			where A.policy_idx="&charge_idx
	Set objRs=objCnn.Execute(strSql)

	group_code	= objRs("group_code")
	group_name	= objRs("group_name")
	policy_date	= fnc_date_change(objRs("policy_date"))

	policy_title		= policy_date & " 부터 적용되는 수수료 정책 입니다."

  Else
	strSql = "select * from policy_list A left outer join code_group B ON A.group_code=B.group_code where policy_idx="&policy_idx
	Set objRs=objCnn.Execute(strSql)

	policy_title	= objRs("policy_title")
	policy_date		= fnc_date_change(objRs("policy_date"))
	group_code		= objRs("group_code")
	group_name		= objRs("group_name")
	charge_idx		= objRs("charge_idx")
  End If  
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script type="text/JavaScript" src="/include/editor/ckeditor.js"></script>

<script language="javascript">
<!--

function OnConditionAdded( queryName, queryValue ) 
{    
	var frm		= document.getElementById('frm_board');

	var chk="O";
	for(i=0;i<frm.select_name.length;i++)
	{
		if (frm.select_name[i].value==queryValue)
		{
			chk="X";
		}
	}

	if(chk=="O")
	{
		frm.select_name.options[frm.select_name.length] = new Option( queryName, queryValue );
	}
	else
	{
		alert("이미 등록되어 있는 협력점 입니다.");
	}
	//alert(aa);
	return true;
} 

function send_board_write(form_name)
{
	var frm		= eval("document.getElementById('"+form_name+"')");


	frm.dealer_code.value="";
	hid_str="";
	
	if(frm.select_name.length!=0)
	{
		for(i = 0; i < frm.select_name.length; i++) 
       	{
	     	receipt_str = frm.select_name.options[i].value+"_";
			hid_str		= hid_str+receipt_str;
		}
	}
		
	frm.dealer_code.value=hid_str;

	
	if(frm.policy_title.value=="")
	{
		alert("제목을 입력해 주세요!");
		return;
	}

	if (frm.dealer_code.value=="")
	{
		alert("정책표를 받을 협력점을 선택해 주세요!");
		return;
	}

	chk="X";

	var check_obj = document.getElementsByName('article_idx[]') ;

    if(check_obj.length) 
	{
		for(i=0; i<check_obj.length; i++)
		{
			if(check_obj.item(i).checked)
			{
				chk="O";
			}
		}
	}

	if(chk=="X")
	{
		alert("발송할 정책 상품을 하나 이상 선택해 주세요!");
		return;
	}

	ans=confirm("수수료 정책표를 발송하시겠습니까?");

	if (ans==true)
	{
		frm.submit();
	}
}

function policy_style_view(form_name) 
{
	var check_obj = document.getElementsByName('article_idx[]') ;
	
    if(check_obj.length) 
	{
		for(i=0; i<check_obj.length; i++)
		{
			check_value = check_obj.item(i).value;

			if(check_obj.item(i).checked)
			{
				style_view = eval("document.all.style_view"+check_value+".style");


				style_view.display = "block"; 	
				style_view.display = ""; 	
			}
			else
			{
				style_view = eval("document.all.style_view"+check_value+".style");
				style_view.display = "none"; 	
			}
			
		}
	}

}


// 삭제기능
function select_name_del1(form_name)
{
	var frm		= eval("document.getElementById('"+form_name+"')");
	if(frm.select_name.selectedIndex=="-1")
	{
		alert("협력점을 선택해 주세요");
		return;
	}
	else
	{
		frm.select_name.options[frm.select_name.selectedIndex] = null;
	}
}

window.onload	= function()
{
	policy_style_view('frm_board');
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
		
		<!------------------ 내용 시작  ------------------>

		<div class="sub_title"><img src="/images/common/sub16_t02.gif"></div>

		<form id="frm_board" name="frm_board" action="a_policy_regist_ok.asp"  ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST">
		<input type="hidden" name="chk" value="<%=chk%>">
		<input type="hidden" name="policy_idx" value="<%=policy_idx%>">
		<input type="hidden" name="charge_idx" value="<%=charge_idx%>">
		<input type="hidden" name="group_code" value="<%=group_code%>">
		<input type="hidden" name="policy_date" value="<%=policy_date%>">
		<input type="hidden" name="dealer_code" value="<%=dealer_code%>">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="board_table3">
		<tr height=30> 
			<th width='150'>제 목 </th>
			<td width='850'> 
				<input type="text" class="txtbox" name="policy_title" size="50" value="<%=policy_title%>">				
			</td>
		</tr>
		<tr height=30> 
			<th>수수료정책 일자 </th>
			<td> <%=policy_date%> </td>
		</tr>
		<tr height=30> 
			<th> 정책 그룹 </th>
			<td> <%=group_name%></td>
		</tr>
		<tr height=30> 
			<th> 협 력 점 </th>
			<td> 
				<select name="select_name" size=4  MULTIPLE  style="width:300; border-width:1; border-style:solid; border-color:003366;">
  <%
 If policy_idx="" then
	  strSql = "select * from dealer_info where dealer_group_code='"&group_code&"' and dealer_view='Y' "
	  Set objRs=objCnn.Execute(strSql)
	  Do Until objRs.eof
			dealer_code		= objRs("dealer_code")
			dealer_name		= objRs("dealer_name")
	  %>
				<option value="<%=dealer_code%>"><%=dealer_name%></option>
	  <%
		objRs.movenext
	  Loop
  Else
	strSql = " select * from policy_list_dealer A left outer "
	strSql = strSql & "		join dealer_info B ON A.dealer_code=B.dealer_code "
	strSql = strSql & "		where A.policy_idx="&policy_idx
	strSql = strSql & "			order by board_idx asc"
	Set objRs=objCnn.Execute(strSql)

	Do Until objRs.eof 
		dealer_code		= objRs("dealer_code")
		dealer_name		= objRs("dealer_name")
  %>
				<option value="<%=dealer_code%>"><%=dealer_name%></option>
  <%
		objRs.movenext
	loop
  End if  
  %>

				</select>
				<img src="/images/button/btn_partner_del.gif" border="0" onclick="select_name_del1('frm_board');" onmouseover="this.style.cursor='hand';">

				<a href="javascript:NewWindow('a_policy_add.asp?group_code=<%=group_code%>','dealer_add',580,550,'yes');">
					<img src="/images/button/btn_partner_add.gif" border="0"></a>
			</td>
		</tr>


   <%

  strSql = " select * from code_article where article_view='Y'	and article_step2=0 order by article_order asc "
  Set objRs=objCnn.Execute(strSql)

  Do Until objRs.eof
	article_idx			= objRs("article_idx")
	article_name		= objRs("article_name")
	article_step1		= objRs("article_step1")
	article_step2		= objRs("article_step2")
	chk					= "X"
	article_name_old	= article_name

	strSql = " select * from  code_article where  article_view='Y' and article_step2>0 "
	strSql = strSql & " and article_step1="&article_step1&" order by article_order asc"
	Set objRs5=objCnn.Execute(strSql)

	Do Until objRs5.eof
  		article_idx1			= objRs5("article_idx")

		strSql = " select promise_idx,promise_name from code_promise where article_idx="&article_idx1&" and promise_policy='Y'"
		Set objRs1=objCnn.Execute(strSql)
		
		If objRs1.eof Or objRs1.bof Then
		Else
			chk="O"
		End If

		objRs5.movenext
	Loop

	If chk="O" Then
		chk1=" checked"
		e_contents =""
		If policy_idx<>"" then
			strSql = "select policy_bigo from policy_list_article where policy_idx="&policy_idx&" and article_idx="&article_idx
			Set objRs6=objCnn.Execute(strSql)
			
			If objRs6.eof Or objRs6.bof Then
				chk1 =" "
				e_contents = ""
			Else
				chk1 =" checked "
				e_contents	= objRs6("policy_bigo")
			End If

		End if
		%>
		<tr height='30'>
			<th> 정책상품 </th>
			<Td>
				<input type='checkbox' name='article_idx[]' value='<%=article_idx%>' <%=chk1%> onclick="policy_style_view('frm_board');"><%=article_name_old%>&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
  		<tr height=30 id="style_view<%=article_idx%>"> 
			<th> <%=article_name_old%> </th>
			<td> 
			<textarea cols="80" class="ckeditor" id="board_contents<%=article_idx%>" name="board_contents<%=article_idx%>" rows="10" style="background-color: yellow;"><%=e_contents%></textarea>
				<script>CKEDITOR.replace( 'board_contents<%=article_idx%>', {
					filebrowserImageUploadUrl: '/include/editor/upload/upload.asp?type=Images&tname=<%=o_code%>/<%=tname%>',
					filebrowserFlashUploadUrl: '/include/editor/upload/upload.asp?type=Flash&tname=<%=o_code%>/<%=tname%>'
					});</script>
			</td>
		</tr>
  <%
	End if
	objRs.movenext
  Loop
  %>
		<tr height=30> 
			<th> 확인 비밀번호 </th>
			<td> <input type="text" name="policy_passwd" size='20' maxlength='20' class='txtbox'> 
				<span class='red'> 협력점 확인시 입력해야할 비밀번호힙니다. (입력하지 않으면 비밀번호 없이 확인 가능합니다) </span>
			</td>
		</tr>
		<tr height=30> 
			<th> 파일 </th>
			<td><input type="file" class="txtbox" name="policy_file1" size="40"></td>
		</tr>
		<tr height=30>            
			<td align='center' colspan="2"> 
				<a href="/charge/policy_list.asp"><img src="/images/button/btn_list.gif" border="0"></a> 

				<img src="/images/button/btn_regist.gif" onclick="send_board_write('frm_board');" onmouseover="this.style.cursor='hand';"> 

			</td>
		</tr>
		</form>	
		</table>
		<!------------------ 내용 종료  ------------------>					          
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