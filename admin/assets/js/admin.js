/*
<!---
This file is part of the The Meld Google Sitemaps Plugin.

The Meld Google Sitemaps Plugin is licensed under the GPL 2.0 license
Copyright (C) 2010 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--->
*/
function doShowHide( src,tgt ) {
	if ( $("#"+src).is(':checked') ) {
		$("#"+tgt).show();
	}
	else {
		$("#"+tgt).hide();
	}
}

$(document).ready(function() {

	var doVal = true;

	meldvalidate = function( frm ) {
		if(!doVal) {
			return true;
		}
		else if (validate(frm)) {
			return true;
		}
		else {
			return false;
		}
	}

	$(":submit","#meld-edit-form").click(function() {

		if($(this).attr('id') == 'btsave') {
		}
		else if($(this).attr('id') == 'btupdate') {
			doVal=true;
		}
		else if ($(this).attr('id') == 'btcancel') {
			doVal=false;
			return true;			
		}
		else if ($(this).attr('id') == 'btdelete') {
			var $dialog = $("<div>" + $(this).attr('data-message') + "</div>");
			doVal=false;

			$dialog.dialog("destroy");

			$dialog.dialog({
				resizable: false,
				height: 140,
				modal: true,
				dialogClass: 'ui-state-highlight',
				title: $(this).attr('data-title'),
				buttons: {
					"Cancel": function(){
						$(this).dialog('close');
					},
					"Delete": function(){
						$('#btdeleteconfirm').val('delete');
						$('#meld-edit-form').submit();
					}
				}
			});
			return false;
		}
	});
});
