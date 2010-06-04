#
# Client module for the Flan server
#

require 'json'
require 'rest_client'

module FlanClient
  class FlanClient
    def initialize(serverURL, username, password)
      @serverURL = serverURL
      @resource = RestClient::Resource.new(serverURL, username, password)
    end
    
    def createJudgment(lfId, relId)
      payload = {:judgment => {
        :logical_form_id => lfId,
        :realization_id => relId          
      }}.to_json
      judgmentJSON = @resource['judgments.json'].post(payload, :content_type => :json, :accept => :json)
      judgment = JSON.parse(judgmentJSON)
      judgment['id']
    end
    
    def createRealization(logicalFormId, sentence)
      payload = {:realization => {
        :logical_form_id => logicalFormId,
        :sentence => sentence
      }}.to_json
      realizationJSON = @resource["logical_forms/#{logicalFormId}/realizations"].post(
        payload, :content_type => :json, :accept => :json)
    end
    
    def deleteJudgment(judgmentId)
      @resource["judgments/#{judgmentId}"].delete
    end
  
    def lf_keys
      keysJSON = @resource['logical_forms.json?restrict=keys'].get
      JSON.parse(keysJSON)
    end
      
    def realizations(lfKey)
      relsJSON = @resource["logical_forms/#{lfKey}/realizations.json"].get
      relsRaw = JSON.parse(relsJSON)
      relsRaw.map {|r| {
        :sentence => r['sentence'], :most_fluent => r['most_fluent'],
        :logicalFormId => r['logical_form_id'], :realizationId => r['id'],
        :judgmentId => r['judgment_id']
        } }
    end
    
    def structure(lfKey)
      @resource["logical_forms/#{lfKey}/structure.xml"].get
    end
    
    def structurePDF(lfKey)
      @resource["logical_forms/#{lfKey}/structure.pdf"].get
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
