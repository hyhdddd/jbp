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

  if ad_c_popup="N" then
 	Alert_URL session_m_name &" ���� �˾����� ������ �����ϴ�. �����ڿ��� �����ϼ���!","/main.asp"
  end if	

  if request("page")=""		then  page=1		Else page=Request("page")			end if
  if request("nowblock")="" then  nowblock=0	Else nowblock=Request("nowblock")	End If 

  %>  

<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta name="robots" content="noindex, nofollow">
<link href="/include/css/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="/include/js/common.js"></SCRIPT>

<body leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#000000">
<div class="outerContainer">
<table width="1000" border=0 cellspacing="0" cellpadding="2">
<tr bgcolor="#FFFFFF"> 
	<td>
	  	<!--#include virtual="/include/asp/cms_top.asp"-->
      </td>
</tr>
<tr height='400' valign='top'> 
	<td>
		<!------------------ ���� ����  ------------------>

		<div class="sub_title"><img src="/images/common/sub12_t06.gif"></div>
				
		<table width="100%" cellspacing=1 cellpadding=0 border=0 id="board_table2">
		<tr height='30'>
			<td colspan='4' align='right' class='con3' style="border-style:none;">
				<% if ad_c_popup="W" OR ad_c_popup="E" OR ad_c_popup="A" then %>
					<a href='popup_regist.asp'><img src="/images/button/btn_new.gif" align='absmiddle' border=0></a>&nbsp;&nbsp;
				<% else %>
					<a href='javascript:alert("<%=session_m_name%> ���� �˾� ��ϱ����� �����ϴ�. �����ڿ� �����ϼ���!");'><img src="/images/button/btn_new.gif" border="0"></a>&nbsp;&nbsp;
				<% end if %>						
			</td>
		</tr>
		<tr height=30>             
			<td width=50  class="head">��ȣ</td>
			<td width=700 class="head">��  ��</td>
			<td width=50  class="head">ǥ�ÿ���</td>
			<td width=100 class="head">�����</td>
		</tr>
  <% 


  strSql = " select *  from popup order by p_idx desc"  
  'response.write strSql
  objRs.PageSize = 15
  objRs.Open strSql, objCnn, 3

  if objRs.BOF or objRs.EOF Then
	  paging_chk="X"
  %>
				<tr height=30>
					<td align="center" class="con5" colspan='5'> ���� �������� �ʽ��ϴ�.</td>	
				</tr>		
  <%
  else
    
  	totalpage = objRs.pagecount
  	objRs.absolutepage = page
  	
  	i = 1
  	Do until objRs.EOF Or i>objRs.PageSize   	
  		p_idx			= objRs("p_idx")
  		p_title			= objRs("p_title")
  		p_contents		= objRs("p_contents")
  		p_writeday		= objRs("p_writeday")
		p_view			= objRs("p_view")

		If p_view="Y" Then
			p_view_txt = "����"
		Else
			p_view_txt = "����"
		End If 
  %>			  
				<tr height=30>
					<td class='con5'><%=i%></td>	
					<td class="con2"><a href="popup_regist.asp?p_idx=<%=p_idx%>&page=<%=page%>"><%=p_title%></a></td>	
					<td class='con4'><%=p_view_txt%></td>	
					<td class='con4'><%=FormatDatetime(p_writeday,2)%></td>	
				</tr>	
          
<% 
    	objrs.MoveNext
    	i=i+1 
    Loop
  End if   
    objRs.close
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
					link_url = "popup_list.asp?search_txt="&search_txt&"&search_key="&search_key&"&"
					%>
					<!--#include virtual="/include/asp/list_paging.asp"-->
				</div>		
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