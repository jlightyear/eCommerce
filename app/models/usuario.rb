class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  def email_required?
    false
  end

  validates :username, presence: true, uniqueness: true,
            length: {in: 5..20, too_short: "Mínimo 5 caracteres", too_long: "Máximo 20 caracteres"},
            format: {with: /([A-Za-z0-9\-\_]+)/, message: "sólo puede contener letras, números y guiones"}

  def self.find_or_create_by_omniauth(auth)
    usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first

    return usuario if usuario
    
      usuario = Usuario.create(
        nombre: auth[:nombre],
        apellido: auth[:apellido],
        username: auth[:username],
        email: auth[:email],
        uid: auth[:uid],
        provider: auth[:provider],
        password: Devise.friendly_token[0,20]
      )

  end

end
