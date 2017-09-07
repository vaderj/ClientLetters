<%@ Page language="C#" MasterPageFile="~masterurl/default.master" Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">

    <link href="../Content/letterTemplate.css" rel="stylesheet" />

    <SharePoint:ScriptLink name="sp.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <script type="text/javascript" src="/dev/Letters/Scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/dev/Letters/Scripts/bootstrap.min.js"></script>
    <script type="text/javascript"  src="/dev/Letters/Scripts/letterTemplate.js"></script>
    <script type="text/javascript"  src="/dev/Letters/Scripts/clipboard.js"></script> 
    <script src="/dev/Letters/Scripts/letterTemplate.js"></script>
    




<!--  <CustomAction
    ScriptSrc="../Scripts/bootstrap.min.js"
    Location="ScriptLink"
    Sequence="10">
  </CustomAction>
  <CustomAction
    ScriptSrc="../Scripts/letterTemplate.js"
    Location="ScriptLink"
    Sequence="20">
  </CustomAction>
    <CustomAction
    ScriptSrc="../Scripts/clipboard.js"
    Location="ScriptLink"
    Sequence="20">
  </CustomAction>
    -->

</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
    

    <div class="no-print container">
	<div class="row">
		<div class="col-md-6 col-xs-12">
			<div class="panel panel-warning">
				<div class="panel-heading clickable">
					<h2 class="panel-title"> Click to close </h2>
					<span class="pull-right "><i class="glyphicon glyphicon-minus"></i></span>
				</div>
				<div class="panel-body">
					<h3 class="chrome browserSpecific" >Chrome handles printing differently than IE. Adjusting the slider below will adjust the size of the font</h3>
				
					<h3 class="browserSpecific ie">When using Internet Explorer, please disable the header and footer in the Print Preview window</h3>
				<img class="browserSpecific ie"  src="../Images/printHeader.png" />
				
				</div>
			</div>
		</div>
	</div>

	<div class="row chrome browserSpecific" id="chromePrintDiv">
		<div class="col-xs-4">
			<input class="fontSlider" type="range" min="1" max="2" step="0.01" value="Adjust Font size" oninput="updateFontSize(this.value)" onchange="updateFontSize(this.value)" />
		</div><span class="col-xs-4" id="fontSizePercentage"></span>
	</div>
	<br>
	<br>
	<div class="row">
		<div class="browserSpecific chrome col-xs-2">
			<input class="btn" type="button" value="Print Preview" id="chromePrint" onclick="window.print()" />
		</div>

		<div class="browserSpecific ie col-xs-2">
			<input class="btn" type="button" value="Print Preview" id="iePrint" onclick="openPrintPreviewIE()" />
		</div>

		<div class="col-xs-2">
			<input class="btn" data-clipboard-target="#rootDiv" type="button" value="Copy to clipboard" />
		</div>
	</div>
</div>

<div id="rootDiv">
	<center><img id="banfieldLogo" width="33%" height="auto" src="../Images/Banfield-Logo.jpg" /></center>
	<p id="letterAddress">
		<span class="clientName" id="clientName"></span><br>
		<span id="clientAddress1"></span><br>
		<span id="clientAddress2"></span>
		<span id="clientCity"></span><span>  </span><span id="clientState"></span><span id="clientZip"></span>
	</p>
	<br>
	<br>
	<p><span id="subjectLine"></span></p>
	<p><span id="greeting">Dear </span><span class="clientName" id="clientName"></span><span>,</span></p>

	<div id="letterBody"></div>

	<div id="signatureBlock">
	<p>Sincerely,</p>
	<br>
	<br>
	
		<span id="agentsName"></span>
		<br>
		<span> Wellness Plan Relations </span>
		<br>
		<span> Banfield Pet Hospital </span>
		<br>
		<span id="companyPhoneNum"> (888) 649-2716 </span>
	</div>

</div>


    
    
    <WebPartPages:WebPartZone runat="server" FrameType="TitleBarOnly" ID="full" Title="loc:full">




    </WebPartPages:WebPartZone>



</asp:Content>
