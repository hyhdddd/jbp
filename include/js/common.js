function Confirm(txtmsg,txturl)
{	
	if(confirm(txtmsg)==1) 
	{
		location.href=txturl;		
	}
}  

//Ŭ������ ����
function copy_clipboard(txt)
{
	window.clipboardData.setData("Text", txt);
}

function FocusColor(This) { This.style.backgroundColor = "#FFF4DA"; }
function BlurColor(This) { This.style.backgroundColor = "#FFFFFF";}

// ���ڼ���ŭ �ڵ� ������Ŀ�� �̵� (onKeyup)
function fncNextFocus(obj, limitLength, form_name, nextcol) 
{
	var frm=eval("document.all."+form_name);
	if(obj.value.length == limitLength) 
	{
		next_c="frm."+nextcol+".focus();"
		eval(next_c);
	}
}

//����üũ (onKeyup="enter_chk('frm_login','passwd');")
function EnterNextFocus(form_name,nextcol)
{
	var frm=eval("document.all."+form_name);
	if(event.keyCode == 13)
	{
		next_c="frm."+nextcol+".focus();"
		eval(next_c);
	}
}  

//���� üũ�� sumbit�� ���� Funtion ���� �̵�
function enter_submit_chk(Argc1,NextFunc)
{
	if(event.keyCode == 13)
	{
		eval(NextFunc+"('"+Argc1+"');");
	}
}  

//Ư������ üũ ���
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

// ���� ���ڸ� �Է� -- ��Ÿ�Ͽ� ime-mode:disabled �ʿ� onKeyUp
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

//����, �޸�, ������, ������ �Է�üũ - ��Ÿ�Ͽ� ime-mode:disabled �ʿ� onKeyUp
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

//	���ϴ� ���ڸ� ����
function fncReplaceCheck(objtxt, repChar) 
{
	for (; objtxt.value.indexOf(repChar) != -1 ;) 
	{ 
		objtxt.value = objtxt.value.replace(repChar,"")
	}

	return objtxt.value;
}



// '-' ������ ���ڸ�
function onlyNumber()
{ 
	if ( ((event.keyCode < 48) || (57 < event.keyCode) && (188 != event.keyCode)) && (45 != event.keyCode) ) event.returnValue=false;
}


//�̹��� ������ �ڵ�����
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

//�̸��� üũ ���
function CheckEmail(invalue)
{
	retval = true;

	// �Ʒ��� ���ڰ� �ִ� ��� 
	if (invalue.indexOf("/") >= 0)   retval = false;
	if (invalue.indexOf(".@") >= 0)  retval = false;
	if (invalue.indexOf("@.") >= 0)  retval = false;
	if (invalue.indexOf("@@") >= 0)  retval = false;
	if (invalue.indexOf(",") >= 0)   retval = false;
	if (invalue.indexOf(" ") >= 0)   retval = false;
	if (invalue.indexOf("http:") >= 0)   retval = false;
		
	// �Ʒ��� ������ ���� ��� 
	if (invalue.indexOf("@") == -1)   retval = false;
	if (invalue.indexOf(".") == -1)   retval = false;
    
	// �Ʒ��� ������ ó���� ��Ÿ���� ��� 
	if (invalue.indexOf("@") == 0)    retval = false;
	if (invalue.indexOf(".") == 0)    retval = false;
   
	// �������� .�� ��� 
	if (invalue.charAt(invalue.length-1) == ".")   retval = false;

	return retval;     
}


// �ֹε�Ϲ�ȣ üũ
/*
function Jumin_chk(it)
{
	return true;
}
*/

//�ܱ��� �ֹε�Ϲ�ȣ üũ
function Jumin_chk1(it)
{
	return true;
}

// �ֹε�Ϲ�ȣ üũ
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


//�ܱ��� �ֹε�Ϲ�ȣ üũ
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

//��â ���� ���
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

//�� ���� ���� - ���� ����
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

// ���񽺽�û -> ���̵� �ߺ�üũ 
function member_idcheck(form_name)
{
	var frm=eval("document.all."+form_name);
  	
  	if(frm.m_id.value == "")
  	{
    		alert("\���̵�(ID)�� �Է��ϼ���.");
    		frm.m_id.focus();
    		return;
  	}
 	if(frm.m_id.value.indexOf(" ") > 0 )
  	{
    		alert ("���̵� ������ �ֽ��ϴ�." );
    		frm.m_id.focus();
    		return ;
  	}
	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("���̵� Ư�����ڳ� ������ ��� ������ �ȵ˴ϴ�.");
		frm.m_id.focus();
		frm.m_id.select();
		return;
	}
  	if(frm.m_id.value.length < 4)
  	{
    		alert("ID�� 4�ڸ� �̻� �Է��ϼ���.");
    		frm.m_id.focus();
    		return;
  	}
  	if(frm.m_id.value.length > 12)
  	{
    		alert("ID�� 12�ڸ� �̸����� �Է��ϼ���.");
    		frm.m_id.focus();
    		return;
  	}

	deurl="/company/company_id_chk.asp?m_id="+frm.m_id.value;
	NewWindow(deurl, 'id_chk', '400', '200', 'no');
}

// ���� �α��� ó��
function send_login(form_name)
{   	
	var frm=eval("document.all."+form_name);		

   	if(frm.m_id.value=="")
   	{
		alert("���̵� �Է��Ͻʽÿ�")
		frm.m_id.focus();
		return;
   	}	
   	if(frm.m_passwd.value=="")
   	{
		alert("��й�ȣ�� �Է��Ͻʽÿ�")
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
   		alert("�н������ 4���̻� 20�� ���Ϸ� �Է��� �ּ���");
   		frm.passwd1.focus();
   		return;
   	}	    
        
   	var pass2=frm.passwd2.value.split(" ").join("");
   	var pass3=frm.passwd3.value.split(" ").join("");
   	
   	if((pass2.length<4) || (pass2.length>20))
   	{
   		alert("�н������ 4���̻� 20�� ���Ϸ� �Է��� �ּ���");
   		frm.passwd2.focus();
   		return;
   	}	    

	if((pass2!=pass3))
	{
   		alert("���ο� ��й�ȣ�� ���� ���� �ʽ��ϴ�.");
   		frm.passwd2.focus();
   		return;			
	}
	
    frm.submit();	
}        


// �����Խ�û - ���
function custom_regist_all(regist_chk) 
{
    var frm=document.all.frm_custom_regist;
    
	if(frm.c_name.value=="")
	{
		alert("������ �Է��� �ּ���!");
		frm.c_name.focus();
		return;
	}

	if(frm.c_type[0].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk(jumin)==false)
		{
			alert("�߸��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
			frm.c_jumin1.focus();
			return;
		}
	}
	if(frm.c_type[1].checked==true)
	{
		if(frm.c_office_no.value.length!=10)
		{
			alert("����� ��ȣ�� 10�ڸ��� ����� �ּ���");
			frm.c_office_no.focus();
			return;
		}

		if(frm.c_office_no.value=="")
		{
			alert(" ����� ��ȣ�� �Է����ּ���!");
			frm.c_office_no.focus();
			return;
		}
	}

	if(frm.c_type[2].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk1(jumin)==false)
		{
			alert("�߸��� �ܱ��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
			frm.c_jumin1.focus();
			return;
		}
	}
	
	if(frm.c_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� �ּҸ� �Է����ּ���!");
		frm.c_zipcode1.focus();
		return;
	}


	//if(frm.c_tel1.value=="")
	//{
	//	alert("��ȭ��ȣ�� �Է��� �ּ���!");
	//	frm.c_tel1.focus();
	//	return;
	//}

	if(frm.c_tel2_com.value=="")
	{
		alert("�ڵ��� ��Ż縦 �������ּ���!");
		frm.c_tel2_com.focus();
		return;
	}

	if(frm.c_tel2.value=="")
	{
		alert("��ȭ��ȣ�� �Է��� �ּ���!");
		frm.c_tel2.focus();
		return;
	}

	/*
	if(frm.g_code_course_idx.value=="0")
	{
		alert("������θ� ������ �ּ���");
		frm.g_code_course_idx.focus();
		return;
	}

	*/
	
	//��������
	if(frm.g_give_type[0].checked==true)
	{
		if(frm.c_bank_cd.value=="0")
		{
			alert("�������� ������� ������ �ּ���");
			frm.c_bank_cd.focus();
			return;
		}

		if(frm.c_bank_no.value=="")
		{
			alert("�������� ���¹�ȣ�� �Է��� �ּ���");
			frm.c_bank_no.focus();
			return;
		}

	}

	if(frm.g_give_type[1].checked==true)
	{
		if(frm.c_card_cd.value=="0")
		{
			alert("�������� ī��縦 ������ �ּ���");
			frm.c_card_cd.focus();
			return;
		}

		if(frm.g_card_no.value=="")
		{
			alert("�������� ī���ȣ�� �Է��� �ּ���");
			frm.g_card_no.focus();
			return;
		}

	}

	if(frm.g_article_idx1.value=="0")
	{
		alert("��ǰ�� ������ �ּ���");
		frm.g_article_idx1.focus();
		return;
	}


	if(frm.g_code_area.value=="0")
	{
		alert("������ ������ �ּ���");
		frm.g_code_area.focus();
		return;
	}

	if(frm.g_article_idx2.value=="0")
	{
		alert("��ǰ�� ������ �ּ���");
		frm.g_article_idx2.focus();
		return;
	}

	if(frm.g_option_idx.value=="0")
	{
		alert("��ǰ �ɼ��� ������ �ּ���!");
		frm.g_option_idx.focus();
		return;
	}

	if(frm.g_code_sale.value=="0")
	{
		alert("��ǰ �������� ������ �ּ���");
		frm.g_code_sale.focus();
		return;
	}

	if(frm.g_code_promise1.value=="0")
	{
		alert("��ǰ ������ ������ �ּ���");
		frm.g_code_promise1.focus();
		return;
	}
	
	if(frm.g_code_service1.value=="0")
	{
		alert("��ǰ �ΰ������� ������ �ּ���");
		frm.g_code_service1.focus();
		return;
	}
	
	if(frm.g_code_combine1.value=="0")
	{
		alert("��ǰ ������ ������ �ּ���!");
		frm.g_code_combine1.focus();
		return;
	}

	if(frm.g_article_cnt1.value=="" || frm.g_article_cnt1.value=="0" || frm.g_article_cnt1.value=="00")
	{
		alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
		frm.g_article_cnt1.focus();
		return;
	}

	if(frm.g_sp_give_type.value=="")
	{
		alert("����ǰ �����ڸ� ������ �ּ���!");
		frm.g_sp_give_type.focus();
		return;
	}


	if(frm.goods_cnt[1].checked==true || frm.goods_cnt[2].checked==true)
	{		
		if(frm.g_article_idx2_1.value=="0")
		{
			alert("��ǰ�� ������ �ּ���");
			frm.g_article_idx2_1.focus();
			return;
		}

		if(frm.g_option_idx_1.value=="0")
		{
			alert("��ǰ �ɼ��� ������ �ּ���!");
			frm.g_option_idx_1.focus();
			return;
		}

		if(frm.g_code_sale1.value=="0")
		{
			alert("��ǰ �������� ������ �ּ���");
			frm.g_code_sale1.focus();
			return;
		}

		if(frm.g_code_promise2.value=="0")
		{
			alert("��ǰ ������ ������ �ּ���");
			frm.g_code_promise2.focus();
			return;
		}

		if(frm.g_code_service2.value=="0")
		{
			alert("��ǰ �ΰ������� ������ �ּ���");
			frm.g_code_service2.focus();
			return;
		}
		
	
		if(frm.g_article_cnt2.value=="" || frm.g_article_cnt2.value=="0" || frm.g_article_cnt2.value=="00")
		{
			alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
			frm.g_article_cnt2.focus();
			return;
		}

		if(frm.g_sp_give_type1.value=="")
		{
			alert("����ǰ �����ڸ� ������ �ּ���!");
			frm.g_sp_give_type1.focus();
			return;
		}
	}

	if(frm.goods_cnt[2].checked==true)
	{		
		if(frm.g_article_idx2_2.value=="0")
		{
			alert("��ǰ�� ������ �ּ���");
			frm.g_article_idx2_2.focus();
			return;
		}

		if(frm.g_option_idx_2.value=="0")
		{
			alert("��ǰ �ɼ��� ������ �ּ���!");
			frm.g_option_idx_2.focus();
			return;
		}

		if(frm.g_code_sale2.value=="0")
		{
			alert("��ǰ �������� ������ �ּ���");
			frm.g_code_sale2.focus();
			return;
		}

		if(frm.g_code_promise3.value=="0")
		{
			alert("��ǰ ������ ������ �ּ���");
			frm.g_code_promise3.focus();
			return;
		}

		if(frm.g_code_service3.value=="0")
		{
			alert("��ǰ �ΰ������� ������ �ּ���");
			frm.g_code_service3.focus();
			return;
		}
		
	
		if(frm.g_article_cnt3.value=="" || frm.g_article_cnt3.value=="0" || frm.g_article_cnt3.value=="00")
		{
			alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
			frm.g_article_cnt3.focus();
			return;
		}

		if(frm.g_sp_give_type2.value=="")
		{
			alert("����ǰ �����ڸ� ������ �ּ���!");
			frm.g_sp_give_type2.focus();
			return;
		}
	}



	if(frm.goods_settop1_chk.checked==true)
	{		
		if(frm.g_article_idx2_4.value=="0")
		{
			alert("��ǰ�� ������ �ּ���");
			frm.g_article_idx2_4.focus();
			return;
		}

		if(frm.g_option_idx_4.value=="0")
		{
			alert("��ǰ �ɼ��� ������ �ּ���!");
			frm.g_option_idx_4.focus();
			return;
		}

		if(frm.g_code_sale4.value=="0")
		{
			alert("��ǰ �������� ������ �ּ���");
			frm.g_code_sale4.focus();
			return;
		}

		if(frm.g_code_promise4.value=="0")
		{
			alert("��ǰ ������ ������ �ּ���");
			frm.g_code_promise4.focus();
			return;
		}

		if(frm.g_code_service4.value=="0")
		{
			alert("��ǰ �ΰ������� ������ �ּ���");
			frm.g_code_service4.focus();
			return;
		}
	
		if(frm.g_article_cnt4.value=="" || frm.g_article_cnt4.value=="0" || frm.g_article_cnt4.value=="00")
		{
			alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
			frm.g_article_cnt4.focus();
			return;
		}

		if(frm.g_sp_give_type4.value=="")
		{
			alert("����ǰ �����ڸ� ������ �ּ���!");
			frm.g_sp_give_type4.focus();
			return;
		}
	}


	if(frm.goods_settop2_chk.checked==true)
	{		
		if(frm.g_article_idx2_5.value=="0")
		{
			alert("��ǰ�� ������ �ּ���");
			frm.g_article_idx2_5.focus();
			return;
		}

		if(frm.g_option_idx_5.value=="0")
		{
			alert("��ǰ �ɼ��� ������ �ּ���!");
			frm.g_option_idx_5.focus();
			return;
		}

		if(frm.g_code_sale5.value=="0")
		{
			alert("��ǰ �������� ������ �ּ���");
			frm.g_code_sale5.focus();
			return;
		}

		if(frm.g_code_promise5.value=="0")
		{
			alert("��ǰ ������ ������ �ּ���");
			frm.g_code_promise5.focus();
			return;
		}

		if(frm.g_code_service5.value=="0")
		{
			alert("��ǰ �ΰ������� ������ �ּ���");
			frm.g_code_service5.focus();
			return;
		}
	
		if(frm.g_article_cnt5.value=="" || frm.g_article_cnt5.value=="0" || frm.g_article_cnt5.value=="00")
		{
			alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
			frm.g_article_cnt5.focus();
			return;
		}

		if(frm.g_sp_give_type5.value=="")
		{
			alert("����ǰ �����ڸ� ������ �ּ���!");
			frm.g_sp_give_type5.focus();
			return;
		}
	}


	//��ü���Խ�û
	if(regist_chk=="A")
	{
		if(frm.g_yuchi_m_id.value=="0")
		{
			alert("��ġ�ڸ� ������ �ּ���");
			frm.g_yuchi_m_id.focus();
			return;
		}
	}
	//������ ���Խ�û
	if(regist_chk=="Y")
	{
		if(frm.g_yuchi_m_id.value=="0")
		{
			alert("��ġ�ڸ� ������ �ּ���");
			frm.g_yuchi_m_id.focus();
			return;
		}
	}

    frm.submit();	
}   


// �����Խ�û - ����
function send_custom_goods_regist(form_name,regist_chk)
{
    var frm=eval("document.all."+form_name);

   
	if(frm.c_name.value=="")
	{
		alert("������ �Է��� �ּ���!");
		frm.c_name.focus();
		return;
	}

	if(frm.c_type[0].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk(jumin)==false)
		{
			alert("�߸��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
			frm.c_jumin1.focus();
			return;
		}
	}

	if(frm.c_type[1].checked==true)
	{
		if(frm.c_office_no.value.length!=10)
		{
			alert("����� ��ȣ�� 10�ڸ��� ����� �ּ���");
			frm.c_office_no.focus();
			return;
		}

		if(frm.c_office_no.value=="")
		{
			alert(" ����� ��ȣ�� �Է����ּ���!");
			frm.c_office_no.focus();
			return;
		}
	}

	if(frm.c_type[2].checked==true)
	{
		jumin=frm.c_jumin1.value+frm.c_jumin2.value;

		if(Jumin_chk1(jumin)==false)
		{
			alert("�߸��� �ܱ��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
			frm.c_jumin1.focus();
			return;
		}
	}

	/*
	if(frm.c_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� �ּ� ������ �Է����ּ���!");
		frm.c_zipcode1.focus();
		return;
	}
	*/

	if(frm.g_article_idx1.value=="0")
	{
		alert("��ǰ�� ������ �ּ���");
		frm.g_article_idx1.focus();
		return;
	}

	if(frm.g_article_idx2.value=="0")
	{
		alert("��ǰ�� ������ �ּ���");
		frm.g_article_idx2.focus();
		return;
	}

	if(frm.g_option_idx.value=="0")
	{
		alert("��ǰ �ɼ��� ������ �ּ���!");
		frm.g_option_idx.focus();
		return;
	}

	if(frm.g_code_sale.value=="0")
	{
		alert("��ǰ �������� ������ �ּ���");
		frm.g_code_sale.focus();
		return;
	}

	if(frm.g_code_promise1.value=="0")
	{
		alert("��ǰ������ ������ �ּ���");
		frm.g_code_promise1.focus();
		return;
	}

	if(frm.g_code_area.value=="0")
	{
		alert("������ ������ �ּ���");
		frm.g_code_area.focus();
		return;
	}
	
	if(frm.g_article_cnt.value=="" || frm.g_article_cnt.value=="0" || frm.g_article_cnt.value=="00")
	{
		alert("��ǰ ȸ������ 1ȸ�� �̻��̿��� �մϴ�!");
		frm.g_article_cnt.focus();
		return;
	}

	if(frm.g_yuchi_m_id.value=="" || frm.g_yuchi_m_id.value=="0")
	{
		alert("��ġ�ڸ� �����ϼ���!");
		frm.g_yuchi_m_id.focus();
		return;	
	}

	if(frm.g_sp_give_type.value=="")
	{
		alert("����ǰ �����ڸ� ������ �ּ���!");
		frm.g_sp_give_type.focus();
		return;
	}


	if(regist_chk=="A")
	{
		if(frm.g_date_yuchi.value=="")
		{
			alert("�������� ������ �ּ���!");
			frm.g_date_yuchi.focus();
			return;
		}
	

		if(frm.g_code_gaetong_idx.value=="")
		{
			alert("������¸� �������ּ���");
			frm.g_code_gaetong_idx.focus();
			return;
		}

		if(frm.g_trans_out_dealer.value=="0")
		{
			alert(" ������� �����ϼ���!");
			frm.g_trans_out_dealer.focus();
			return;
		}
	}

	if(regist_chk=="Y")
	{
	}

	frm.submit();
}


// ������ - ������(�Ϲ�) - ��� �˻�
function send_custom_goods(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);
	if(frm.s_search_key.value!="")
	{
		if(frm.s_date_start.value=="" || frm.s_date_end.value=="")
		{
			alert("�˻� ��¥�� ������ �ּ���");
			return;
		}
	}

	if(frm.s_date_start.value!="" || frm.s_date_end.value!="")
	{
		if(frm.s_search_key.value=="")
		{
			alert("�˻� �׸��� ������ �ּ���!");
			frm.s_search_key.focus();
			return;
		}
	}
		frm.submit();
}

 
// �ڵ���� - ������ �ڵ� ���    
function send_sale() 
{
	frm=document.all.frm_sale;

	if(frm.sale_name.value.length==0)
	{
		alert(" �ڵ带 �Է��� �ּ���!");
		frm.sale_name.focus();
		return false;
	}	
	frm.submit();
}


// �ڵ���� - �ΰ����� �ڵ� ���    
function send_service() 
{
	frm=document.all.frm_service;

	if(frm.service_name.value.length==0)
	{
		alert(" �ڵ带 �Է��� �ּ���!");
		frm.service_name.focus();
		return false;
	}	
	frm.submit();
}
 


// �ڵ���� - ��ǰ���� �ڵ� ���    
function send_promise() 
{
	frm=document.all.frm_promise;

	if(frm.promise_name.value.length==0)
	{
		alert("��ǰ���� �ڵ� ���� �Է��� �ּ���!");
		frm.promise_name.focus();
		return false;
	}	
	frm.submit();
}

// �ڵ���� - ��ǰ �ڵ� ���    
function send_article() 
{
	frm=document.all.frm_article;
	if(frm.article_name.value.length==0)
	{
		alert("��ǰ�ڵ带 �Է��� �ּ���!");
		frm.article_name.focus();
		return false;
	}	
	frm.submit();
}



// �ڵ���� - ��ǰ�ɼ� ���
function send_option() 
{
	frm=document.all.frm_option;
	if(frm.option_name.value.length==0)
	{
		alert(" �ڵ带 �Է��� �ּ���!");
		frm.option_name.focus();
		return;
	}	
	frm.submit();
}

   
// �ΰ����� - ������Ʈ
function send_black() 
{
	frm=document.all.frm_black;
	if(frm.black_name.value=="")
	{
		alert("������ �Է��� �ּ���!");
		frm.black_name.focus();
	    return;
	}	

 	var jumin=frm.black_jumin1.value+frm.black_jumin2.value;

	if(Jumin_chk(jumin)==false)
	{
		alert("�߸��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
		frm.black_jumin1.focus();
		return;
	}

	frm.submit();
}


// �λ���� - �ŷ�ó���    
function send_dealer() 
{
	frm=document.all.frm_dealer;

	if(frm.dealer_name.value=="")
	{
		alert("�ŷ�ó ȸ����� �Է��� �ּ���!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� ȸ���ּ� ������ �Է����ּ���!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_insu.checked==false && frm.dealer_ingea.checked==false)
	{
		alert("������/����� ���θ� �ϳ��̻� üũ�� �ּ���!");
		frm.dealer_insu.focus();
		return;
	}

	if(frm.dealer_group_code.value=="0")
	{
		alert("����׷��� ������ �ּ���!");
		frm.dealer_group_code.focus();
		return;
	}
	frm.submit();
}

//�Ϲ����� �˻�
function Search(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.search_txt.value=="")
	{
		alert("�˻�� �Է��� �ּ���");
		return;
	}
	
	frm.submit();
}


//�λ���� - ������ 	
function send_emp_regist() 
{
    var frm=document.all.frm_emp_regist;

	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("���̵� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.length<4) || (frm.m_id.length>10))
   	{
   		alert("���̵�� 4���̻� 10�� ���Ϸ� �Է��� �ּ���");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("������� �Է� �ϼ���");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("�̸��� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("�н������ 4���̻� 20�� ���Ϸ� �Է��� �ּ���");
   		frm.m_passwd.focus();
   		return;
   	}	    
 	
	//var jumin=frm.m_jumin1.value+frm.m_jumin2.value;

	//if(Jumin_chk(jumin)==false)
	//{
	//	alert("�߸��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
	//	frm.m_jumin1.focus();
	//	return;
	//}

	if(frm.m_duty.selectedIndex==0)
	{
		alert("�μ��� ������ �ּ���.");
		frm.m_duty.focus();
		return;	
	}
	if(frm.m_position.selectedIndex==0)
	{
		alert("����/������  ������ �ּ���.");
		frm.m_position.focus();
		return;	
	}
	if(frm.m_bank_cd.selectedIndex==0)
	{
		alert("������� ������ �ּ���.");
		frm.m_bank_cd.focus();
		return;	
	}		
	if(frm.m_bank_no.value=="")
	{
		alert("���¹�ȣ�� �Է��� �ּ���.");
		frm.m_bank_no.focus();
		return;	
	}	
	if(frm.m_bank_name.value=="")
	{
		alert("�����ָ� �Է��� �ּ���.");
		frm.m_bank_name.focus();
		return;	
	}

	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� �ּ� ������ �Է����ּ���!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("�̸��� �ּҸ� ��Ȯ�� �Է��� �ּ���!");
		frm.m_email.focus();
		return;
	}	
	if(frm.y_chk.value=="X")
	{
		if(frm.session_o_code.value!=frm.m_dealer_code.value)
		{
			if(frm.all_decision.checked==true)
			{
				alert(" �� �������� ���� ���� �Ҽ� ����� ������ �����մϴ�. \n\n �ŷ�ó ���� �Ҽ��� �ٲٰų�, �Ѱ����� �׸��� ������ �ּ���");
				frm.all_decision.focus();
				return;
			}
			if(frm.duty_decision.checked==true)
			{
				alert(" �μ��������� ���� ���� �Ҽ� ����� ������ �����մϴ�. \n\n �ŷ�ó ���� �Ҽ��� �ٲٰų�, �μ� ������ �׸��� ������ �ּ���");
				frm.duty_decision.focus();
				return;
			}
		}
	
	
		if(frm.all_decision.checked==true && frm.duty_decision.checked==true)
		{
			alert(" �μ������ǰ� �� �������� �Ѱ��� �����ؾ� �մϴ�.")
			return;
		}

		if(frm.m_dealer_admin.checked==true)
		{
			if(frm.session_o_code.value==frm.m_dealer_code.value)
			{
				alert("�Ϻ� ���� ������ ����Ҽ����� �Ǿ� ������ �ȵ˴ϴ�. \n\n �ŷ�ó�� �ٲپ� �ֽñ� �ٶ��ϴ�.");
				frm.m_dealer_code.focus();
				return;
			}
		}
	}
   

   frm.submit();
}	


// ������� - ����/���� ����������(����)  �˻�
function result_customer_search(form_name)
{
	var frm=eval("document.all."+form_name);
	//alert(frm.search_key.value);

	if(frm.date_chk.value!="0")
	{
		if (frm.s_date_start.value=="")
		{
			alert("�˻� ��¥�� �����ϼ���");
			frm.s_date_start.focus();
			return;
		}
		if (frm.s_date_end.value=="")
		{
			alert("�˻� ��¥�� �����ϼ���");
			frm.s_date_end.focus();
			return;
		}
	}
	if(frm.s_date_start.value!="" && frm.s_date_end.value!="")
	{
		if(frm.date_chk.value=="0")
		{
			alert("��¥ �˻� ������ ������ �ּ���");
			frm.date_chk.focus();
			return;
		}
	}

	frm.submit();
}

// ������� - �Ϻ� �������
function h_custom_goods_exact(form_name)
{
    var frm=eval("document.all."+form_name);
	
	ans=confirm("�����Ͻðڽ��ϱ�?")
	
	if(ans==true)
	{
		frm.submit();
	}
}


// ������ - ���� ������ ����
function p_gamang_regist(form_name) 
{
   	var frm=eval("document.all."+form_name);

	if(frm.c_m_name.value=="")
	{
			alert("������ �Է��� �ּ���");
			frm.c_m_name.focus();
			return
	}	

 	frm.submit();	
}   


//�������� - ���� ���� ����
function result_search01(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" ȸ����� ������ �ּ���");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("��ȸ ������ ������ �ּ���");
		frm.result.focus();
		return;
	}	
    
	link_url ="p_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//�������� - ��ü ���� ����
function result_search02(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" ȸ����� ������ �ּ���");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("��ȸ ������ ������ �ּ���");
		frm.result.focus();
		return;
	}	
    
	link_url ="a_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//�������� - ��ü ���� ����
function result_search03(form_name)
{
	var frm=eval("document.all."+form_name);

	if(frm.g_article_idx1.value=="0")
	{
		alert(" ȸ����� ������ �ּ���");
		frm.g_article_idx1.focus();
		return;
	}
	if(frm.result.value==0 || frm.result.value=="")
	{
		alert("��ȸ ������ ������ �ּ���");
		frm.result.focus();
		return;
	}	
    
	link_url ="y_result_list_"+frm.result.value+".asp";
	frm.action=link_url;
	frm.submit();
}


//������ �Խ��� �۾���
function gw_write()
{
	var frm=document.all.w_frm;
	
	if(frm.species.value=="")
	{
		alert("������ �����Ͻʽÿ�!");
		frm.species.focus();
		return;
	}

	if(frm.company.value=="")
	{
		alert("ȸ����� �Է��� �ּ���!");
		frm.company.focus();
		return;
	}
	
	if(frm.name.value=="")
	{
		alert("����ڸ� �Է��� �ּ���!");
		frm.name.focus();
		return;
	}
	
	if(frm.job.value=="")
	{
		alert("����� ��å�� �Է��� �ּ���!");
		frm.job.focus();
		return;
	}
	
	if(frm.telephone.value=="")
	{
		alert("�繫�� ��ȭ��ȣ�� �Է��� �ּ���!");
		frm.telephone.focus();
		return;
	}
	
	if(frm.fax.value=="")
	{
		alert("�繫�� �ѽ���ȣ�� �Է��� �ּ���!");
		frm.fax.focus();
		return;
	}
	
	if(frm.email.value=="")
	{
		alert("E-mail �ּҸ� �Է��� �ּ���!");
		frm.email.focus();
		return;
	}
	else
	{
		if(CheckEmail(frm.email.value)==false)
		{
			alert("�̸��� �ּҸ� ��Ȯ�� �Է��� �ּ���!");
			frm.email.focus();
			return;
		}	
	}
	
	if(frm.content.value=="")
	{
		alert("������ ���� �̻� �ۼ��ϼž� �մϴ�.");
		frm.content.focus();
		return;
	}
	
	frm.submit();
}


// ���񽺰��� ��û
function company_edit(form_name) 
{
    var frm=eval("document.all."+form_name);
    
    if (frm.o_com_name.value=="") 
    {
        alert("ȸ����� �Է��� �ּ���!");
		frm.o_com_name.focus();
		return;
    }

	if(frm.o_office_no1.value.length!=3)
	{
		alert("����� ��ȣ 3�ڸ��� �Է����ּ���!");
		frm.o_office_no1.focus();
		return;
	}
	if(frm.o_office_no2.value.length!=2)
	{
		alert("����� ��ȣ 2�ڸ��� �Է����ּ���!");
		frm.o_office_no2.focus();
		return;
	}
	if(frm.o_office_no3.value.length!=5)
	{
		alert("����� ��ȣ 5�ڸ��� �Է����ּ���!");
		frm.o_office_no3.focus();
		return;
	}
    if(frm.o_name.value=="") 
    {
        alert("��ǥ�ڸ��� �Է��� �ּ���!");
		frm.o_name.focus();
		return;
    }
	if(frm.o_judi_no1.value=="")
	{
		alert("����(�ֹ�)��Ϲ�ȣ�� �Է����ּ���!");
		frm.o_judi_no1.focus();
		return;
	}
	if(frm.o_judi_no2.value=="")
	{
		alert("����(�ֹ�)��Ϲ�ȣ�� �Է����ּ���!");
		frm.o_judi_no2.focus();
		return;
	}

	/*
	if(frm.o_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� ȸ���ּ� ������ �Է����ּ���!");
		frm.o_zipcode1.focus();
		return;
	}
	*/

	if(frm.o_type1.value=="")
	{
		alert("ȸ�� ���¸� �Է����ּ���!")
		frm.o_type1.focus();
		return;
	}
	if(frm.o_type2.value=="")
	{
		alert("ȸ�� ������ �Է����ּ���!")
		frm.o_type2.focus();
		return;
	}
	if(frm.o_tel1.value.length==0)
	{
		alert("��ǥ ��ȭ��ȣ�� �Է����ּ���!");
		frm.o_tel1.focus();
		return;
	}
	if(frm.o_tel2.value.length==0)
	{
		alert("��ǥ ��ȭ��ȣ�� �Է����ּ���!");
		frm.o_tel2.focus();
		return;
	}
	if(frm.o_tel3.value.length==0)
	{
		alert("��ǥ ��ȭ��ȣ�� �Է����ּ���!");
		frm.o_tel3.focus();
		return;
	}
		       
   frm.submit();
}	

// SMS ����
function sms_trans(frm,url)
{
	var frm=eval(frm);
	gaetong_status=frm.g_code_gaetong_idx.value;

	if (gaetong_status=="")
	{
		alert("������¸� ������ �ּ���!")
		return;
	}

	NewWindow(url+"&g_code_gaetong_idx="+gaetong_status,'sms_main','180','520','no');
}

// ������ SMS ����
function admin_sms_trans(frm,url)
{
	var frm=eval(frm);
	NewWindow(url,'sms_admin_main','180','520','no');
}

//  �޿� ���� ���
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


//  ���κ� ���� ���
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

//��Ʈ�� ��� ��û
function send_partner_regist() 
{
    var frm=document.all.frm_emp_regist;

	if(frm.id_chk.value=="")
	{
		alert("���̵� �ߺ�Ȯ���� �ֽñ� �ٶ��ϴ�.")
		return;
	}

	if(frm.strAgree.checked==false)
	{
		alert(" ����� ������ �ֽñ� �ٶ��ϴ�.");
		return;
	}
	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("���̵� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.value.length<4) || (frm.m_id.value.length>10))
   	{
   		alert("���̵�� 4���̻� 10�� ���Ϸ� �Է��� �ּ���");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("�̸��� �Է� �ϼ���");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("�̸��� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("�н������ 4���̻� 20�� ���Ϸ� �Է��� �ּ���");
   		frm.m_passwd.focus();
   		return;
   	}	    
	if(frm.m_passwd.value!=frm.m_passwd1.value)
	{
		alert("�н����尡 ��ġ���� �ʽ��ϴ�.")
		frm.m_passwd.value;
		return;
	}

	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� �ּ� ������ �Է����ּ���!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(frm.m_tel1.value.length==0)
	{
		alert("����ó�� �Է����ּ���!");
		frm.m_tel1.focus();
		return;
	}
	if(frm.m_tel2.value.length==0)
	{
		alert("�޴��� ��ȣ�� �Է����ּ���!");
		frm.m_tel2.focus();
		return;
	}

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("�̸��� �ּҸ� ��Ȯ�� �Է��� �ּ���!");
		frm.m_email.focus();
		return;
	}	
	if(frm.dealer_name.value=="")
	{
		alert("�ŷ�ó ȸ����� �Է��� �ּ���!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� ȸ���ּ� ������ �Է����ּ���!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_bank_name.value=="")
	{
		alert("��ǥ�� ���� �Է����ּ���!");
		frm.dealer_bank_name.focus();
		return;
	}	

	
   frm.submit();
}	


function a_custom_print(g_goods_idx)
{
	o_win=NewWindow('/customer/a_custom_goods_print.asp?g_goods_idx='+g_goods_idx,'a_custom_print','800','700','yes');
}


// �λ���� - �ŷ�ó/��� �ϰ� ��ϵ��    
function partner_dealer_all() 
{
	frm=document.all.frm_dealer;

	if(frm.dealer_name.value=="")
	{
		alert("�ŷ�ó ȸ����� �Է��� �ּ���!");
		frm.dealer_name.focus();
		return;
	}

	/*
	if(frm.dealer_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� ȸ���ּ� ������ �Է����ּ���!");
		frm.dealer_zipcode1.focus();
		return;
	}
	*/

	if(frm.dealer_insu.checked==false && frm.dealer_ingea.checked==false)
	{
		alert("������/����� ���θ� �ϳ��̻� üũ�� �ּ���!");
		frm.dealer_insu.focus();
		return;
	}

	if(frm.dealer_group_code.value=="0")
	{
		alert("����׷��� ������ �ּ���!");
		frm.dealer_group_code.focus();
		return;
	}

	if(checkSpecialChar(frm.m_id.value)==false)
	{
		alert("���̵� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_id.focus();
		return;
	}

   	if((frm.m_id.length<4) || (frm.m_id.length>10))
   	{
   		alert("���̵�� 4���̻� 10�� ���Ϸ� �Է��� �ּ���");
   		frm.m_id.focus();
   		return;
   	}	 

    if (frm.m_name.value == "" ) 
    {
        alert("������� �Է� �ϼ���");
		frm.m_name.focus();
		return;
    }

	if(checkSpecialChar(frm.m_name.value)==false)
	{
		alert("�̸��� Ư�����ڰ� �� �ֽ��ϴ�. ���鵵 �����ϸ� �ȵ˴ϴ�.");
		frm.m_name.focus();
		return;
	}

   	var pass=frm.m_passwd.value.split(" ").join("");
   	if((pass.length<4) || (pass.length>20))
   	{
   		alert("�н������ 4���̻� 20�� ���Ϸ� �Է��� �ּ���");
   		frm.m_passwd.focus();
   		return;
   	}	    


	if(frm.m_duty.selectedIndex==0)
	{
		alert("�μ��� ������ �ּ���.");
		frm.m_duty.focus();
		return;	
	}
	if(frm.m_position.selectedIndex==0)
	{
		alert("����/������  ������ �ּ���.");
		frm.m_position.focus();
		return;	
	}
	
	/*
	if(frm.m_zipcode1.value=="")
	{
		alert("�˻���ư�� ���� �ּ� ������ �Է����ּ���!");
		frm.m_zipcode1.focus();
		return;
	}
	*/

	if(frm.m_tel1.value.length==0)
	{
		alert("����ó�� �Է����ּ���!");
		frm.m_tel1.focus();
		return;
	}
	if(frm.m_tel2.value.length==0)
	{
		alert("����ó�� �Է����ּ���!");
		frm.m_tel2.focus();
		return;
	}

	if(CheckEmail(frm.m_email.value)==false)
	{
		alert("�̸��� �ּҸ� ��Ȯ�� �Է��� �ּ���!");
		frm.m_email.focus();
		return;
	}	
	
	frm.submit();
}


// ����ǰ ���� ��� (�����׸� üũ)
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
		//����ǰ ������ �����.
		frm.g_sp_bank_code.options[0].selected=true;
		frm.g_sp_bank_acount.value="";
		frm.g_sp_bank_name.value="";
		frm.g_sp_bank_jumin1.value = "";
		frm.g_sp_bank_jumin2.value = "";
	}
}

//������Ʈ �˻�
function black_search(form_name)
{
	var frm=eval("document.all."+form_name);

	var jumin1=frm.c_jumin1.value;
	var jumin2=frm.c_jumin2.value;
	jumin=frm.c_jumin1.value+frm.c_jumin2.value;

	if(frm.c_jumin1.value=="")
	{
		alert("�ֹι�ȣ�� �Է����ּ���!");
		frm.c_jumin1.focus();
		return;
	}
	if(Jumin_chk(jumin)==false)
	{
		alert("�߸��� �ֹε�� ��ȣ �Դϴ�. \n\n �ٽ� Ȯ���� �ֽð� �Է��� �ּ���");
		frm.c_jumin1.focus();
		return;
	}

	NewWindow("/include/asp/black_search.asp?black_jumin1="+jumin1+"&black_jumin2="+jumin2,"balck_search","600","250","no")
}


//������Ʈ �˻�
function black_search_tel(form_name,tel_chk)
{
	var frm		= eval("document.all."+form_name);
	
	var tel_num	= eval("frm."+tel_chk+".value");

	if(tel_num=="")
	{
		alert("��ȭ��ȣ�� �Է����ּ���!");
		return;
	}

	NewWindow("/include/asp/black_search.asp?tel_num="+tel_num+"&black_chk=tel1","balck_search","600","250","no")
}

// �̷� �������� ǥ�� ����
function consult_date_view_apply(url)
{
	ans=confirm("����ǥ�ø� �����Ͻðڽ��ϱ�?");
	if(ans==true)
	{
		location.replace(url);
	}
}




function style_view_chk(form_name,chk)	
{

	var frm = document.getElementById(form_name);	
	
	// ���� ����
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

		//�ջ� û��
		if(frm.g_give_type[3].checked==true)
		{
			document.getElementById("style_view_15").style.display = "block";	
			document.getElementById("style_view_15").style.display = "";			
			
		}
	}
	// ��ü ����
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
		frm.g_option_idx.options[0] = new Option('��ǰ �ɼ�','0');

			
		frm.g_article_idx2_1[0].selected=true;


		frm.g_option_idx_1.length=0;		
		frm.g_option_idx_1.options[0] = new Option('��ǰ �ɼ�','0');

		
		frm.g_article_idx2_2[0].selected=true;


		frm.g_option_idx_2.length=0;		
		frm.g_option_idx_2.options[0] = new Option('��ǰ �ɼ�','0');
		
		//���� �ʱ�ȭ
		frm.g_code_promise1.length=0;		
		frm.g_code_promise1.options[0] = new Option('���� ����','0');

		frm.g_code_promise2.length=0;		
		frm.g_code_promise2.options[0] = new Option('���� ����','0');

		frm.g_code_promise3.length=0;		
		frm.g_code_promise3.options[0] = new Option('���� ����','0');

		//�ΰ����� �ʱ�ȭ
		frm.g_code_service1.length=0;		
		frm.g_code_service1.options[0] = new Option('�ΰ����� ����','0');

		frm.g_code_service2.length=0;		
		frm.g_code_service2.options[0] = new Option('�ΰ����� ����','0');

		frm.g_code_service3.length=0;		
		frm.g_code_service3.options[0] = new Option('�ΰ����� ����','0');

		//������ �ʱ�ȭ
		frm.g_code_sale.length=0;		
		frm.g_code_sale.options[0] = new Option('������ ����','0');

		frm.g_code_sale1.length=0;		
		frm.g_code_sale1.options[0] = new Option('������ ����','0');

		frm.g_code_sale2.length=0;		
		frm.g_code_sale2.options[0] = new Option('������ ����','0');

		frm.g_article_cnt1.value = "1";
		frm.g_article_cnt2.value = "1";
		frm.g_article_cnt3.value = "1";

	}

}


function customer_dong_copy(form_name,this_chk, chk)
{
	var frm = eval("document.all."+form_name);	

	
	//������ü ���� ����(������, �ֹι�ȣ)
	if(chk=="A")
	{
		if(this_chk.checked==true)
		{
			frm.c_bank_name.value = frm.c_name.value;
			frm.c_bank_jumin1.value = frm.c_jumin1.value;
			frm.c_bank_jumin2.value = frm.c_jumin2.value;
		}
	}

	//ī�� ���� ����(������, �ֹι�ȣ)
	if(chk=="B")
	{
		if(this_chk.checked==true)
		{
			frm.g_card_name.value = frm.c_name.value;
			frm.g_card_jumin1.value = frm.c_jumin1.value;
			frm.g_card_jumin2.value = frm.c_jumin2.value;
		}
	}

	//��ȣ�̵��� ����
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

//�˾�â ���� ���
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
	
	//����
	if (This.value=="")
	{
		Target1_value = "";
		Target2_value = "";
	}	
	//����
	if (This.value=="A")
	{
		now_month		= String(now_month);
		now_day			= String(now_day);

		if (now_month.length=="1")	now_month	= "0"+now_month;
		if (now_day.length=="1")	now_day		= "0"+now_day;	

		Target1_value	= now_year+"-"+now_month+"-"+now_day;
		Target2_value	= now_year+"-"+now_month+"-"+now_day;
	}	
	//����
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
	//�̹���
	if (This.value=="C")
	{
		now_month		= String(now_month);
		now_day			= String(now_day);

		if (now_month.length=="1")	now_month	= "0"+now_month;
		if (now_day.length=="1")	now_day		= "0"+now_day;	

		Target1_value	= now_year+"-"+now_month+"-01";
		Target2_value	= now_year+"-"+now_month+"-"+now_day;
	}
	//������
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
			alert("��¥ �׸��� ������ �ּ���!");
			frm.date_chk.focus();
			return;
		}
	}
	else
	{
		if(frm.s_search_key.value=="")
		{
			alert("��¥ �׸��� ������ �ּ���!");
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
		sHTML += "	<tr align='center' height='22px' ><td style='padding-left:30px'>�ݾ��� ���� �Ͻʽÿ�.</td>"
		sHTML += "		<td style='text-align:right;'><input type='button' value='�ݱ�' onclick=\"select_price_close('"+obj+"');\" style='height:25px;cursor:pointer;' ></td>"
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
	input = input.replace(/,/g, ''); // �޸� ����
 
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

//�� ���������� ���θ� �ּ� ǥ�� ��Ŀ� ���� ���ɿ� ����, �������� �����͸� �����Ͽ� �ùٸ� �ּҸ� �����ϴ� ����� �����մϴ�.
function sample4_execDaumPostcode(Target1, Target2) {
	new daum.Postcode({
		popupName : 'daum_address',
		oncomplete: function(data) {
			// �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

			var fullAddr = ''; // ���� �ּ� ����
			var extraAddr = ''; // ������ �ּ� ����

			// ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
			if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
				fullAddr = data.roadAddress;

			} else { // ����ڰ� ���� �ּҸ� �������� ���(J)
				fullAddr = data.jibunAddress;
			}

			// ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
			if(data.userSelectedType === 'R'){
				//���������� ���� ��� �߰��Ѵ�.
				if(data.bname !== ''){
					extraAddr += data.bname;
				}
				// �ǹ����� ���� ��� �߰��Ѵ�.
				if(data.buildingName !== ''){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			}


			// �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
			//document.getElementById(Target1).value = data.postcode; //�� �����ȣ ���					
			//document.getElementById(Target1).value = data.postcode1; //�� �����ȣ ���
			//document.getElementById(Target2).value = data.postcode2; //�� �����ȣ ���
			//document.getElementById(Target3).value = data.jibunAddress;	//�����ּ�


			document.getElementById(Target1).value = data.zonecode; //5�ڸ� �������ȣ ���
            document.getElementById(Target2).value = fullAddr;



			// ����ڰ� '���� ����'�� Ŭ���� ���, ���� �ּҶ�� ǥ�ø� ���ش�.
			if(data.autoRoadAddress) {
				//����Ǵ� ���θ� �ּҿ� ������ �ּҸ� �߰��Ѵ�.
				var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				//document.getElementById('guide').innerHTML = '(���� ���θ� �ּ� : ' + expRoadAddr + ')';

			} else if(data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				//document.getElementById('guide').innerHTML = '(���� ���� �ּ� : ' + expJibunAddr + ')';

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

//�޸�Ǯ��
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
	
	//���̾��˾� z-index ���� 100 ���Ϸ� �����ؾ� ��.
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
