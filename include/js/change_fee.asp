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
  Response.Write("var f_article_idx = new Array()" & Chr(13))
  Response.Write("var f_article_name = new Array()" & Chr(13))
  Response.Write("var f_article_step1 = new Array()" & Chr(13))
  Response.Write("var f_article_step2 = new Array()" & Chr(13))
  
 
  strSql = " SELECT article_idx, article_name, article_step1,article_step2 FROM code_article "
  strSql = strSql & " where article_view='Y' and article_step2>0 order by article_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		f_article_idx			= objRs("article_idx")
		f_article_name			= objRs("article_name")
       	f_article_step1			= objRs("article_step1")
       	f_article_step2			= objRs("article_step2")
        	
       	Response.Write("f_article_idx[" & i & "] = '" & CStr(f_article_idx) & "';")
       	Response.Write("f_article_name[" & i & "] = '" & CStr(f_article_name) & "';")
       	Response.Write("f_article_step1[" & i & "] = '" & CStr(f_article_step1) & "';")
       	Response.Write("f_article_step2[" & i & "] = '" & CStr(f_article_step2) & "';")
       	objRs.MoveNext
       	i = i + 1
  	Loop

  objRs.Close

  Response.Write("var f_option_idx = new Array()" & Chr(13))
  Response.Write("var f_option_article_idx = new Array()" & Chr(13))  
  Response.Write("var f_option_name = new Array()" & Chr(13))  
  Response.Write("var f_option_set = new Array()" & Chr(13))  
 
  strSql = " SELECT option_idx, article_idx, option_name,option_set FROM code_article_option "
  strSql = strSql & " where option_view='Y' order by option_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		f_option_idx			= objRs("option_idx")
		f_option_article_idx	= objRs("article_idx")
		f_option_name			= objRs("option_name")
		f_option_set			= objRs("option_set")
		
		Response.Write("f_option_idx[" & i & "]				= '" & CStr(f_option_idx) & "';")
		Response.Write("f_option_article_idx[" & i & "]		= '" & CStr(f_option_article_idx) & "';")
		Response.Write("f_option_name[" & i & "]			= '" & CStr(f_option_name) & "';")
		Response.Write("f_option_set[" & i & "]				= '" & CStr(f_option_set) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close

  Response.Write("var f_sale_idx			= new Array()" & Chr(13))
  Response.Write("var f_sale_article_idx	= new Array()" & Chr(13))
  Response.Write("var f_sale_name			= new Array()" & Chr(13))
  
   strSql = " SELECT * FROM code_sale "
  strSql = strSql & " where sale_view='Y' order by sale_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		f_sale_idx				= objRs("sale_idx")
		f_sale_article_idx		= objRs("article_idx")
		f_sale_name				= objRs("sale_name")
		
		Response.Write("f_sale_idx[" & i & "]			= '" & (f_sale_idx) & "';")
		Response.Write("f_sale_article_idx[" & i & "]	= '" & (f_sale_article_idx) & "';")
		Response.Write("f_sale_name[" & i & "]			= '" & (f_sale_name) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close


  Response.Write("var f_service_idx = new Array()" & Chr(13))
  Response.Write("var f_service_article_idx = new Array()" & Chr(13))
  Response.Write("var f_service_name = new Array()" & Chr(13))
  
   strSql = " SELECT * FROM code_service "
  strSql = strSql & " where service_view='Y' order by service_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		f_service_idx			= objRs("service_idx")
		f_service_article_idx	= objRs("article_idx")
		f_service_name			= objRs("service_name")
		
		Response.Write("f_service_idx[" & i & "]			= '" & CStr(f_service_idx) & "';")
		Response.Write("f_service_article_idx[" & i & "]	= '" & CStr(f_service_article_idx) & "';")
		Response.Write("f_service_name[" & i & "]			= '" & CStr(f_service_name) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close

  Response.Write("var f_promise_idx = new Array()" & Chr(13))
  Response.Write("var f_promise_article_idx = new Array()" & Chr(13))
  Response.Write("var f_promise_name = new Array()" & Chr(13))
  
   strSql = " SELECT * FROM code_promise "
  strSql = strSql & " where promise_view='Y' order by promise_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		f_promise_idx			= objRs("promise_idx")
		f_promise_article_idx	= objRs("article_idx")
		f_promise_name			= objRs("promise_name")

		If f_promise_article_idx="" Or IsNull(f_promise_article_idx)=true Then
			f_promise_article_idx="0"
		End if
		
		Response.Write("f_promise_idx[" & i & "]			= '" & CStr(f_promise_idx) & "';")
		Response.Write("f_promise_article_idx[" & i & "]	= '" & CStr(f_promise_article_idx) & "';")
		Response.Write("f_promise_name[" & i & "]			= '" & CStr(f_promise_name) & "';")
		objRs.MoveNext
		i = i + 1
  	Loop

  objRs.Close
  %> 

  
function f_set_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	f_set_value			= code.options[idx].value;
	option_idx_length	= frm.g_option_idx.length;
	g_article_idx1		= frm.g_article_idx2.value;

	if(g_article_idx1!="0")
	{
		article_change(form_name);
	}

	frm.g_option_idx.length=0;		
	frm.g_option_idx.options[0] = new Option('상품옵션','0');

	
	frm.g_code_promise.length=0;		
	frm.g_code_promise.options[0] = new Option('약정선택','0');		


	frm.g_code_sale.length=0;		
	frm.g_code_sale.options[0] = new Option('할인탭선택','0');
		
	frm.g_code_service.length=0;		
	frm.g_code_service.options[0] = new Option('부가서비스','0');
}

	 
function article_change(form_name) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= frm.g_article_idx1.value;
	g_article2_length	= frm.g_article_idx2.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2.options[i] = null;
	}
	
	frm.g_article_idx2.length=0;		
	frm.g_article_idx2.options[cnt++] = new Option('상품선택','0');
	

	g_option_idx_length=frm.g_option_idx.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx.options[i] = null;
	}
	
	frm.g_option_idx.length=0;		
	frm.g_option_idx.options[0] = new Option('상품옵션','0');

	for(i=0; i<f_article_idx.length;i++)
	{	
		if(f_article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2.options[cnt++] = new Option(f_article_name[i],f_article_idx[i]);
		}	
	}
}



function option_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		= code.options[idx].value;
	option_idx_length	= frm.g_option_idx.length;
	article_set			= frm.article_set.value;
	var g_set=""

    if(article_set=="0")
	{
		alert("항목을 선택해 주세요!");
		frm.article_set.focus();
		return;
	}
  
	if(article_set=="A" || article_set=="B")
	{
		g_set = "A";
	}
	else
	{
		g_set = "B";
	}
	
	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx.options[i] = null;
	}


	frm.g_option_idx.length=0;		
	frm.g_option_idx.options[cnt++] = new Option('상품옵션','0');
	
	for(i=0; i<f_option_idx.length;i++)
	{	
		if(f_option_article_idx[i]==goods_idx2_val && (f_option_set[i]=="C" || f_option_set[i]==g_set))
		{
			frm.g_option_idx.options[cnt++] = new Option(f_option_name[i],f_option_idx[i]);
		}	
	}
}


function promise_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_promise_length		= frm.g_code_promise.length;

	for(i=0; i<g_code_promise_length;i++)
	{
		frm.g_code_promise.options[i] = null;
	}
	
	frm.g_code_promise.length=0;		
	frm.g_code_promise.options[cnt++] = new Option('약정선택','0');
	

	for(i=0; i<f_promise_idx.length;i++)
	{	
		if(f_promise_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_promise.options[cnt++] = new Option(f_promise_name[i],f_promise_idx[i]);
		}	
	}
}

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
	frm.g_code_sale.options[cnt++] = new Option('할인탭선택','0');
	

	for(i=0; i<f_sale_idx.length;i++)
	{	
		if(f_sale_article_idx[i]==g_article_idx_val)
		{
			frm.g_code_sale.options[cnt++] = new Option(f_sale_name[i],f_sale_idx[i]);
		}	
	}
}

function service_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	g_article_idx1_val			= code.options[idx].value;
	g_code_service_length		= frm.g_code_service.length;

	for(i=0; i<g_code_service_length;i++)
	{
		frm.g_code_service.options[i] = null;
	}
	
	frm.g_code_service.length=0;		
	frm.g_code_service.options[cnt++] = new Option('부가서비스선택','0');
	

	for(i=0; i<f_service_idx.length;i++)
	{	
		if(f_service_article_idx[i]==g_article_idx1_val)
		{
			frm.g_code_service.options[cnt++] = new Option(f_service_name[i],f_service_idx[i]);
		}	
	}
}


function s_set_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	f_set_value			= code.options[idx].value;
	option_idx_length	= frm.g_option_idx.length;
	g_article_idx1		= frm.g_article_idx2.value;

	if(g_article_idx1!="0")
	{
		s_article_change(form_name);
	}

	frm.s_option_idx.length=0;		
	frm.s_option_idx.options[0] = new Option('상품옵션','0');

	
	frm.s_code_promise.length=0;		
	frm.s_code_promise.options[0] = new Option('약정선택','0');		


	frm.s_code_sale.length=0;		
	frm.s_code_sale.options[0] = new Option('할인탭선택','0');
		
	frm.s_code_service.length=0;		
	frm.s_code_service.options[0] = new Option('부가서비스','0');
}


function s_article_change(form_name) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	s_article_idx1_val	= frm.s_article_idx1.value;
	s_article2_length	= frm.s_article_idx2.length;

	for(i=0; i<s_article2_length;i++)
	{
		frm.s_article_idx2.options[i] = null;
	}
	
	frm.s_article_idx2.length=0;		
	frm.s_article_idx2.options[cnt++] = new Option('상품선택','0');
	

	s_option_idx_length=frm.s_option_idx.length;

	for(i=0; i<s_option_idx_length;i++)
	{
		frm.s_option_idx.options[i] = null;
	}
	
	frm.s_option_idx.length=0;		
	frm.s_option_idx.options[0] = new Option('상품옵션','0');

	for(i=0; i<f_article_idx.length;i++)
	{	
		if(f_article_step1[i]==s_article_idx1_val)
		{
			frm.s_article_idx2.options[cnt++] = new Option(f_article_name[i],f_article_idx[i]);
		}	
	}
}

	 

function s_option_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		= code.options[idx].value;
	option_idx_length	= frm.s_option_idx.length;
	article_set			= frm.s_article_set.value;
	var g_set=""

    if(article_set=="0")
	{
		alert("항목을 선택해 주세요!");
		frm.s_article_set.focus();
		return;
	}
  
	if(article_set=="A" || article_set=="B")
	{
		g_set = "A";
	}
	else
	{
		g_set = "B";
	}
	
	for(i=0; i<option_idx_length;i++)
	{
		frm.s_option_idx.options[i] = null;
	}


	frm.s_option_idx.length=0;		
	frm.s_option_idx.options[cnt++] = new Option('상품옵션','0');
	
	for(i=0; i<f_option_idx.length;i++)
	{	
		if(f_option_article_idx[i]==goods_idx2_val && (f_option_set[i]=="C" || f_option_set[i]==g_set))
		{
			frm.s_option_idx.options[cnt++] = new Option(f_option_name[i],f_option_idx[i]);
		}	
	}
}


function s_promise_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	s_article_idx1_val			= code.options[idx].value;
	s_code_promise_length		= frm.s_code_promise.length;

	for(i=0; i<s_code_promise_length;i++)
	{
		frm.s_code_promise.options[i] = null;
	}
	
	frm.s_code_promise.length=0;		
	frm.s_code_promise.options[cnt++] = new Option('약정선택','0');
	

	for(i=0; i<f_promise_idx.length;i++)
	{	
		if(f_promise_article_idx[i]==s_article_idx1_val)
		{
			frm.s_code_promise.options[cnt++] = new Option(f_promise_name[i],f_promise_idx[i]);
		}	
	}
}

function s_sale_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	s_article_idx_val			= code.options[idx].value;
	s_code_sale_length			= frm.s_code_sale.length;

	for(i=0; i<s_code_sale_length;i++)
	{
		frm.s_code_sale.options[i] = null;
	}
	
	frm.s_code_sale.length=0;		
	frm.s_code_sale.options[cnt++] = new Option('할인탭선택','0');
	

	for(i=0; i<f_sale_idx.length;i++)
	{	
		if(f_sale_article_idx[i]==s_article_idx_val)
		{
			frm.s_code_sale.options[cnt++] = new Option(f_sale_name[i],f_sale_idx[i]);
		}	
	}
}

function s_service_change(code,form_name,idx) 
{
	var frm						= eval("document.all."+form_name);
	cnt							= 0;
	s_article_idx1_val			= code.options[idx].value;
	s_code_service_length		= frm.s_code_service.length;

	for(i=0; i<s_code_service_length;i++)
	{
		frm.s_code_service.options[i] = null;
	}
	
	frm.s_code_service.length=0;		
	frm.s_code_service.options[cnt++] = new Option('부가서비스선택','0');
	

	for(i=0; i<f_service_idx.length;i++)
	{	
		if(f_service_article_idx[i]==s_article_idx1_val)
		{
			frm.s_code_service.options[cnt++] = new Option(f_service_name[i],f_service_idx[i]);
		}	
	}
}
