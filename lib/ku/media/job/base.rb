require_relative '../config/queue_classic'

require 'logger'

module KU
  module Media
    module Job
      class Base
        
        def self.enqueue(options)
          DefaultQueue.enqueue "#{self.name}.perform", options
        end
        
        def self.perform options
          new(options).perform
        end
        
        def logger
          Logger.new STDOUT
        end
      end
    end
  end
end

