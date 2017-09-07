<script type="text/Javascript">
var configListName = "Letter Configuration" ;
var letterTypes = new Array() ;

function showHideFields()
{
	var letterType = jQuery("#letterSelect").val() ;
	jQuery("[title='Letter Type'").val(letterType)
	//console.log(letterType )

	if (letterType == "Credit Reference")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Overdraft Apology")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').hide() ;
		jQuery("[title='Current Balance']").closest('tr').show() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').show() ;
	}

	else if (letterType == "Paid in full at I.C.S.")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').hide() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').show() ;
	}

	else if (letterType == "Paid in full - Not at I.C.S.")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Sent in error - Credit Bureau Reported")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Send in error - Not reported")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Settlement Offer - Wellness Plan")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Settled - Not at I.C.S.")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}

	else if (letterType == "Settled at I.C.S.")
	{
		jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').show() ;
		jQuery("[title='Current Balance']").closest('tr').hide() ;
		jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}
	else
	{
	jQuery("[title='OWP Cancel Date']").parent().parent().parent().parent().closest('tr').hide() ;
	jQuery("[title='Current Balance']").closest('tr').hide() ;
	jQuery("[title='OWP Renewal Date']").parent().parent().parent().parent().closest('tr').hide() ;
	}
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
		//console.dir(letterConfigData) ;
		var config = letterConfigData.d.results ;
		for (var i = 0 ; i <config.length ; i++)
		{
			if (config[i].config_x0020_type == "Letter")
			{
				letterTypes.push({
					letterName : config[i].Title,
					letterText : config[i].Value
				});
			}
		}
		createLetterTypeDropdown() ;
	});
}

function createLetterTypeDropdown()
{
	var letterSelect = document.getElementById("letterSelect");
	for (var i = 0 ; i < letterTypes.length ; i++)
	{
		var option = document.createElement("option");
		option.textContent = letterTypes[i].letterName ;
		option.value = letterTypes[i].letterName ;
		letterSelect.appendChild(option);
	}

	//Set the Select Option value to the value the list item has. Otherwise, the selected value would be the first value in the list
	var currentValue = jQuery("[title='Letter Type']").val() ;
	jQuery("#letterSelect").val(currentValue)
}

function getStarted()
{
	//Hide the text field since the values are being read from a configuration list.
	jQuery("[title='Letter Type']").hide() ;
	jQuery("[title='Letter Type']").parent().prepend("<select id='letterSelect'></select>");
	jQuery("#letterSelect").on('focus input change',showHideFields) ;
	getConfig() ;
}

_spBodyOnLoadFunctionNames.push("getStarted");

</script>


