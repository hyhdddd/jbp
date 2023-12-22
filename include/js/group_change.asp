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
  <%     
  Response.Write("var c_dealer_code = new Array()" & Chr(13))
  Response.Write("var c_dealer_name = new Array()" & Chr(13))
  Response.Write("var c_dealer_group_code = new Array()" & Chr(13))
  
  strSql = " SELECT * FROM dealer_info order by dealer_name asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		c_dealer_code		= objRs("dealer_code")
		c_dealer_name		= objRs("dealer_name")
		c_dealer_group_code	= objRs("dealer_group_code")
		
		Response.Write("c_dealer_code[" & i & "]		= '" & CStr(c_dealer_code) & "';")
		Response.Write("c_dealer_name[" & i & "]		= '" & CStr(c_dealer_name) & "';")
		Response.Write("c_dealer_group_code[" & i & "]	= '" & CStr(c_dealer_group_code) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close
  %> 
	 
function s_group_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	s_group_code				= code.options[idx].value;
	s_dealer_code_length		= frm.s_dealer_code.length;

	for(i=0; i<s_dealer_code_length;i++)
	{
		frm.s_dealer_code.options[i] = null;
	}
	
	frm.s_dealer_code.length=0;		
	frm.s_dealer_code.options[cnt++] = new Option('::협력점::','');
	

	for(i=0; i<c_dealer_code.length;i++)
	{	
		if(c_dealer_group_code[i]==s_group_code)
		{
			frm.s_dealer_code.options[cnt++] = new Option(c_dealer_name[i],c_dealer_code[i]);
		}	
	}

}
