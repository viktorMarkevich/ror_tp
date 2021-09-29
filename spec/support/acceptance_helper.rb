module Acceptance
  module SpecHelper
    def payload
      file_content = file_fixture("payload.json").read
      JSON.parse(file_content, symbolize_names: false)
    end
  end
end
