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
<cfcomponent extends="MeldGoogleSitemaps.com.meldsolutions.mura.MuraEventHandler">
	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">

		<cfset verifySlatwallAttributeSet($) />

		<cfset var state=preseveInternalState(request)>
		<cfset var appreloadKey = $.GlobalConfig().getValue('appreloadKey') />

		<cfif len( appreloadKey ) and structKeyExists(url,appreloadKey)>
			<cfset url[variables.framework.reload] = true />
		</cfif>

		<!--- invoke onApplicationStart in the application.cfc so the framework can do its thing --->
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />
		<cfset restoreInternalState(request,state)>

		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onGlobalSessionStart" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfset var state=preseveInternalState(request)>
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onSessionStart" />
		<cfset restoreInternalState(request,state)>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false" access="private">
		<cfset var framework = StructNew() />

		<cfinclude template="../frameworkConfig.cfm" />

		<cfreturn framework />
	</cffunction>

	<cffunction name="getIsSlatwallIntegrationActive" returnType="boolean" access="public" output="false">
		<cfif NOT structKeyExists(variables,'isSlatwallIntegrationActive')>
			<cfset variables.isSlatwallIntegrationActive = variables.pluginConfig.getSetting('isSlatwallIntegrationActive') AND fileExists(expandPath('/Slatwall/Application.cfc')) />
		</cfif>

		<cfreturn variables.isSlatwallIntegrationActive />
	</cffunction>

	<cffunction name="getSlatwallApplication" returnType="any" access="public" output="false">
		<cfif NOT structKeyExists(variables,'slatwallApplication')>
			<cfset variables.slatwallApplication = createObject('Slatwall.Application') />
		</cfif>

		<cfreturn variables.slatwallApplication />
	</cffunction>

	<cffunction name="verifySlatwallRequest" returnType="void" access="private" output="false">
		<cfargument name="$" type="any" required="true" />

		<cfif getIsSlatwallIntegrationActive()>
			<cfif NOT structKeyExists(request,'slatwallScope')>
				<cfset getSlatwallApplication().setupGlobalRequest() />
			</cfif>

			<cfset $.setCustomMuraScopeKey('slatwall',request.slatwallScope) />
		</cfif>
	</cffunction>

	<cffunction name="verifySlatwallAttributeSet" returnType="void" access="private" output="false">
		<cfargument name="$" type="any" required="true" />

		<cfif getIsSlatwallIntegrationActive()>
			<cfset local.hibachiService				= getSlatwallApplication().getBeanFactory().getBean('hibachiService') />
			<cfset local.attributeSetService	= local.hibachiService.getServiceByEntityName('attributeSet') />
			<cfset local.attributeService			= local.hibachiService.getServiceByEntityName('attribute') />
			<cfset local.attributeSet					= local.attributeSetService.getAttributeSetByAttributeSetCode('googleSitemaps') />

			<cfif isNull(local.attributeSet)>
				<cfset local.attributeSet = local.attributeSetService.newAttributeSet() />
			</cfif>

			<cfset local.attributeSet.populate({
				attributeSetName='Google Sitemaps',
				attributeSetCode='googleSitemaps'
			}) />

			<cfset local.attributeSet.setAttributeSetType(local.attributeSetService.getType({ systemCode='astProduct' })) />
			<cfset local.attributeSetService.saveAttributeSet(local.attributeSet) />

			<cfset local.attributeItems = [{
				attributeName='Exclude From Sitemap',
				attributeHint='Exclude this product from the sitemap',
				attributeCode='googleSiteMapsExclude',
				defaultValue='no',
				attributeType={
					systemCode='atYesNo'
				},
				attributeSet={
					attributeSetCode='googleSitemaps'
				}
			},{
				attributeName='Change Frequency',
				attributeHint='The change frequency for the product',
				attributeCode='googleSiteMapsChangeFrequency',
				defaultValue='monthly',
				attributeType={
					systemCode='atSelect'
				},
				attributeSet={
					attributeSetCode='googleSitemaps'
				},
				attributeOptions=[{
					attributeOptionID='',
					attributeOptionValue='daily',
					attributeOptionLabel='Daily',
					sortOrder=1
				},{
					attributeOptionID='',
					attributeOptionValue='weekly',
					attributeOptionLabel='Weekly',
					sortOrder=2
				},{
					attributeOptionID='',
					attributeOptionValue='monthly',
					attributeOptionLabel='Monthly',
					sortOrder=3
				},{
					attributeOptionID='',
					attributeOptionValue='yearly',
					attributeOptionLabel='Yearly',
					sortOrder=4
				}]
			},{
				attributeName='Priority',
				attributeCode='googleSiteMapsPriority',
				attributeHint='The relative importance of the product to the site',
				defaultValue='0.5',
				attributeType={
					systemCode='atSelect'
				},
				attributeSet={
					attributeSetCode='googleSitemaps'
				},
				attributeOptions=[{
					attributeOptionID='',
					attributeOptionValue='0.1',
					attributeOptionLabel='0.1',
					sortOrder=1
				},{
					attributeOptionID='',
					attributeOptionValue='0.2',
					attributeOptionLabel='0.2',
					sortOrder=2
				},{
					attributeOptionID='',
					attributeOptionValue='0.3',
					attributeOptionLabel='0.3',
					sortOrder=3
				},{
					attributeOptionID='',
					attributeOptionValue='0.4',
					attributeOptionLabel='0.4',
					sortOrder=4
				},{
					attributeOptionID='',
					attributeOptionValue='0.5',
					attributeOptionLabel='0.5',
					sortOrder=5
				},{
					attributeOptionID='',
					attributeOptionValue='0.6',
					attributeOptionLabel='0.6',
					sortOrder=6
				},{
					attributeOptionID='',
					attributeOptionValue='0.7',
					attributeOptionLabel='0.7',
					sortOrder=7
				},{
					attributeOptionID='',
					attributeOptionValue='0.8',
					attributeOptionLabel='0.8',
					sortOrder=8
				},{
					attributeOptionID='',
					attributeOptionValue='0.9',
					attributeOptionLabel='0.9',
					sortOrder=9
				},{
					attributeOptionID='',
					attributeOptionValue='1.0',
					attributeOptionLabel='1.0',
					sortOrder=10
				}]
			}] />

			<cfloop array="#local.attributeItems#" index="local.attributeItem">
				<cfset local.attribute = local.attributeService.getAttributeByAttributeCode(local.attributeItem.attributeCode) />

				<cfif isNull(local.attribute)>
					<cfset local.attribute = local.attributeService.newAttribute() />
				</cfif>

				<cfif local.attribute.hasAttributeOption()>
					<cfset structDelete(local.attributeItem,'attributeOptions') />
				</cfif>

				<cfset local.attribute.populate(local.attributeItem) />
				<cfset local.attribute.setAttributeSet(local.attributeSet) />
				<cfset local.attribute.setAttributeType(local.attributeService.getType(local.attributeItem.attributeType)) />

				<cfset local.attributeService.saveAttribute(local.attribute) />
			</cfloop>

			<cfset getSlatwallApplication().getBeanFactory().getBean('hibachiDAO').flushORMSession() />
		</cfif>
	</cffunction>

</cfcomponent>