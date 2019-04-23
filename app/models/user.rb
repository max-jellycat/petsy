class User < ApplicationRecord

  has_many :pets

  has_secure_password
  has_secure_token :confirmation_token
  has_secure_token :recover_password

  has_image :avatar

  validates :username,
    format: { with: /\A[a-zA-Z0-9]{2,20}\z/, message: 'must only contain alphanumerical characters' },
    uniqueness: { case_sensitive: false, message: 'already taken' }
  
  validates :email,
    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ },
    uniqueness: { case_sensitive: false }

  def to_session
    { user_id: id }
  end
=begin
  attr_accessor :avatar_file
  validates :avatar_file, file: { ext: [:jpg, :png, :gif] } 
  before_save :avatar_before_upload
  after_destroy_commit :avatar_destroy
  after_save :avatar_after_upload

  def avatar_path
    File.join(Rails.public_path, self.class.name.downcase.pluralize, id.to_s, "avatar.jpg")
  end

  def avatar_url
    "/" + [
      self.class.name.downcase.pluralize,
      id.to_s,
      "avatar.jpg"
    ].join('/')
  end

  private
  def avatar_after_upload
    if avatar_file.respond_to? :path
      dest = avatar_path
      dir = File.dirname(dest)
      FileUtils.mkdir_p(dir) unless Dir.exist? dir
      
      image = MiniMagick::Image.new(avatar_file.path) do |b|
        b.resize '150x150'
        b.gravity 'Center'
        b.crop '150x150+0+0'
      end
      image.format 'jpg'
      image.write dest
    end
  end

  def avatar_before_upload
    if avatar_file.respond_to? :path
      self.avatar = true
    end
  end

  def avatar_destroy
    dir = File.dirname(avatar_path)
    FileUtils.rm_r(dir) if Dir.exist? dir
  end
=end

end
