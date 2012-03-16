Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
    :mini => '52x52', # thumbs under image
    :small => '200x200', # images on category view
    :product => '360x360', # full product image
    :large => '600x600>'  # light box image
  }
  attachment_definitions[:attachment][:convert_options] = {
    :mini => "-background white -compose Copy -gravity center -extent 52x52",
    :small => "-background white -compose Copy -gravity center -extent 200x200",
    :product => "-background white -compose Copy -gravity center -extent 360x360"
  }
end