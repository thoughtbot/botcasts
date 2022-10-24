class DownloadAttachmentJob < ApplicationJob
  def perform(record, name, url)
    record.update! name => download(url)
  end

  private

  def download(attachment_url)
    request_uri = URI(attachment_url)

    {io: request_uri.open, filename: File.basename(request_uri.path)}
  end
end
