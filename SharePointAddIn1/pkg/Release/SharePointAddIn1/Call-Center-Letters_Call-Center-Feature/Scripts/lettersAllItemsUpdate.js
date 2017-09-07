<style type="text/css">


.btn{
	background-color: #FFB81C !important;
}

</style>


<div>

</div>

<script type="text/Javascript">

var libraryName = "CFS-CST Letters" ;

function openLetter(id)
{
	window.location.href = _spPageContextInfo.webAbsoluteUrl + "/SitePages/LetterTemplate.aspx?lid=" + id ;
}

function interateList() // As a jQuery array 
{
	var listItems = jQuery("[summary='" + libraryName + "'] tr.ms-itmhover")
	for ( var i = 0 ; i < listItems.length ; i++ )
	{
		var currentID = jQuery("[summary='" + libraryName + "'] tr.ms-itmhover").eq(i).attr('id').split(",")[1]
		jQuery("[summary='" + libraryName + "'] tr.ms-itmhover").eq(i).children("td").eq(2).prepend("<input class='btn' type='button' value='View/Print Letter' onclick='openLetter(" + currentID + ")'>")
	}
}


_spBodyOnLoadFunctionNames.push("interateList");





</script>