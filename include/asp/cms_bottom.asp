<div id="select_price" style="visibility:hidden;"></div>
<div class="copyright">
<table width="100%" border=0 cellspacing="0" cellpadding="0" style="font-size:11px;">
<tr>
	<td rowspan="2" width="169"><img src="/images/common/bottom.gif"></td>
	<td valign="bottom">&nbsp;&nbsp;(우: <%=o_zipcode1%>-<%=o_zipcode2%>)&nbsp; <%=o_address%>&nbsp;&nbsp;
	<% If o_tel1="0" Or o_tel1="00" Then %>
	대표전화: <%=o_tel2%>-<%=o_tel3%>
	<% Else %>
	대표전화: <%=o_tel1%>-<%=o_tel2%>-<%=o_tel3%>
	<% End If %>&nbsp;&nbsp;	
	대표팩스: <%=o_fax1%>-<%=o_fax2%>-<%=o_fax3%>	
	</td>
 <tr>
	<td valign="top">&nbsp;&nbsp;사업자등록번호: <%=o_office_no1%>-<%=o_office_no2%>-<%=o_office_no3%>&nbsp;&nbsp;Copyright (c)<%=o_com_name%> All rights reserved.</td>
</tr>
</table>
</div>


