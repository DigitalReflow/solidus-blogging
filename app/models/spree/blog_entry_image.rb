class Spree::BlogEntryImage < Spree::Asset
  validate :no_attachment_errors
  has_attached_file :attachment,
    styles: { mini: '48x48#', normal: '150x150#', large: '1024x600>' },
    path:   ':rails_root/public/assets/blog_entry_images/:id/:style/:basename.:extension',
    url:    '/assets/blog_entry_images/:id/:style/:basename.:extension'
  validates_attachment :attachment,
    presence:     true,
    content_type: { content_type: %w[image/jpeg image/jpg image/png image/gif] }

  def no_attachment_errors
    return if attachment.errors.empty?

    errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
    false
  end
end
