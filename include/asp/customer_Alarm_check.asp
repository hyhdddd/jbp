  <% Session.CodePage = 949 %>
  <%
  '====================================='
  ' 프로젝트 : CenterCms PROJECT
  ' 목    적 : HTTP://WWW.CenterCMS.CO.KR
  ' 개발일자 : 2009/03/01 ~2009/05/31
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.CharSet = "euc-kr"
  Response.AddHeader "Pragma","no-cache"
  Response.AddHeader "Expires","0"

  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  %>  
  <!--#include virtual="/include/asp/dbconnection.asp"-->
  <!--#include virtual="/include/asp/Config.asp"-->
  <%

  strSql = "select top 1 board_idx, alarm_chk, customer_name, m_name, goods_idx from customer_goods_alarm where alarm_chk='X' order by board_idx desc"
  Set objRs=objCnn.Execute(strSql)

  If objRs.eof Or objRs.bof Then
	Response.write "X"
	'customer_name	= "최안규"
	'm_name			= "테스트"
	'Response.write "고객명:"&customer_name&"<br>"&"등록자:"&m_name&"<br>"&"시간:"&now()
  Else	
	board_idx		= objRs("board_idx")
	alarm_chk		= objRs("alarm_chk")
	customer_name	= objRs("customer_name")
	m_name			= objRs("m_name")
	goods_idx		= objRs("goods_idx")

  	'신규등록 고객 존재
	If alarm_chk="X" Then 		
  %>

		<table width='100%' height="150" border=0 cellspacing="0" cellpadding="0" style="font-size:12px;border:1px solid c7c7c7;background:url(/images/common/alram_bg.gif);">
		<tr height='30'>
			<td colspan='2' align='center'><font color="ff8400"><b>신규 등록 고객 정보</b></font></td>
		</tr>
		<tr height='25'>
			<td width='100' align='center'>고객명 :</td>
			<td width='150'><a href="/customer/a_custom_goods_regist.asp?g_goods_idx=<%=goods_idx%>"><b><%=customer_name%></b></a></td>
		</tr>
		<tr height='25'>
			<td width='100' align='center'>등록자 :</td>
			<td width='150'><%=m_name%></td>
		</tr>
		<tr height='25'>
			<td colspan='2' align='center'>고객명을 클릭하면 알림창이 사라집니다.</td>
		</tr>
		<tr>
			<td colspan='2' align='right'><span onclick="Alarm_hidden();" onmouseover="this.style.cursor='hand'"><img src="/images/button/btn_colse2.gif"></span>
			<audio controls loop autoplay>
			<embed src="/images/wav/new_goods.wav" LOOP="0" AUTOSTERT="TRUE"  hidden="true"></embed></object>
			</td>
		</tr>		
		</table>
  <%
		strSql = "delete customer_goods_alarm where alarm_chk='O'"
		Set objRs=objCnn.Execute(strSql)
	End If
  End if
  %>
  