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
<cfsilent>
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent>
<cfoutput>
<!--- global menu --->
<!--- begin content --->
<h3>#rc.mmRBF.key('editsettings')#</h3>

<form id="meld-edit-form" class="meld-form" method="post" action="index.cfm" onsubmit="return validate(this);" enctype="multipart/form-data">
	<input type="hidden" name="action" value="admin:settings.edit">
	#view("settings/includes/edit_settings")#
	<div class="mura-actions">
		<div class="form-actions">
			<button type="button" name="btaction" value="#rc.mmRBF.key('cancel')#" class="btn" id="btcancel"><i class="mi-trash"></i>#rc.mmRBF.key('cancel')#</button>
			<button type="submit" name="btaction" value="#rc.mmRBF.key('update')#" class="btn mura-primary" id="btupdate"><i class="mi-check-circle"></i>#rc.mmRBF.key('update')#</button>
		</div>
	</div>
</form>		


<!--- end content --->
</cfoutput> 