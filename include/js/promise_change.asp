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
  Response.Write("var c_promise_idx = new Array()" & Chr(13))
  Response.Write("var c_promise_article_idx = new Array()" & Chr(13))
  Response.Write("var c_promise_name = new Array()" & Chr(13))
  
  strSql = " SELECT * FROM code_promise where promise_view='Y' order by promise_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		c_promise_idx			= objRs("promise_idx")
		c_promise_article_idx	= objRs("article_idx")
		c_promise_name			= objRs("promise_name")

		If c_promise_article_idx="" Or IsNull(c_promise_article_idx)=true Then
			c_promise_article_idx="0"
		End if
		
		Response.Write("c_promise_idx[" & i & "]			= '" & CStr(c_promise_idx) & "';")
		Response.Write("c_promise_article_idx[" & i & "]	= '" & CStr(c_promise_article_idx) & "';")
		Response.Write("c_promise_name[" & i & "]			= '" & CStr(c_promise_name) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close
  %> 
	 
function promise_change1(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length			= frm.g_code_promise1.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise1.options[i] = null;
	}
	
	frm.g_code_promise1.length=0;		
	frm.g_code_promise1.options[cnt++] = new Option('약정 선택','0');
	

	for(i=0; i<c_promise_idx.length;i++)
	{	
		if(c_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise1.options[cnt++] = new Option(c_promise_name[i],c_promise_idx[i]);
		}	
	}
}

	 
function promise_change2(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length			= frm.g_code_promise2.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise2.options[i] = null;
	}
	
	frm.g_code_promise2.length=0;		
	frm.g_code_promise2.options[cnt++] = new Option('약정 선택','0');
	

	for(i=0; i<c_promise_idx.length;i++)
	{	
		if(c_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise2.options[cnt++] = new Option(c_promise_name[i],c_promise_idx[i]);
		}	
	}
}


	 
function promise_change3(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length			= frm.g_code_promise3.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise3.options[i] = null;
	}
	
	frm.g_code_promise3.length=0;		
	frm.g_code_promise3.options[cnt++] = new Option('약정 선택','0');
	

	for(i=0; i<c_promise_idx.length;i++)
	{	
		if(c_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise3.options[cnt++] = new Option(c_promise_name[i],c_promise_idx[i]);
		}	
	}
}

function fnc_promise_change4(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length		= frm.g_code_promise4.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise4.options[i] = null;
	}
	
	frm.g_code_promise4.length=0;		
	frm.g_code_promise4.options[cnt++] = new Option('약정 선택','0');
	

	for(i=0; i<c_promise_idx.length;i++)
	{	
		if(c_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise4.options[cnt++] = new Option(c_promise_name[i],c_promise_idx[i]);
		}	
	}
}


function fnc_promise_change5(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length		= frm.g_code_promise5.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise5.options[i] = null;
	}
	
	frm.g_code_promise5.length=0;		
	frm.g_code_promise5.options[cnt++] = new Option('약정 선택','0');
	

	for(i=0; i<c_promise_idx.length;i++)
	{	
		if(c_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise5.options[cnt++] = new Option(c_promise_name[i],c_promise_idx[i]);
		}	
	}
}
