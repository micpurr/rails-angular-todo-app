module WaitForAngular
  def wait_for_angular
    Angular::Waiter.new(Capybara.current_session).wait_until_ready
  end
end