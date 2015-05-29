module Wikidata
  module Property
    class CommonsMedia < Wikidata::Property::Base
      BASE_PAGE_URL = "https://commons.wikimedia.org/wiki/File:%s.%s".freeze
      IMAGE_URL = "https://upload.wikimedia.org/wikipedia/commons/%s/%s/%s.%s"
      THUMB_IMAGE_URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/%s/%s/%s.%s/%ipx-%s.%s"

      def page_url
        @_page_url ||= sprintf BASE_PAGE_URL, basename, extension
      end

      def url size = nil
        if size
          sprintf THUMB_IMAGE_URL, md5[0], md5[0..1], basename, extension, size, basename, extension, thumb_extension
        else
          sprintf IMAGE_URL, md5[0], md5[0..1], basename, extension
        end
      end

      def md5
        @_md5 ||= Digest::MD5.hexdigest "#{basename}.#{extension}"
      end

      def basename
        @_basename ||= name.gsub ' ', '_'
      end

      def name
        @_name ||= File.basename(value, ".#{extension}")
      end

      def thumb_extension
        @_thumb_ext ||= extension == 'svg' ? 'svg.png' : extension
      end

      def extension
        @_ext ||= File.extname(value).tr '.', ''
      end
    end
  end
end
