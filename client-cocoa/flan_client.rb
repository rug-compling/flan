#
# Client module for the Flan server
#

require 'json'
require 'rest_client'

module FlanClient
  class FlanClient
    def initialize(serverURL, username, password)
      @serverURL = serverURL
    end
  
    def lf_keys
      keysJSON = RestClient.get("#{@serverURL}/logical_forms.json?restrict=keys")
      JSON.parse(keysJSON)
    end
  
    def lf(key)
      lfJSON = RestClient.get("#{@serverURL}/logical_forms/#{key}.json")
      lfRaw = JSON.parse(lfJSON)
      sentences = lfRaw['realization'].map {|r| r['sentence']}
      LogicalForm.new(key, lfRaw['data'], sentences)
    end
    
    def realizations(lfKey)
      relsJSON = RestClient.get("#{@serverURL}/logical_forms/#{lfKey}/realizations.json")
      relsRaw = JSON.parse(relsJSON)
      relsRaw.map {|r| r['sentence']}
    end
    
    def structure(lfKey)
      RestClient.get("#{@serverURL}/logical_forms/#{lfKey}/structure.xml")
    end
    
    def structurePDF(lfKey)
      RestClient.get("#{@serverURL}/logical_forms/#{lfKey}/structure.pdf")
    end
  end

  class LogicalForm
    attr_reader :key, :data, :realizations
  
    def initialize(key, data, realizations)
      @key = key
      @data = data
      @realizations = realizations
    end
  end
end