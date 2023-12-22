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
  Response.Write("var article_idx = new Array()" & Chr(13))
  Response.Write("var article_name = new Array()" & Chr(13))
  Response.Write("var article_step1 = new Array()" & Chr(13))
  Response.Write("var article_step2 = new Array()" & Chr(13))
  
 
  strSql = " SELECT article_idx, article_name, article_step1,article_step2 FROM code_article "
  strSql = strSql & " where article_view='Y' and article_step2>0 order by article_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
		article_idx			= objRs("article_idx")
		article_name		= objRs("article_name")
       	article_step1		= objRs("article_step1")
       	article_step2		= objRs("article_step2")
        	
       	Response.Write("article_idx[" & i & "] = '" & CStr(article_idx) & "';")
       	Response.Write("article_name[" & i & "] = '" & CStr(article_name) & "';")
       	Response.Write("article_step1[" & i & "] = '" & CStr(article_step1) & "';")
       	Response.Write("article_step2[" & i & "] = '" & CStr(article_step2) & "';")
       	objRs.MoveNext
       	i = i + 1
  	Loop

  objRs.Close

  Response.Write("var option_idx = new Array()" & Chr(13))
  Response.Write("var option_article_idx = new Array()" & Chr(13))  
  Response.Write("var option_name = new Array()" & Chr(13))  
  Response.Write("var option_set = new Array()" & Chr(13))  
 
  strSql = " SELECT option_idx, article_idx, option_name,option_set FROM code_article_option "
  strSql = strSql & " where option_view='Y' order by option_order asc"
  set objRs=objCnn.Execute(strSql)
	
	i=0
  	Do Until objRs.EOF
			option_idx			= objRs("option_idx")
			option_article_idx	= objRs("article_idx")
			option_name			= objRs("option_name")
			option_set			= objRs("option_set")
        	
        	Response.Write("option_idx[" & i & "]			= '" & CStr(option_idx) & "';")
        	Response.Write("option_article_idx[" & i & "]	= '" & CStr(option_article_idx) & "';")
        	Response.Write("option_name[" & i & "]			= '" & CStr(option_name) & "';")
        	Response.Write("option_set[" & i & "]			= '" & CStr(option_set) & "';")
        	objRs.MoveNext
        	i = i + 1
  	Loop

  objRs.Close
  %> 
	 
function article_change(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= code.options[idx].value;
	g_article2_length	= frm.g_article_idx2.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2.options[i] = null;
	}
	
	frm.g_article_idx2.length=0;		
	frm.g_article_idx2.options[cnt++] = new Option('상품 선택','0');
	

	g_option_idx_length=frm.g_option_idx.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx.options[i] = null;
	}
	
	frm.g_option_idx.length=0;		
	frm.g_option_idx.options[0] = new Option('상품 옵션','0');

	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}

	if(regist_chk=="T")
	{
		article_change_1(code,form_name,idx);
		article_change_2(code,form_name,idx);

		fnc_article_change_4(code,form_name,idx);
		fnc_article_change_5(code,form_name,idx);
	}
}

function option_change(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.g_option_idx.length;
	var g_set=""
	if(regist_chk=="T")
	{
		if(frm.goods_cnt[0].checked==true)
		{
			g_set ="A";
		}
		if(frm.goods_cnt[1].checked==true)
		{
			g_set ="B";
		}
		if(frm.goods_cnt[2].checked==true)
		{
			g_set ="B";
		}
	}

	if(regist_chk=="R")
	{
		if(frm.g_set.value=="0")
		{
			alert("셋트를 선택해 주세요!")
			frm.g_set.focus();
			return;
		}

		g_set = frm.g_set.value;
		if(g_set=="C")
		{
			g_set="B";
		}
	}

	for(i=0; i<option_idx_length;i++)
	{
		frm.g_option_idx.options[i] = null;
	}
	
	frm.g_option_idx.length=0;		
	frm.g_option_idx.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val && (option_set[i]=="C" || option_set[i]==g_set))
		{
			frm.g_option_idx.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}
}



	 
function s_article_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	s_article_idx1_val	= code.options[idx].value;
	s_article2_length	= frm.s_article_idx2.length;

	for(i=0; i<s_article2_length;i++)
	{
		frm.s_article_idx2.options[i] = null;
	}
	
	frm.s_article_idx2.length=0;		
	frm.s_article_idx2.options[cnt++] = new Option('상품 선택','0');
	
	
	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==s_article_idx1_val)
		{
			frm.s_article_idx2.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}
}


function s_option_change(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.s_option_idx.length;
	
	for(i=0; i<option_idx_length;i++)
	{
		frm.s_option_idx.options[i] = null;
	}
	
	frm.s_option_idx.length=0;		
	frm.s_option_idx.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val )
		{
			frm.s_option_idx.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}
}




function article_change_1(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= code.options[idx].value;
	g_article2_length	= frm.g_article_idx2.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2_1.options[i] = null;
	}
	
	frm.g_article_idx2_1.length=0;		
	frm.g_article_idx2_1.options[cnt++] = new Option('상품 선택','0');
	

	g_option_idx_length=frm.g_option_idx_1.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx_1.options[i] = null;
	}
	
	frm.g_option_idx_1.length=0;		
	frm.g_option_idx_1.options[0] = new Option('상품 옵션','0');

	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2_1.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}
}

function option_change_1(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.g_option_idx_1.length;
	
	var g_set=""
	if(regist_chk=="T")
	{
		if(frm.goods_cnt[0].checked==true)
		{
			g_set ="A"
		}
		if(frm.goods_cnt[1].checked==true)
		{
			g_set ="B"
		}
		if(frm.goods_cnt[2].checked==true)
		{
			g_set ="B"
		}
	}
	

	for(i=0; i<option_idx_length;i++)
	{
		frm.g_option_idx_1.options[i] = null;
	}
	
	frm.g_option_idx_1.length=0;		
	frm.g_option_idx_1.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val && (option_set[i]=="C" || option_set[i]==g_set))
		{
			frm.g_option_idx_1.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}


}


function article_change_2(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= code.options[idx].value;
	g_article2_length	= frm.g_article_idx2_2.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2_2.options[i] = null;
	}
	
	frm.g_article_idx2_2.length=0;		
	frm.g_article_idx2_2.options[cnt++] = new Option('상품 선택','0');
	

	g_option_idx_length=frm.g_option_idx_2.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx_2.options[i] = null;
	}
	
	frm.g_option_idx_2.length=0;		
	frm.g_option_idx_2.options[0] = new Option('상품 옵션','0');

	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2_2.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}
}

function option_change_2(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.g_option_idx_2.length;

	var g_set=""
	if(regist_chk=="T")
	{
		if(frm.goods_cnt[0].checked==true)
		{
			g_set ="A"
		}
		if(frm.goods_cnt[1].checked==true)
		{
			g_set ="B"
		}
		if(frm.goods_cnt[2].checked==true)
		{
			g_set ="B"
		}
	}
		
	for(i=0; i<option_idx_length;i++)
	{
		frm.g_option_idx_2.options[i] = null;
	}
	
	frm.g_option_idx_2.length=0;		
	frm.g_option_idx_2.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val && (option_set[i]=="C" || option_set[i]==g_set))
		{
			frm.g_option_idx_2.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}
}


function fnc_option_change4(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.g_option_idx_4.length;

	var g_set=""
	if(regist_chk=="T")
	{
		if(frm.goods_cnt[0].checked==true)
		{
			g_set ="A"
		}
		if(frm.goods_cnt[1].checked==true)
		{
			g_set ="B"
		}
		if(frm.goods_cnt[2].checked==true)
		{
			g_set ="B"
		}
	}
		
	for(i=0; i<option_idx_length;i++)
	{
		frm.g_option_idx_4.options[i] = null;
	}
	
	frm.g_option_idx_4.length=0;		
	frm.g_option_idx_4.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val && (option_set[i]=="C" || option_set[i]==g_set))
		{
			frm.g_option_idx_4.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}
}


function fnc_option_change5(code,form_name,idx,regist_chk) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	goods_idx2_val		=code.options[idx].value;
	option_idx_length	= frm.g_option_idx_5.length;

	var g_set=""
	if(regist_chk=="T")
	{
		if(frm.goods_cnt[0].checked==true)
		{
			g_set ="A"
		}
		if(frm.goods_cnt[1].checked==true)
		{
			g_set ="B"
		}
		if(frm.goods_cnt[2].checked==true)
		{
			g_set ="B"
		}
	}
		
	for(i=0; i<option_idx_length;i++)
	{
		frm.g_option_idx_5.options[i] = null;
	}
	
	frm.g_option_idx_5.length=0;		
	frm.g_option_idx_5.options[cnt++] = new Option('상품 옵션','0');
	
	for(i=0; i<option_idx.length;i++)
	{	
		if(option_article_idx[i]==goods_idx2_val && (option_set[i]=="C" || option_set[i]==g_set))
		{
			frm.g_option_idx_5.options[cnt++] = new Option(option_name[i],option_idx[i]);
		}	
	}
}




function fnc_article_change_4(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= code.options[idx].value;
	g_article2_length	= frm.g_article_idx2_4.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2_4.options[i] = null;
	}
	
	frm.g_article_idx2_4.length=0;		
	frm.g_article_idx2_4.options[cnt++] = new Option('상품 선택','0');
	

	g_option_idx_length=frm.g_option_idx_4.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx_4.options[i] = null;
	}
	
	frm.g_option_idx_4.length=0;		
	frm.g_option_idx_4.options[0] = new Option('상품 옵션','0');

	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2_4.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}
}


function fnc_article_change_5(code,form_name,idx) 
{
	var frm				= eval("document.all."+form_name);
	cnt					= 0;
	g_article_idx1_val	= code.options[idx].value;
	g_article2_length	= frm.g_article_idx2_5.length;

	for(i=0; i<g_article2_length;i++)
	{
		frm.g_article_idx2_5.options[i] = null;
	}
	
	frm.g_article_idx2_5.length=0;		
	frm.g_article_idx2_5.options[cnt++] = new Option('상품 선택','0');
	

	g_option_idx_length=frm.g_option_idx_4.length;

	for(i=0; i<g_option_idx_length;i++)
	{
		frm.g_option_idx_5.options[i] = null;
	}
	
	frm.g_option_idx_5.length=0;		
	frm.g_option_idx_5.options[0] = new Option('상품 옵션','0');

	for(i=0; i<article_idx.length;i++)
	{	
		if(article_step1[i]==g_article_idx1_val)
		{
			frm.g_article_idx2_5.options[cnt++] = new Option(article_name[i],article_idx[i]);
		}	
	}
}
