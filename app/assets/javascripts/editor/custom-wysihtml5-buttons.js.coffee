window.customWysihtml5Buttons =
	getUniqueId: ->
		Math.floor Math.random() * 10000000000000001

	# Add a button into the editor's toolbar
	addToggleButton: (button, parent)->
		uniqId = customWysihtml5Buttons.getUniqueId()
		buttonEl = '<a id="toolbarButton'+uniqId+'" data-wysihtml-class-toggle="'+button.class+'" class="btn btn-sm btn-default" title="'+button.title+'" tabindex="-1" href="javascript:;" unselectable="on"><i class="glyphicon '+button.icon+'"></i></a>'
		if parent?
			parent.append buttonEl
		else
			$('.wysihtml5-toolbar').append '<li>'+buttonEl+'</li>'
		$('#toolbarButton'+uniqId).click button.callback

	# Add a button group
	addGroupButton: (buttons) ->
		$('.wysihtml5-toolbar').append '<li><div class="btn-group"></div></li>'
		parent = $('.wysihtml5-toolbar li').last().find('div')
		customWysihtml5Buttons.addToggleButton button, parent for button in buttons

	# Search container of current selection
	getContainer: (selection) ->
		# Image block
		if selection? and $(selection).find(':first-child').prop('tagName') == 'IMG'
			container = $(selection).find(':first-child')
		# Text block
		else if selection?  && selection.parentNode?
			# Two cases :
			# 1. Selection is the P container
			container = $(selection.parentNode)
			# 2. Selection is a child, we'll go up to P
			if container.prop('tagName') != 'P' && container.prop('tagName') != 'DIV'
				container = container.parent 'p'
		container

	# Add/Remove a class to P container or IMG
	classToggle: ->
		uniqId = customWysihtml5Buttons.getUniqueId()
		wysihtml5Editor = $('#article_body').data("wysihtml5").editor
		# Class to toggle
		className = $(@).data 'wysihtml-class-toggle'
		# Get current selection node
		anchorNode = wysihtml5Editor.composer.selection.getSelection().anchorNode
		container = customWysihtml5Buttons.getContainer(anchorNode);
		# Parent found
		if container?
			# Set an unique ID on its parent (for further use)
			container.attr 'id','editorEl'+uniqId
			id = $(container).attr('id')
			# Find its parent container
			if container.prop('tagName') != 'BODY'
				# Add the class or empty all presents
				# Class is empty to auto remove previous class
				if container.hasClass className
					container.attr 'class', ''
				else
					container.attr 'class', className

# Once editor has beend initialized, add custom buttons
$(document).on 'editorInitialized', (e, data) ->
	customWysihtml5Buttons.addGroupButton [
		{icon: 'glyphicon-align-left', title: 'Aligner à gauche', class: 'wysiwyg-float-left', callback: customWysihtml5Buttons.classToggle}
		{icon: 'glyphicon-align-center', title: 'Aligner au centre', class: 'wysiwyg-centered', callback: customWysihtml5Buttons.classToggle}
		{icon: 'glyphicon-align-right', title: 'Aligner à droite', class: 'wysiwyg-float-right', callback: customWysihtml5Buttons.classToggle}
	]
