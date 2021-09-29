class WhiteList
  attr_reader :options, :result, :control_point

  ALLOWED_LIST = { request_number: 'RequestNumber',
                   sequence_number: 'SequenceNumber',
                   request_type: 'RequestType',
                   response_due_date: 'ResponseDueDateTime',
                   service_area_code: 'SACode',
                   digsite_info_wkt: 'WellKnownText' }.freeze

  def initialize(options)
    @result = []
    @control_point = ''
    @options = options
  end

  def handle_payload
    ALLOWED_LIST.each_with_object({}) do |(attr, point), hsh|
      hsh[attr] = result.join(', ') if has_key(options, point)
    end
  end

  private

  def has_key(obj, point)
    if obj[point]
      if @control_point != point
        @result = []
        @control_point = point
      end
      @result << obj[point]
      @result.flatten!
      return true
    end

    obj.each do |key, val|
      if point == key
        return val
      elsif val.class.to_s != 'String' && val.class.to_s != 'Array'
        has_key(val, point)
      end
    end
  end
end