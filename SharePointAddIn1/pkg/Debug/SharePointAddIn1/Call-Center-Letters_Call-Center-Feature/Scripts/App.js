'use strict';

ExecuteOrDelayUntilScriptLoaded(initializePage, "sp.js");

function initializePage()
{
    var context = SP.ClientContext.get_current();
    var user = context.get_web().get_currentUser();

    // This code runs when the DOM is ready and creates a context object which is needed to use the SharePoint object model
    $(document).ready(function () {
        getUserName();
    });

    // This function prepares, loads, and then executes a SharePoint query to get the current users information
    function getUserName() {
        context.load(user);
        context.executeQueryAsync(onGetUserNameSuccess, onGetUserNameFail);
    }

    // This function is executed if the above call is successful
    // It replaces the contents of the 'message' element with the user name
    function onGetUserNameSuccess() {
        $('#message').text('Hello ' + user.get_title());
    }

    // This function is executed if the above call fails
    function onGetUserNameFail(sender, args) {
        alert('Failed to get user name. Error:' + args.get_message());
    }

    
}

function RESTdisableSiteFeature(featureGuid) {

    var ctx = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);


    jQuery.ajax({
        url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/features/remove(featureId=guid'" + featureGuid + "',force=false)",
        type: "POST",
        headers: {
            "accept": "application/json; odata=verbose",
            "content-type": "application/json;odata=verbose",
            "X-RequestDigest": $("#__REQUESTDIGEST").val()
        },
        success: function () {
        },
        error: function (jqxhr) {
            alert("Fail: " + jqxhr.responseText);
        }
    });
}

function listConfig() {
    var configListName = "Letter Configuration";
    var configList = jQuery.ajax({
        //url: url + "_api/web/lists/getbytitle('" + payRangesListName + "')/items?'" + payRangesColumns + "'&$filter=Pay_x0020_Zone_x0020__x002d__x00 eq '" + cscPayZone + "'",
        url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('" + configListName + "')/items?'",
        method: "GET",
        headers: { "Accept": "application/json; odata=verbose" }
    });
    configList.done(function (listData, listTextStatus, listJqXHR) {
        //console.log(payRangeData.d.results[0].OData__x0031_st_x0020_Quartile_x0020__)
        console.dir(listData);
    });
}

function btnSubmit_CreateListItem() {

    //siteUrl will be your host web url.

    //app web
    var clientContext = new SP.ClientContext.get_current();
    var siteUrl = "http://gliese.vader.zone/dev"
    //host web
    var parentCtx = new SP.AppContextSite(clientContext, siteUrl);
    var oList = parentCtx.get_web().get_lists().getByTitle('Letters');

    var itemCreateInfo = new SP.ListItemCreationInformation();
    this.oListItem = oList.addItem(itemCreateInfo);
    oListItem.set_item('Client Name', 'My New Item!');
    oListItem.update();

    clientContext.load(oListItem);
    clientContext.executeQueryAsync(
        Function.createDelegate(this, this.onQuerySucceeded), Function.createDelegate(this, this.onQueryFailed)

    );
}


function onQuerySucceeded(sender, args) {
    alert('Item created: ' + oListItem.get_id());
}

function onQueryFailed(sender, args) {
    alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}
