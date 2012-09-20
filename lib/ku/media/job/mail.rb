require_relative 'base'

require 'pony'

module KU
  module Media
    module Job
      class Mail < Base
    
        def initialize(mailer=Pony, options)
          @mailer  = mailer
          @to      = options['to']
          @from    = options['from']
          @subject = options['subject']
          @body    = options['body']
        end
    
        def perform
          logger.debug deliver
        end
        
        private
        
        def deliver
          @mailer.mail \
              to: @to, from: @from, subject: @subject, body: @body,
              via: :smtp, via_options: { address: address, domain: domain }
        end
        
        def address
          ENV['MAIL_ADDRESS']
        end
        
        def domain
          ENV['MAIL_DOMAIN']
        end
      end
    end
  end
end
