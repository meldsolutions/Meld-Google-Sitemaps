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
	<ul class="form">
	<li class="first">
		<label for="enabled">
			<input type="checkbox" name="enabled" id="enabled" value="1" <cfif form.enabled>CHECKED</cfif>/>
			#rc.mmRBF.key('sitemapenabled')#
		</label>
	</li>
	<li>
		<label for="location">
			#rc.mmRBF.key('location')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('location','tip')#</span>&nbsp;</a>
		</label>
		<select class="select" name="location" id="location">
			<cfloop list="site,web" index="local.x">
			<option value="#local.x#" <cfif local.x eq form.location>SELECTED</cfif>>#rc.mmRBF.key('#local.x#_location')#</option>
			</cfloop>
		</select>
	</li>
	<li>
		<label for="frequency">
			#rc.mmRBF.key('frequency')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('frequency','tip')#</span>&nbsp;</a>
		</label>
		<select class="select" name="frequency" id="frequency">
			<cfloop list="Daily,Weekly,Monthly" index="local.x">
			<option value="#local.x#" <cfif local.x eq form.frequency>SELECTED</cfif>>#local.x#</option>
			</cfloop>
		</select>
	</li>
	<li>
		<label for="frequency">
			#rc.mmRBF.key('timeofday')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('timeofday','tip')#</span>&nbsp;</a>
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
	</li>
	<li>
		<label for="email">
			#rc.mmRBF.key('emailnotifications')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('emailnotifications','tip')#</span>&nbsp;</a>
		</label>
		<input class="text" type="text" name="email" id="email" value="#form.email#" size="150" maxlength="150" required="false"/>
		<p><small>#rc.mmRBF.key('emailnotifications','note')#</small></p>
	</li>
	</ul>
</cfoutput>
