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
	<cfset local.rc = rc>
	<cfset local.timeofday			= rc.sitemapsObject.getExtendedData().getAttribute('timeofday',true,'object')>
	<cfif not isDate( local.timeOfDay )>
		<cfset local.timeofday = createDateTime( 2011,01,01,02,0,0) />
	</cfif>
	<cfset local.timeofday_hour		= timeformat( local.timeofday,"HH" ) />
	<cfset local.timeofday_minute	= datepart("n", local.timeofday ) />
</cfsilent>
<cfoutput>
	<div class="mura-control-group">
		<label>#rc.mmRBF.key('sitemapenabled')#</label>
		<input type="checkbox" name="enabled" id="enabled" value="1" <cfif form.enabled>CHECKED</cfif>>
	</div>
	<div class="mura-control-group">
		<label>
			<span data-toggle="popover" title="" data-placement="right"
			data-content="#rc.mmRBF.key('location','tip')#"
			data-original-title="#rc.mmRBF.key('location')#">
			  #rc.mmRBF.key('location')# <i class="mi-question-circle"></i>
			</span>
		</label>
		<select class="select" name="location" id="location">
			<cfloop list="site,web" index="local.x">
			<option value="#local.x#" <cfif local.x eq form.location>SELECTED</cfif>>#rc.mmRBF.key('#local.x#_location')#</option>
			</cfloop>
		</select>
	</div>
	<div class="mura-control-group">
		<label>
			<span data-toggle="popover" title="" data-placement="right"
			data-content="#rc.mmRBF.key('frequency','tip')#"
			data-original-title="#rc.mmRBF.key('frequency')#">
			  #rc.mmRBF.key('frequency')# <i class="mi-question-circle"></i>
			</span>
		</label>
		<select class="select" name="frequency" id="frequency">
			<cfloop list="Daily,Weekly,Monthly" index="local.x">
			<option value="#local.x#" <cfif local.x eq form.frequency>SELECTED</cfif>>#local.x#</option>
			</cfloop>
		</select>
	</div>
	<div class="mura-control-group">
		<label>
			<span data-toggle="popover" title="" data-placement="right"
			data-content="#rc.mmRBF.key('timeofday','tip')#"
			data-original-title="#rc.mmRBF.key('timeofday')#">
			  #rc.mmRBF.key('timeofday')# <i class="mi-question-circle"></i>
			</span>
		</label>
		<select class="select" name="timeofday_hour" id="timeofday_hour">
			<cfloop from="0" to="23" index="local.x">
			<option value="#local.x#" <cfif local.x eq local.timeofday_hour>SELECTED</cfif>><cfif len(local.x) eq 1>0</cfif>#local.x#</option>
			</cfloop>
		</select>
		<select class="select" name="timeofday_minute" id="timeofday_minute">
			<cfloop list="00,15,30,45" index="local.x">
			<option value="#local.x#" <cfif local.x eq local.timeofday_minute>SELECTED</cfif>>#local.x#</option>
			</cfloop>
		</select>
	</div>
	<div class="mura-control-group">
		<label>
			<span data-toggle="popover" title="" data-placement="right"
			data-content="#rc.mmRBF.key('emailnotifications','tip')#"
			data-original-title="#rc.mmRBF.key('emailnotifications')#">
			  #rc.mmRBF.key('emailnotifications')# <i class="mi-question-circle"></i>
			</span>
		</label>
		<input type="text" name="email" value="#form.email#" >
	</div>
</cfoutput>
