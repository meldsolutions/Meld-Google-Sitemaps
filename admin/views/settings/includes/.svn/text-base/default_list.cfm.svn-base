<!---
||MELDGALLERYLICENSE||
--->
<cfsilent>
	<cfset local.rc = rc>
</cfsilent>
<cfoutput>
<div class="section clearfix">
	<table class="ms-datatable display hideTable" id="ms-datatable"
		data-url="#rc.$.globalConfig().getContext()#/plugins/#local.rc.pluginConfig.getDirectory()#/com/meldsolutions/meldgallery/remote/meldgalleryRemoteAOP.cfc?method=getDisplayTypeList&data&returnFormat=json">
		<thead class="headers">
		<tr>
			<th class="nosort nopad ui-state-active" data-class="nopad">&nbsp;</th>
			<th class="varWidth ui-state-active">#local.rc.mmRBF.key('name')#</th>
			<th class="nosort minWidth ui-state-active" data-class="center">#local.rc.mmRBF.key('status')#</th>
		</tr>
		</thead>
		<thead class="search" id="ms-datatable_search">
		<tr>
			<th>
			<ul class='table-buttons two'>
				<li><span title="#local.rc.mmRBF.key('clearfilter')#" id="clearFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-arrowreturnthick-1-w"></span></span></li>
				<li><span title="#local.rc.mmRBF.key('setfilter')#" id="setFilter" class="sb-button ui-state-active"><span class="ui-icon ui-icon-check"></span></span></li>
			</ul>
			</th>
			<th><input class="searchable text full" type="text" id="flt_name" data-column="name"></th>
			<th>
			<select class="select" name="isactive" id="flt_isactive" data-column="isactive">
				<option value="1">#local.rc.mmRBF.key('active1')#</option>
				<option value="0">#local.rc.mmRBF.key('active0')#</option>
			</select>
			</th>
		</tr>
		</thead>
		<tbody>
	</table>
</div>

</cfoutput>