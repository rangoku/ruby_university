ROLES = {
  'admin' => 1,
  'user' => 2
}

class Service
  def method1
    puts '[real] method1'
  end
end

class LimitedService < Service
  def initialize(user_role_id)
    @service = Service.new
    @user_role_id = user_role_id
  end

  def method1
    puts '[proxy] method1 (validating access...)'
    if @user_role_id == ROLES['admin']
      puts '[proxy] access granted'
      @service.method1
    elsif
      puts '[proxy] access denied'
    end
  end
end


class SomeService
  def initialize(service)
    unless service.is_a? Service
      raise "Expected service:#{service} to be of type #{Service}. Got #{service.class}"
    end

    @service = service
  end

  def do_work
    puts '[some_service] prepare'
    @service.method1
    puts '[some_service] done'
  end
end

puts '[test] service used by admin'
service_used_by_admin = SomeService.new(LimitedService.new(ROLES['admin']))
service_used_by_admin.do_work

puts ''
puts '[test] service used by user'
service_used_by_user = SomeService.new(LimitedService.new(ROLES['user']))
service_used_by_user.do_work