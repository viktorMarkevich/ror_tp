class WhiteList
  attr_reader :options, :result, :control_point, :exception

  ALLOWED_TICKET_LIST = { request_number: 'RequestNumber',
                          sequence_number: 'SequenceNumber',
                          request_type: 'RequestType',
                          response_due_date: 'ResponseDueDateTime',
                          service_area_code: 'SACode',
                          digsite_info_wkt: 'WellKnownText' }.freeze

  ALLOWED_EXCAVATOR_LIST = { company_name: 'CompanyName',
                             address: 'Address',
                             city: 'City',
                             state: 'State',
                             zip: 'Zip',
                             crew_on_site: 'CrewOnsite' }.freeze

  def initialize(options)
    @result = []
    @control_point = ''
    @options = options
  end

  def handle_payload
    handle_ticket_payload.merge(excavator_attributes: handle_excavator_payload)
  end

  def handle_excavator_payload
    @exception = false
    response = common_handler(ALLOWED_EXCAVATOR_LIST, options['Excavator'])
    return_final_excavator(response)
  end

  def handle_ticket_payload
    common_handler(ALLOWED_TICKET_LIST)
  end

  private

  def common_handler(white_list, params = options)
    white_list.each_with_object({}) do |(attr, point), hsh|
      hsh[attr] = result.join(', ') if has_key(params, point)
    end
  end

  def has_key(obj, point)
    if obj[point]
      update_settings(point) if @control_point != point
      @result << obj[point]
      @result.flatten!

      return true
    end

    obj.each do |key, val|
      if point == key
        return val
      elsif val.class.to_s == 'ActionController::Parameters'
        has_key(val, point)
      end
    end
  end

  def update_settings(point)
    @result = []
    @control_point = point
  end

  def set_address(hsh)
    [hsh[:address], hsh[:city], hsh[:state], hsh[:zip]].join(', ')
  end

  def return_final_excavator(hsh)
    response = {}
    response[:company_name] = hsh[:company_name]
    response[:address] = set_address(hsh)
    response[:crew_on_site] = hsh[:crew_on_site]
    response
  end
end
