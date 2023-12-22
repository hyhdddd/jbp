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
  
  if ad_c_sms="N" Or ad_c_sms="R" then
 	Alert session_m_name &" 님은 SMS 관리 권한이 없습니다. SMS관리 쓰기권한 이상이여야 사용가능 합니다. \n\n 관리자에게 문의하세요!"
	Win_close()
  end if	

  message_cnt	= 0

  o_tel			= o_tel1+o_tel2+o_tel3  
  %>
<title>:::::::<%=o_com_name%> 관리시스템 :::::::</title>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>
<script language="javascript">
<!--
	function insertStr(txt)
	{
		var frm=document.all.frm_sms;
		frm.content.value=frm.content.value+txt;
		document.all.frm_sms.txt_length.value = parseInt(document.all.frm_sms.txt_length.value)+1;
	}

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
		
		document.all.frm_sms.txt_length.value= result;
	}



	function sms_group_send()
	{
		var frm=document.all.frm_sms;
		if(frm.content.value=="")
		{
			alert("내용을 입력해주세요!")
			frm.content.focus();
			return;
		}
		
		var chk=0
		aaa=frm.group_idx;
		
		if(aaa==undefined)
		{
			alert("SMS그룹관리에서 그룹을 먼저 만들어 주시기 바랍니다.");
			return;
		}

		if(frm.group_idx.length==undefined)
		{
			if(frm.group_idx.checked==true)
			{
				chk++;
			}
		}
		else
		{
			for(i=0;i<frm.group_idx.length;i++)
			{
				if(frm.group_idx[i].checked==true)
				{
					chk++;
				}
			}
		}
		if(chk==0)
		{
			alert("전송그룹을 선택해주세요!");
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

		ans=confirm("문자전송을 하시겠습니까?");

		if (ans==true)
		{
			frm.submit();
		}
	}
-->
</script>
<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellpadding="0" cellspacing="0">
<tr bgcolor="#FFFFFF"  align='center'> 
	<td valign='top' align='center'>
		
		<!------------------ 내용 시작  ------------------>    
	
		<div class="sub_title"><img src="/images/common/sub12_t04_3.gif" width='680'></div>

		<form name="frm_sms" Method="POST" action="sms_group_regist_ok.asp">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="board_table3">
		<tr height='30'>
			<td colspan='4'>&nbsp;&nbsp;
			  	<a href="/sms/sms_group_regist.asp"> SMS 그룹전송 </a>&nbsp;&nbsp;|&nbsp;&nbsp;
			  	<a href="/sms/sms_group_list.asp"> SMS 그룹관리 </a>&nbsp;&nbsp;|&nbsp;&nbsp;
			</td>
		</tr>
		</table>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #C7C7C7;">
		<tr>
			<tr height='30'>
				<td colspan='2'>&nbsp;</td>
			</tr>
		</tr>
		<tr>
			<td width='180'>
				<table width="180" border="0" cellpadding="0" cellspacing="0">
				<tr> 
					<td width="180" height="49" align="center" valign="bottom" background="/images/sms/sms_top.gif"></td>
				</tr>
				<tr> 
					<td height="215" align="center" valign="top" background="/images/sms/sms_bg01.gif" style="padding-top:3"> 
						<table width="175" height="142" border="0" cellpadding="0" cellspacing="0">
						<tr> 
							<td align="center" valign="bottom" style="padding-bottom:15">
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

						<table>
						<tr>
							<td  width="50" align="right" style="padding-top:3">
								<font color="3677C0" style="font-size: 11px">발신번호</font>
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
						<area shape="rect" coords="26,4,95,41" href="javascript:sms_group_send();">
						<area shape="rect" coords="98,4,152,41" href="javascript:self.close();">
						</map>		
					</td>
				</tr>
				</table>  
			</td>
			<td width='500' valign='top'>

				<span id="spanRight" style="border-right: 1px solid #C7C7C7;width:100%;height:240;overflow-y:scroll;">					
				<TABLE width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
				<tr height=30>             
					<td class="head" width=50>번  호</td>
					<td class="head" width=450>SMS 그룹명</td>
					<td class="head" width=150>그룹선택</td>
				</tr>
		  <%
		  if request("page")=""		then  page=1		Else page=Request("page")			end if
		  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

		  strSql = " select * from sms_group order by group_name asc"

		  strSql = " select A.group_idx , A.group_name , A.group_writeday , isnull(B.group_cnt,0) as group_cnt  from sms_group A  "
		  strSql = strsql & " Left outer join "
		  strSql = strSql & " (SELECT group_idx, count(group_idx) as group_cnt FROM sms_group_emp  GROUP BY group_idx ) B "
		  strSql = strSql & "		ON A.Group_idx=B.group_idx "
		  strSql = strSql & "     	 ORDER BY A.group_name ASC "
		  Set objRs=objCnn.Execute(strSql)
		  
		  if objRs.BOF or objRs.EOF Then
			paging_chk="X"
		  %>
				<tr height=30>
					<td colspan='4' align='center' class="table_list3">
						코드가 존재하지 않습니다.
					</td>
				</tr>
		  <%
		  else      		 
			

			i = 1
			Do until objRs.EOF 
				group_idx			= objRs("group_idx")
				group_name			= objRs("group_name")
				group_writeday		= objRs("group_writeday")
				group_cnt			= objRs("group_cnt")
		  %>	
				<tr height=30>
					<td class="con5"><%=i%></td>
					<td class="con2"><%=group_name%> (<%=group_cnt%>명)</td>
					<td class="con4"><input type="checkbox" name="group_idx" value="<%=group_idx%>"> 선택
					</td>
		  <% 
				objRs.MoveNext
				i=i+1 
			loop
		  %>							
		  <%
		   objRs.close
		   end if					
		%>   
				</table>
				</span>

				<br><br>
				<center>
				<div style="font-size:12px;border:1px solid #b8ddf3;padding:6px 0 0 2px;width:480px;.width:480px;height:53px;.height:61px;border:1px solid #CDCDCD;color:#000000;line-height:1.25em;font-family:dotum;">
				<a href="javascript:parent.insertStr('★');">★</a> <a href="javascript:parent.insertStr('☆');">☆</a> 
				<a href="javascript:parent.insertStr('☎');">☎</a> <a href="javascript:parent.insertStr('☏');">☏</a> 
				<a href="javascript:parent.insertStr('☜');">☜</a> <a href="javascript:parent.insertStr('☞');">☞</a> 
				<a href="javascript:parent.insertStr('※');">※</a> <a href="javascript:parent.insertStr('♥');">♥</a> 
				<a href="javascript:parent.insertStr('♡');">♡</a> <a href="javascript:parent.insertStr('♣');">♣</a> 
				<a href="javascript:parent.insertStr('♠');">♠</a> <a href="javascript:parent.insertStr('♤');">♤</a> 
				<a href="javascript:parent.insertStr('♧');">♧</a> <a href="javascript:parent.insertStr('♨');">♨</a> 
				<a href="javascript:parent.insertStr('ㆀ');">ㆀ</a> <a href="javascript:parent.insertStr('♩');">♩</a> 
				<a href="javascript:parent.insertStr('♪');">♪</a> <a href="javascript:parent.insertStr('♬');">♬</a> 
				<a href="javascript:parent.insertStr('■');">■</a> <a href="javascript:parent.insertStr('□');">□</a> 
				<a href="javascript:parent.insertStr('▣');">▣</a> <a href="javascript:parent.insertStr('▤');">▤</a> 
				<a href="javascript:parent.insertStr('▦');">▦</a> <a href="javascript:parent.insertStr('▨');">▨</a> 
				<a href="javascript:parent.insertStr('▩');">▩</a> <a href="javascript:parent.insertStr('▒');">▒</a> 
				<a href="javascript:parent.insertStr('▲');">▲</a> <a href="javascript:parent.insertStr('△');">△</a> 
				<a href="javascript:parent.insertStr('▶');">▶</a> <a href="javascript:parent.insertStr('▷');">▷</a> 
				<a href="javascript:parent.insertStr('▼');">▼</a> <a href="javascript:parent.insertStr('▽');">▽</a> 
				<a href="javascript:parent.insertStr('◀');">◀</a> <a href="javascript:parent.insertStr('◁');">◁</a> 
				<a href="javascript:parent.insertStr('◆');">◆</a> <a href="javascript:parent.insertStr('◇');">◇</a> 
				<a href="javascript:parent.insertStr('◈');">◈</a> <a href="javascript:parent.insertStr('●');">●</a> 
				<a href="javascript:parent.insertStr('○');">○</a> <a href="javascript:parent.insertStr('◎');">◎</a> 
				<a href="javascript:parent.insertStr('⊙');">⊙</a> <a href="javascript:parent.insertStr('◐');">◐</a> 
				<a href="javascript:parent.insertStr('◑');">◑</a> <a href="javascript:parent.insertStr('←');">←</a> 
				<a href="javascript:parent.insertStr('↑');">↑</a> <a href="javascript:parent.insertStr('→');">→</a> 
				<a href="javascript:parent.insertStr('↓');">↓</a> <a href="javascript:parent.insertStr('⇒');">⇒</a> 
				<a href="javascript:parent.insertStr('∀');">∀</a> <a href="javascript:parent.insertStr('∃');">∃</a> 
				<a href="javascript:parent.insertStr('∏');">∏</a> <a href="javascript:parent.insertStr('∞');">∞</a> 
				<a href="javascript:parent.insertStr('∧');">∧</a> <a href="javascript:parent.insertStr('∪');">∪</a> 
				<a href="javascript:parent.insertStr('∬');">∬</a> <a href="javascript:parent.insertStr('∴');">∴</a> 
				<a href="javascript:parent.insertStr('￥');">￥</a> 
				</div>
				</center>
			</td>
		</tr>
		</table>
        
		</form>

		<!------------------ 내용 종료  ------------------>				
			
	</td>
</tr>
</table>
</body>
