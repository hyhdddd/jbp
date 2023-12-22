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
  Response.Write("var j_area_idx			= new Array()" & Chr(13))
  Response.Write("var j_area_article_idx	= new Array()" & Chr(13))
  Response.Write("var j_area_name			= new Array()" & Chr(13))
  
  strSql = " SELECT * FROM code_area "
  strSql = strSql & " where area_view='Y' order by area_order asc"
  set objRs=objCnn.Execute(strSql)
	
  i=0
  Do Until objRs.EOF
		j_area_idx			= objRs("area_idx")
		j_area_article_idx	= objRs("article_idx")
		j_area_name			= objRs("area_name")
        	
       	Response.Write("j_area_idx[" & i & "]			= '" & CStr(j_area_idx) & "';"& Chr(13))
       	Response.Write("j_area_article_idx[" & i & "]	= '" & CStr(j_area_article_idx) & "';"& Chr(13))
       	Response.Write("j_area_name[" & i & "]			= '" & CStr(j_area_name) & "';"& Chr(13))
       	objRs.MoveNext
       	i = i + 1
  Loop
  objRs.Close
  %> 
	 
function area_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_area_length			= frm.g_code_area.length;

	for(i=0; i<g_code_area_length;i++)
	{
		frm.g_code_area.options[i] = null;
	}
	
	frm.g_code_area.length=0;		
	frm.g_code_area.options[cnt++] = new Option('::지역 선택::','0');
	

	for(i=0; i<j_area_idx.length;i++)
	{	
		if(j_area_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_area.options[cnt++] = new Option(j_area_name[i],j_area_idx[i]);
		}	
	}
}

function s_area_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	s_code_area_length			= frm.s_code_area.length;

	for(i=0; i<s_code_area_length;i++)
	{
		frm.s_code_area.options[i] = null;
	}
	
	frm.s_code_area.length=0;		
	frm.s_code_area.options[cnt++] = new Option('::지역::','');
	

	for(i=0; i<j_area_idx.length;i++)
	{	
		if(j_area_article_idx[i]==g_article_idx1_val)
		{
			frm.s_code_area.options[cnt++] = new Option(j_area_name[i],j_area_idx[i]);
		}	
	}
}
