$(document).ready(function (cms) {
  cms = cms || {};
  cms.plugin = cms.plugin || {};

  /**
   * Generates a drop-down box for changing the displayed page part
   * in the snippets tab in the edit page interface.
   */
  cms.plugin.PartSnippetsSelect = {

    init: function() {
      $('#part-snippets-menu').html(this.generateWidget());
      this.changeVisiblePart();
      $('#part-snippets-select').change(this.changeVisiblePart);
    },

    /**
     * Writes the html code for the drop-down box.
     */
    generateWidget: function() {
      select = '<select id="part-snippets-select">';
      $('#part-snippets-menu a').each(function(i,e) {
        select += '<option value="'+$(e).attr('href').split('#',2)[1]+'">'
        select += e.text
        select += '</option>'
      });
      select += '</select>';
      return select;
    },

    changeVisiblePart: function() {
      $('.part-snippets').css('display', 'none');
      $('#'+$('#part-snippets-select').val()).css('display', 'block');
    },

  }

  cms.plugin.PartSnippetsSelect.init();

});
