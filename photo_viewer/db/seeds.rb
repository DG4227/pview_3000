require 'net/http'

url = URI('https://pastebin.com/raw/BmA8B0tY')
# shuffle to make for more varied image query responses
photo_links = Net::HTTP.get(url).split("\r\n").shuffle
photo_links.each do |pl|
  local_link = pl.gsub('/', '-')
  open(pl) do |image|
    img = Magick::Image.from_blob(image.read).first

    img.write "vendor/images/#{local_link}.png"
    # writing grayspace image into subfolder
    img.quantize(256, Magick::GRAYColorspace).write "vendor/images/grayscale/#{local_link}.png"
    PhotoLink.create!(filepath: local_link, columns: img.columns, rows: img.rows)
  end
end
