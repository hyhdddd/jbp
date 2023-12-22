  <%
  '====================================='
  ' 프로젝트 : 엔터소프트
  ' 개 발 자 : 최 안 규 
  ' 이 메 일 : cak0280@nate.com
  ' 문    의 : 010-9619-8289
  '====================================='
  Response.Expires = -1000
  Response.CacheControl = "no-cache"
  Response.AddHeader "Pragma", "no-cache"
  Response.AddHeader "cache-control", "no-store"
  Response.ContentType = "application/x-javascript"
  %>
  <!--#include virtual="/include/asp/dbconnection.asp"--> 
  <!--#include virtual="/include/asp/config.asp"--> 
  <%     
  Response.Write("var c_combine_idx		= new Array()" & Chr(13))
  Response.Write("var c_article1_idx	= new Array()" & Chr(13))
  Response.Write("var c_combine_name	= new Array()" & Chr(13))
  
  strSql = " SELECT * FROM code_combine where combine_view='Y' order by combine_order asc"
  set objRs=objCnn.Execute(strSql)
	
  i=0
  Do Until objRs.EOF
		c_combine_idx		= objRs("combine_idx")&""
		c_article1_idx		= objRs("article1_idx")&""
		c_combine_name		= objRs("combine_name")&""
        	
       	Response.Write("c_combine_idx["& i &"]	= '" & CStr(c_combine_idx) &"';"& Chr(13)&Chr(10))
       	Response.Write("c_article1_idx["& i &"]	= '" & CStr(c_article1_idx) &"';"& Chr(13)&Chr(10))
       	Response.Write("c_combine_name["& i &"]	= '" & CStr(c_combine_name) &"';"& Chr(13)&Chr(10))
       	objRs.MoveNext
       	i = i + 1
  Loop

  objRs.Close
  %> 

	
function fnc_combine_change(This, form_name, This_idx, Target) 
{
	var frm				= document.getElementById(form_name);
	var frm_Target		= eval("frm."+Target);
	cnt					= 0;
	This_value			= This.options[This_idx].value;
	Target_length		= eval("frm_Target.length");

	for(i=0; i<Target_length;i++)
	{
		frm_Target.options[i] = null;
	}
	
	frm_Target.length=0;		
	frm_Target.options[cnt++] = new Option('::결합선택::','0');
	

	for(i=0; i<c_combine_idx.length;i++)
	{	
		if(This_value==c_article1_idx[i])
		{
			frm_Target.options[cnt++] = new Option(c_combine_name[i],c_combine_idx[i]);
		}	
	}
}
