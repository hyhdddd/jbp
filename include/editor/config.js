/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.language = 'ko';
	config.uiColor = '#EEEEEE';
	config.height = '300px'; //Editor 높이  
	config.width = '100%';
	config.contentsCss = ['/include/css/style.css'];

	config.toolbar = [['NewPage','Preview','Bold','Italic','Underline','Strike','-','Subscript','Superscript','-','-',
		'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Outdent','Indent','HorizontalRule','Link','Unlink','-',
		'Find','Replace','SelectAll','Image','Flash','Table','SpecialChar'],
		'/',['Styles','Format','Font','FontSize','Undo','Redo'],['TextColor','BGColor'],['Cut','Copy','Paste','PasteText'],['Source']];
	config.font_names = '맑은 고딕; 돋움; 바탕; 돋음; 궁서; Nanum Gothic Coding;' + CKEDITOR.config.font_names; 

	config.pasteFromWordPromptCleanup = true;
	config.pasteFromWordRemoveStyles = false;
	config.pasteFromWordRemoveFontStyles = false;
	config.allowedContent=true;

    //config.forcePasteAsPlainText = false; // default so content won't be manipulated on load
    //config.basicEntities = true;
    //config.entities = true;
    //config.entities_latin = true;
    //config.entities_greek = true;
    //config.entities_processNumerical = true;
    //config.fillEmptyBlocks = function (element) {
      //      return true; // DON'T DO ANYTHING!!!!!
    //};

	//※기본적으로 제공하는 툴바의 버튼입니다.
	/*
	['Source','-','Save','NewPage','Preview','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print','SpellChecker', 'Scayt'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	['Form', 'Checkbox', 'Radio','TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	'/',
	['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Link','Unlink','Anchor'],
	['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	'/',
	['Styles','Format','Font','FontSize'],
	['TextColor','BGColor'],
	['Maximize', 'ShowBlocks','-','About']

	config.font_defaultLabel = 'Gulim';
	config.font_names='Gulim/Gulim;Dotum/Dotum;Batang/Batang;Gungsuh/Gungsuh/Arial/Arial;Tahoma/Tahoma;Verdana/Verdana';
	config.fontSize_defaultLabel = '12px';
	config.fontSize_sizes='8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';
	config.language = "ko";
	config.enterMode =CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.startupFocus = true;
	config.uiColor = '#EEEEEE';
	config.toolbar = 
	[['Bold','Italic','Underline','Strike','-','Subscript','Superscript','-','TextColor','BGColor','-',
	'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Link','Unlink','-',
	'Find','Replace','SelectAll','RemoveFormat','-','Image','Flash','Table','SpecialChar'],
	'/',['Source','-','ShowBlocks','-','Font','FontSize','Undo','Redo','-','About']];
	*/
	//CKEditor에 대해 추가적으로궁금한 사항을 찾아보고 싶으시다면, 제공되는 API인 
	//http://docs.cksource.com/ckeditor_api/을 통해 찾아보실 수 있습니당~ 



};
