<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function showHideLayers(obj) { //v3.0
	document.all.Layer1.style.visibility="hidden";
	document.all.Layer2.style.visibility="hidden";
	document.all.Layer3.style.visibility="hidden";
	document.all.Layer4.style.visibility="hidden";
	document.all.Layer5.style.visibility="hidden";
	document.all.Layer6.style.visibility="hidden";
	document.all.Layer7.style.visibility="hidden";
	document.all.Layer8.style.visibility="hidden";
	document.all.Layer9.style.visibility="hidden";
	document.all.Layer10.style.visibility="hidden";

	var obj=eval("document.all."+obj);
	obj.style.visibility="visible";
}
//-->
</script>

<div id="top">
	<table width="100%" border=0 cellspacing=0 cellpadding=0>
	<tr height='40'>
		<!---- 구버전 메뉴 붙는현상(바로아래 스타일 style="font-size:16px dotum;color:#022c74;font-weight:bold;padding-left: 10px;" -->
		<td width='250' style="font-size:16px dotum;color:#022c74;font-weight:bold;padding-left: 10px;"><a href="/main.asp"><%=logo_img%></a></td>
		<td width='200' valign='bottom' align='right'><span class='blue'><nobr><%=session_m_name%>님 로그인</span></nobr></td>
		<td align='right' valign='bottom'>
			<nobr>
			<a href="http://onsalehome.uplus.co.kr/" target="_blank"><img src="/images/button/btn_lg_auth.gif" /></a>	
			<a href="https://ok.skbroadband.com/service/preok/start.jsp " target="_blank"><img src="/images/button/btn_sk_auth.gif" /></a>


			<% If o_code="C0001" Then %>
			<img src="/images/button/btn_pw.gif" onmouseover="this.style.cursor='hand';">
			<% Else %>
			<a href="/information/passwd_regist.asp"><img src="/images/button/btn_pw.gif" /></a>
			<% End If %>
				
			<% If t_dealer_code=o_code Then %>

			<span onclick="NewWindow('/sms/sms_batch_regist.asp','sms_group_add','340','450','no');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_sms.gif"></span>

			<% End If %>
			

			<a href="javascript:NewWindow('/include/asp/communication_info.asp','info_url','350','370','no');" onmouseover="this.style.cursor='hand';"><img src="/images/button/btn_user_info.gif" /></a>
			<a href="/include/asp/logout.asp"><img src="/images/common/btn_logout.gif" /></a></nobr>
		</td>
	</tr>
	</table>
	<table width="100%" border=0 cellspacing=0 cellpadding=0>
	<tr height='40'>
		<Td style="background:url(/images/common/top_m_bg.gif) repeat-x"><img src="/images/common/top_m00.gif" width='15' height='40'/><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu1','','/images/common/top_m01_o.gif',1);showHideLayers('Layer1');"><img src="/images/common/top_m01.gif"  alt="고객관리" name="topmenu1" border="0" id="topmenu1" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu2','','/images/common/top_m02_o.gif',0);showHideLayers('Layer2');"><img src="/images/common/top_m02.gif" alt="가망고객관리" name="topmenu2" border="0" id="topmenu2" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu3','','/images/common/top_m03_o.gif',0);showHideLayers('Layer3');"><img src="/images/common/top_m03.gif" alt="인사관리" name="topmenu3" border="0" id="topmenu3" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image5','','/images/common/top_m05_o.gif',0);showHideLayers('Layer5');"><img src="/images/common/top_m05.gif" alt="실적관리" name="Image5" border="0" id="Image5" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu6','','/images/common/top_m06_o.gif',0);showHideLayers('Layer6');"><img src="/images/common/top_m06.gif" alt="정산관리" name="topmenu6" border="0" id="topmenu6" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu10','','/images/common/top_m10_o.gif',0);showHideLayers('Layer10');"><img src="/images/common/top_m10.gif" alt="정책표보기" name="topmenu10"  border="0" id="topmenu10" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu7','','/images/common/top_m07_o.gif',0);showHideLayers('Layer7');"><img src="/images/common/top_m07.gif" alt="고객센터" name="topmenu7" border="0" id="topmenu7" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu8','','/images/common/top_m08_o.gif',0);showHideLayers('Layer8');"><img src="/images/common/top_m08.gif" alt="부가서비스" name="topmenu8"  border="0" id="topmenu8" /></a><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('topmenu9','','/images/common/top_m09_o.gif',0);showHideLayers('Layer9');"><img src="/images/common/top_m09.gif" alt="부가서비스" name="topmenu9"  border="0" id="topmenu9" /></a></td>
		<td  width='15'><img src="/images/common/top_m_end.gif" width='15' height='40'/></td>		
	</tr>
	<tr height='30'>
		<td align="left" colspan='2'>&nbsp;
			<div id="Layer1" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:35px;">
					<% If ad_b_p_custom<>"N" Then %>
					<a href="/customer/p_custom_goods_list.asp"><font style="COLOR:#1A5699;">개인 고객관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_b_y_custom<>"N" Then %>
					<a href="/customer/y_custom_goods_list.asp"><font style="COLOR:#1A5699;">협력점 고객관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_b_a_custom<>"N" Then %>
					<a href="/customer/a_custom_goods_list.asp"><font style="COLOR:#1A5699;">전체 고객관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/customer/a_custom_goods_diary.asp"><font style="COLOR:#1A5699;">전체 일정관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/customer/a_custom_goods_consult_list.asp"><font style="COLOR:#1A5699;">전체 상담관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_b_g_custom<>"N" Then %>
					<a href="/customer/g_custom_goods_list.asp"><font style="COLOR:#1A5699;">상부점 고객관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_b_m_custom<>"N" Then %>
					<a href="/customer/m_custom_goods_list.asp"><font style="COLOR:#1A5699;">담당별 고객관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>		
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer2" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:130px;">

					<% If ad_g_p_gamang<>"N" Then %>
					<a href="/gamang/p_gamang_list.asp"><font style="COLOR:#1A5699;">개인 가망고객 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<a href="/gamang/p_gamang_diary.asp"><font style="COLOR:#1A5699;">개인 가망고객 일정</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>


					<% If ad_g_y_gamang<>"N" Then %>
					<a href="/gamang/y_gamang_list.asp" style="COLOR:#1A5699;">협력점 가망고객 관리</a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_g_a_gamang<>"N" Then %>
					<a href="/gamang/a_gamang_list.asp"><font style="COLOR:#1A5699;">전체 가망고객 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<a href="/gamang/a_gamang_diary.asp"><font style="COLOR:#1A5699;">전체 가망고객 일정</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

				</td>
			</tr>
			</table>
			</div>

			<div id="Layer3" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:170px;" valign='middle'>
					<% If ad_i_y_emp<>"N" Then %>
					<a href="/insa/y_emp_list.asp"><font style="COLOR:#1A5699;">직영사원관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
					<% If ad_i_a_emp<>"N" Then %>
					<a href="/insa/a_emp_list.asp"><font style="COLOR:#1A5699;">전체사원관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
					<% If ad_i_a_company<>"N" Then %>
					<a href="/insa/a_company_list.asp"><font style="COLOR:#1A5699;">협력점 정보관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/insa/y_partner_list.asp"><font style="COLOR:#1A5699;">협력점 신청관리</font></a>
					  &nbsp;&nbsp;&nbsp;
					<%
					  End If
					%>
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer4" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:270px;">
					<% If ad_p_a_pay<>"N" Then %>
					<a href="/pay/pay_a_list.asp"><font style="COLOR:#1A5699;">관리팀 급여 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<a href="/pay/pay_c_list.asp"><font style="COLOR:#1A5699;">영업팀 급여 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<a href="/pay/pay_t_list.asp"><font style="COLOR:#1A5699;">급여 명세서 출력</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer5" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:270px;">
					<% If ad_k_p_result<>"N" Then %>
					<a href="/result/p_result_main.asp"><font style="COLOR:#1A5699;">개인 실적 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_k_y_result<>"N" Then %>
					<a href="/result/y_result_main.asp"><font style="COLOR:#1A5699;">직영 실적 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_k_a_result<>"N" Then %>
					<a href="/result/a_result_main.asp"><font style="COLOR:#1A5699;">전체 실적 관리</a></font>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer6" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:200px;">
					<% If ad_r_p_exact<>"N" Then %>		
					<a href="/exact_view/p_exact_list.asp"><font style="COLOR:#1A5699;">개인 정산내역서</font></a>
					&nbsp;&nbsp;&nbsp;					
					<% End If %>

					<% If ad_r_y_exact<>"N" Then %>		
					<a href="/exact_view/y_exact_list.asp"><font style="COLOR:#1A5699;">협력점 정산내역서</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
					
					<% If ad_p_gift<>"N"  Then %>	
					<a href="/exact_apply/p_apply_list.asp"><font style="COLOR:#1A5699;">정산일 신청</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/board_gift/p_gift_list.asp"><font style="COLOR:#1A5699;">추가사은품 신청</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>


					<% If ad_r_a_exact<>"N" Then %>	
					<a href="/exact/a_exact_list.asp"><font style="COLOR:#1A5699;">전체 정산관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/exact_view/a_exact_list.asp"><font style="COLOR:#1A5699;">전체 정산내역서</font></a>
					&nbsp;&nbsp;&nbsp;	
					<% End If %>

					
					<% If ad_a_gift<>"N" Then %>	
					<a href="/exact_apply/a_apply_list.asp"><font style="COLOR:#1A5699;">정산일 관리</font></a>
					&nbsp;&nbsp;&nbsp;					
					<a href="/board_gift/a_gift_list.asp"><font style="COLOR:#1A5699;">추가사은품 관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

				</td>
			</tr>
			</table>
			</div>

			<div id="Layer7" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:470px;">
					<% If ad_e_notice1<>"N" Then %>
					<a href="/center/board_notice1/board_list.asp?tname=board_notice1"><font style="COLOR:#1A5699;">사내 공지사항</font></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<% End If %>
					<% If ad_e_data1<>"N" Then %>
					<a href="/center/board_data1/board_list.asp?tname=board_data1"><font style="COLOR:#1A5699;">사내 자료실</font></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_e_notice2<>"N" Then %>
					<a href="/center/board_notice2/board_list.asp?tname=board_notice2"><font style="COLOR:#1A5699;">협력점 공지사항</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_e_data2<>"N" Then %>
					<a href="/center/board_data2/board_list.asp?tname=board_data2"><font style="COLOR:#1A5699;">협력점 자료실</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer8" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:550px;">
					<a href="/center_mail/mail_write.asp"><font style="COLOR:#1A5699;">메일작성</font></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="/center_mail/mail_to_list.asp"><font style="COLOR:#1A5699;">받은 메일</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/center_mail/mail_send_list.asp"><font style="COLOR:#1A5699;">보낸메일</font></a>
					&nbsp;&nbsp;&nbsp;
					<a href="/center_mail/mail_del_list.asp"><font style="COLOR:#1A5699;">지운메일</font></a>
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer9" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:200px;">
					<% If ad_c_sms<>"N" Then %>
					<a href="/sms/a_sms_list.asp"><font style=" COLOR:#1A5699;">SMS 관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>		
					
					<% If ad_c_code<>"N" Then %>
					<a href="/code/article_list.asp"><font style="COLOR:#1A5699;">코드관리</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_c_popup<>"N" Then %>
					<a href="/information/popup_list.asp"><font style="COLOR:#1A5699;">팝업 공지</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_c_black<>"N" Then %>
					<a href="/information/custom_black_list.asp"><font style="COLOR:#1A5699;">블랙리스트</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If session_m_step="M" Then %>
					<a href="/information/company_info_regist.asp"><font style="COLOR:#1A5699;">사업자 정보</font></a>
					&nbsp;&nbsp;&nbsp;

					<a href="/information/y_partner_agree.asp"><font style="COLOR:#1A5699;">협력점 약관</font></a>	
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					
				</td>
			</tr>
			</table>
			</div>

			<div id="Layer10" style="width:1000px; height:30px; position:absolute; left:20px; top:85px; z-index;1; visibility:hidden;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  style="FONT-SIZE:12px;">
			<tr height="30">
				<td style="padding-left:550px;">
					<% If ad_r_y_exact<>"N" Then %>		
					<a href="/policy/y_policy_list.asp"><font style="COLOR:#1A5699;">협력점 정책표</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>

					<% If ad_r_a_exact<>"N" Then %>		
					<a href="/policy/a_policy_list.asp"><font style="COLOR:#1A5699;">전체 정책표</font></a>
					&nbsp;&nbsp;&nbsp;
					<% End If %>
				</td>
			</tr>
			</table>
			</div>
			
		</td>
	</tr>
	</table>
</div>
