module ApplicationHelper
  include TranslateHelper

  def color_badge(text = nil, color = nil)
    text_color = contrast_color(color)

    content_tag(
      :span,
      text,
      class: "color-badge",
      style: "background: #{color}; color: #{text_color}"
    )
  end

  def current_page_name
    if @cur_url.include?('users')
      tm(User, :title)
    elsif @cur_url.include?('clients')
      tm(Client, :title)
    elsif @cur_url.include?('orders')
      tm(Order, :title)
    elsif @cur_url.include?('interactions')
      tm(Interaction, :title)
    else
      tm(Client, :title)
    end
  end

  def pretty_date(date)
    date.strftime("%d %B %Y") if date.present?
  end

  def pretty_date_month_year(date)
    date.strftime("%B %Y") if date.present?
  end

  def pretty_number(number, delimiter = '')
    number_to_currency number, precision: 0, delimiter: delimiter, unit: ""
  end

  def pretty_decimal(number, separator = '.', delimiter = '')
    # Используем NumberHelper через ActionView::Helpers::NumberHelper
    ActionController::Base.helpers.number_to_currency(number, precision: 2, delimiter: delimiter, unit: "", separator: separator)
  end

  def pretty_date_time(date)
    date.strftime("%d %B %Y %H:%M") if date.present?
  end

  def small_date(date)
    date.strftime("%d.%m.%Y") if date.present?
  end

  def small_date_hyphen(date)
    date.strftime("%d-%m-%Y") if date.present?
  end

  def time_only(date)
    date.strftime("%H:%M") if date.present?
  end

  def smallest_date(date)
    date.strftime("%d.%m") if date.present?
  end

  def small_datetime(date)
    date.strftime("%d.%m.%Y %H:%M") if date.present?
  end

  def format_number(number, precision: 2, delimiter: ',', separator: '.')
    number_with_precision(
      number,
      precision: precision,
      delimiter: delimiter,
      separator: separator
    )
  end

  def logo_icon
    image_tag "/icons/vexodus_mini.png"
  end

  def g_icon icon_name, class_name=''
    content_tag(:span, icon_name, class: "material-symbols-outlined g-icon #{class_name}")
  end

  def user_image(user = nil)
    user ||= current_user
    image_tag user.user_image_url
  end

  def active_sidebar?(url_path)
    url_path.include?("/#{@cur_url}") || url_path == @cur_url
  end

  private

  def contrast_color(hex)
    return '#000000' unless hex.present?

    hex = hex.delete('#')

    r = hex[0..1].to_i(16)
    g = hex[2..3].to_i(16)
    b = hex[4..5].to_i(16)

    brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000

    brightness > 160 ? '#000000' : '#ffffff'
  end

end
