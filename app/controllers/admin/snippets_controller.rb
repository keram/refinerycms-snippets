module Admin
  class SnippetsController < Admin::BaseController

    crudify :snippet, :xhr_paging => true

  end
end
