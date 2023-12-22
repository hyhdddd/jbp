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
  Response.Write("var c_service_idx = new Array()" & Chr(13))
  Response.Write("var c_service_article_idx = new Array()" & Chr(13))
  Response.Write("var c_service_name = new Array()" & Chr(13))
  
  strSql = " SELECT * FROM code_service where service_view='Y' order by service_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		c_service_idx			= objRs("service_idx")
		c_service_article_idx	= objRs("article_idx")
		c_service_name			= objRs("service_name")
		
		Response.Write("c_service_idx[" & i & "]			= '" & CStr(c_service_idx) & "';")
		Response.Write("c_service_article_idx[" & i & "]	= '" & CStr(c_service_article_idx) & "';")
		Response.Write("c_service_name[" & i & "]			= '" & CStr(c_service_name) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close
  %> 
	 
function service_change1(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length			= frm.g_code_service1.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service1.options[i] = null;
	}
	
	frm.g_code_service1.length=0;		
	frm.g_code_service1.options[cnt++] = new Option('부가서비스 선택','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service1.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}

	 
function service_change2(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length			= frm.g_code_service2.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service2.options[i] = null;
	}
	
	frm.g_code_service2.length=0;		
	frm.g_code_service2.options[cnt++] = new Option('부가서비스 선택','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service2.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}


	 
function service_change3(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length			= frm.g_code_service3.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service3.options[i] = null;
	}
	
	frm.g_code_service3.length=0;		
	frm.g_code_service3.options[cnt++] = new Option('부가서비스 선택','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service3.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}


function s_code_service_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length		= frm.s_code_service.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.s_code_service.options[i] = null;
	}
	
	frm.s_code_service.length=0;		
	frm.s_code_service.options[cnt++] = new Option('::부가서비스::','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.s_code_service.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}


	 
function fnc_service_change4(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length		= frm.g_code_service4.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service4.options[i] = null;
	}
	
	frm.g_code_service4.length=0;		
	frm.g_code_service4.options[cnt++] = new Option('부가서비스 선택','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service4.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}


function fnc_service_change5(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length		= frm.g_code_service5.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service5.options[i] = null;
	}
	
	frm.g_code_service5.length=0;		
	frm.g_code_service5.options[cnt++] = new Option('부가서비스 선택','0');
	

	for(i=0; i<c_service_idx.length;i++)
	{	
		if(c_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service5.options[cnt++] = new Option(c_service_name[i],c_service_idx[i]);
		}	
	}
}

