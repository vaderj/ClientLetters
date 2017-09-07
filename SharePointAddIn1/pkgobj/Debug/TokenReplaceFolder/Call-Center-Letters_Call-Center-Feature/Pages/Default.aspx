﻿<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="~masterurl/default.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <SharePoint:ScriptLink name="sp.js" runat="server" OnDemand="true" LoadAfterUI="true" Localizable="false" />
    <meta name="WebPartPageExpansion" content="full" />

    <!-- Add your CSS styles to the following file -->
    <link rel="Stylesheet" type="text/css" href="../Content/App.css" />

    <!-- Add your JavaScript to the following file -->
    <script type="text/javascript" src="../Scripts/App.js"></script>
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Page Title
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">

    <div id="fullForm" class="container-fluid">
        <p></p>
        <p></p>
        <br />
        <div id="screen" class="row">
            <div id="nav" class="col-xs-3 col-md-2 col-lg-1">
                <p id="message">
            <!-- The following content will be replaced with the user name when you run the app - see App.js -->
            initializing...
                </p>
                <p>
                    <input type="button" value="Disable MDS" onclick="RESTdisableSiteFeature('87294c72-f260-42f3-a41b-981a2ffce37a')" />
                </p>
            </div>
            <div id="content" class="col-xs-9 col-md-10 col-lg-11">

                <div id="editForm" class="col-xs-12">
                                    <input type="button" onclick="btnSubmit_CreateListItem()" value="new list item on HOST WEB" />
                </div>
                <div class="col-xs-12"><input type="button" value="List config" onclick="listConfig()" /></div>
                <p>
                    <a href="../Lists/Letter Configuration">Letter config</a>
                </p>
                <p>
                    <a href="../Pages/LetterTemplate.aspx?lid=1">Letter Template</a>
                </p>
                <br />
                <p></p>
                <div id="listView" class="col-xs-12">
                    <!-- https://sharepoint.stackexchange.com/questions/90000/how-to-add-list-view-on-application-page-of-appweb-in-sharepoint-autohosted-app -->
                    <WebPartPages:WebPartZone 
                        runat="server" 
                        FrameType="TitleBarOnly"
                        ID="full" 
                        Title="loc:full" >
                        <WebPartPages:XsltListViewWebPart 
                            ID="XsltListViewWebPart2" 
                            runat="server" 
                            ListUrl="Lists/Letters" 
                            IsIncluded="True" 
                            NoDefaultStyle="TRUE" 
                            Title="Letters" 
                            PageType="PAGE_NORMALVIEW" 
                            Default="False" 
                            ViewContentTypeId="0x"> 
                        </WebPartPages:XsltListViewWebPart>
                    </WebPartPages:WebPartZone>
                </div>
            </div>
        </div>
    </div>    
</asp:Content>
