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
  Response.Write("var sa_sale_idx		= new Array()" & Chr(13))
  Response.Write("var sa_article_idx	= new Array()" & Chr(13))
  Response.Write("var sa_sale_name		= new Array()" & Chr(13))
  
   strSql = " SELECT * FROM code_sale where sale_view='Y' order by sale_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
			sa_sale_idx			= objRs("sale_idx")
			sa_article_idx		= objRs("article_idx")
			sa_sale_name		= objRs("sale_name")
        	
        	Response.Write("sa_sale_idx[" & i & "]		= '" & (sa_sale_idx) & "';")
        	Response.Write("sa_article_idx[" & i & "]	= '" & (sa_article_idx) & "';")
        	Response.Write("sa_sale_name[" & i & "]		= '" & (sa_sale_name) & "';")
        	objRs.MoveNext
        	i = i + 1
  	Loop

  objRs.Close
  %> 

	 	 
function sale_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx_val			= code.options[idx].value;
	g_code_sale_length			= frm.g_code_sale.length;

	for(i=0; i<g_code_sale_length;i++)
	{
		frm.g_code_sale.options[i] = null;
	}
	
	frm.g_code_sale.length=0;		
	frm.g_code_sale.options[cnt++] = new Option('할인탭 선택','0');
	

	for(i=0; i<sa_sale_idx.length;i++)
	{	
		if(sa_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale.options[cnt++] = new Option(sa_sale_name[i],sa_sale_idx[i]);
		}	
	}
}

function sale_change1(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx_val			= code.options[idx].value;
	g_code_sale_length			= frm.g_code_sale1.length;

	for(i=0; i<g_code_sale_length;i++)
	{
		frm.g_code_sale1.options[i] = null;
	}
	
	frm.g_code_sale1.length=0;		
	frm.g_code_sale1.options[cnt++] = new Option('할인탭 선택','0');
	

	for(i=0; i<sa_sale_idx.length;i++)
	{	
		if(sa_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale1.options[cnt++] = new Option(sa_sale_name[i],sa_sale_idx[i]);
		}	
	}
}

	 
function sale_change2(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx_val			= code.options[idx].value;
	g_code_sale_length			= frm.g_code_sale2.length;

	for(i=0; i<g_code_sale_length;i++)
	{
		frm.g_code_sale2.options[i] = null;
	}
	
	frm.g_code_sale2.length=0;		
	frm.g_code_sale2.options[cnt++] = new Option('할인탭 선택','0');
	

	for(i=0; i<sa_sale_idx.length;i++)
	{	
		if(sa_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale2.options[cnt++] = new Option(sa_sale_name[i],sa_sale_idx[i]);
		}	
	}
}

 
function fnc_sale_change4(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx_val			= code.options[idx].value;
	g_code_sale_length			= frm.g_code_sale4.length;

	for(i=0; i<g_code_sale_length;i++)
	{
		frm.g_code_sale4.options[i] = null;
	}
	
	frm.g_code_sale4.length=0;		
	frm.g_code_sale4.options[cnt++] = new Option('할인탭 선택','0');
	

	for(i=0; i<sa_sale_idx.length;i++)
	{	
		if(sa_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale4.options[cnt++] = new Option(sa_sale_name[i],sa_sale_idx[i]);
		}	
	}
}

 
function fnc_sale_change5(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx_val			= code.options[idx].value;
	g_code_sale_length			= frm.g_code_sale5.length;

	for(i=0; i<g_code_sale_length;i++)
	{
		frm.g_code_sale5.options[i] = null;
	}
	
	frm.g_code_sale5.length=0;		
	frm.g_code_sale5.options[cnt++] = new Option('할인탭 선택','0');
	

	for(i=0; i<sa_sale_idx.length;i++)
	{	
		if(sa_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale5.options[cnt++] = new Option(sa_sale_name[i],sa_sale_idx[i]);
		}	
	}
}

 