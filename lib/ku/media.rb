require 'bundler/setup'

require_relative 'media/config/sequel'
require_relative 'media/config/queue_classic'

require_relative 'media/person'
require_relative 'media/group'

require_relative 'media/keyword'
require_relative 'media/tag'
require_relative 'media/link'

require_relative 'media/asset'

require_relative 'media/category'
require_relative 'media/subcategory'
require_relative 'media/language'

require_relative 'media/collection'
require_relative 'media/item'

require_relative 'media/format'
require_relative 'media/proxy'

require_relative 'media/license'
require_relative 'media/consent'

require_relative 'media/job/ping_podcast'
require_relative 'media/job/mail'

require_relative 'media/transcoder'




