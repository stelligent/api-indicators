module DocsHelper
  def api_request_code path, method
    result = content_tag :code, "#{method.upcase} #{api_root_url}/#{path} HTTP/1.1"
  end
end
