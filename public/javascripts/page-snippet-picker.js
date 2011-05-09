$(document).ready(function(){

	/**
	 * Class for handling everything between page and snippets
	 */
	var PageSnippet = {
		processing: false,
		content_holder: [], // html wrapper for all stuff
		add_snippet: [], // add snippet anchor
		inactive_snippets: [], // select box with inactive snippets on page


		spinner_on: function () {
			this.processing = true;
			this.inactive_snippets.attr('disabled', 'disabled');
			this.content_holder.css({opacity: 0.5});
		},

		spinner_off: function () {
			this.content_holder.css({opacity: 1});
			this.inactive_snippets.removeAttr('disabled');
			this.processing = false;
		},

		update: function (html) {
			this.clear();
			this.content_holder.html(html);			
			this.bind();
			this.spinner_off();		
		},

		add: function () {
			var that = this;
			
			if (!this.processing) {
				var selected_item = this.inactive_snippets.find('option:selected'),
					selected_id = null,
					values = [],
					add_url = this.add_snippet.attr('href');

				if (selected_item.length > 0 && selected_item.val() !== '') {
					this.spinner_on();
				
					add_url += '&add=' + selected_item.val();
					
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
						}
					});
				} else {
					this.processing = false;
				}
			}
		},

		remove: function (elm) {
			var that = this,
				remove_url = $(elm).attr('href');

			if (!this.processing) {
				var values = [];
				this.spinner_on();
				
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
						// console.log('pleas');
						that.update(response);
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
			this.add_snippet.unbind('click');
		},

		/**
		 * Bind event handlers and other smells ;-)
		 */
		bind: function () {
			var that = this;
			this.add_snippet = $('#add-snippet');
			this.inactive_snippets = $('#inactive_snippets');
			this.add_snippet.click(function (e) {
				e.preventDefault();
				that.add();
				return false;
			});
			
			$('a.remove-snippet').click(function (e) {
				e.preventDefault();
				that.remove(this);
				return false;
			});
		},

		init: function () {
			this.content_holder = $('#page_snippet_picker	');
			if (this.content_holder.length > 0) {
				this.bind();
			}
		}
	}

	PageSnippet.init();
});
