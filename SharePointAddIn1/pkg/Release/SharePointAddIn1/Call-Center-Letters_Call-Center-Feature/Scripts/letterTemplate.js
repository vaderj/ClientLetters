(function(){
var configListName = "Letter Configuration" ;
var letterListName /*= "CFS-CST Letters" ;

var configLetterColumns = "Letter_x0020_Type,LetterTXT,Title,Key" ;

var letterListColumns = "Title,Client_x0020_Address_x0020__x002,Client_x0020_Address_x0020__x0020,Client_x0020_City,Client_x0020_State,Client_x0020_Zip,OWP_x0020_Agreement,OWP_x0020_Pet_x0020_Name,OWP_x0020_Plan_x0020_Level,OWP_x0020_Monthly_x0020_Price,OWP_x0020_Renewal_x0020_Date,Client_x0020_Start_x0020_Date,Monthly_x0020_Payment_x0020_Date,Number_x0020_of_x0020_payments_x,Number_x0020_of_x0020_payments_x0,Number_x0020_of_x0020_payments_x1,Number_x0020_of_x0020_payments_x2,Type_x0020_of_x0020_letter,Agents_x0020_Name,Date_x0020_Payment_x0020_was_x00,Amount_x0020_Paid,Payment_x0020_Date,Check_x0020_the_x0020_box_x0020_,Date_x0020_invoice_x0020_was_x00,Settlement_x0020_Amount,Full_x0020_Amount_x0020_Owed,Settlement_x0020_Amount,Settlement_x0020_Date" ;
*/

var letterText ;
var letterObject = new Object() ;

var fontSize = new Array() ;
var letterTypes = new Array() ;
var letterTokenMappings = new Array() ;

var monthList = new Array();
	monthList[0] = "January";
	monthList[1] = "February";
	monthList[2] = "March";
	monthList[3] = "April";
	monthList[4] = "May";
	monthList[5] = "June";
	monthList[6] = "July";
	monthList[7] = "August";
	monthList[8] = "September";
	monthList[9] = "October";
	monthList[10] = "November";
	monthList[11] = "December";

function openPrintPreviewIE()
{
	var objPrintPreview = '<object id="printPrev" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>';
	document.body.insertAdjacentHTML('beforeEnd', objPrintPreview);
	printPrev.ExecWB(7, 1);
	printPrev.outerHTML = ""
}

function buildLetterBody(letterObject)
{
	//console.log(letterObject) ;
	var letterType = letterObject.Letter_x0020_Type ;
	var unformattedLetter;
	for (var i = 0 ; i < letterTypes.length ; i++)
	{
		if (letterTypes[i].letterName == letterType)
		{
			unformattedLetter = letterTypes[i].letterText ;
			//console.log(unformattedLetter) ;
		}
	}
	for (var i = 0 ; i < letterTokenMappings.length ; i++)
	{
		var tokenRegEx = new RegExp(letterTokenMappings[i].token,"g");
		unformattedLetter = unformattedLetter.replace(tokenRegEx,letterObject[letterTokenMappings[i].fieldInternalName])
	}
	unformattedLetter = unformattedLetter.replace(/\n/gm,"</span></p><p><span>");
	unformattedLetter = "<p><span>" + unformattedLetter ;
	unformattedLetter = unformattedLetter + "</span></p>";
	document.getElementById("letterBody").innerHTML = unformattedLetter ;
	browserCheck();
}

function getConfig()
{
	// Get the configuration and letter text
	var lettersConfig = jQuery.ajax({
		url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('" + configListName + "')/items?",
		method: "GET",
		contentType: 'application/json;odata=verbose',
		headers: { 
			'Accept': 'application/json;odata=verbose',
			'content-type':'application/json;odata=verbose',
			'X-RequestDigest': $("#__REQUESTDIGEST").val()
		}
	});

	lettersConfig.done(function(letterConfigData, textStatus, jqXHR){
		var config = letterConfigData.d.results ;
		
		for (var i = 0 ; i < config.length ; i++)
		{
			if(config[i].config_x0020_type == "Token Mapping")
			{
				//console.log(config[i].Value)
				letterTokenMappings.push({
					token : config[i].Title,
					fieldInternalName : config[i].Value
				}) ;
			}
			else if (config[i].config_x0020_type == "Letter")
			{
				letterTypes.push({
					letterName : config[i].Title,
					letterText : config[i].Value 
				})
			}
			else if (config[i].config_x0020_type == "Font Size")
			{
				fontSize.push({
					browser: config[i].Title,
					size : config[i].Value 
				})
			}
			else if ( config[i].config_x0020_type == "General")
			{
				if ( config[i].Title == "List Name")
				{
					letterListName = config[i].Value
				}
			}
		}

	JSRequest.EnsureSetup();
	var q = JSRequest.QueryString["lid"] ;
	
	
	getLetter(q) ;
	});
}

function getLetter(id)
{
	var letter = jQuery.ajax({
		url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('" + letterListName + "')/items?&$filter=Id eq '" + id + "'",
		method: "GET",
		contentType: 'application/json;odata=verbose',
		headers: { 
			'Accept': 'application/json;odata=verbose',
			'content-type':'application/json;odata=verbose',
			'X-RequestDigest': $("#__REQUESTDIGEST").val()
		}
	});

	letter.done(function(letterData, textStatus, jqXHR){

		for (var i = 0 ; i < letterTokenMappings.length ; i++)
		{
			var str = letterData.d.results[0][letterTokenMappings[i].fieldInternalName] ;

			if (typeof(str) == "string" && str.charAt(str.length-1) == "Z")
			{
				var unformattedDate = new Date(letterData.d.results[0][letterTokenMappings[i].fieldInternalName]) ;
				try
				{
					formattedDate = monthList[unformattedDate.getMonth()] + " " + unformattedDate.getDay() + ", " + unformattedDate.getFullYear() ;
				}
				catch(err)
				{
					console.log(err) ;
				}
				letterObject[letterTokenMappings[i].fieldInternalName] = formattedDate ;
			}
			else
			{
				letterObject[letterTokenMappings[i].fieldInternalName] = letterData.d.results[0][letterTokenMappings[i].fieldInternalName]
			}
		}
		browserCheck();
		applyStaticFields(letterObject) ;
		buildLetterBody(letterObject) ;
	});
}

function applyStaticFields(letterObject)
{
	jQuery(".clientName").text(letterObject.Title) ;
	jQuery("#clientAddress1").text(letterObject.Client_x0020_Address_x0020__x002) ;
	
	if (typeof(letterObject.Client_x0020_Address_x0020__x0020) != "object")
	{
		jQuery("#clientAddress2").text(letterObject.Client_x0020_Address_x0020__x0020);
		jQuery("<br>").insertAfter(jQuery("#clientAddress2")) ;
	}
	
	jQuery("#clientCity").text(letterObject.Client_x0020_City) ;
	jQuery("#clientState").text(letterObject.Client_x0020_State) ;
	jQuery("#clientZip").text(", " + letterObject.Client_x0020_Zip) ;
	jQuery("#subjectLine").text("Re: Wellness Plan for #" + letterObject.OWP_x0020_Agreement) ;
	jQuery("#agentsName").text(letterObject.Agents_x0020_Name) ;
}

function browserCheck()
{
	//Check for which browser.  If chrome, hide the IE tag and show a chrome message-bo
	var browsersFontSize ;
	var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
	if (is_chrome)
	{
		jQuery(".chrome").show() ;
		jQuery(".ie").hide() ;
		browsersFontSize = fontSize.filter(function(obj){return obj.browser == "chrome"}) ;
		jQuery("#rootDiv p, #rootDiv span, #rootDiv #signatureBlock").css("font-size", browsersFontSize[0].size + "pt");
	}
	else
	{
		jQuery(".ie").show() ;
		jQuery(".chrome").hide() ;
		browsersFontSize = fontSize.filter(function(obj){return obj.browser == "ie"})
		jQuery("#rootDiv p, #rootDiv span, #rootDiv #signatureBlock").css("font-size", browsersFontSize[0].size + "pt");
	}
	console.log(browsersFontSize[0].size)
}

function updateFontSize(percentage)
{
	jQuery("#rootDiv p, #rootDiv span, #rootDiv #signatureBlock").css("font-size",100*percentage + "%");
	jQuery("#fontSizePercentage").text(100*percentage + "%") ;
}

function getStarted()
{
	getConfig() ;
	jQuery("#banfield-breadcrumbs").addClass('no-print') ;
	jQuery("#pageTitle").addClass('no-print') ;
	new Clipboard('.btn');

	// Instruction panel support
	$(document).on('click', '.panel-heading span.clickable', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.addClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    } else {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.removeClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
    }
});
	$(document).on('click', '.panel div.clickable', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.addClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    } else {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.removeClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
    }
});
	$(document).ready(function () {
    $('.panel-heading span.clickable').click();
    $('.panel div.clickable').click();
});
}
_spBodyOnLoadFunctionNames.push("getStarted");

function hideSkypeIcon()
{
	jQuery("img[title^='Call:']").hide() ;
}

setInterval(function(){hideSkypeIcon();},2000) ;
})