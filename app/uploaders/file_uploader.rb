class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    [model.company_id, attachable_type, attachable_id, model_type].compact.join("/")
  end

  process :set_document_meta

  def extension_white_list
    %w(doc docx)
  end

  def filename
    "#{model.expected_filename}.#{file.extension}" if original_filename
  end

  private

  def attachable_type
    (model.attachable.try(:attachable_parent_type) ||
      model.attachable_type).to_s.underscore.pluralize
  end

  def attachable_id
    model.attachable.try(:attachable_parent_id) || model.attachable_id
  end

  def model_type
    model.type.underscore.pluralize
  end

  def set_document_meta
    model.content_type = file.content_type if file.content_type
    model.size = file.size
  end
end
