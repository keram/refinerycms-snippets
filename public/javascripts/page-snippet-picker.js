$(document).ready(function(){

	/**
	 * Class for handling everything between page and snippets
	 */
	var PageSnippet = {
		processing: false,
		add_url: '', // something like => /refinery/pages/home/add-snippet/1
		update_url: '', // => /refinery/pages/home/remove-snippet/1
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
		},

		add: function () {
			var that = this;
			
			if (!this.processing) {
				var selected_item = this.inactive_snippets.find('option:selected'),
					selected_id = null,
					values = [];

				if (selected_item.length > 0 && selected_item.val() !== '') {
					this.spinner_on();
					console.log('add start');

					selected_id = selected_item.val();
//					$.ajax(
//						url: that.add_url,
//						method: 'POST',
//						values: values,
//						error: function (response) { },
//						succes: function (response) {
//							that.update(response);
//						}
//					);

					// for test
					setTimeout(function () {
						that.spinner_off();						
					}, 3000);
				} else {
					this.processing = false;
				}
			}
		},

		remove: function (elm) {
			var that = this;

			if (!this.processing) {
				var values = [];
				this.spinner_on();
				
				console.log('remove start');
//				$.ajax(
//					url: that.remove_url,
//					method: 'POST',
//					values: values,
//					error: function (response) { },
//					succes: function (response) {
						that.update(response);
//					}
//				);

				// for test
				setTimeout(function () {
					that.spinner_off();
				}, 3000);
			}
		},

		/**
		 * Remove event handlers and other smells
		 */
		clear: function () {
			console.log('start clear');
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
