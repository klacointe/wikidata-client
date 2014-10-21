module Wikidata
  module Property
    class Time < Wikidata::Property::Base
      DATE_PRECISION = {
        0  => 1_000_000_000 * 365 * 24 * 3600,
        1  => 100_000_000 * 365 * 24 * 3600,
        2  => 10_000_000 * 365 * 24 * 3600,
        3  => 1_000_000 * 365 * 24 * 3600,
        4  => 100_000 * 365 * 24 * 3600,
        5  => 10_000 * 365 * 24 * 3600,
        6  => 1000 * 365 * 24 * 3600,
        7  => 100 * 365 * 24 * 3600,
        8  => 10 * 365 * 24 * 3600,
        9  => 365 * 24 * 3600,
        10 => 30 * 24 * 3600,
        11 => 24 * 3600,
        12 => 3600,
        13 => 60,
        14 => 1
      }.freeze

      def date
        return @_date if @_date
        d = Hash[[:year, :month, :day, :hour, :min, :sec].zip(
          value.time.scan(/(-?\d+)-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})/).first.map(&:to_i)
        )]
        [:month, :day].each do |k|
          d[k] = (d[k] == 0 ? 1 : d[k])
        end
        @_date ||= DateTime.new *d.values
      end

      def timestamp
        date.to_time.utc.to_i
      end

      def precision
        DATE_PRECISION[value.precision.to_i]
      end

      def after
        value.after
      end

      def before
        value.before
      end

      def range
        return @_range if @_range

        if before.to_i == 0 && after.to_i == 0
          case value.precision.to_i
          when 7
            extract_century
          when 11
            extract_day
          else
            extract_generic_range
          end
        end
        extract_generic_range
      end

      protected

      def extract_generic_range
        from = before > 0 ?
           timestamp - (before.to_i * precision) : timestamp
        to = after > 0 ?
          timestamp + (after.to_i * precision) : timestamp

        @_range ||= (to_datetime ::Time.at(from).utc)..(to_datetime ::Time::at(to).utc)
      end

      def extract_century
        if date.year > 0
          from = DateTime.new(date.year - 99, 1, 1, 0, 0, 0)
          to = DateTime.new(date.year, 12, 31, 23, 59, 59)
        else
          from = DateTime.new(date.year, 1, 1, 0, 0, 0)
          to = DateTime.new(date.year + 99, 12, 31, 23, 59, 59)
        end
        @_range ||= (from..to)
      end

      def extract_day
        from = DateTime.new(date.year, date.month, date.day, 0, 0, 0)
        to = DateTime.new(date.year, date.month, date.day, 23, 59, 59)
        @_range ||= (from..to)
      end

      def to_datetime(t)
        DateTime.new t.year, t.month, t.day, t.hour, t.min, t.sec
      end
    end
  end
end
