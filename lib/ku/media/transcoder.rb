require 'shellwords'

module KU
  module Media
    
    TranscodeFailed = Class.new(StandardError)
    
    class Transcoder
  
      def initialize options
        @input = options[:input]
        @options = options[:options]
      end
  
      def perform
        `#{command}`
        raise TranscodeFailed if $? != 0
        tempfile
      end
  
      private
  
      def command
        [binary, input, options, '-y', tempfile.path].join(' ')
      end
      
      def binary
        'ffmpeg'
      end
  
      def input
        "-i #{@input.shellescape}"
      end
  
      def options
        @options.map {|k,v| "-#{k} #{v}"}.join(' ')
      end
      
      def tempfile
        @tempfile ||= Tempfile.new 'ku-media-transcode'
      end
    end
  end
end

