module Blinkbox
  class OnixProcessor
    VERSION = open(File.expand_path('../../../../VERSION',__FILE__)) do |f|
      f.read.strip
    end
  end
end
