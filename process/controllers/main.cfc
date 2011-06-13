<!---

This file is part of the Meld Google Sitemaps Plugin.

Meld Google Sitemaps Plugin is licensed under the GPL 2.0 license
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
<cfcomponent extends="controller">
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var site					= iif( StructKeyExists(url,'site'),de(url.site),de(rc.siteID) ) />
		<cfset var siteConfig			= rc.$.getBean('settingsManager').getSite(site) />
		<cfset var sitemapsObject		= createObject("component","mura.extend.extendObject").init(Type="Custom",SubType="MeldGoogleSitemaps",SiteID=site)>
		<cfset var mailer				= rc.$.getBean("mailer") />
		<cfset var tickCount			= getTickCount() />
		<cfset var msg					= "" />
		<cfset var fileName				= "" />
		<cfset var fileURL				= "" />
		<cfset var sitemapManager		= getBeanFactory().getBean('MeldGoogleSitemapsManager') />
		<cfset var sitemapXML			= sitemapManager.getSitemap(rc.$,site) />

		<cfset sitemapsObject.setID( site ) />
		<cfset sitemapsObject.setModuleID( rc.pluginConfig.getModuleID() ) />
		<cfset sitemapsObject.getAllValues() />

		<cfset sitemapsObject.setValue('DateLastCreate',now()) />
		<!--- extend object issue, must set this --->
		<cfset sitemapsObject.setValue('TimeOfDay',sitemapsObject.getExtendedData().getAttribute('timeofday',true,'object') ) />
		<cfset sitemapsObject.save() />

		<cfif sitemapsObject.getValue('location') eq "site">
			<cfset filename ="#expandPath("/" & rc.$.globalConfig('muraWRM'))##site#/sitemap.xml" /> 
			<cfset fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getContext()#/#site#/sitemap.xml" /> 
		<cfelse>
			<cfset filename = "#expandPath("/" & rc.$.globalConfig('muraWRM'))#sitemap.xml" /> 
			<cfset fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getContext()#/sitemap.xml" /> 
		</cfif>

		<cffile action="write" file="#filename#" output="#sitemapXML#" />
		
		<cfif len( sitemapsObject.getValue('Email') )>
			<cfsavecontent variable="msg"><cfoutput>
<p>Google Sitemap for #siteConfig.getDomain()# - #site# complete.</p>
<p><strong>Processing Time</strong>: #(getTickCount()-tickCount)# msec</p>
<p><strong>Location</strong>: #fileURL#</p>

<p style='color: ##aaa'>Powered by the Meld Google Sitemaps plugin, <a style='color: ##666' href="http://www.meldsolutions.com/">http://www.meldsolutions.com/</a></p>
			</cfoutput></cfsavecontent>
			<cftry>
			<cfset mailer.sendHTML(msg,
				#sitemapsObject.getValue('Email')#,
				"",
				"Google Sitemap for #siteConfig.getDomain()# - #site# complete.",
				site,
				siteConfig.getContactEmail() ) />
			<cfcatch></cfcatch>
			</cftry>
		</cfif>
		<cfset rc.time = (getTickCount()-tickCount) />
		
	</cffunction>
</cfcomponent>