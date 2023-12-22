function Confirm(txtmsg,txturl)
{	
	if(confirm(txtmsg)==1) 
	{
		location.href=txturl;		
	}
}  

//클립보드 복사
function copy_clipboard(txt)
{
	window.clipboardData.setData("Text", txt);
}

function FocusColor(This) { This.style.backgroundColor = "#FFF4DA"; }
function BlurColor(This) { This.style.backgroundColor = "#FFFFFF";}

// 글자수만큼 자동 다음포커스 이동 (onKeyup)
function fncNextFocus(obj, limitLength, form_name, nextcol) 
{
	var frm=eval("document.all."+form_name);
	if(obj.value.length == limitLength) 
	{
		next_c="frm."+nextcol+".focus();"
		eval(next_c);
	}
}

//엔터체크 (onKeyup="enter_chk('frm_login','passwd');")
function EnterNextFocus(form_name,nextcol)
{
	var frm=eval("document.all."+form_name);
	if(event.keyCode == 13)
	{
		next_c="frm."+nextcol+".focus();"
		eval(next_c);
	}
}  

//엔터 체크후 sumbit을 위한 Funtion 으로 이동
function enter_submit_chk(Argc1,NextFunc)
{
	if(event.keyCode == 13)
	{
		eval(NextFunc+"('"+Argc1+"');");
	}
}  

//특수문자 체크 모듈
function checkSpecialChar(expression)
{
  var strSpecial = " `~!@#$%^&*()_+|\;\\/:=-<>.'\" "; 
	
  for(i=0;i<expression.length;i++)
  {
  	for(j=0;j<strSpecial.length;j++)
  	{
  		if(expression.charAt(i) == strSpecial.charAt(j))
  		{
  			return false;
  		}
  	}
  }
}    

// 오직 숫자만 입력 -- 스타일에 ime-mode:disabled 필요 onKeyUp
function fncOnlyNumber(objtext1) 
{
	var inText = objtext1.value;

	var ret;
		
	for (var i = 0; i < inText.length; i++) 
	{
		ret = inText.charCodeAt(i);
		if (!((ret > 47) && (ret < 58)))  
		{
			objtext1.value=inText.replace(inText.charAt(i),"");
			objtext1.focus();
			return false;
		}
	}
	return true;
}

//숫자, 콤마, 하이픈, 데쉬만 입력체크 - 스타일에 ime-mode:disabled 필요 onKeyUp
function fncOnlyNum(objtext1) 
{
	var inText = objtext1.value;
	var ret;
		
	for (var i = 0; i < inText.length; i++) 
	{
		ret = inText.charCodeAt(i);
		
		if (!((ret > 42) && (ret < 58)) ) 
		{
			objtext1.value=inText.replace(inText.charAt(i),"");
			objtext1.focus();
			return false;
		}
	}
	return true;
}

//	원하는 문자만 제거
function fncReplaceCheck(objtxt, repChar) 
{
	for (; objtxt.value.indexOf(repChar) != -1 ;) 
	{ 
		objtxt.value = objtxt.value.replace(repChar,"")
	}

	return objtxt.value;
}



// '-' 포함한 숫자만
function onlyNumber()
{ 
	if ( ((event.keyCode < 48) || (57 < event.keyCode) && (188 != event.keyCode)) && (45 != event.keyCode) ) event.returnValue=false;
}


//이미지 싸이즈 자동조절
function img_resize()
{
    maxsize = 1000;

    var content = document.getElementById("vw_content");
    var img = content.getElementsByTagName("img");

    for(i=0; i<img.length; i++) {
        if ( eval('img[' + i + '].width > maxsize') ) {
            eval('img[' + i + '].width = maxsize') ;
        }
    }
}

function enter_chk(frm_name,nextcol)
{
	var frm=eval("document.all."+frm_name);
	if(event.keyCode == 13)
	{
		next_c="frm."+nextcol+".focus();"
		eval(next_c);
	}
}   


function auto_enter_send(frm_name)
{
	var frm=eval("document.all."+frm_name);
	if(event.keyCode == 13)
	{
		next_c="frm.submit();"
		eval(next_c);
	}
}

//이메일 체크 모듈
function CheckEmail(invalue)
{
	retval = true;

	// 아래의 문자가 있는 경우 
	if (invalue.indexOf("/") >= 0)   retval = false;
	if (invalue.indexOf(".@") >= 0)  retval = false;
	if (invalue.indexOf("@.") >= 0)  retval = false;
	if (invalue.indexOf("@@") >= 0)  retval = false;
	if (invalue.indexOf(",") >= 0)   retval = false;
	if (invalue.indexOf(" ") >= 0)   retval = false;
	if (invalue.indexOf("http:") >= 0)   retval = false;
		
	// 아래의 형식이 없는 경우 
	if (invalue.indexOf("@") == -1)   retval = false;
	if (invalue.indexOf(".") == -1)   retval = false;
    
	// 아래의 형식이 처음에 나타나는 경우 
	if (invalue.indexOf("@") == 0)    retval = false;
	if (invalue.indexOf(".") == 0)    retval = false;
   
	// 마지막이 .인 경우 
	if (invalue.charAt(invalue.length-1) == ".")   retval = false;

	return retval;     
}


// 주민등록번호 체크
/*
function Jumin_chk(it)
{
	return true;
}
*/

//외국인 주민등록번호 체크
function Jumin_chk1(it)
{
	return true;
}

// 주민등록번호 체크
function Jumin_chk(it)
{
	idtot=0;
	idadd="234567892345";

	for(i=0;i<12;i++) 
	{
		idtot=idtot+parseInt(it.substring(i,i+1))*parseInt(idadd.substring(i,i+1));
	}
	idtot=11-(idtot%11);

	if (idtot==10)  idtot=0
	if (idtot==11)  idtot=1
	if (idtot==12)  idtot=2
	if (idtot==13)  idtot=3
	if (idtot==14)  idtot=4
	if (idtot==15)  idtot=5
	if (idtot==16)  idtot=6
	if (idtot==17)  idtot=7
	if (idtot==18)  idtot=8
	if (idtot==19)  idtot=9

	if((it.substring(12,13))==idtot) 
	{ return true; }
	else 
	{ return false;} 
}


//외국인 주민등록번호 체크
/*
function Jumin_chk1(reg_no) 
{
    var sum = 0;
    var odd = 0;
    
    buf = new Array(13);
    for (i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i)); 
    odd = buf[7]*10 + buf[8];
    
    if (odd%2 != 0) {
      return false;
    }

    if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
      return false;
    }
     
    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
    for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);


    sum=11-(sum%11);
    
    if (sum>=10) sum-=10;

    sum += 2;

    if (sum>=10) sum-=10;

    if ( sum != buf[12]) 
	{
        return false;
    }
    else 
	{
        return true;
    }
}
*/

//새창 열기 모뮬
function NewWindow(mypage,myname,w,h,scroll)
{ 
	var win_w = (screen.width-w)/2; 
	var win_h = (screen.height-h)/2; 
	var settings ='height='+h+','; 
	settings +='width='+w+','; 
	settings +='top='+win_h+','; 
	settings +='left='+win_w+','; 
	settings +='scrollbars='+scroll+','; 
	settings +='resizable=yes,'; 
	settings +='menubar=no,'; 
	settings +='toolbar=no'; 
	win=window.open(mypage,myname,settings); 
} 

//고객 일정 관리 - 일정 띄우기
function toggle_calendar(e) 
{
	//alert(e.style.visibility);
	if(e.style.visibility=="hidden") 
	{
		e.style.posTop = 10+event.y + document.body.scrollTop;
		e.style.posLeft = 10+event.x + document.body.scrollLeft;

   		e.style.visibility="visible";
   	}
  	else
  	{
   		e.style.visibility="hidden";
   	}
}

// 서비스신청 -> 아이디 중복체크 
function member_idcheck(form_name)
{
	var frm=eval("document.all."+form_name);
  	
  	if(frm.m_id.value == "")
  	{
    		alert("\아이디(ID)를 입력하세요.");
    		frm.m_id.focus();
    		return;
  	}
 	if(frm.m_id.value.indexOf(" ") > 0 )
  	{
    		alert ("아이디에 공백이 있습니다." );
    		frm.m_id.focus();
    		return ;
  	}
	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("아이디에 특수문자나 공백이 들어 있으면 안됩니다.");
		frm.m_id.focus();
		frm.m_id.select();
		return;
	}
  	if(frm.m_id.value.length < 4)
  	{
    		alert("ID는 4자리 이상 입력하세요.");
    		frm.m_id.focus();
    		return;
  	}
  	if(frm.m_id.value.length > 12)
  	{
    		alert("ID는 12자리 미만으로 입력하세요.");
    		frm.m_id.focus();
    		return;
  	}

	deurl="/company/company_id_chk.asp?m_id="+frm.m_id.value;
	NewWindow(deurl, 'id_chk', '400', '200', 'no');
}

// 센터 로그인 처리
function send_login(form_name)
{   	
	var frm=eval("document.all."+form_name);		

   	if(frm.m_id.value=="")
   	{
		alert("아이디를 입력하십시오")
		frm.m_id.focus();
		return;
   	}	
   	if(frm.m_passwd.value=="")
   	{
		alert("비밀번호을 입력하십시오")
		frm.m_passwd.focus();
		return;
   	}	

	frm.submit();
}

function send_passwd() 
{
    var frm=document.all.frm_passwd;
   	var pass1=frm.passwd1.value.split(" ").join("");
   	if((pass1.length<4) || (pass1.length>20))
   	{
   		alert("패스워드는 4자이상 20자 이하로 입력해 주세요");
   		frm.passwd1.focus();
   		return;
   	}	    
        
   	var pass2=frm.passwd2.value.split(" ").join("");
   	var pass3=frm.passwd3.value.split(" ").join("");
   	
   	if((pass2.length<4) || (pass2.length>20))
   	{
   		alert("패스워드는 4자이상 20자 이하로 입력해 주세요");
   		frm.passwd2.focus();
   		return;
   	}	    

	if((pass2!=pass3))
	{
   		alert("새로운 비밀번호가 서로 맞지 않습니다.");
   		frm.passwd2.focus();
   		return;			
	}
	
    frm.submit();	
}        


// 고객가입신청 - 등록
function custom_regist_all(regist_chk) 
{
    var frm=document.all.frm_custom_regist;
    
	if(frm.c_name.value=="")
	{
		alert("고객명을 입력해 주세요!");
		frm.c_name.focus();
		return;
	}

	if(frm.c_type[0].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk(jumin)==false)
		{
			alert("잘못된 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
			frm.c_jumin1.focus();
			return;
		}
	}
	if(frm.c_type[1].checked==true)
	{
		if(frm.c_office_no.value.length!=10)
		{
			alert("사업자 번호는 10자리로 등록해 주세요");
			frm.c_office_no.focus();
			return;
		}

		if(frm.c_office_no.value=="")
		{
			alert(" 사업자 번호를 입력해주세요!");
			frm.c_office_no.focus();
			return;
		}
	}

	if(frm.c_type[2].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk1(jumin)==false)
		{
			alert("잘못된 외국인 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
			frm.c_jumin1.focus();
			return;
		}
	}
	
	if(frm.c_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 주소를 입력해주세요!");
		frm.c_zipcode1.focus();
		return;
	}


	//if(frm.c_tel1.value=="")
	//{
	//	alert("전화번호를 입력해 주세요!");
	//	frm.c_tel1.focus();
	//	return;
	//}

	if(frm.c_tel2_com.value=="")
	{
		alert("핸드폰 통신사를 선택해주세요!");
		frm.c_tel2_com.focus();
		return;
	}

	if(frm.c_tel2.value=="")
	{
		alert("전화번호를 입력해 주세요!");
		frm.c_tel2.focus();
		return;
	}

	/*
	if(frm.g_code_course_idx.value=="0")
	{
		alert("접수경로를 선택해 주세요");
		frm.g_code_course_idx.focus();
		return;
	}

	*/
	
	//납부정보
	if(frm.g_give_type[0].checked==true)
	{
		if(frm.c_bank_cd.value=="0")
		{
			alert("납부정보 은행명을 선택해 주세요");
			frm.c_bank_cd.focus();
			return;
		}

		if(frm.c_bank_no.value=="")
		{
			alert("납부정보 계좌번호를 입력해 주세요");
			frm.c_bank_no.focus();
			return;
		}

	}

	if(frm.g_give_type[1].checked==true)
	{
		if(frm.c_card_cd.value=="0")
		{
			alert("납부정보 카드사를 선택해 주세요");
			frm.c_card_cd.focus();
			return;
		}

		if(frm.g_card_no.value=="")
		{
			alert("납부정보 카드번호를 입력해 주세요");
			frm.g_card_no.focus();
			return;
		}

	}

	if(frm.g_article_idx1.value=="0")
	{
		alert("상품을 선택해 주세요");
		frm.g_article_idx1.focus();
		return;
	}


	if(frm.g_code_area.value=="0")
	{
		alert("지역을 선택해 주세요");
		frm.g_code_area.focus();
		return;
	}

	if(frm.g_article_idx2.value=="0")
	{
		alert("상품을 선택해 주세요");
		frm.g_article_idx2.focus();
		return;
	}

	if(frm.g_option_idx.value=="0")
	{
		alert("상품 옵션을 선택해 주세요!");
		frm.g_option_idx.focus();
		return;
	}

	if(frm.g_code_sale.value=="0")
	{
		alert("상품 할인탭을 선택해 주세요");
		frm.g_code_sale.focus();
		return;
	}

	if(frm.g_code_promise1.value=="0")
	{
		alert("상품 약정을 선택해 주세요");
		frm.g_code_promise1.focus();
		return;
	}
	
	if(frm.g_code_service1.value=="0")
	{
		alert("상품 부가서비스을 선택해 주세요");
		frm.g_code_service1.focus();
		return;
	}
	
	if(frm.g_code_combine1.value=="0")
	{
		alert("상품 결합을 선택해 주세요!");
		frm.g_code_combine1.focus();
		return;
	}

	if(frm.g_article_cnt1.value=="" || frm.g_article_cnt1.value=="0" || frm.g_article_cnt1.value=="00")
	{
		alert("상품 회선수는 1회선 이상이여야 합니다!");
		frm.g_article_cnt1.focus();
		return;
	}

	if(frm.g_sp_give_type.value=="")
	{
		alert("사은품 지급자를 선택해 주세요!");
		frm.g_sp_give_type.focus();
		return;
	}


	if(frm.goods_cnt[1].checked==true || frm.goods_cnt[2].checked==true)
	{		
		if(frm.g_article_idx2_1.value=="0")
		{
			alert("상품을 선택해 주세요");
			frm.g_article_idx2_1.focus();
			return;
		}

		if(frm.g_option_idx_1.value=="0")
		{
			alert("상품 옵션을 선택해 주세요!");
			frm.g_option_idx_1.focus();
			return;
		}

		if(frm.g_code_sale1.value=="0")
		{
			alert("상품 할인탭을 선택해 주세요");
			frm.g_code_sale1.focus();
			return;
		}

		if(frm.g_code_promise2.value=="0")
		{
			alert("상품 약정을 선택해 주세요");
			frm.g_code_promise2.focus();
			return;
		}

		if(frm.g_code_service2.value=="0")
		{
			alert("상품 부가서비스을 선택해 주세요");
			frm.g_code_service2.focus();
			return;
		}
		
	
		if(frm.g_article_cnt2.value=="" || frm.g_article_cnt2.value=="0" || frm.g_article_cnt2.value=="00")
		{
			alert("상품 회선수는 1회선 이상이여야 합니다!");
			frm.g_article_cnt2.focus();
			return;
		}

		if(frm.g_sp_give_type1.value=="")
		{
			alert("사은품 지급자를 선택해 주세요!");
			frm.g_sp_give_type1.focus();
			return;
		}
	}

	if(frm.goods_cnt[2].checked==true)
	{		
		if(frm.g_article_idx2_2.value=="0")
		{
			alert("상품을 선택해 주세요");
			frm.g_article_idx2_2.focus();
			return;
		}

		if(frm.g_option_idx_2.value=="0")
		{
			alert("상품 옵션을 선택해 주세요!");
			frm.g_option_idx_2.focus();
			return;
		}

		if(frm.g_code_sale2.value=="0")
		{
			alert("상품 할인탭을 선택해 주세요");
			frm.g_code_sale2.focus();
			return;
		}

		if(frm.g_code_promise3.value=="0")
		{
			alert("상품 약정을 선택해 주세요");
			frm.g_code_promise3.focus();
			return;
		}

		if(frm.g_code_service3.value=="0")
		{
			alert("상품 부가서비스을 선택해 주세요");
			frm.g_code_service3.focus();
			return;
		}
		
	
		if(frm.g_article_cnt3.value=="" || frm.g_article_cnt3.value=="0" || frm.g_article_cnt3.value=="00")
		{
			alert("상품 회선수는 1회선 이상이여야 합니다!");
			frm.g_article_cnt3.focus();
			return;
		}

		if(frm.g_sp_give_type2.value=="")
		{
			alert("사은품 지급자를 선택해 주세요!");
			frm.g_sp_give_type2.focus();
			return;
		}
	}



	if(frm.goods_settop1_chk.checked==true)
	{		
		if(frm.g_article_idx2_4.value=="0")
		{
			alert("상품을 선택해 주세요");
			frm.g_article_idx2_4.focus();
			return;
		}

		if(frm.g_option_idx_4.value=="0")
		{
			alert("상품 옵션을 선택해 주세요!");
			frm.g_option_idx_4.focus();
			return;
		}

		if(frm.g_code_sale4.value=="0")
		{
			alert("상품 할인탭을 선택해 주세요");
			frm.g_code_sale4.focus();
			return;
		}

		if(frm.g_code_promise4.value=="0")
		{
			alert("상품 약정을 선택해 주세요");
			frm.g_code_promise4.focus();
			return;
		}

		if(frm.g_code_service4.value=="0")
		{
			alert("상품 부가서비스을 선택해 주세요");
			frm.g_code_service4.focus();
			return;
		}
	
		if(frm.g_article_cnt4.value=="" || frm.g_article_cnt4.value=="0" || frm.g_article_cnt4.value=="00")
		{
			alert("상품 회선수는 1회선 이상이여야 합니다!");
			frm.g_article_cnt4.focus();
			return;
		}

		if(frm.g_sp_give_type4.value=="")
		{
			alert("사은품 지급자를 선택해 주세요!");
			frm.g_sp_give_type4.focus();
			return;
		}
	}


	if(frm.goods_settop2_chk.checked==true)
	{		
		if(frm.g_article_idx2_5.value=="0")
		{
			alert("상품을 선택해 주세요");
			frm.g_article_idx2_5.focus();
			return;
		}

		if(frm.g_option_idx_5.value=="0")
		{
			alert("상품 옵션을 선택해 주세요!");
			frm.g_option_idx_5.focus();
			return;
		}

		if(frm.g_code_sale5.value=="0")
		{
			alert("상품 할인탭을 선택해 주세요");
			frm.g_code_sale5.focus();
			return;
		}

		if(frm.g_code_promise5.value=="0")
		{
			alert("상품 약정을 선택해 주세요");
			frm.g_code_promise5.focus();
			return;
		}

		if(frm.g_code_service5.value=="0")
		{
			alert("상품 부가서비스을 선택해 주세요");
			frm.g_code_service5.focus();
			return;
		}
	
		if(frm.g_article_cnt5.value=="" || frm.g_article_cnt5.value=="0" || frm.g_article_cnt5.value=="00")
		{
			alert("상품 회선수는 1회선 이상이여야 합니다!");
			frm.g_article_cnt5.focus();
			return;
		}

		if(frm.g_sp_give_type5.value=="")
		{
			alert("사은품 지급자를 선택해 주세요!");
			frm.g_sp_give_type5.focus();
			return;
		}
	}


	//전체가입신청
	if(regist_chk=="A")
	{
		if(frm.g_yuchi_m_id.value=="0")
		{
			alert("유치자를 선택해 주세요");
			frm.g_yuchi_m_id.focus();
			return;
		}
	}
	//딜러점 가입신청
	if(regist_chk=="Y")
	{
		if(frm.g_yuchi_m_id.value=="0")
		{
			alert("유치자를 선택해 주세요");
			frm.g_yuchi_m_id.focus();
			return;
		}
	}

    frm.submit();	
}   


// 고객가입신청 - 수정
function send_custom_goods_regist(form_name,regist_chk)
{
    var frm=eval("document.all."+form_name);

   
	if(frm.c_name.value=="")
	{
		alert("고객명을 입력해 주세요!");
		frm.c_name.focus();
		return;
	}

	if(frm.c_type[0].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk(jumin)==false)
		{
			alert("잘못된 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
			frm.c_jumin1.focus();
			return;
		}
	}

	if(frm.c_type[1].checked==true)
	{
		if(frm.c_office_no.value.length!=10)
		{
			alert("사업자 번호는 10자리로 등록해 주세요");
			frm.c_office_no.focus();
			return;
		}

		if(frm.c_office_no.value=="")
		{
			alert(" 사업자 번호를 입력해주세요!");
			frm.c_office_no.focus();
			return;
		}
	}

	if(frm.c_type[2].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk1(jumin)==false)
		{
			alert("잘못된 외국인 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
			frm.c_jumin1.focus();
			return;
		}
	}

	/*
	if(frm.c_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 주소 정보를 입력해주세요!");
		frm.c_zipcode1.focus();
		return;
	}
	*/

	if(frm.g_article_idx1.value=="0")
	{
		alert("상품을 선택해 주세요");
		frm.g_article_idx1.focus();
		return;
	}

	if(frm.g_article_idx2.value=="0")
	{
		alert("상품을 선택해 주세요");
		frm.g_article_idx2.focus();
		return;
	}

	if(frm.g_option_idx.value=="0")
	{
		alert("상품 옵션을 선택해 주세요!");
		frm.g_option_idx.focus();
		return;
	}

	if(frm.g_code_sale.value=="0")
	{
		alert("상품 할인탭을 선택해 주세요");
		frm.g_code_sale.focus();
		return;
	}

	if(frm.g_code_promise1.value=="0")
	{
		alert("상품약정을 선택해 주세요");
		frm.g_code_promise1.focus();
		return;
	}

	if(frm.g_code_area.value=="0")
	{
		alert("지역을 선택해 주세요");
		frm.g_code_area.focus();
		return;
	}
	
	if(frm.g_article_cnt.value=="" || frm.g_article_cnt.value=="0" || frm.g_article_cnt.value=="00")
	{
		alert("상품 회선수는 1회선 이상이여야 합니다!");
		frm.g_article_cnt.focus();
		return;
	}

	if(frm.g_yuchi_m_id.value=="" || frm.g_yuchi_m_id.value=="0")
	{
		alert("유치자를 선택하세요!");
		frm.g_yuchi_m_id.focus();
		return;	
	}

	if(frm.g_sp_give_type.value=="")
	{
		alert("사은품 지급자를 선택해 주세요!");
		frm.g_sp_give_type.focus();
		return;
	}


	if(regist_chk=="A")
	{
		if(frm.g_date_yuchi.value=="")
		{
			alert("접수일을 선택해 주세요!");
			frm.g_date_yuchi.focus();
			return;
		}
	

		if(frm.g_code_gaetong_idx.value=="")
		{
			alert("개통상태를 선택해주세요");
			frm.g_code_gaetong_idx.focus();
			return;
		}

		if(frm.g_trans_out_dealer.value=="0")
		{
			alert(" 상부점을 선택하세요!");
			frm.g_trans_out_dealer.focus();
			return;
		}
	}

	if(regist_chk=="Y")
	{
	}

	frm.submit();
}


// 고객관리 - 고객관리(일반) - 상단 검색
function send_custom_goods(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);
	if(frm.s_search_key.value!="")
	{
		if(frm.s_date_start.value=="" || frm.s_date_end.value=="")
		{
			alert("검색 날짜를 선택해 주세요");
			return;
		}
	}

	if(frm.s_date_start.value!="" || frm.s_date_end.value!="")
	{
		if(frm.s_search_key.value=="")
		{
			alert("검색 항목을 선택해 주세요!");
			frm.s_search_key.focus();
			return;
		}
	}
		frm.submit();
}

 
// 코드관리 - 할인탭 코드 등록    
function send_sale() 
{
	frm=document.all.frm_sale;

	if(frm.sale_name.value.length==0)
	{
		alert(" 코드를 입력해 주세요!");
		frm.sale_name.focus();
		return false;
	}	
	frm.submit();
}


// 코드관리 - 부가서비스 코드 등록    
function send_service() 
{
	frm=document.all.frm_service;

	if(frm.service_name.value.length==0)
	{
		alert(" 코드를 입력해 주세요!");
		frm.service_name.focus();
		return false;
	}	
	frm.submit();
}
 


// 코드관리 - 상품약정 코드 등록    
function send_promise() 
{
	frm=document.all.frm_promise;

	if(frm.promise_name.value.length==0)
	{
		alert("상품약정 코드 명을 입력해 주세요!");
		frm.promise_name.focus();
		return false;
	}	
	frm.submit();
}

// 코드관리 - 상품 코드 등록    
function send_article() 
{
	frm=document.all.frm_article;
	if(frm.article_name.value.length==0)
	{
		alert("상품코드를 입력해 주세요!");
		frm.article_name.focus();
		return false;
	}	
	frm.submit();
}



// 코드관리 - 상품옵션 등록
function send_option() 
{
	frm=document.all.frm_option;
	if(frm.option_name.value.length==0)
	{
		alert(" 코드를 입력해 주세요!");
		frm.option_name.focus();
		return;
	}	
	frm.submit();
}

   
// 부가서비스 - 블랙리스트
function send_black() 
{
	frm=document.all.frm_black;
	if(frm.black_name.value=="")
	{
		alert("고객명을 입력해 주세요!");
		frm.black_name.focus();
	    return;
	}	

 	var jumin=frm.black_jumin1.value+frm.black_jumin2.value;

	if(Jumin_chk(jumin)==false)
	{
		alert("잘못된 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
		frm.black_jumin1.focus();
		return;
	}

	frm.submit();
}


// 인사관리 - 거래처등록    
function send_dealer() 
{
	frm=document.all.frm_dealer;

	if(frm.dealer_name.value=="")
	{
		alert("거래처 회사명을 입력해 주세요!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 회사주소 정보를 입력해주세요!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_insu.checked==false && frm.dealer_ingea.checked==false)
	{
		alert("협력점/상부점 여부를 하나이상 체크해 주세요!");
		frm.dealer_insu.focus();
		return;
	}

	if(frm.dealer_group_code.value=="0")
	{
		alert("정산그룹을 선택해 주세요!");
		frm.dealer_group_code.focus();
		return;
	}
	frm.submit();
}

//일반적인 검색
function Search(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.search_txt.value=="")
	{
		alert("검색어를 입력해 주세요");
		return;
	}
	
	frm.submit();
}


//인사관리 - 사원등록 	
function send_emp_regist() 
{
    var frm=document.all.frm_emp_regist;

	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("아이디에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.length<4) || (frm.m_id.length>10))
   	{
   		alert("아이디는 4자이상 10자 이하로 입력해 주세요");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("사원명을 입력 하세요");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("이름에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("패스워드는 4자이상 20자 이하로 입력해 주세요");
   		frm.m_passwd.focus();
   		return;
   	}	    
 	
	//var jumin=frm.m_jumin1.value+frm.m_jumin2.value;

	//if(Jumin_chk(jumin)==false)
	//{
	//	alert("잘못된 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
	//	frm.m_jumin1.focus();
	//	return;
	//}

	if(frm.m_duty.selectedIndex==0)
	{
		alert("부서를 선택해 주세요.");
		frm.m_duty.focus();
		return;	
	}
	if(frm.m_position.selectedIndex==0)
	{
		alert("직위/직급을  선택해 주세요.");
		frm.m_position.focus();
		return;	
	}
	if(frm.m_bank_cd.selectedIndex==0)
	{
		alert("은행명을 선택해 주세요.");
		frm.m_bank_cd.focus();
		return;	
	}		
	if(frm.m_bank_no.value=="")
	{
		alert("계좌번호를 입력해 주세요.");
		frm.m_bank_no.focus();
		return;	
	}	
	if(frm.m_bank_name.value=="")
	{
		alert("예금주를 입력해 주세요.");
		frm.m_bank_name.focus();
		return;	
	}

	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 주소 정보를 입력해주세요!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("이메일 주소를 정확히 입력해 주세요!");
		frm.m_email.focus();
		return;
	}	
	if(frm.y_chk.value=="X")
	{
		if(frm.session_o_code.value!=frm.m_dealer_code.value)
		{
			if(frm.all_decision.checked==true)
			{
				alert(" 총 결제권은 본사 직원 소속 사원만 선택이 가능합니다. \n\n 거래처 에서 소속을 바꾸거나, 총결제권 항목을 해제해 주세요");
				frm.all_decision.focus();
				return;
			}
			if(frm.duty_decision.checked==true)
			{
				alert(" 부서결제권은 본사 직원 소속 사원만 선택이 가능합니다. \n\n 거래처 에서 소속을 바꾸거나, 부서 결제권 항목을 해제해 주세요");
				frm.duty_decision.focus();
				return;
			}
		}
	
	
		if(frm.all_decision.checked==true && frm.duty_decision.checked==true)
		{
			alert(" 부서결제권과 총 결제권은 한곳만 선택해야 합니다.")
			return;
		}

		if(frm.m_dealer_admin.checked==true)
		{
			if(frm.session_o_code.value==frm.m_dealer_code.value)
			{
				alert("하부 사장 권한은 본사소속으로 되어 있으면 안됩니다. \n\n 거래처를 바꾸어 주시기 바랍니다.");
				frm.m_dealer_code.focus();
				return;
			}
		}
	}
   

   frm.submit();
}	


// 정산관리 - 실적/정산 수수료정산(관리)  검색
function result_customer_search(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);

	if(frm.date_chk.value!="0")
	{
		if (frm.s_date_start.value=="")
		{
			alert("검색 날짜를 선택하세요");
			frm.s_date_start.focus();
			return;
		}
		if (frm.s_date_end.value=="")
		{
			alert("검색 날짜를 선택하세요");
			frm.s_date_end.focus();
			return;
		}
	}
	if(frm.s_date_start.value!="" && frm.s_date_end.value!="")
	{
		if(frm.date_chk.value=="0")
		{
			alert("날짜 검색 조건을 선택해 주세요");
			frm.date_chk.focus();
			return;
		}
	}

	frm.submit();
}

// 정산관리 - 하부 정산관리
function h_custom_goods_exact(form_name)
{
    var frm=eval("document.all."+form_name);
	
	ans=confirm("수정하시겠습니까?")
	
	if(ans==true)
	{
		frm.submit();
	}
}


// 가망고객 - 나의 가망고객 접수
function p_gamang_regist(form_name) 
{
   	var frm=eval("document.all."+form_name);

	if(frm.c_m_name.value=="")
	{
			alert("고객명을 입력해 주세요");
			frm.c_m_name.focus();
			return
	}	

 	frm.submit();	
}   


//실적관리 - 나의 실적 관리
function result_search01(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" 회사명을 선택해 주세요");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("조회 내용을 선택해 주세요");
		frm.result.focus();
		return;
	}	
    
	link_url ="p_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//실적관리 - 전체 실적 관리
function result_search02(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" 회사명을 선택해 주세요");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("조회 내용을 선택해 주세요");
		frm.result.focus();
		return;
	}	
    
	link_url ="a_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//실적관리 - 전체 실적 관리
function result_search03(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" 회사명을 선택해 주세요");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("조회 내용을 선택해 주세요");
		frm.result.focus();
		return;
	}	
    
	link_url ="y_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//광고문의 게시판 글쓰기
function gw_write()
{
	var frm=document.all.w_frm;
	
	if(frm.species.value=="")
	{
		alert("종류를 선택하십시요!");
		frm.species.focus();
		return;
	}

	if(frm.company.value=="")
	{
		alert("회사명을 입력해 주세요!");
		frm.company.focus();
		return;
	}
	
	if(frm.name.value=="")
	{
		alert("담당자를 입력해 주세요!");
		frm.name.focus();
		return;
	}
	
	if(frm.job.value=="")
	{
		alert("담당자 직책를 입력해 주세요!");
		frm.job.focus();
		return;
	}
	
	if(frm.telephone.value=="")
	{
		alert("사무실 전화번호를 입력해 주세요!");
		frm.telephone.focus();
		return;
	}
	
	if(frm.fax.value=="")
	{
		alert("사무실 팩스번호를 입력해 주세요!");
		frm.fax.focus();
		return;
	}
	
	if(frm.email.value=="")
	{
		alert("E-mail 주소를 입력해 주세요!");
		frm.email.focus();
		return;
	}
	else
	{
		if(CheckEmail(frm.email.value)==false)
		{
			alert("이메일 주소를 정확히 입력해 주세요!");
			frm.email.focus();
			return;
		}	
	}
	
	if(frm.content.value=="")
	{
		alert("내용은 한자 이상 작성하셔야 합니다.");
		frm.content.focus();
		return;
	}
	
	frm.submit();
}


// 서비스가입 신청
function company_edit(form_name) 
{
    var frm=eval("document.all."+form_name);
    
    if (frm.o_com_name.value=="") 
    {
        alert("회사명을 입력해 주세요!");
		frm.o_com_name.focus();
		return;
    }

	if(frm.o_office_no1.value.length!=3)
	{
		alert("사업자 번호 3자리를 입력해주세요!");
		frm.o_office_no1.focus();
		return;
	}
	if(frm.o_office_no2.value.length!=2)
	{
		alert("사업자 번호 2자리를 입력해주세요!");
		frm.o_office_no2.focus();
		return;
	}
	if(frm.o_office_no3.value.length!=5)
	{
		alert("사업자 번호 5자리를 입력해주세요!");
		frm.o_office_no3.focus();
		return;
	}
    if(frm.o_name.value=="") 
    {
        alert("대표자명을 입력해 주세요!");
		frm.o_name.focus();
		return;
    }
	if(frm.o_judi_no1.value=="")
	{
		alert("법인(주민)등록번호를 입력해주세요!");
		frm.o_judi_no1.focus();
		return;
	}
	if(frm.o_judi_no2.value=="")
	{
		alert("법인(주민)등록번호를 입력해주세요!");
		frm.o_judi_no2.focus();
		return;
	}

	/*
	if(frm.o_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 회사주소 정보를 입력해주세요!");
		frm.o_zipcode1.focus();
		return;
	}
	*/

	if(frm.o_type1.value=="")
	{
		alert("회사 업태를 입력해주세요!")
		frm.o_type1.focus();
		return;
	}
	if(frm.o_type2.value=="")
	{
		alert("회사 업종을 입력해주세요!")
		frm.o_type2.focus();
		return;
	}
	if(frm.o_tel1.value.length==0)
	{
		alert("대표 전화번호를 입력해주세요!");
		frm.o_tel1.focus();
		return;
	}
	if(frm.o_tel2.value.length==0)
	{
		alert("대표 전화번호를 입력해주세요!");
		frm.o_tel2.focus();
		return;
	}
	if(frm.o_tel3.value.length==0)
	{
		alert("대표 전화번호를 입력해주세요!");
		frm.o_tel3.focus();
		return;
	}
		       
   frm.submit();
}	

// SMS 전송
function sms_trans(frm,url)
{
	var frm=eval(frm);
	gaetong_status=frm.g_code_gaetong_idx.value;

	if (gaetong_status=="")
	{
		alert("개통상태를 선택해 주세요!")
		return;
	}

	NewWindow(url+"&g_code_gaetong_idx="+gaetong_status,'sms_main','180','520','no');
}

// 관리자 SMS 전송
function admin_sms_trans(frm,url)
{
	var frm=eval(frm);
	NewWindow(url,'sms_admin_main','180','520','no');
}

//  급여 명세서 출력
function pay_t_list01(frm_name)
{
	var frm=eval("document.all."+frm_name);
	
	ye		= frm.pay_year.selectedIndex
	mo		= frm.pay_month.selectedIndex
	
	ye_v	= frm.pay_year[ye].value;
	mo_v	= frm.pay_month[mo].value;
	url1 = "/pay/pay_t_list01.asp?pay_year="+ye_v+"&pay_month="+mo_v;
	NewWindow(url1,'pay_t_list01',1100,800,'yes');
}


//  개인별 명세서 출력
function pay_t_list02(frm_name)
{
	var frm=eval("document.all."+frm_name);
	
	ye		= frm.pay_year.selectedIndex
	mo		= frm.pay_month.selectedIndex
	
	ye_v	= frm.pay_year[ye].value;
	mo_v	= frm.pay_month[mo].value;
	url1 = "/pay/pay_t_list02.asp?pay_year="+ye_v+"&pay_month="+mo_v;
	NewWindow(url1,'pay_t_list02',850,800,'yes');
}

//파트너 등록 신청
function send_partner_regist() 
{
    var frm=document.all.frm_emp_regist;

	if(frm.id_chk.value=="")
	{
		alert("아이디 중복확인해 주시기 바랍니다.")
		return;
	}

	if(frm.strAgree.checked==false)
	{
		alert(" 약관에 동의해 주시기 바랍니다.");
		return;
	}
	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("아이디에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.value.length<4) || (frm.m_id.value.length>10))
   	{
   		alert("아이디는 4자이상 10자 이하로 입력해 주세요");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("이름을 입력 하세요");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("이름에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("패스워드는 4자이상 20자 이하로 입력해 주세요");
   		frm.m_passwd.focus();
   		return;
   	}	    
	if(frm.m_passwd.value!=frm.m_passwd1.value)
	{
		alert("패스워드가 일치하지 않습니다.")
		frm.m_passwd.value;
		return;
	}

	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 주소 정보를 입력해주세요!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(frm.m_tel1.value.length==0)
	{
		alert("연락처를 입력해주세요!");
		frm.m_tel1.focus();
		return;
	}
	if(frm.m_tel2.value.length==0)
	{
		alert("휴대폰 번호를 입력해주세요!");
		frm.m_tel2.focus();
		return;
	}

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("이메일 주소를 정확히 입력해 주세요!");
		frm.m_email.focus();
		return;
	}	
	if(frm.dealer_name.value=="")
	{
		alert("거래처 회사명을 입력해 주세요!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 회사주소 정보를 입력해주세요!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_bank_name.value=="")
	{
		alert("대표자 명을 입력해주세요!");
		frm.dealer_bank_name.focus();
		return;
	}	

	
   frm.submit();
}	


function a_custom_print(g_goods_idx)
{
	o_win=NewWindow('/customer/a_custom_goods_print.asp?g_goods_idx='+g_goods_idx,'a_custom_print','800','700','yes');
}


// 인사관리 - 거래처/사원 일괄 등록등록    
function partner_dealer_all() 
{
	frm=document.all.frm_dealer;

	if(frm.dealer_name.value=="")
	{
		alert("거래처 회사명을 입력해 주세요!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 회사주소 정보를 입력해주세요!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_insu.checked==false && frm.dealer_ingea.checked==false)
	{
		alert("협력점/상부점 여부를 하나이상 체크해 주세요!");
		frm.dealer_insu.focus();
		return;
	}

	if(frm.dealer_group_code.value=="0")
	{
		alert("정산그룹을 선택해 주세요!");
		frm.dealer_group_code.focus();
		return;
	}

	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("아이디에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.length<4) || (frm.m_id.length>10))
   	{
   		alert("아이디는 4자이상 10자 이하로 입력해 주세요");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("사원명을 입력 하세요");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("이름에 특수문자가 들어가 있습니다. 공백도 포함하면 안됩니다.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("패스워드는 4자이상 20자 이하로 입력해 주세요");
   		frm.m_passwd.focus();
   		return;
   	}	    


	if(frm.m_duty.selectedIndex==0)
	{
		alert("부서를 선택해 주세요.");
		frm.m_duty.focus();
		return;	
	}
	if(frm.m_position.selectedIndex==0)
	{
		alert("직위/직급을  선택해 주세요.");
		frm.m_position.focus();
		return;	
	}
	
	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("검색버튼을 눌러 주소 정보를 입력해주세요!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(frm.m_tel1.value.length==0)
	{
		alert("연락처를 입력해주세요!");
		frm.m_tel1.focus();
		return;
	}
	if(frm.m_tel2.value.length==0)
	{
		alert("연락처를 입력해주세요!");
		frm.m_tel2.focus();
		return;
	}

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("이메일 주소를 정확히 입력해 주세요!");
		frm.m_email.focus();
		return;
	}	
	
	frm.submit();
}


// 사은품 계좌 등록 (동일항목 체크)
function g_sp_bank_copy(form_name,chk)
{
	var frm=eval("document.all."+form_name);

	if(chk.checked==true)
	{
		c_bank_cd_val = frm.c_bank_cd.value;

		g_sp_bank_code_length		= frm.g_sp_bank_code.length;

		for(i=0; i<g_sp_bank_code_length;i++)
		{
		
			if(frm.g_sp_bank_code.options[i].value==c_bank_cd_val)
			{
					frm.g_sp_bank_code.options[i].selected=true;
			}

		}

		frm.g_sp_bank_acount.value=frm.c_bank_no.value;
		frm.g_sp_bank_name.value=frm.c_bank_name.value;
		frm.g_sp_bank_jumin1.value = frm.c_jumin1.value;
		frm.g_sp_bank_jumin2.value = frm.c_jumin2.value;

	}
	else
	{
		//사은품 정보를 지운다.
		frm.g_sp_bank_code.options[0].selected=true;
		frm.g_sp_bank_acount.value="";
		frm.g_sp_bank_name.value="";
		frm.g_sp_bank_jumin1.value = "";
		frm.g_sp_bank_jumin2.value = "";
	}
}

//블랙리스트 검색
function black_search(form_name)
{
	var frm=eval("document.all."+form_name);

	var jumin1=frm.c_jumin1.value;
	var jumin2=frm.c_jumin2.value;
	jumin=frm.c_jumin1.value+frm.c_jumin2.value;

	if(frm.c_jumin1.value=="")
	{
		alert("주민번호를 입력해주세요!");
		frm.c_jumin1.focus();
		return;
	}
	if(Jumin_chk(jumin)==false)
	{
		alert("잘못된 주민등록 번호 입니다. \n\n 다시 확인해 주시고 입력해 주세요");
		frm.c_jumin1.focus();
		return;
	}

	NewWindow("/include/asp/black_search.asp?black_jumin1="+jumin1+"&black_jumin2="+jumin2,"balck_search","600","250","no")
}


//블랙리스트 검색
function black_search_tel(form_name,tel_chk)
{
	var frm		= eval("document.all."+form_name);
	
	var tel_num	= eval("frm."+tel_chk+".value");

	if(tel_num=="")
	{
		alert("전화번호를 입력해주세요!");
		return;
	}

	NewWindow("/include/asp/black_search.asp?tel_num="+tel_num+"&black_chk=tel1","balck_search","600","250","no")
}

// 이력 추진일정 표시 변경
function consult_date_view_apply(url)
{
	ans=confirm("일정표시를 변경하시겠습니까?");
	if(ans==true)
	{
		location.replace(url);
	}
}




function style_view_chk(form_name,chk)	
{

	var frm = document.getElementById(form_name);	
	
	// 가입 유형
	if(chk=="A")
	{
		document.getElementById("style_view_01").style.display = "none";
		document.getElementById("style_view_02").style.display = "none";
		document.getElementById("style_view_09").style.display = "none";
		document.getElementById("style_view_15").style.display = "none";

		if(frm.g_give_type[0].checked==true)
		{
			document.getElementById("style_view_01").style.display = "block";	
			document.getElementById("style_view_01").style.display = "";	

		}

		if(frm.g_give_type[1].checked==true)
		{
			document.getElementById("style_view_02").style.display = "block";	
			document.getElementById("style_view_09").style.display = "block";	

			document.getElementById("style_view_02").style.display = "";	
			document.getElementById("style_view_09").style.display = "";			

		}
		if(frm.g_give_type[2].checked==true)
		{
		}

		//합산 청구
		if(frm.g_give_type[3].checked==true)
		{
			document.getElementById("style_view_15").style.display = "block";	
			document.getElementById("style_view_15").style.display = "";			
			
		}
	}
	// 이체 정보
	if(chk=="B")
	{
		document.getElementById("style_view_03").style.display = "none";	
		document.getElementById("style_view_04").style.display = "none";	
		document.getElementById("style_view_05").style.display = "none";	
		document.getElementById("style_view_06").style.display = "none";	
		document.getElementById("style_view_07").style.display = "none";	
		document.getElementById("style_view_08").style.display = "none";	
		document.getElementById("style_view_30").style.display = "none";	
		document.getElementById("style_view_31").style.display = "none";	
		
		
		if(frm.goods_cnt[0].checked==true)
		{

		}	

		if(frm.goods_cnt[1].checked==true)
		{
			document.getElementById("style_view_03").style.display = "block";	
			document.getElementById("style_view_04").style.display = "block";	
			document.getElementById("style_view_05").style.display = "block";	
			document.getElementById("style_view_30").style.display = "block";	

			document.getElementById("style_view_03").style.display = "";	
			document.getElementById("style_view_04").style.display = "";	
			document.getElementById("style_view_05").style.display = "";	
			document.getElementById("style_view_30").style.display = "";	
	
		}	

		if(frm.goods_cnt[2].checked==true)
		{

			document.getElementById("style_view_03").style.display = "block";	
			document.getElementById("style_view_04").style.display = "block";	
			document.getElementById("style_view_05").style.display = "block";	
			document.getElementById("style_view_06").style.display = "block";	
			document.getElementById("style_view_07").style.display = "block";	
			document.getElementById("style_view_08").style.display = "block";	
			document.getElementById("style_view_30").style.display = "block";	
			document.getElementById("style_view_31").style.display = "block";	

			document.getElementById("style_view_03").style.display = "";	
			document.getElementById("style_view_04").style.display = "";	
			document.getElementById("style_view_05").style.display = "";	
			document.getElementById("style_view_06").style.display = "";	
			document.getElementById("style_view_07").style.display = "";	
			document.getElementById("style_view_08").style.display = "";	
			document.getElementById("style_view_30").style.display = "";	
			document.getElementById("style_view_31").style.display = "";	


		}	

		frm.g_article_idx2[0].selected=true;

		frm.g_option_idx.length=0;		
		frm.g_option_idx.options[0] = new Option('상품 옵션','0');

			
		frm.g_article_idx2_1[0].selected=true;


		frm.g_option_idx_1.length=0;		
		frm.g_option_idx_1.options[0] = new Option('상품 옵션','0');

		
		frm.g_article_idx2_2[0].selected=true;


		frm.g_option_idx_2.length=0;		
		frm.g_option_idx_2.options[0] = new Option('상품 옵션','0');
		
		//약정 초기화
		frm.g_code_promise1.length=0;		
		frm.g_code_promise1.options[0] = new Option('약정 선택','0');

		frm.g_code_promise2.length=0;		
		frm.g_code_promise2.options[0] = new Option('약정 선택','0');

		frm.g_code_promise3.length=0;		
		frm.g_code_promise3.options[0] = new Option('약정 선택','0');

		//부가서비스 초기화
		frm.g_code_service1.length=0;		
		frm.g_code_service1.options[0] = new Option('부가서비스 선택','0');

		frm.g_code_service2.length=0;		
		frm.g_code_service2.options[0] = new Option('부가서비스 선택','0');

		frm.g_code_service3.length=0;		
		frm.g_code_service3.options[0] = new Option('부가서비스 선택','0');

		//할인탭 초기화
		frm.g_code_sale.length=0;		
		frm.g_code_sale.options[0] = new Option('할인탭 선택','0');

		frm.g_code_sale1.length=0;		
		frm.g_code_sale1.options[0] = new Option('할인탭 선택','0');

		frm.g_code_sale2.length=0;		
		frm.g_code_sale2.options[0] = new Option('할인탭 선택','0');

		frm.g_article_cnt1.value = "1";
		frm.g_article_cnt2.value = "1";
		frm.g_article_cnt3.value = "1";

	}

}


function customer_dong_copy(form_name,this_chk, chk)
{
	var frm = eval("document.all."+form_name);	

	
	//계좌이체 정보 동일(예금주, 주민번호)
	if(chk=="A")
	{
		if(this_chk.checked==true)
		{
			frm.c_bank_name.value = frm.c_name.value;
			frm.c_bank_jumin1.value = frm.c_jumin1.value;
			frm.c_bank_jumin2.value = frm.c_jumin2.value;
		}
	}

	//카드 정보 동일(예금주, 주민번호)
	if(chk=="B")
	{
		if(this_chk.checked==true)
		{
			frm.g_card_name.value = frm.c_name.value;
			frm.g_card_jumin1.value = frm.c_jumin1.value;
			frm.g_card_jumin2.value = frm.c_jumin2.value;
		}
	}

	//번호이동시 동일
	if(chk=="C")
	{
		if(this_chk.checked==true)
		{
			frm.g_move_tel1.value = frm.c_tel1.value;
			frm.g_move_name.value = frm.c_name.value;
			frm.g_move_jumin1.value = frm.c_jumin1.value;
			frm.g_move_jumin2.value = frm.c_jumin2.value;
			frm.g_move_tel2.value = frm.c_tel2.value;
			frm.g_move_date.value = frm.c_jumin_date.value;
		}
		else
		{
			frm.g_move_tel1.value = "";
			frm.g_move_name.value = "";
			frm.g_move_jumin1.value = "";
			frm.g_move_jumin2.value = "";
			frm.g_move_date.value	= "";
		}
	}
}

//팝업창 열기 모뮬
function NewWindow_popup(mypage,myname,w,h,t,l,scroll)
{ 
	var settings ='height='+h+','; 
	settings +='width='+w+','; 
	settings +='top='+t+','; 
	settings +='left='+l+','; 
	settings +='scrollbars='+scroll+','; 
	settings +='resizable=yes,'; 
	settings +='menubar=no,'; 
	settings +='toolbar=no'; 
	win=window.open(mypage,myname,settings); 
} 

function fncDateCalculator(form_name, This, Target1, Target2)
{
	var frm=eval("document.all."+form_name);

	var Digital = new Date();
	var now_year = Digital.getFullYear();
	var now_month = Digital.getMonth()+1;
	var now_day = Digital.getDate();
	
	//선택
	if (This.value=="")
	{
		Target1_value = "";
		Target2_value = "";
	}	
	//오늘
	if (This.value=="A")
	{
		now_month		= String(now_month);
		now_day			= String(now_day);

		if (now_month.length=="1")	now_month	= "0"+now_month;
		if (now_day.length=="1")	now_day		= "0"+now_day;	

		Target1_value	= now_year+"-"+now_month+"-"+now_day;
		Target2_value	= now_year+"-"+now_month+"-"+now_day;
	}	
	//어제
	if (This.value=="B")
	{
		now_month		= now_month-1;
		new_date		= new Date(now_year,now_month,now_day-1);

		now_year1		= String(new_date.getFullYear());
		now_month1		= String(new_date.getMonth()+1);
		now_day1		= String(new_date.getDate());	

		if (now_month1.length=="1")	now_month1	= "0"+now_month1;
		if (now_day1.length=="1")	now_day1	= "0"+now_day1;	

		Target1_value	= now_year1+"-"+now_month1+"-"+now_day1;
		Target2_value	= now_year1+"-"+now_month1+"-"+now_day1;
	}	
	//이번달
	if (This.value=="C")
	{
		now_month		= String(now_month);
		now_day			= String(now_day);

		if (now_month.length=="1")	now_month	= "0"+now_month;
		if (now_day.length=="1")	now_day		= "0"+now_day;	

		Target1_value	= now_year+"-"+now_month+"-01";
		Target2_value	= now_year+"-"+now_month+"-"+now_day;
	}
	//지난달
	if (This.value=="D")
	{
		now_month		= now_month-1;
		new_date		= new Date(now_year,now_month-1,now_day);

		now_year1		= String(new_date.getFullYear());
		now_month1		= String(new_date.getMonth()+1);

		var now_day2 = 0;
		
		if (now_month1 == 2)
		{
			if ((now_year1 % 4 == 0) && ((now_year1 % 100 != 0) || (now_year1 % 400 == 0)))
			{
				now_day2 = 29;
			}
			else
			{
				now_day2 = 28;
			}
		}
		else if ((now_month1 == 1) || (now_month1 == 3) || (now_month1 == 5) || (now_month1 == 7) || (now_month1 == 8) || (now_month1 == 10) || (now_month1 == 12))
		{
			now_day2 = 31;
		}
		else
		{
			now_day2 = 30;
		}
		
		if (now_month1.length=="1")	now_month1	= "0"+now_month1;
		
		Target1_value	= now_year1+"-"+now_month1+"-01";
		Target2_value	= now_year1+"-"+now_month1+"-"+now_day2;
	}

	Target1 = eval("frm."+Target1);
	Target2 = eval("frm."+Target2);
	
	Target1.value = Target1_value;
	Target2.value = Target2_value;

	if(form_name=="frm_exact_detail")
	{
		if(frm.date_chk.value=="0")
		{
			alert("날짜 항목을 선택해 주세요!");
			frm.date_chk.focus();
			return;
		}
	}
	else
	{
		if(frm.s_search_key.value=="")
		{
			alert("날짜 항목을 선택해 주세요!");
			frm.s_search_key.focus();
			return;
		}
	}
}


function select_price(obj)
{ 
	T_obj = document.getElementById(obj);
	
	var obj1 =  $("[id=p_"+obj+"]");      

	if(obj1.length==0)
	{
		var sHTML = "";
		sHTML += "<div id='p_"+obj+"' style='position:absolute;padding:2px;z-index:9999;background-color:white;'>";
		sHTML += "	<table width='300' style='font:9pt dotum; background-Color:#464646;color:white;'>";	
		sHTML += "	<tr align='center' height='22px' ><td style='padding-left:30px'>금액을 선택 하십시오.</td>"
		sHTML += "		<td style='text-align:right;'><input type='button' value='닫기' onclick=\"select_price_close('"+obj+"');\" style='height:25px;cursor:pointer;' ></td>"
		sHTML += "	</tr>"
		sHTML += "	</table>";
		sHTML += "	<table width='300' border='0' style='font:8pt dotum; color:gray; border:1px solid #262626;padding:0px;'><tr>";
	 
		for(i=10000 ; i<= 100000 ; i=i+10000) 
		{
			for(j=0 ; j<= 500000 ; j=j+100000) 
			{			
				sum = i + j ; 
				sHTML += "<td height='18' align='center' style='cursor:pointer;' onmouseover=\"this.style.backgroundColor = '#FE9A2E';\" onmouseOut=\"this.style.backgroundColor = '#FFFFFF';\"  onclick=\"document.getElementById('"+obj+"').value = '"+sum+"'; document.getElementById('"+obj+"').style.color='#555555';select_price_close('"+obj+"');\"> "+number_format(sum)+"  </td>";
			}
				sHTML += "</tr> <tr>";
		}
	 
		sHTML += "</td> </tr> </table>"
		sHTML += "</div>";
		$("body").append(sHTML);
	}	

	var tInput  = $("#" + obj).offset();
	var tHeight = $("#" + obj).outerHeight();
	var tWidth 	= $("#" + obj).outerWidth();
	

	if( tInput != null){
		$("#p_"+obj).css({"top":tInput.top+tHeight , "left":tInput.left});	
	}

	$("#p_"+obj).show();

}


function number_format(input)
{ 
    var input = String(input);
	input = input.replace(/,/g, ''); // 콤마 제거
 
    var reg = /(\-?\d+)(\d{3})($|\.\d+)/; 
    if(reg.test(input)){ 
        return input.replace(reg, function(str, p1,p2,p3){ 
                return number_format(p1) + "," + p2 + "" + p3; 
            }     
        ); 
    }else{ 
        return input; 
    } 
}


function select_price_close(obj)
{
	$("#p_"+obj).hide();
}


function style_view_settop(form_name,chk)	
{
	var frm = document.getElementById(form_name);		

	if (chk=="A")
	{
		if(frm.goods_settop1_chk.checked==true)
		{
			document.getElementById("view_settop01").style.display = "block";	
			document.getElementById("view_settop01").style.display = "";
			document.getElementById("view_settop02").style.display = "block";	
			document.getElementById("view_settop02").style.display = "";	
			document.getElementById("view_settop03").style.display = "block";	
			document.getElementById("view_settop03").style.display = "";	
			document.getElementById("view_settop04").style.display = "block";	
			document.getElementById("view_settop04").style.display = "";	
		} else {
			document.getElementById("view_settop01").style.display = "none";
			document.getElementById("view_settop02").style.display = "none";
			document.getElementById("view_settop03").style.display = "none";
			document.getElementById("view_settop04").style.display = "none";
		}
	}

	if (chk=="B")
	{
		if(frm.goods_settop2_chk.checked==true)
		{
			document.getElementById("view_settop05").style.display = "block";	
			document.getElementById("view_settop05").style.display = "";
			document.getElementById("view_settop06").style.display = "block";	
			document.getElementById("view_settop06").style.display = "";	
			document.getElementById("view_settop07").style.display = "block";	
			document.getElementById("view_settop07").style.display = "";	
			document.getElementById("view_settop08").style.display = "block";	
			document.getElementById("view_settop08").style.display = "";	
		} else {
			document.getElementById("view_settop05").style.display = "none";
			document.getElementById("view_settop06").style.display = "none";
			document.getElementById("view_settop07").style.display = "none";
			document.getElementById("view_settop08").style.display = "none";
		}
	}
}

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode(Target1, Target2) {
	new daum.Postcode({
		popupName : 'daum_address',
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			var fullAddr = ''; // 최종 주소 변수
			var extraAddr = ''; // 조합형 주소 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				fullAddr = data.roadAddress;

			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				fullAddr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			if(data.userSelectedType === 'R'){
				//법정동명이 있을 경우 추가한다.
				if(data.bname !== ''){
					extraAddr += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== ''){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			}


			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			//document.getElementById(Target1).value = data.postcode; //구 우편번호 사용					
			//document.getElementById(Target1).value = data.postcode1; //구 우편번호 사용
			//document.getElementById(Target2).value = data.postcode2; //구 우편번호 사용
			//document.getElementById(Target3).value = data.jibunAddress;	//지번주소


			document.getElementById(Target1).value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById(Target2).value = fullAddr;



			// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
			if(data.autoRoadAddress) {
				//예상되는 도로명 주소에 조합형 주소를 추가한다.
				var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				//document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

			} else if(data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				//document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

			} else {
				//document.getElementById('guide').innerHTML = '';
			}
		}
	}).open();
}



function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}



function remove_modal() {
	$('div#layerModal').remove();
}


function open_modal_url(Target, win_width, win_height, mobile_chk) {

	if(mobile_chk=="O")
	{
		win_width	= "98%";
		win_height	= $(window).height()-10;
	} 
	
	//레이어팝업 z-index 값을 100 이하로 설정해야 함.
	var modal = $('<div id="layerModal" style="overflow-y: hidden; overflow-x: hidden;z-index:9996"></div>').appendTo('body');

    $("#layerModal").html('<iframe id=\'modalframe_consult\' src="'+Target+'" frameborder="no" width="100%" height="100%" scrolling="auto" /></iframe>');
    $("#layerModal").dialog({
        title:"", 
        autoopen:false, 
        center: true,
        modal:true, 
        width:win_width, 
        height: win_height,
        resizable: false
    });


}
