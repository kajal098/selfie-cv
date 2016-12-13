class VideoUploadReport

  include Datagrid

  scope { VideoUpload.order(:id) }
  
  column(:id, header: "id", :order => "video_uploads.id")
  column(:file, :html => true, header: "Video") do |model|
    model.file.url
  end
  column(:updated_at, html: true, header: "Updated At") { |video_upload| content_tag :span, time_ago_in_words(video_upload.updated_at), title: video_upload.updated_at.to_formatted_s(:long) if video_upload.updated_at }
  column(:actions, header: "Action", html: true  ) do |video_upload|
    html = link_to "", admin_video_upload_path(video_upload), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View Video"
    html += link_to "", edit_admin_video_upload_path(video_upload), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit Video"
    html += link_to "", admin_video_upload_path(video_upload), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove Video", 'data-confirm' => 'Are you sure?'
    html
  end

end