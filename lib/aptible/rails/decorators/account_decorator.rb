class AccountDecorator < ApplicationDecorator
  def needs_startup_guide?
    object.apps.count == 0 && object.databases.count == 0
  end

  def cached_permissions
    garner.bind(h.controller.session_token) do
      object.permissions
    end
  end

  # rubocop:disable PredicateName
  def has_scope?(scope)
    cached_permissions.map(&:scope).include? scope
  end
  # rubocop:enable PredicateName

  def syslog_drain_host
    drain = syslog_drain
    drain.drain_host if drain
  end

  def syslog_drain_port
    drain = syslog_drain
    drain.drain_port if drain
  end

  def syslog_drain
    drains = (object.log_drains || []).select do |d|
      d.drain_type == 'syslog_tls_tcp'
    end
    drains.first unless drains.empty?
  end
end
