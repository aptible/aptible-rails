class AppDecorator < ResourceDecorator
  def service_summary
    garner.bind(h.controller.session_token).bind(object) do
      object.services.map(&:process_type).sort.join(', ')
    end
  end
end
