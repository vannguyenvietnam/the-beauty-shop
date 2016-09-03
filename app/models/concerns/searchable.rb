module Searchable
	extend ActiveSupport::Concern

	included do
		include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks

  	 # Elasticsearch
	  settings index: { number_of_shards: 1 } do
	    mappings dynamic: 'false' do
	      indexes :title, analyzer: 'english', index_options: 'offsets'
	      indexes :text, analyzer: 'english'
	    end
	  end

	  def self.search(query)
	    __elasticsearch__.search(
	      {
	        query: {
	          multi_match: {
	            query: query,
	            fields: ['name^10', 'discription']
	          }
	        },
	        highlight: {
	          pre_tags: ['<em>'],
	          post_tags: ['</em>'],
	          fields: {
	            name: {},
	            descriptio: {}
	          }
	        }
	      }
	    )
	  end
	  
	end
end