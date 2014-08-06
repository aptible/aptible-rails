class AppDecorator < ResourceDecorator
  def service_summary
    garner.bind(h.controller.session_token).bind(object) do
      object.services.map(&:process_type).join(', ')
    end
  end
end
