class LargeServiceInterface
  def method1
    raise 'Not Implemented'
  end
end

class LargeService < LargeServiceInterface
  def method1
    puts '[real] method1'
  end
end

class LargeServiceProxy < LargeServiceInterface
  def initialize
    @internal = nil
  end

  def method1
    @internal = LargeService.new if @internal == nil

    puts '[proxy] method1'
    @internal.method1
  end
end

class SomeService
  def initialize(large_service)
    unless large_service.is_a? LargeServiceInterface
      raise "Expected large_service:#{large_service} to be of type #{LargeService}. Got #{large_service.class}"
    end

    @service = large_service
  end

  def do_work
    puts '[some_service] prepare'
    @service.method1
    puts '[some_service] done'
  end
end

service = SomeService.new(LargeServiceProxy.new)
service.do_work


