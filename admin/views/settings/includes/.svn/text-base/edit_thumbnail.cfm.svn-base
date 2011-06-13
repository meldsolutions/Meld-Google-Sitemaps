<!---
||MELDGALLERYLICENSE||
--->
<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-ImageThumb">
		<h3>#local.rc.mmRBF.key('secondaryimages')#</h3>
		<ul class="form">
			<fieldset>
			<legend>#local.rc.mmRBF.key('mediumimage')#</legend>
			<p>#local.rc.mmRBF.key('mediumimage','tip')#</p>
			<li>
				<label for="settingbean_imagewidthmedium">#local.rc.mmRBF.key('imagewidth')#</label>
				<input class="text tiny" type="text" name="settingbean_imagewidthmedium" id="settingbean_imagewidthmedium" value="#form.settingbean_imagewidthmedium#" size="10" maxlength="10" required="true" validate="numeric" message="#local.rc.mmRBF.key('imagewidthmedium','validate')#"/>
			</li>
			<li>
				<label for="settingbean_imageheightmedium">#local.rc.mmRBF.key('imageheight')#</label>
				<input class="text tiny" type="text" name="settingbean_imageheightmedium" id="settingbean_imageheightmedium" value="#form.settingbean_imageheightmedium#" size="10" maxlength="10" required="true" validate="numeric" message="#local.rc.mmRBF.key('imageheightmedium','validate')#"/>
			</li>
			<li>
				<label for="settingbean_imageresizetypemedium">#local.rc.mmRBF.key('resize')#</label>
				<select name="settingbean_imageresizetypemedium">
					<cfloop list="crop,resize,cropresize" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imageresizetypemedium> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imageaspecttypemedium">#local.rc.mmRBF.key('aspect')#</label>
				<select name="settingbean_imageaspecttypemedium">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="AspectXY,AspectX,AspectY,MaxAspectXY" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imageaspecttypemedium> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imagecroptypemedium">#local.rc.mmRBF.key('crop')#</label>
				<select name="settingbean_imagecroptypemedium">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="CenterXY,CenterX,CenteryY,BestXY" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imagecroptypemedium> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imagequalitytypemedium a">#local.rc.mmRBF.key('quality')#</label>
				<select name="settingbean_imagequalitytypemedium a">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="highestQuality,mediumQuality,lowQuality,highestPerformance" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imagequalitytypemedium> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			</fieldset>
			<fieldset>
			<legend>#local.rc.mmRBF.key('thumbnail')#</legend>
			<p>#local.rc.mmRBF.key('thumbnail','tip')#</p>
			<li>
				<label for="settingbean_imagewidthsmall">#local.rc.mmRBF.key('imagewidth')#</label>
				<input class="text tiny" type="text" name="settingbean_imagewidthsmall" id="settingbean_imagewidthsmall" value="#form.settingbean_imagewidthsmall#" size="10" maxlength="10" required="true" validate="numeric" message="#local.rc.mmRBF.key('imagewidthsmall','validate')#"/>
			</li>
			<li>
				<label for="settingbean_imageheightsmall">#local.rc.mmRBF.key('imageheight')#</label>
				<input class="text tiny" type="text" name="settingbean_imageheightsmall" id="settingbean_imageheightsmall" value="#form.settingbean_imageheightsmall#" size="10" maxlength="10" required="true" validate="numeric" message="#local.rc.mmRBF.key('imageheightsmall','validate')#"/>
			</li>
			<li>
				<label for="settingbean_imageresizetypesmall">#local.rc.mmRBF.key('resize')#</label>
				<select name="settingbean_imageresizetypesmall">
					<cfloop list="crop,resize,cropresize" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imageresizetypesmall> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imageaspecttypesmall">#local.rc.mmRBF.key('aspect')#</label>
				<select name="settingbean_imageaspecttypesmall">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="AspectXY,AspectX,AspectY,MaxAspectXY" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imageaspecttypesmall> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imagecroptypesmall">#local.rc.mmRBF.key('crop')#</label>
				<select name="settingbean_imagecroptypesmall">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="CenterXY,CenterX,CenteryY,BestXY" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imagecroptypesmall> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			<li>
				<label for="settingbean_imagequalitytypesmall a">#local.rc.mmRBF.key('quality')#</label>
				<select name="settingbean_imagequalitytypesmall a">
					<option value="">#local.rc.mmRBF.key('none')#</option>
					<cfloop list="highestQuality,mediumQuality,lowQuality,highestPerformance" index="local.item">
						<option value="#local.item#"<cfif local.item eq form.settingbean_imagequalitytypesmall> SELECTED</cfif>>#local.rc.mmRBF.key(local.item)#</option>
					</cfloop>
				</select>
			</li>
			</fieldset>
		</ul>
	</div>
</cfoutput>