module JockeyCli
  class LogFormatter
    attr_accessor :logs, :last_time, :raw

    def initialize opts={}
      @opts = opts
      @raw = opts[:raw] || false
    end

    def print
      return if logs.empty?

      skip_previous_lines

      logs.each do |line|
        puts raw ? line : format_line(line)
      end

      self.last_time = Time.parse(logs.last['timestamp']) if logs.any?
    end

    def skip_previous_lines
      if last_time
        self.logs = logs
          .reject {|l| l == '' }
          .drop_while do |l|
            if l.timestamp
              Time.parse(l.timestamp) <= last_time
            end
          end
      end
    end

    def format_line line
      process = line.logger

      # This pulls out 'stream' logs from the docker api that are being sent to us
      message = JSON.parse(line.message.text)['stream'] rescue nil
      message ||= line.message.text rescue nil

      message.chomp! if message

      timestamp = line.timestamp ? Time.parse(line.timestamp).strftime('%H:%M:%SZ') : "--:--:-- "

      [timestamp, process, message].join(" ")
    end
  end
end
