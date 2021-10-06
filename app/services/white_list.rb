class WhiteList
  attr_reader :options, :result, :control_point, :exception

  ALLOWED_TICKET_LIST = { request_number: 'RequestNumber',
                          sequence_number: 'SequenceNumber',
                          request_type: 'RequestType',
                          response_due_date: 'ResponseDueDateTime',
                          additional_sacode: 'SACode',
                          primary_sacode: 'SACode',
                          digsite_info_wkt: 'WellKnownText' }.freeze

  ALLOWED_EXCAVATOR_LIST = { company_name: 'CompanyName',
                             address: 'Address',
                             city: 'City',
                             state: 'State',
                             zip: 'Zip',
                             crew_on_site: 'CrewOnsite' }.freeze

  def initialize(options)
    @result = []
    @options = options
  end

  def handle_payload
    handle_ticket_payload.merge(excavator_attributes: handle_excavator_payload)
  end

  # TODO: need to refactor
  def handle_excavator_payload
    @exception = false
    response = ALLOWED_EXCAVATOR_LIST.each_with_object({}) do |(attr, point), hsh|
      hsh[attr] = result if has_key(options['Excavator'], point)
    end
    return_final_excavator(response)
  end

  def handle_ticket_payload
    ALLOWED_TICKET_LIST.each_with_object({}) do |(attr, point), hsh|
      hsh[attr] = result if hard_has_key(options.except('Excavator'), point, attr)
    end
  end

  private

  def has_key(obj, point)
    if obj[point]
      @result = obj[point]

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

  def hard_has_key(obj, point, attr)
    if obj[point].present? &&
      (obj[point].class == String && Ticket.new.send(attr).class == NilClass) ||
      (obj[point].class == Array && Ticket.new.send(attr).class == Array) # can be nil == nil
      @result = obj[point]

      return true
    end

    obj.each do |key, val|
      if point == key
        return val
      elsif val.class.to_s == 'ActionController::Parameters'
        hard_has_key(val, point, attr)
      end
    end
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
