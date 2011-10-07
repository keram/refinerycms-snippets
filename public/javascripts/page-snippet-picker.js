$(document).ready(function (cms) {
	cms = cms || {};
	cms.plugin = cms.plugin || {};

	/**
	 * Class for handling everything between page and snippets
	 */
	cms.plugin.PageSnippet = {
		processing: false,
		content_holder: [], // html wrapper for all stuff
		add_snippet: [], // add snippet anchor
		remove_snippet: [],

		spinner_on: function () {
			this.processing = true;
			this.content_holder.css({opacity: 0.5});
		},

		spinner_off: function () {
			this.content_holder.css({opacity: 1});
			this.processing = false;
		},

		update: function (html) {
			this.clear();
			this.content_holder.html(html);			
			this.bind();
			this.spinner_off();		
		},

		add: function (elm) {
			var that = this,
				add_url = $(elm).attr('href');
			
			if (!this.processing) {
				this.spinner_on();
                          var partId = $('#part-snippets-select').val();
				$.ajax({
					url: add_url,
					type: 'GET',
					dataType: 'html',
					error: function (response) { alert(response); },
					complete: function (e) {
						// console.log(e);
					},
					success: function (response) {
						that.update(response);
                                          cms.plugin.PartSnippetsSelect.init();
                                          $('#part-snippets-select').val(partId).change();
					}
				});
			}
		},

		remove: function (elm) {
			var that = this,
				remove_url = $(elm).attr('href');

			if (!this.processing) {
				this.spinner_on();
			        var partId = $('#part-snippets-select').val();
				// console.log('remove start');
				$.ajax({
					url: remove_url,
					dataType: 'html',
					error: function (response) { 
						alert(response); 
					},
					complete: function (e) {
						// console.log(e);
					},
					success: function (response) {
						that.update(response);
                                          cms.plugin.PartSnippetsSelect.init();
                                          $('#part-snippets-select').val(partId).change();
					}
				});
			}
		},

		/**
		 * Remove event handlers and other smells
		 */
		clear: function () {
			// console.log('start clear');
			this.content_holder.find('a').unbind('click');
			this.content_holder.find('a').unbind('mouseout');
			this.content_holder.find('a').unbind('mouseover');
		},

		/**
		 * Bind event handlers and other smells ;-)
		 */
		bind: function () {
			var that = this;
			this.add_snippet = this.content_holder.find('a.add-snippet');
			this.remove_snippet = this.content_holder.find('a.remove-snippet');
			
			this.add_snippet.click(function (e) {
				e.preventDefault();
				that.add(this);
				return false;
			});
			
			this.remove_snippet.click(function (e) {
				e.preventDefault();
				that.remove(this);
				return false;
			});
		},

		init: function () {
			this.content_holder = $('#page_snippet_picker');
			if (this.content_holder.length > 0) {
				this.bind();
			}
		}
	}

	cms.plugin.PageSnippet.init();
});
