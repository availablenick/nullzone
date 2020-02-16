module UsersHelper

  # options's keys:
  # - size: image size
  # - use_default: use default avatar in case there isn't any
  # or display a text
  def set_avatar(user, options = {})
    options.reverse_merge! size: nil, use_default: true

    if user.avatar.attached?
      return image_tag user.avatar, size: '125x125'
    end

    if !options[:use_default]
      return 'Nenhum avatar selecionado'
    end

    if user.login == 'ADM'
      img_src = 'adm_avatar.jpg'
    else
      img_src = 'new_user_avatar.jpg'
    end

    return image_tag img_src, size: "#{options[:size]}x#{options[:size]}"
  end
end
